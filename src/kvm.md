Virtualizing with KVM in Linux
==============================

<div class="center">June 15, 2015</div>
<div class="center">Updated: May 13, 2016</div>

Most of you are familiar with
[full virtualization](https://en.wikipedia.org/wiki/Full_virtualization)
solutions before like VMware Workstation, VirtualBox, and
Parallels. In this post, I’ll re-introduce you to another, arguably
faster, way of doing things.


## Table of contents

* [Setup](#setup)
  - [Hardware](#hardware)
  - [Software](#software)
* [Configuration](#configuration)
  - [Images](#images)
  - [Networking](#networking)
* [Execution](#execution)
  - [Load the image](#loadimage)
  - [Connect to the SPICE display](#display)
  - [Configure guest networking](#guestnetworking)
* [Closing the curtains](#closingcurtains)
  - [Restore networking](#restorenetworking)
* [Putting it all](#all)
* [Closing remarks](#closing)

## Setup <a name="setup"></a>

### Hardware <a name="hardware"></a>

One of the first things that you need to do is to enable
[Hardware-assisted virtualization](https://en.wikipedia.org/wiki/Hardware-assisted_virtualization),
also called accelerated virtualization, in your hardware. If your CPU
was made before 2006, chances are, this feature won’t be present on
your chip. Also, take note that this step is not compulsory to make
use of the virtualization solution described in this post, but it will
_significantly_ speed things up. To enable accelerated virtualization,
go into your BIOS/UEFI settings, and look for the knob that enables
this feature. The name into which it goes is different from
manufacturer to manufacturer. Save the settings, then boot your
system. You can verify on the command line if your system indeed
recognizes it.

```bash
$ egrep '(vmx|svm)' /proc/cpuinfo
```

If it returns some text, then you’re good.

### Software <a name="software"></a>

Next, you need to install the essential applications.

Nix:

```bash
$ nix-env -i qemu vde2 spice
```

APT:

```bash
$ sudo apt-get install qemu-kvm vde2 spice-client
```

This will install the [QEMU](http://wiki.qemu.org/) (pronounced as
kee-moo) hypervisor, [VDE](http://vde.sourceforge.net/) tools, and
[SPICE](http://www.spice-space.org/) support. QEMU, at least during
its early days had the _meh_ impression — it is OK, but not
stellar. Since version 0.10.1, QEMU started supporting
[KVM](http://www.linux-kvm.org/), a virtualization subsystem for
Linux, that provides near-native virtualization performance using
hardware-assisted virtualization. It even rivals the performance of
the virtualization solutions mentioned above.

Other suites offer the option of connecting to the guest machine’s
display via VNC. The problem is that, it’s slow and clunky. The
response time is just horrible. Using the
[SPICE](http://www.spice-space.org/) protocol, not only does it makes
things faster, but it makes other things possible. Take note that
SPICE is not a replacement for
[VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing), but
rather, it a different way of meeting your goals.


## Configuration <a name="configuration"></a>

### Images <a name="images"></a>

QEMU supports an array of image types, however the
[QCOW2](https://en.wikipedia.org/wiki/Qcow) format is the most
flexible, and feature-rich, for QEMU use.

If you have an existing VirtualBox file (VDI), you can convert it to
QCOW2 with:

```bash
$ qemu-img convert -f vdi -O qcow2 vm.vdi vm.qcow2
```

However, if you don’t have an image, yet, you can create one with:

```bash
$ qemu-img create -f qcow2 vm.qcow2 20G
```

The last step creates a 20GB image, that is named `vm.qcow2`. Take
note that the extension name doesn’t really matter — you can name
your image as `index.html`, but that wouldn’t make a lot of sense,
right? :)

### Networking <a name="networking"></a>

QEMU [supports](http://wiki.qemu.org/Documentation/Networking) several
ways of setting up networking for its guest, but for this post you’re
going to use VDE.

You need to run several commands to prep the networking
environment. Ideally, you’d want to save these in a shell function, or
a shell script:

```bash
$ sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
$ sudo ip addr add 10.0.2.1/24 dev tap0
$ sudo ip link set dev tap0 up
$ sudo sysctl -w net.ipv4.ip_forward=1
$ sudo iptables -t nat -A POSTROUTING \
-s 10.0.2.0/24 -j MASQUERADE
```

The above commands will:

1. Create a VDE device
2. Configure the TCP/IP options for that device.
3. Enable the VDE device.
4. Enable packet forwarding on the host OS.
5. Setup the routing configuration.


## Execution <a name="execution"></a>

### Load the image <a name="loadimage"></a>

You now need to invoke `qemu-kvm`, the command that will launch
everything up. The name of the command may differ with the one
installed on your system.

If you’re installing an OS from a bootable image, usually an ISO file,
run:

```bash
$ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
-net vde -soundhw all -vga qxl \
-spice port=9999,addr=127.0.0.1,password=mysecretkey \
-boot once=d -cdrom installer.iso \
vm.qcow2
```

On subsequent uses:

```bash
$ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
-net vde -soundhw all -vga qxl \
-spice port=9999,addr=127.0.0.1,password=mysecretkey \
vm.qcow2
```

Let’s break that down:

```
-cpu host
```
Use the KVM processor with all the supported features

```
-m 2G
```
Allocate 2GB of host memory for the guest. Adjust as necessary.

```
-net nic,model=virtio -net vde
```
Create a virtual NIC, and enable VDE networking

```
-soundhw all
```
Enable all audio drivers

```
-vga qxl
```
Specify the video adapter to emulate. Use QXL when using SPICE

```
-spice addr=127.0.0.1,port=9999,password=mysecretkey
```

Specify the options for SPICE, separated by commas. _addr_ and _port_
are the IP address and TCP port that SPICE will listen on. Ideally,
access to that port must be properly configured, and
secured. _password_ is key that will be used by the SPICE client,
`spicec`, to connect to the guest display later.

```
-boot once=d -cdrom installer.iso
```

Boot initially from `installer.iso`, then on subsequent boots, boot in
the normal order.

Running the _qemu-kvm_ command above will load the image, but you
won’t be able to view the display, yet.

### Connect to the SPICE display <a name="display"></a>

To be able to use the guest machine’s display, you need to connect to
the SPICE server, using the SPICE client `spicec`:

```bash
$ spicec -h 127.0.0.1 -p 5901 -w mysecretkey
```

Take note that closing the spicec window will not kill the QEMU
session. If the guest OS captures the mouse input, press
<kbd>Shift+F12</kbd>, to get out of it.

### Configure guest networking <a name="guestnetworking"></a>

Next, you need to properly configure the network configuration of the
guest OS so that it can connect to the rest of the local network, and
to the internet if the host machine has access to it.

_IP address_

```
10.0.2.2
```

_Gateway_

```
10.0.2.1
```

_DNS_

```
8.8.8.8
8.8.4.4
```

## Closing the curtains <a name="closingcurtains"></a>

### Restore networking <a name="restorenetworking"></a>

If you want to explicitly revert the network configuration, do the
following.

```bash
$ sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 \
-j MASQUERADE
$ sudo sysctl -w net.ipv4.ip_forward=0
$ sudo ip link set dev tap0 down
$ sudo ip link delete tap0
$ sudo pkill -9 vde_switch
$ sudo rm -f /run/vde.ctl/ctl
```

The above commands will:

1. Revert the routing configuration.
2. Disable packet forwarding.
3. Disable the VDE device.
4. Delete the VDE device.
5. Kill the VDE process.
6. Remove control files.

## Putting it all <a name="all"></a>

Here’s all of the code above, compiled functions, that can be run from
the command-line:

```
vde () {
  case $1 in
    down|0)
      sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 \
        -j MASQUERADE
      sudo sysctl -w net.ipv4.ip_forward=0
      sudo ip link set dev tap0 down
      sudo ip link delete tap0
      sudo pkill -9 vde_switch
      sudo rm -f /run/vde.ctl/ctl
      ;;
    up|1)
      sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
      sudo ip addr add 10.0.2.1/24 dev tap0
      sudo ip link set dev tap0 up
      sudo sysctl -w net.ipv4.ip_forward=1
      sudo iptables -t nat -A POSTROUTING -s 10.0.2.0/24 \
        -j MASQUERADE
      ;;
  esac
}

kvm () {
  sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
    -net vde -device AC97,addr=0x18 -vga qxl \
    -spice port=5900,addr=127.0.0.1,disable-ticketing \
    -daemonize $@
  spicec -p 5900 -h 127.0.0.1 &
}
```

Initially, setup the VDE network:

```bash
$ vde up
```

Then, load the image:

```bash
$ kvm vm.qcow32
```

## Closing remarks <a name="closing"></a>

QEMU supports a myriad of cool options that we’ve not even discussed
here, including saving and loading states (snapshots), creating screen
and audio grabs, and a whole lot more. To learn more about them, click
[here](http://wiki.qemu-project.org/Main_Page).

QEMU with KVM is a powerful, fast, and flexible solution for doing
[Full Virtualization](https://en.wikipedia.org/wiki/Full_virtualization). At
least in my case, it out-performs the well-known options in the
market. If you want to contribute to this project, head over to their
[GitHub page](https://github.com/qemu/qemu).

I hope this post helped you, in one way or another, learn more about
QEMU and KVM and what it has to offer. Ciao!
