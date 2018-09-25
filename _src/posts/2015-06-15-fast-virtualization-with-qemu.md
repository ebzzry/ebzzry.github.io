    Title: Fast Virtualization with QEMU
    Date: 2015-06-15T03:50:50
    Tags: virtualization, sysadmin

Most of you are familiar with
[Full Virtualization](https://en.wikipedia.org/wiki/Full_virtualization)
solutions before like VMware Workstation, VirtualBox, and
Parallels. In this post, I'll re-introduce you to another, arguably
faster, way of doing things.

<!-- more -->

# Preparation

## Hardware
One of the first things that we need to do is to enable
[Hardware-assisted virtualization](https://en.wikipedia.org/wiki/Hardware-assisted_virtualization),
also called accelerated virtualization, in your hardware. If your CPU
was made before 2006, chances are, this feature won't be present on
your chip. Also, take note that this step is not compulsory to make
use of the virtualization solution described in this post, but it will
**significantly** speed things up. To enable accelerated
virtualization, go into BIOS/UEFI, and look for the knob that enables
this feature. The name into which it goes is different from
manufacturer to manufacturer. You can verify on the command line if
your system indeed recognizes it.

```console
$ egrep '(vmx|svm)' /proc/cpuinfo
```

If it returns some text, then we're good.

## Software
Next, we need to install the essential applications. The commands
below are for NixOS, so change it accordingly for your system.

```console
$ nix-env -i qemu vde2 spice
```

This will install the [QEMU](http://wiki.qemu.org/) (pronounced as
kee-moo) hypervisor, [VDE](http://vde.sourceforge.net/) tools, and
[SPICE](http://www.spice-space.org/) support. QEMU, at least during
its early days had the _meh_ impression -- it is OK, but not
stellar. Since version 0.10.1, QEMU started supporting
[KVM](http://www.linux-kvm.org/), a virtualization subsystem for
Linux, that provides near-native virtualization performance using
hardware-assisted virtualization. It even rivals the performance of
the virtualization solutions mentioned above.

Other suites offer the option of connecting to the guest machine's
display via VNC. The problem is that, it's slow and clunky. The
response time is just horrible. Using the
[SPICE](http://www.spice-space.org/) protocol, not only does it makes
things faster, but it makes other things possible. Take note that
SPICE is not a replacement for
[VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing), but
rather, it a different way of meeting our goals.


# Configuration

## Images
QEMU supports an array of image types, however the
[QCOW2](https://en.wikipedia.org/wiki/Qcow) format is the most
flexible, and feature-rich, for QEMU use.

If you have an existing VirtualBox file (VDI), you can convert it to
QCOW2 with:

```console
$ qemu-img convert -f vdi -O qcow2 vm.vdi vm.qcow2
```

However, if you don't have an image, yet, you can create one with:

```console
$ qemu-img create -f qcow2 vm.qcow2 20G
```

The last step creates a 20GB image, that is named **vm.qcow2**. Take
note that the extension name doesn't really matter -- you can name
your image as **index.html**, but that wouldn't make a lot of sense,
right? :)

## Networking
QEMU [supports](http://wiki.qemu.org/Documentation/Networking)
several ways of setting up networking for its guest, but for this post
we're going to use VDE.

We need to run several commands to prep the networking
environment. Ideally, you'd want to save these in a shell function, or
a shell script:

```console
$ sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
$ sudo ip addr add 10.0.2.1/24 dev tap0
$ sudo ip link set dev tap0 up
$ sudo sysctl -w net.ipv4.ip_forward=1
$ sudo iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j MASQUERADE
```

The above commands will:

> 1. Create a VDE device
> 2. Configure the TCP/IP options for that device.
> 3. Enable the VDE device.
> 4. Enable packet forwarding on the host OS.
> 5. Setup the routing configuration.

# Execution

## Load the image
We now need to invoke **qemu-kvm**, the command that will launch
everything up. The name of the command may differ with the one
installed on your system.

If you're installing an OS from a bootable image, usually an ISO file,
run:

```console
$ qemu-kvm -cpu host -m 2G -net nic,model=virtio -net vde \
-device AC97,addr=0x18 -vga qxl \
-spice port=9999,addr=127.0.0.1,password=mysecretkey \
-boot once=d -cdrom installer.iso \
vm.qcow2
```

On subsequent uses:

```console
$ qemu-kvm -cpu host -m 2G -net nic,model=virtio -net vde \
-device AC97,addr=0x18 -vga qxl \
-spice port=9999,addr=127.0.0.1,password=mysecretkey \
vm.qcow2
```

Let's break that down:

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
-device AC97,addr=0x18
```
Specify the audio adapter to
emulate. [AC97](https://en.wikipedia.org/wiki/AC%2797) works
reasonably well for most configurations.

```
-vga qxl
```
Specify the video adapter to emulate. Use QXL when using SPICE

```
-spice addr=127.0.0.1,port=9999,password=mysecretkey
```
Specify the options for SPICE, separated by commas. **addr** and
**port** are the IP address and TCP port that SPICE will listen
on. Ideally, access to that port must be properly configured, and
secured. **password** is key that will be used by the SPICE client,
`spicec`, to connect to the guest display later.

```
-boot once=d -cdrom installer.iso
```
Boot initially from `installer.iso`, then on subsequent boots, boot in
the normal order.

Running the **qemu-kvm** command above will load the image, but we
won't be able to view the display, yet.

## Connect to the SPICE display
To be able to use the guest machine's display, we need to connect to
the SPICE server, using the SPICE client **spicec**:

```console
$ spicec -h 127.0.0.1 -p 5901 -w mysecretkey
```

Take note that closing the spicec window will not kill the QEMU
session. If the guest OS captures the mouse input, press
**Shift+F12**, to get out of it.

## Configure guest networking
Next, we need to properly configure the network configuration of the
guest OS so that it can connect to the rest of the local network, and
to the internet if the host machine has access to it.

```
# IP address (any value from 10.0.2.2 to 10.0.2.254)
10.0.2.2

# Gateway (the host machines' address, from the guest machine's view.)
10.0.2.1

# DNS (Google's DNS service)
8.8.8.8
8.8.4.4
```

# Closing the Curtains

## Restore networking
If you want to explicitly revert the network configuration, do the
following.

```console
$ sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 -j MASQUERADE
$ sudo sysctl -w net.ipv4.ip_forward=0
$ sudo ip link set dev tap0 down
$ sudo ip link delete tap0
$ sudo pkill -9 vde_switch
$ sudo rm -f /run/vde.ctl/ctl
```

The above commands will:

> 1. Revert the routing configuration.
> 2. Disable packet forwarding.
> 3. Disable the VDE device.
> 4. Delete the VDE device.
> 5. Kill the VDE process.
> 6. Remove control files.

# Conclusion
QEMU supports a myriad of cool options that were not even discussed
here, including saving and loading states (snapshots), creating screen
and audio grabs, and a whole lot more. To learn more about them, click
[here](http://wiki.qemu-project.org/Main_Page).

QEMU with KVM is a powerful, fast, and flexible solution for doing
[Full Virtualization](https://en.wikipedia.org/wiki/Full_virtualization). At
least in my case, it out-performs the well-known options in the
market. If you want to contribute to this project, head over to their
[GitHub page](https://github.com/qemu/qemu).

I hope this post helped you, in one way or another, learn more about
QEMU and what it has to offer. Ciao!
