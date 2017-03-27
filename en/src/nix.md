Nix and Why it Matters
======================

<div class="center">March 22, 2017 (Wed)</div>
<div class="center">Updated: March 26, 2017 (Wed)</div>

Ideas that change the way we do computing come rarely. A lot of the technology that we are using now
are just re-hashes of old ones. Layers upon layers of cosmetics envelop old concepts. Entire product
lines are based upon this lack of creativity and ingenuity. Old problems are not solved. Instead,
these so-called *innovative solutions* merely around the problem while painting it with a new shade,
claiming that at least they made it more colorful. This mentality harms progress in innumerable
ways. This gives the false impression that solutions are actually being done. This creates a false
sense of assurance of improvements.

Several years ago [Eelco Dolstra](https://nixos.org/~eelco/) wrote the
seminal [papers](https://nixos.org/docs/papers.html) that described radical ways to deploy
software. These papers effectively formed the cornerstones of [Nix](https://nixos.org/nix/), a
purely functional package manager language that solves the disease that plagued computing for a long
time—package management. In this article I’ll talk about Nix and friends, and how to use them to
your advantage.

The `$` symbol will be used to indicate the shell prompt for a regular user, while the `#` symbol
will denote the shell for the root user. There are cases when the EUID of a command will be 0 due
to the use of sudo.


Table of contents
-----------------
- [NixOS](#nixos)
- [Nixpkgs](#nixpkgs)
- [Nix](#nix)
- [Closing remarks](#closing)


NixOS <a name="nixos"></a>
--------------------------

How many times have you had a broken system because you upgraded a software that other components
depended on? How many late night stays have you had because you had to make an application work,
that you so greatly depend on because the new package that you installed broke it? How many times,
when in frustration, you gave up repairing your system and just decided to re-install your system
from scratch? Restoring data files is easy; restoring system configuration from the last working
state, however, is a one-way ticket to hell.

[NixOS](https://nixos.org) is a Linux distribution that solves that by leveraging on the determinism
of Nix and by using a single declarative configuration file that contains all settings in knobs in
one place—`/etc/nixos/configuration.nix`. This file may contain information about your filesystems,
users, services, network configuration, input devices, kernel parameters, and more. This means that
you can take a `configuration.nix` of someone, and have his exact system configuration! In NixOS you
don’t have to fiddle around the with whole system manually for configuration that want. You don’t have to
use ad-hoc solutions to specify a desired configuration state. You don’t need to install additional
software to manage system configuration.

NixOS does not follow
the
[Filesystem Hierarchy Standard (FHS)](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard),
effectively preventing additional brain damage.  This gives room for a lot of flexibility and
ingenuity. It does not have `/usr/` and `/opt/`. It does have `/bin/`, which contains only `sh` and
`/usr/bin/` which contains only `env`, both of which are actually symlinks to the real programs
somewhere in `/nix/store/`. The top-level location for system binaries—the ones installed explicitly
by the administrator—are located in `/run/curren-system/sw/bin/` and `/run/curren-system/sw/sbin/`.
User-installed programs, on the other hand, are available at their respective
`~/.nix-profile/bin/`. These locations cannot be modified through normal means; dedicated programs
must be used to write to these trees.


### Installation

Installation of NixOS is straightforward. For bare metal systems, download an installer
from [nixos.org/nixos/download.html](https://nixos.org/nixos/download.html). VM images are also
available from that page. For my last installation, I installed with the following setup:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- USB boot
- Wi-Fi connectivity
- [GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)
- [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) over [LVM](https://en.wikipedia.org/wiki/Logical_volume_management)


#### Booting

Boot from the USB drive in UEFI mode. In the login prompt, login as `root`.


#### Setup networking

Scan for available networks

```bash
# nmcli d wifi list
```

Then, connect to the router of choice

```bash
# nmcli d wifi con Foobarbaz name Foo password supersecretkey
```

#### Prepare the disk

Create the partitions:

```bash
# gdisk /dev/sda
sda1: EF00 (EFI system), 512 MiB
sda2: 8E00 (Linux LVM), rest
```

Format `/dev/sda1`:

```bash
# mkfs.vfat -F32 /dev/sda1
```

Create the physical volume

```bash
# pvcreate /dev/sda2
```

Create the volume group

```bash
vgcreate vg /dev/sda2
```

Create the logical volumes

```bash
# lvcreate -L 20G -n swap vg
# lvcreate -l 100%FREE -n root vg
```

Encrypt root

```bash
# cryptsetup luksFormat /dev/vg/root
# cryptsetup luksOpen /dev/vg/root root
```

Format root

```bash
# mkfs.ext4 -j -L root /dev/mapper/root
```

Format swap

```bash
# mkswap -L /dev/vg/swap
```

Mount the filesystems

```bash
# mount /dev/mapper/root /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
```

Enable swap

```bash
# swapon /dev/vg/swap
```


#### Install NixOS to disk

Create the base config

```bash
# nixos-generate-config --root /mnt
```

Edit the config file

```bash
nano /mnt/etc/nixos/configuration.nix
```

A version
of [my configuration](https://github.com/ebzzry/dotfiles/blob/master/nixos/configuration.nix)
follows. Replace the values as it suits you.


```
{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    initrd.luks.devices = [
      {
        device = "/dev/vg/root";
        name = "root";
        preLVM = false;
      }
    ];

    cleanTmpDir = true;
  };

  fileSystems = [
    {
      device = "/dev/disk/by-uuid/6106-6BF8";
      fsType = "vfat";
      mountPoint = "/boot";
    }

    {
      device = "/dev/mapper/root";
      fsType = "ext4";
      mountPoint = "/";
    }
  ];

  swapDevices = [
    {
      device = "/dev/vg/swap";
    }
  ];

  networking = {
    hostName = "mehfoo";
    hostId = "7B1548AE";
    enableIPv6 = true;
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ zsh ];
  };

  time.timeZone = "Asia/Manila";

  security.sudo = {
    enable = true;
    configFile = ''
      Defaults env_reset
      root ALL = (ALL:ALL) ALL
      %wheel ALL = (ALL) SETENV: NOPASSWD: ALL
    '';
  };

  services = {
    xserver = {
      autorun = true;
      defaultDepth = 24;
      enable = true;
      displayManager.kdm.enable = true;
      desktopManager.kde5.enable = true;
      videoDrivers = [ "intel" ];
    };
  };

  users = {
    extraUsers.user = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
    defaultUserShell = "/run/current-system/sw/bin/zsh";
  };
}
```

You may save this with:

```bash
# curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/ZTQcGs
```

A longer version is available with:

```bash
# curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/K4P7l5
```

Replace the UUID of the disk with the one that you have. Use the command `blkid` to get the
UUIDs. For `networking.hostID`, use the following command:

```bash
# cksum /etc/machine-id | while read c rest; do printf "%x" $c; done
```

The above configuration specifies the following, among other things:

- It creates a user `mel` with full sudo access
- It uses KDE 5 as the desktop environment
- It enables SSH
- It specifies the LUKS parameters

Install NixOS to the disk:

```bash
# nixos-install
```

This will parse `/etc/nixos/configuration.nix`, making sure that there are no errors. This command
will download all the necessary packages to match the specification, making sure that no stones are
left unturned.

When the installation completes, reboot your system:

```bash
# reboot
```


### Configuration

After installation, updating your existing configuration is trivial. All you have to do is edit the
configuration file then rebuild the system:

```bash
# nano /etc/nixos/configuration.nix
# nixos-rebuild switch
```

If you make a mistake, the system will notify you of it, instead of proceeding with an incorrect
configuration. All the possible knobs are
available [here](https://nixos.org/nixos/options.html). After the system has completed booting,
switch to the console <kbd>Ctrl+Alt+F1</kbd>, then login as `root`, then set a password for the user
that we specified in `configuration.nix`:

```bash
# passwd user
```

Exit the shell, switch to the graphical interface <kbd>Alt+F7</kbd>, then login as `user`.


Nixpkgs <a name="nixpkgs"></a>
------------------------------

Nixpkgs is a collection of thousands of packages curated and maintained by users worldwide. Since
the source code is in [GitHub](https://github.com/nixos/nixpkgs), it is able to take advantage of
the powerful collaboration models that that platform offers. At the time of writing, there are
almost 6500 packages in the collection. It contains a wide array of packages ranging from
productivity applications to theorem provers.

Most of the popular operating systems handle packages well, until, they don’t. As long as you are
moving in a straight line, alone, you’ll be fine. Things change, when you introduce other people in
the walk. For the whole cast to move in unison, everyone must be strictly connected to one
another. If a member decides to break off, and walk on his own, the entire cast becomes
crippled. However, if that member clones himself so that the departing copy becomes independent, the
original walking cast becomes undisturbed.

Let’s take the case of a distribution aimed as a multi-user production development environment. When
you install Firefox 100, the main binary goes to either `/usr/bin/firefox` or
`/usr/local/bin/firefox`. All the users then, in this system, will be able to access the application
from that path; John, Mary, and Peter are happy. However, when John upgrades it to version 200, the
same application that is being used by Mary and Peter are also upgraded. That’s not a good thing if
they prefer the old version that works with them! Nixpkgs allows you have multiple versions of a
software, without collisions from the other versions. John, Mary, and Peter can all have their
versions of Firefox without conflicting with the other versions. How does it do it? It does it by
not using a common global location.

Each user has their own versions of `~/.nix-profile` and all of the contents of those directories do
not contain regular files. Instead, they are all symbolic files to the actual files located in
`/nix/store/`. This directory is where programs and their dependencies are actually installed. The
only way to write to that directory is through the Nix-specific programs. There is no way to modify
the contents of that directory through normal means. So, when regular user `john` installs Vim 8,
the program becomes installed as something like
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329`. The characters before the package name
is the checksum of all the inputs to build the package. The file `/home/john/.nix-profile/bin/vim`
then points to a symlink to a file in `/nix/store/` that will lead to the actual Vim binary in
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329/bin/vim`.


### Installation

Although Nixpkgs nicely complements NixOS, it is not limited to that platform. Nixpkgs can also be
installed on other GNU/Linux systems and recent versions of macOS. To install Nixpkgs for your
platform, run:

```bash
$ curl https://nixos.org/nix/install | bash
```

You’ll be prompted to enter credentials for root access via sudo because it will install the
resources to `/nix/`. After the installation, you may also be requested to append a line of command
to your shell initialization file. When you spawn a new shell instance, the Nix-specific commands
will become available for use.


### Usage

There are two ways to install packages with Nixpkgs: the git checkout, which is the bleeding edge,
up-to-the-minute updated version, or by using
channels. The [git repository](https://github.com/nixos/nixpkgs)is ideal for people who want to use
the latest and greatest available version of a package, or for those who want to test things
out. [Channels](https://nixos.org/channels/) on the other hand, are essentially snapshots of the git
repository at an earlier version.


#### Git checkout

Updates to the git repository happen frequently—aAs you are reading this article, new commits are
made to the main tree. To use the git checkout, clone
the [repository](https://github.com/nixos/nixpkgs):

```bash
$ git clone https://github.com/nixos/nixpkgs ~/nixpkgs
```

This command creates a `nixpkgs/` directory under your home. If your username is `ogag`, the
clone of the repository is available at `/home/ogag/nixpkgs/` or `/Users/ogag/nixpkgs`, if you’re
using a GNU/Linux or macOS system, respectively.

To install a package, say emem—a Markdown to HTML converter, using the git checkout, run:

```bash
$ nix-env -f ~/nixpkgs/default.nix -iA emem
```

This will download emem along with all its dependencies, and then it will make the program available
to you. To make sure that emem has successfully installed, run:

```bash
$ emem --version
```

If your doesn’t barf and complain that you’re looking for something that does not exist, and instead
you see a version number, it means that you have successfully installed emem.

To get the most recent changes from the git repo, run:

```bash
$ cd ~/nixpkgs && git pull origin master
```


#### Channels

Installing packages via channels is nicer, because the commands to install packages with it are more
convenient. The trade-off is that the packages will be out-of-date by a few weeks. If you’re fine
with it, then use channels instead of the git checkout.

Channels are labeled **stable**, **unstable**, or with a specific version number, e.g.,
**16.09**. For this article, let’s use the unstable channel—it’s not as dated as stable, nor as
recent as the git checkout. To subscribe to the unstable channel, run:

```bash
$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
```

This fetches the channel labeled `nixpkgs-unstable` from nixos.org, then installs it to your user
profile.

Uisng the example above, to install emem, run the following commands for NixOS and other systems,
respectively:

```bash
$ nix-env -iA nixos.emem
```

```bash
$ nix-env -iA nixpkgs.emem
```

To update your channels, run:

```bash
$ nix-channel --update
```


### Other commands

To uninstall a package, run:

```bash
$ nix-env -e emem
```

To list all your installed packages, run:

```bash
$ nix-env -q --installed
```

To list all available packages, run:

```bash
$ nix-env -q --available
```

If you know the binary name of a program, and you want to know which package does it belong to, run:

```bash
$ command-not-found emem
```


### Notes

If at any point during the installation of a package, the process is interrupted, the package being
installed will not be in a half-baked state. The very last step of installing a package is
atomic. The secret to it is that it the operation that makes it available to a user creates a
symlink from `/nix/store`, where the actual program data is, to your profile, which is located at
`~/.nix-profile/`. Symbolic link creation in GNU/Linux and macOS systems are either successful or
not.

On NixOS, the channel used by the root user is important because it is the one used when rebuilding
the system when changes to `/etc/nixos/configuration.nix` are made. To make sure that you using the
right channel, list it with:

```bash
$ sudo nix-channel --list
```

To change the root channel similar to the one used above:

```bash
$ sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```


Nix <a name="nix"></a>
----------------------

The component that forms the heart of NixOS and Nixpkgs is the [Nix](https://nixos.org/nix)
language. It is a declarative language designed in mind to handle packages.

To make it easier to understand the language, let’s install the Nix REPL. Run the following commands
for NixOS and other systems, respectively:

```bash
$ nix-env -iA nixos.nix-repl
```

```bash
$ nix-env -iA nixpkgs.nix-repl
```

Next, let’s run it. You’ll be greeted with the version number, and the nix-repl prompt. At the time
of writing, the latest version is 1.11.8:

```bash
$ nix-repl
Welcome to Nix version 1.11.8. Type :? for help.

nix-repl>
```

Let’s try out some basic expressions.

Strings evaluate to themselves:

```bash
nix-repl> "foo"
"foo"
```

Arithmetic:

```bash
nix-repl> 6+2
8

nix-repl> 6-2
4

nix-repl> 6*2
12

nix-repl> 6/2
/home/user/6/2
```

Oops, that wasn’t what we expected. Since Nix was designed with files and directories in mind, it
made a special case that when a `/` character is surrounded by non-space characters, it interprets
it as a directory path, resulting in an absolute path. To actually perform division, add at least
one space before and after the `/` character:

```bash
nix-repl> 6 / 2
```

There are no floating point numbers in Nix. So, if you try to evaluate one, you’ll get:

```bash
nix-repl> 1.0
error: syntax error, unexpected INT, expecting ID or OR_KW or DOLLAR_CURLY or '"', at (string):1:3
'"'
```

Boolean values:

```bash
nix-repl> 1 < 2
true

nix-repl> 1 > 2
false

nix-repl> 1 == 1
true

nix-repl> "foo" == "foo"
true
```


### environmonts

- environments


### user commands
- nix-instantiate
- nix-store
- nix-build


### nix-shell


### configuration
- `~/.nixpkgs/config.nix`

### same package


### nix-repl


Closing remarks <a name="closing"></a>
--------------------------------------

??? Docker, along with Kubernetes and OpenShift solves a different class of problems.
??? Docker is good at what it does, and it does it well. However, the key philosophy with Docker is that
it assumes that the underlying systems may not exhibit reproducibility. Hence, treating them as
expendables.

- purely functional
- stateless
- declarative

- Building Declarative Deterministic Systems with Nix

flatpak
