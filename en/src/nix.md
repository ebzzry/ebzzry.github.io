Nix and Why it Matters
======================

<div class="center">March 22, 2017</div>
<div class="center">Updated: March 28, 2017</div>

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
  + [Installation](#nixosinstallation)
    * [Boot machine](#nixosboot)
    * [Setup networking](#nixosnetworking)
    * [Preare disks](#nixosdisks)
    * [Install to disk](#nixosinstall)
  + [Configuratino](#nixosconfiguration)
- [Nixpkgs](#nixpkgs)
  + [Installation](#nixpkgsinstallation)
  + [Usage](#nixpkgsusage)
    * [Git checkout](#nixpkgsgit)
    * [Channels](#nixpkgschannels)
    * [Other commands](#nixpkgsother)
  + [Notes](#nixpkgsnotes)
- [Nix](#nix)
  + [Strings](#nixstrings)
  + [Numbers](#numbers)
  + [Booleans](#nixbooleans)
  + [Lists](#nixlists)
  + [Sets](#nixsets)
  + [Paths](#nixpaths)
  + [Functions](#nixfunctions)
  + [Let](#nixlet)
  + [With](#nixwith)
  + [Conditionals](#nixconditionals)
  + [File imports](#niximports)
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


### Installation <a name="nixosinstallation"></a>

Installation of NixOS is straightforward. For bare metal systems, download an installer
from [nixos.org/nixos/download.html](https://nixos.org/nixos/download.html). VM images are also
available from that page. For my last installation, I installed with the following setup:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- USB boot
- Wi-Fi connectivity
- [GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)
- [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) over [LVM](https://en.wikipedia.org/wiki/Logical_volume_management)


#### Boot machine <a name="nixosboot"></a>

Boot from the USB drive in UEFI mode. In the login prompt, login as `root`.


#### Setup networking <a name="nixosnetworking"></a>

Scan for available networks

```bash
# nmcli d wifi list
```

Then, connect to the router of choice

```bash
# nmcli d wifi con Foobarbaz name Foo password supersecretkey
```

#### Prepare disks < name"disks"></a>

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


#### Install to disk <a name="nixosinstall"></a>

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

A longer version is available at:

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


### Configuration <a name="nixosconfiguration"></a>

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


### Installation <a name="nixpkgsinstallation"></a>
Skip this step if you are using NixOS because Nixpkgs already comes with it. To install Nixpkgs on
GNU/Linux or macOS systems, run:

```bash
$ curl https://nixos.org/nix/install | bash
```

You’ll be prompted to enter credentials for root access via sudo because it will install the
resources to `/nix/`. After the installation, you may also be requested to append a line of command
to your shell initialization file. When you spawn a new shell instance, the Nix-specific commands
will become available for use.


### Usage <a name="nixpkgsusage"></a>

There are two ways to install packages with Nixpkgs: the git checkout, which is the bleeding edge,
up-to-the-minute updated version, or by using
channels. The [git repository](https://github.com/nixos/nixpkgs)is ideal for people who want to use
the latest and greatest available version of a package, or for those who want to test things
out. [Channels](https://nixos.org/channels/) on the other hand, are essentially snapshots of the git
repository at an earlier version.


#### Git checkout <a name="nixpkgsgit"></a>

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


#### Channels <a name="nixpkgschannels"></a>

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


#### Other commands <a name="nixpkgsother"></a>

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


### Notes <a name="nixpkgsnotes"></a>
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


### Strings <a name="nixstrings"></a>
Just like in other languages, strings evaluate to themselves:

```bash
nix-repl> "foo"
"foo"
```

To concatenate strings, use the `+` operator:

```bash
nix-repl> "foo" + "bar"
"foobar"
```

Another way to declare strings is to use two pairs of single quotes. Do not mistake it with the
double quotes:

```bash
nix-repl> ''foo bar''
"foo bar"
```

The advantage of using `''` over the `"` is that allows `"` inside it:

```bash
nix-repl> ''"foo" "bar"''
"\"foo\" \"bar\"\"
```

The value that it then returns will be properly quoted. This is useful later when we’re going to
build complex expressions.

To deference strings inside strings, use the `${name}` form:

```bash
nix-repl> x = "foo"

nix-repl> y = "bar"

nix-repl> "${x} ${y}"
"foo bar"

nix-repl> ''${x} ${y}''
"foo bar"
```


### Numbers <a name="nixnumbers"></a>

asic arithmetic operations in Nix are included with a small twist:

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

The function `builtins.div` does essentially the same as `/`:

```bash
nix-repl> builtins.div 6 3
2
```

The difference, however, is that `builtins.dev` can be applied partially:

```bash
nix-repl> (builtins.div 6)
«primop-app»
```

This expressions returns a closure of a partially applied function. We need another value to fully
apply it:

```bash
nix-repl> (builtins.div 6) 3
2
```

We can even store the value of that partial application:

```bash
nix-repl> d = builtins.div 6
```

The `=` operator in Nix is used to bind values. In this example, it is used to define a partial
application. To use that function:

```bash
nix-repl> d 3
2
```


### Booleans <a name="nixboolean"></a>
Truth and falsehood are represented with *true* and *false*:

```bash
nix-repl> 1 < 2
true

nix-repl> 1 > 2
false

nix-repl> 1 == 1
true

nix-repl> "foo" == "foo"
true

nix-repl> "foo" < "bar"
false

nix-repl> false || true
true

nix-repl> false && true
false
```


### Lists <a name="nixlists"></a>
Lists are heterogenous types for containing serial values, wherein elements are separated
with spaces:

```bash
nix-repl> [ 1 "foo" true ]
[ 1 "foo" true ]
```

To concatenate lists:

```bash
nix-repl> [ 1 "foo" true ] ++ [ false (6 / 2) ]
[ 1 "foo" true false ]
```

To extract the head:

```bash
nix-repl> builtins.head ([ 1 "foo" true (6 / 2) ] ++ [ false (6 / 2) ])
1
```

To extract the tail:

```bash
nix-repl> builtins.tail ([ 1 "foo" true (6 / 2) ] ++ [ false (6 / 2) ])
[ "foo" true 3 false 3 ]
```

Lists are indexed starting
at [0](https://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD831.html). To get the *1th*
element, use the *builtins.elemAt* operator:

```bash
nix-repl> builtins.elemAt [ 1 "foo" true ] 1
"foo"
```


### Sets <a name="nixsets"></a>
An important data structure in Nix are sets. They keyword-value pairs separated with semi-colons:

```bash
nix-repl> { a = 0; b = "bar"; c = true; d = (6 / 2); }
```

What makes sets different from lists is that extracting values from them are done by making name
references. To extract the value of `b`, use the `.` operator:

```bash
nix-repl> { a = 0; b = "bar"; c = true; d = (6 / 2); }.b
"bar"
```

To dereference a member from the same set, use the `rec` keyword:

```bash
nix-repl> rec { a = 0; b = "bar"; c = true; d = (6 / 2); e = b; }.e
"bar"
```


### Paths <a name="nixpaths"></a>
In Nix all paths are translated to absolute ones. If you make a reference to a file in the current
directory:

```bash
nix-repl> ./foo
/home/user/foo
```

It gets translated to an absolute path. This is a Good Thing™.

Similarly, if you make a reference to a relative path inside an absolute path, it still gets
translated to an absolute one:

```bash
nix-repl> /./foo
/foo
```

Note, however, that Nix doesn’t like paths that stand alone:

```bash
nix-repl> /
error: syntax error, unexpected '/', at (string):1:1

nix-repl> ./
error: syntax error, unexpected '.', at (string):1:1
```


### Functions <a name="nixfunctions"></a>
What fun would it be if there’ll be no verbs to use with these nouns? Functions in Nix share
similarities with other languages while having its own unique traits.

The most basic form of a function follows:

```bash
nix-repl> x: x
«lambda»
```

This expression creates an anonymous function that returns its argument—the identity function. The
colon after the first *x* indicates that it is a parameter to the function, just like
in [lambda calculus](http://ebzzry.io/en/lambda-calculus/#functions). Also,the names do not matter
due to [alpha equivalence](https://en.wikipedia.org/wiki/Lambda_calculus#Alpha_equivalence):

```bash
nix-repl> foo-bar-baz: foo-bar-baz
«lambda»
```

These functions are not of much use because they are not captured for application. If we want to use
it, for example the value `"foo"`, we need to surround it with parentheses:

```bash
nix-repl> (x: x) "foo"
"foo"
```

To add more fun, let’s name that function:

```bash
nix-repl> identity = x: x
```

Sweet! Now, let’s apply it:

```bash
nix-repl> identity "foo"
"foo"
```

Let’s create a function that appends `" ugh"` to its input, then let’s apply it:

```bash
nix-repl> ugh = s: s + " ugh"

nix-repl> ugh "me"
"me ugh"
```

To define a function that takes another argument, let’s use the following form:

```bash
nix-repl> ugh = s: t: s + " ugh " + t

nix-repl> ugh "me" "you"
"me ugh you"
```

The pattern is that to add an additional parameter, use the `name: ` form.

Sets, when used with functions enable more powerful abstractions. We can pass a set as an argument
to a function, which will then use the data inside that set:

```bash
nix-repl> poof = { a, b }: x: a + " " + b + x
```

This function has two parameters: `{ a, b }`—a parameter specification for a set with two elements,
and `x`—a regular parameter. Take note, too that the parameter specifaciton is not a real set, but
merely a way to match arguments; it uses a comma, as value separator. Inside this function we
combine the inputs with the `+` operator. To use this function, we’d do it like:

```bash
nix-repl> poof { a = "ugh"; b = "me"; } " poof"
"ugh me poof"
```

When a function declares a set as its parameter, you need to specify the keywords when invoking the
function that uses them. In this case the keyword names are `a` and `b`.

The definition of `poof` above is actually a syntactic sugar for:

```bash
nix-repl> poof = meh: x: meh.a + " " + meh.b + x
```

We used a regular, non-set parameter here so that it can refer to the set as a value. Observe this:

```bash
nix-repl> meh = { a = "foo"; b = "bar"; }

nix-repl> meh.a
"foo"
```

It is also possible to specify default values. When a parameter with default value is not used, the
default value is used. They are declared similarly in Common Lisp:
`(defun foop (a &optional (b "O.o")) (concatenate 'string a b'))`

```bash
nix-repl> foop = { a, b ? "O.o" }: a + b

nix-repl> foop { a = "goo"; }
"gooO.o"

nix-repl> foop { a = "goo"; b = "oog"; }
"goooog"

```

To add even more flexibility, Nix supports the use of pseudo-‘rest’ arguments. Let’s modify the
function from above:

```bash
nix-repl> foop = { a, b, ...}: a + b
```

Let’s use it:

```bash
nix-repl> foop { a = "meh"; b = "foo"; }
"mehfoo"
```

The same. So how can we make use of that flexibility, then? We’ll create a label for the attribute
set, so that we can refer to the ‘extra’ values:

```bash
nix-repl> foop = attrs@{ a, b, ...}: a + b + attrs.blah
```

We use it just like before, but with the use of the label:

```bash
nix-repl> foop { a = "goo"; b = "oog"; c = "hhh"; }
"gooooghhh"
```

I said ‘pseudo’ because the value for `c` was still required.

The use of default values of variable arity, can be combined together:

```bash
nix-repl> foop = attrs@{ a, b, c ? "C", ... }: a + b + c + attrs.d

nix-repl> foop { a = "A"; b = "B"; d = "D"; }
"ABCD"

nix-repl> foop { a = "A"; b = "B"; c = "X"; d = "D"; }
"ABXD"

```


### Let <a name="nixlet"></a>
The keyword `let` lets (pun not intended) us define variables in a local scope. For example, the
names `x` and `y` are only visible in that scope:

```bash
nix-repl> let x = "foo"; y = "bar"; in x + poof { a = "huh"; b = "really"; } "hmm" + y
"foohuh reallyhmmbar"
```

Take note of the last `;` before the '`in` keyword that goes with `let`—it marks the start of the
`let` body. The let contruct behaves in similar ways to the `let` keyword found in languages like
Lisp and Haskell.


### With <a name="with"></a>
The keyword `with` lets (no pun not intended, this time) you ‘drop’ set values in a scope:

```bash
nix-repl> with { x = "foo"; y = "bar"; }; poof { a = y; b = x; } " xyz"
"bar foo xyz"
```

What happened here is that the values inside that set were ‘unveiled’ to make them available in the
`with` body.


### Conditionals <a name="conditionals"></a>
Conditional expressions are done with the `if` keyword. It has a similar form with mainstream
languages:

```bash
nix-repl> if true then "true" else "false"
"true"
```

It can also be nested:

```bash
nix-repl> if false then "true" else if false then "true" else if false then "true" else "false"
"false"
```

### File imports <a name="imports"></a>
The idea of importing files into a Nix expression is subtly different from most methods. Imports in
Nix are closed tied with sets. Presuming we have the file `meh.nix` that contains the following:

```
let
  meh = x: x + "meh";
in {
  meh = meh;
}
```

The let expression binds the name *meh* to a function that takes one argument. In the body of let,
it returns a set which contains one member with the name *meh*, the one on the left side of the
`=`. The value of this member is the function that was just defined. The important concept to
remember here is that this let expression returns an attribute set.

Let’s go back to the REPL to use this file:

```bash
nix-repl> import ./meh.nix
{ meh = «lambda»; }
```

We see again the familiar lambda term. The *meh* name here, as it shows, is a function. Now, how can
we dereference this value? With the use of the `.` operator!

```bash
nix-repl> (import ./meh.nix).meh "foo"
"foomeh"
```

We had to use parentheses because there is no such file as `meh.nix.meh` in the current
directory. If we’re going to step through it, it would like the following:

```bash
nix-repl> { meh = «lambda»; }.meh "foo"
```

then

```bash
nix-repl> { meh = (x: x + "meh"); }.meh "foo"
"foomeh"
```

This pretty sums up the introductory concepts about the Nix language. The rest of the hairy details
are available in the [manual](https://nixos.org/nix/manual/#ch-expression-language).


Miscellany
----------
This section contains concepts and information that are shared across the entire Nix ecosystem.


### Environments
An environment is a way of Nix of providing component isolations between system and users. In NixOS,
there are three enviroments: system enviroment, user environment, and user development environment.

The system enviroment is modified only by the root user who declares its value in
`/etc/nixos/configuration.nix`. It is a list which contains the packages that will be made available
to all users of the system. An excerpt of `/etc/nixos/configuration.nix` that uses the system
environment is:

```
{ config, lib, pkgs, ... }:

{
  ...
  environment.systemPackages = with pkgs; [ zsh vim ];
  ...
}
```

This declares that the packages named zsh and vim will be available for all users of the
system. The binaries will be available as `/run/current-system/sw/bin/zsh` and
`/run/current-system/sw/bin/vim`, for Zsh and Vim, respectively.

The user enviroment is the one that is used whenever the command `nix-env` is used. For example,
when installing Zsh using nix-env:

```bash
$ nix-env -iA nixos.zsh
```

Zsh only becomes explicity avaible for the user invoking it. If the username who ran that command is
`john`, then the Zsh binary will be available as `/home/john/.nix-profile/bin/zsh`. If the user
`mary` hasn’t installed Zsh to her profile, then it is unavailable to her. If `mary` has the same
channel as `john`, and she run that nix-env command, then Nix  will no longer need to fetch
the Zsh program data, from scratch. Instead, Nix makes the Zsh program data, created by the nix-env
processes that `john` used earlier, to make Zsh available to `mary`. However, if `mary` uses the git
checkout, or a different version of channels than the one used by `john`, and the versions of Zsh
differ from the version of `john`, then the invocation of `nix-env` by `mary` will fetch a newer
instance of Zsh.

The third enviroment, user development enviroments, are created with the use of
`nix-shell`. `nix-shell` allows the user to create sandboxed environments. The enviroment created is
isolated from the system and regular user environments. The enviroment created will still use
`/nix/store`, but neither `/run/current-system/sw/` nor `~/.nix-profile/` will be accessed. What
*nix-shell* provides is an environment that is separated from the rest of the system, allowing the
user to create ad-hoc deployments, without worries of altering system state. With this, a user gains
the ability, for example, to use an environment to test out different deployments of an application,
or to compare features prior to delivery.


### User commands
- nix-instantiate
- nix-store
- nix-build


### nix-shell
- nix-shell -p vim emacs


### Configuration
- `~/.nixpkgs/config.nix`


Closing remarks <a name="closing"></a>
--------------------------------------

Docker, along with Kubernetes and OpenShift solves a different class of Docker is good at what it
does, and it does it well. However, the key philosophy with Docker is that it assumes that the
underlying systems may not exhibit reproducibility. Hence, treating them as expendables.

- purely functional
- stateless
- declarative

Building Declarative Deterministic Systems with Nix

flatpak

Special mention goes to [Francois-Rene Rideau](https://fare.livejournal.com) who introduced me to
NixOS several years ago.

emacs nix mode

https://medium.com/@MrJamesFisher/nix-by-example-a0063a1a4c55
https://lethalman.blogspot.com/2014/07/nix-pill-1-why-you-should-give-it-try.html
