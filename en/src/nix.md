A Gentle Introduction to the Nix Family
=======================================

<div class="center">March 22, 2017</div>
<div class="center">Updated: April 6, 2017</div>

>Don’t worry about what anybody else is going to do. The best way to predict the future is to
>invent it.<br>
>―Alan Kay

Ideas that change the way we do computing come rarely. A lot of the technology that we are using now
are just re-hashes of old ones—layers upon layers of cosmetics enveloping old concepts. Entire
product lines are based upon this lack of creativity and ingenuity. Old problems are not
solved. Instead, these so-called innovative solutions merely pass around the problem while painting
it with new shades, claiming that at least, they made it more colorful. This mentality harms
progress in innumerable ways. This gives the false impression that solutions are actually being
done. This creates a false sense of assurance of improvements.

Several years ago [Eelco Dolstra](https://nixos.org/~eelco/) wrote the
seminal [papers](https://nixos.org/docs/papers.html) that described radical ways to deploy
software. These papers effectively formed the cornerstones of [Nix](https://nixos.org/nix/), a
purely functional package manager language that solved the disease that plagued computing for a long
time—poor package management. In this article I’ll talk about the Nix family, and how to use them to
your advantage.

The `$` symbol will be used to indicate the shell prompt for a regular user, while the `#` symbol
will denote the shell for the root user. There are cases when
the [EUID](https://en.wikipedia.org/wiki/User_identifier#Effective_user_ID) of a command will be
zero (0) due to the use of sudo.


Table of contents
-----------------

- [NixOS](#nixos)
  + [Installation](#nixosinstallation)
    * [Boot machine](#nixosboot)
    * [Setup networking](#nixosnetworking)
    * [Prepare disks](#nixosdisks)
    * [Install to disk](#nixosinstall)
  + [Configuration](#nixosconfiguration)
- [Nix](#nix)
  + [Strings](#nixstrings)
  + [Numbers](#nixnumbers)
  + [Booleans](#nixbooleans)
  + [Lists](#nixlists)
  + [Sets](#nixsets)
  + [Paths](#nixpaths)
  + [Functions](#nixfunctions)
  + [Let](#nixlet)
  + [With](#nixwith)
  + [Conditionals](#nixconditionals)
  + [File imports](#niximports)
- [Nixpkgs](#nixpkgs)
  + [Installation](#nixpkgsinstallation)
  + [Usage](#nixpkgsusage)
    * [Git checkout](#nixpkgsgit)
    * [Channels](#nixpkgschannels)
    * [Other commands](#nixpkgsother)
  + [Configuration](#nixpkgsconfiguration)
  + [Contributing](#nixpkgscontribute)
    * [Updating an existing package](#nixpkgsupdateexisting)
    * [Submitting a new package](#nixpkgssubmitnew)
  + [Notes](#nixpkgsnotes)
- [Environments](#environments)
  + [System environment](#systemenvironment)
  + [User environment](#userenvironment)
  + [Development environment](#developmentenvironment)
- [Closing remarks](#closing)
- [Bonus](#bonus)


<a name="nixos"></a> NixOS
--------------------------

How many times have you had a broken system because you upgraded a software that other components
depended on? How many late night stays have you had because you had to make an application work,
because the new package that you installed broke it? How many times, when in frustration, you gave
up repairing your system and just decided to re-install your system from scratch? Restoring data
files are easy; restoring system configuration from the last working state, however, is a one-way
ticket to hell.

[NixOS](https://nixos.org) is a Linux distribution that solves these problems by leveraging on the
determinism of [Nix](https://nixos.org/nix) and by using a single declarative configuration file
that contains all settings and knobs in one place—`/etc/nixos/configuration.nix`. This file conntain
information about your filesystems, users, services, network configuration, input devices, kernel
parameters, and more. This means that you can take a `configuration.nix` of someone, and have his
exact system configuration! In NixOS you don’t have to fiddle around with the whole system manually
for configuration that want. You don’t have to use ad-hoc solutions to specify a desired
configuration state. You don’t need to install additional software to manage system configuration.

NixOS does not follow the [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard),
effectively preventing additional brain damage.  This gives room for a lot of flexibility and
ingenuity. It does not have `/usr/` and `/opt/`. It does have `/bin/`, which contains only `sh` and
`/usr/bin/` which contains only `env`—both of which are actually symlinks to the real programs
somewhere in `/nix/store/`. The top-level location for system binaries—the ones installed explicitly
by the administrator—are located in `/run/current-system/sw/bin/` and
`/run/current-system/sw/sbin/`.  User-installed programs, on the other hand, are available at their
respective `~/.nix-profile/bin/`. These locations cannot be modified through normal means; dedicated
programs must be used to write to these trees.


### <a name="nixosinstallation"></a> Installation

Installation of NixOS is straightforward. For bare metal systems, download an installer
from [https://nixos.org/nixos/download.html](https://nixos.org/nixos/download.html). VM images are
also available from that page. For my last installation, I installed with the following setup:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- USB boot
- Wi-Fi connectivity
- [GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)
- [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) over [LVM](https://en.wikipedia.org/wiki/Logical_volume_management)


#### <a name="nixosboot"></a> Boot machine

Boot from the USB drive in UEFI mode. On the login prompt, login as `root`.


#### <a name="nixosnetworking"></a> Setup networking

Scan for available networks

    # nmcli d wifi list

Then, connect to the router of choice

    # nmcli d wifi con Foobarbaz name Foo password supersecretkey


#### <a name="nixosdisks"></a> Prepare disks

Create the partitions

    # gdisk /dev/sda
    sda1: EF00 (EFI system), 512 MiB
    sda2: 8E00 (Linux LVM), rest

Format `/dev/sda1`

    # mkfs.vfat -F32 /dev/sda1

Create the physical volume

    # pvcreate /dev/sda2

Create the volume group

    vgcreate vg /dev/sda2

Create the logical volumes

    # lvcreate -L 20G -n swap vg
    # lvcreate -l 100%FREE -n root vg

Encrypt root

    # cryptsetup luksFormat /dev/vg/root
    # cryptsetup luksOpen /dev/vg/root root

Format root

    # mkfs.ext4 -j -L root /dev/mapper/root

Format swap

    # mkswap -L /dev/vg/swap

Mount the filesystems

    # mount /dev/mapper/root /mnt
    # mkdir /mnt/boot
    # mount /dev/sda1 /mnt/boot

Enable swap

    # swapon /dev/vg/swap


#### <a name="nixosinstall"></a> Install to disk

Create the base config

    # nixos-generate-config --root /mnt

Edit the config file

    nano /mnt/etc/nixos/configuration.nix

To give you a headstart, you may use a trimmed-down version
of [my configuration](https://github.com/ebzzry/dotfiles/blob/master/nixos/configuration.nix)
follows. Replace the values as it suits you. All available configuration knobs are
available [here](https://nixos.org/nixos/options.html).


```nix
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
    extraUsers.ogag = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
    defaultUserShell = "/run/current-system/sw/bin/zsh";
  };
}
```

Save this with:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/ZTQcGs

A longer version is available at:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/K4P7l5

Replace the UUID of the disk with the one that you have. Use the command `blkid` to get the
UUIDs. For `networking.hostID`, use the following command:

    # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done

The above configuration specifies the following, among other things:

- It creates a user `ogag` with full sudo access
- It uses KDE 5 as the desktop environment
- It enables SSH
- It specifies the LUKS parameters

Install NixOS to the disk

    # nixos-install

This will parse `/etc/nixos/configuration.nix`, making sure that there are no errors. This command
will download all the necessary packages to match the specification, making sure that no stones are
left unturned.

When the installation completes, reboot your system:

    # reboot


### <a name="nixosconfiguration"></a> Configuration

After installation, updating your existing configuration is trivial. All you have to do is edit the
configuration file then rebuild the system:

    # nano /etc/nixos/configuration.nix
    # nixos-rebuild switch

If you make a mistake, the system will notify you of it, instead of proceeding with an incorrect
configuration. After the system has completed booting, switch to the console <kbd>Ctrl+Alt+F1</kbd>,
then login as `root`, then set a password for the user that we specified in `configuration.nix`:

    # passwd ogag

Exit the shell, switch to the graphical interface <kbd>Alt+F7</kbd>, then login as `ogag`.


<a name="nix"></a> Nix
----------------------

The component that forms the heart of NixOS and Nixpkgs is the [Nix](https://nixos.org/nix)
language. It is a declarative language designed in mind to handle packages.

To make it easier to understand the language, let’s install the Nix REPL:

    $ nix-env -iA $(nix-channel --list | awk '{print $1}').nix-repl

Next, let’s run it. You’ll be greeted with the version number, and the nix-repl prompt. At the time
of writing, the latest stable version is 1.11.8:

```nix
$ nix-repl
Welcome to Nix version 1.11.8. Type :? for help.

nix-repl>
```

Let’s try out some basic expressions.


### <a name="nixstrings"></a> Strings

Just like in other languages, strings evaluate to themselves:

```nix
nix-repl> "foo"
"foo"
```

To concatenate strings, use the `+` operator:

```nix
nix-repl> "foo" + "bar"
"foobar"
```

Another way to declare strings is to use two pairs of single quotes. Do not mistake it with the
double quotes:

```nix
nix-repl> ''foo bar''
"foo bar"
```

The advantage of using `''` over `"` is that allows the presence of `"` inside it:

```nix
nix-repl> ''"foo" "bar"''
"\"foo\" \"bar\"\"
```

The value that it then returns will be properly quoted. This is useful later when we’re going to
build complex expressions.

To deference strings inside strings, use the `${name}` form:

```nix
nix-repl> x = "foo"

nix-repl> y = "bar"

nix-repl> "${x} ${y}"
"foo bar"

nix-repl> ''${x} ${y}''
"foo bar"
```


### <a name="nixnumbers"></a> Numbers

Basic arithmetic operations in Nix are included, with a small twist:

```nix
nix-repl> 6+2
8

nix-repl> 6-2
4

nix-repl> 6*2
12

nix-repl> 6/2
/home/ogag/6/2
```

Oops, that wasn’t what we expected. Since Nix was designed with files and directories in mind, it
made a special case that when a `/` character is surrounded by non-space characters, it interprets
it as a directory path, resulting in an absolute path. To actually perform division, add at least
one space before and after the `/` character:

```nix
nix-repl> 6 / 2
```

There are no floating point numbers in Nix. So, if you try to evaluate one, you’ll get:

```nix
nix-repl> 1.0
error: syntax error, unexpected INT, expecting ID or OR_KW or DOLLAR_CURLY or '"', at (string):1:3
'"'
```

The function `builtins.div` does essentially the same as `/`:

```nix
nix-repl> builtins.div 6 3
2
```

The difference, however, is that `builtins.div` can be applied partially:

```nix
nix-repl> (builtins.div 6)
«primop-app»
```

This expressions returns a closure of a partially applied function. We need another value to fully
apply it:

```nix
nix-repl> (builtins.div 6) 3
2
```

We can even store the value of that partial application:

```nix
nix-repl> d = builtins.div 6
```

The `=` operator in Nix is used to bind values. In this example, it is used to define a partial
application. To use that function:

```nix
nix-repl> d 3
2
```


### <a name="nixbooleans"></a> Booleans

Truth- and falsehood are represented with `true` and `false`:

```nix
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


### <a name="nixlists"></a> Lists

Lists are heterogeneous types for containing serial values. Elements are separated by spaces:

```nix
nix-repl> [ 1 "foo" true ]
[ 1 "foo" true ]
```

To concatenate lists:

```nix
nix-repl> [ 1 "foo" true ] ++ [ false (6 / 2) ]
[ 1 "foo" true false 3 ]
```

To extract the head:

```nix
nix-repl> builtins.head ([ 1 "foo" true (6 / 2) ] ++ [ false (6 / 2) ])
1
```

To extract the tail:

```nix
nix-repl> builtins.tail ([ 1 "foo" true (6 / 2) ] ++ [ false (6 / 2) ])
[ "foo" true 3 false 3 ]
```

Lists are indexed starting
at [0](https://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD831.html). To get the *1th*
element, use the `builtins.elemAt` operator:

```nix
nix-repl> builtins.elemAt [ 1 "foo" true ] 1
"foo"
```


### <a name="nixsets"></a> Sets

An important data structure in Nix are sets. They are keyword-value pairs separated by semi-colons:

```nix
nix-repl> { a = 0; b = "bar"; c = true; d = (6 / 2); }
```

What makes sets different from lists is that extracting values from them are done by making name
references. To extract the value of `b`, use the `.` operator:

```nix
nix-repl> { a = 0; b = "bar"; c = true; d = (6 / 2); }.b
"bar"
```

which is equivalent to:

```nix
nix-repl> { a = 0; b = "bar"; c = true; d = (6 / 2); }."b"
"bar"
```

To dereference a member from the same set, use the `rec` keyword:

```nix
nix-repl> rec { a = 0; b = "bar"; c = true; d = (6 / 2); e = b; }.e
"bar"
```


### <a name="nixpaths"></a> Paths

In Nix all paths are translated to absolute ones. If you make a reference to a file in the current
directory:

```nix
nix-repl> ./foo
/home/ogag/foo
```

It gets translated to an absolute path. This is a Good Thing™.

Similarly, if you make a reference to a relative path inside an absolute path, it still gets
translated to an absolute one:

```nix
nix-repl> /./foo
/foo
```

Note, however, that Nix doesn’t like paths that stand alone:

```nix
nix-repl> /
error: syntax error, unexpected '/', at (string):1:1

nix-repl> ./
error: syntax error, unexpected '.', at (string):1:1
```


### <a name="nixfunctions"></a> Functions

What fun would it be if there’ll be no verbs to use with these nouns? Functions in Nix share
similarities with other languages while having its own unique traits.

The most basic form of a function follows:

```nix
nix-repl> x: x
«lambda»
```

This expression creates an anonymous function that returns its
argument—the [identity function](https://en.wikipedia.org/wiki/Identity_function). The colon after
the first *x* indicates that it is a parameter to the function, just like
in [lambda calculus](/en/lambda-calculus/#functions). Also, the names do not matter
due to [alpha equivalence](https://en.wikipedia.org/wiki/Lambda_calculus#Alpha_equivalence):

```nix
nix-repl> foo-bar-baz: foo-bar-baz
«lambda»
```

These functions are not of much use because they are not captured for application. If we want to use
it, for example with the argument `"foo"`, we need to surround it with parentheses:

```nix
nix-repl> (x: x) "foo"
"foo"
```

To add more fun, let’s name that function:

```nix
nix-repl> identity = x: x
```

Sweet! Now, let’s apply it:

```nix
nix-repl> identity "foo"
"foo"
```

Let’s create a function that appends `" ugh"` to its input, then let’s apply it:

```nix
nix-repl> ugh = s: s + " ugh"

nix-repl> ugh "me"
"me ugh"
```

To define a function that takes another argument, let’s use the following form:

```nix
nix-repl> ugh = s: t: s + " ugh " + t

nix-repl> ugh "me" "you"
"me ugh you"
```

The pattern is that to add an additional parameter, use the `name: ` form.

Sets, when used with functions, enable more powerful abstractions. We can pass a set as an argument
to a function, which will then use the data inside that set:

```nix
nix-repl> poof = { a, b }: x: a + " " + b + x
```

This function has two parameters: `{ a, b }`—a parameter specification for a set with two elements,
and `x`—a regular parameter. Take note, that the parameter specification is not a real set, but
merely a way to match arguments; it uses a comma, as value separator. Inside this function we
combine the inputs with the `+` operator. To use this function, we’d do it like:

```nix
nix-repl> poof { a = "ugh"; b = "me"; } " poof"
"ugh me poof"
```

When a function declares a set as its parameter, you need to specify the keywords when invoking the
function that uses them. In this case the keyword names are `a` and `b`.

The definition of `poof` above is semantically similar to:

```nix
nix-repl> poof = meh: x: meh.a + " " + meh.b + x
```

We used a regular, non-set parameter here so that it can refer to the set as a value. Observe this:

```nix
nix-repl> meh = { a = "foo"; b = "bar"; }

nix-repl> meh.a
"foo"
```

It is also possible to specify default values. When a parameter with default value is not used, the
default value is used. They are declared similarly in Common Lisp:

```lisp
(defun foop (a &optional (b "O.o"))
  (concatenate 'string a b'))
```

```nix
nix-repl> foop = { a, b ? "O.o" }: a + b

nix-repl> foop { a = "goo"; }
"gooO.o"

nix-repl> foop { a = "goo"; b = "oog"; }
"goooog"
```

To add even more flexibility, Nix supports the use of pseudorest arguments. Let’s modify the
function from above:

```nix
nix-repl> foop = { a, b, ...}: a + b
```

Let’s use it:

```nix
nix-repl> foop { a = "meh"; b = "foo"; }
"mehfoo"
```

The same. So how can we make use of that flexibility, then? We’ll create a label for the attribute
set, so that we can refer to the ‘extra’ values:

```nix
nix-repl> foop = attrs@{ a, b, ...}: a + b + attrs.blah
```

We use it just like before, but with the use of the label:

```nix
nix-repl> foop { a = "goo"; b = "oog"; c = "hhh"; }
"gooooghhh"
```

I said ‘pseudo’ because the value for `c` was still required.

Default values and variable arity can be combined together:

```nix
nix-repl> foop = attrs@{ a, b, c ? "C", ... }: a + b + c + attrs.d

nix-repl> foop { a = "A"; b = "B"; d = "D"; }
"ABCD"

nix-repl> foop { a = "A"; b = "B"; c = "X"; d = "D"; }
"ABXD"

```


### <a name="nixlet"></a> Let

The keyword `let` lets (pun not intended) us define variables in a local scope. For example, to make
the identifiers `x` and `y` visible only in a local scope:

```nix
nix-repl> let x = "foo"; y = "bar"; in x + poof { a = "huh"; b = "really"; } "hmm" + y
"foohuh reallyhmmbar"
```

Take note of the last `;` before the `in` keyword that goes with `let`—it marks the start of the
`let` body. The let construct behaves in similar ways to the `let` keyword found in languages like
Lisp and Haskell.


### <a name="nixwith"></a> With

The keyword `with` lets you ‘drop’ set values in a scope:

```nix
nix-repl> with { x = "foo"; y = "bar"; }; poof { a = y; b = x; } " xyz"
"bar foo xyz"
```

What happened here is that the values inside that set were ‘unveiled’ to make them available in the
`with` body.


### <a name="nixconditionals"></a> Conditionals

Conditional expressions are done with the `if` keyword. It has a similar form with mainstream
languages:

```nix
nix-repl> if true then "true" else "false"
"true"
```

It can also be nested:

```nix
nix-repl> if false then "true" else if false then "true" else if false then "true" else "false"
"false"
```


### <a name="niximports"></a> File imports

The idea of importing files into a Nix expression is subtly different from other languages. Imports
in Nix are closely tied with sets. Presuming we have the file `meh.nix` that contains the following:

```nix
let
  meh = x: x + "meh";
in {
  meh = meh;
}
```

The let expression binds the name *meh* to a function that takes one argument. In the body of let,
it returns a set which contains one member with the name *meh*—the one on the left side of the
`=`. The value of this member is the function that was just defined. The important concept to
remember here is that this let expression returns an attribute set.

Let’s go back to the REPL to use this file:

```nix
nix-repl> import ./meh.nix
{ meh = «lambda»; }
```

We see again the familiar lambda term. The *meh* name here, as it shows, is a function. Now, how can
we dereference this value? With the use of the `.` operator!

```nix
nix-repl> (import ./meh.nix).meh "foo"
"foomeh"
```

We had to use parentheses because there is no such file as `meh.nix.meh` in the current
directory. If we’re going to step through it, it would like the following:

```nix
nix-repl> { meh = «lambda»; }.meh "foo"
```

becoming:

```nix
nix-repl> { meh = (x: x + "meh"); }.meh "foo"
"foomeh"
```

This pretty sums up the introductory concepts about the Nix language. The rest of the hairy details
are available in the [manual](https://nixos.org/nix/manual/#ch-expression-language).


<a name="nixpkgs"></a> Nixpkgs
------------------------------

Nixpkgs is a collection of thousands of packages curated and maintained by users worldwide. Since
the source code is in [GitHub](https://github.com/nixos/nixpkgs), it is able to take advantage of
the powerful collaboration models that that platform offers. At the time of writing, there are
almost 6500 packages in [the collection](https://nixos.org/nixos/packages.html). It contains a wide
array of packages ranging from productivity applications to theorem provers.

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
same application that is being used by Mary and Peter get upgraded, too!. That’s not a good thing if
they prefer the old version that works with them! Nixpkgs allows you have multiple versions of a
software, without collisions from the other versions. John, Mary, and Peter can all have their
versions of Firefox without conflicting with the other versions. How does it do it? It does it by
naming components by their computed checksums, and by not using a common global location.

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


### <a name="nixpkgsinstallation"></a> Installation

Skip this step if you are using NixOS because Nixpkgs already comes with it. To install Nixpkgs on
GNU/Linux or macOS, run:

    $ curl https://nixos.org/nix/install | bash

You’ll be prompted to enter credentials for root access via sudo because it will install the
resources to `/nix/`. After the installation, you may also be requested to append a line of command
to your shell initialization file. When you spawn a new shell instance, the Nix-specific commands
will be available for use.


### <a name="nixpkgsusage"></a> Usage

There are two ways to install packages with Nixpkgs: the git checkout, which is the bleeding edge,
up-to-the-minute updated version, or by using
channels. The [git repository](https://github.com/nixos/nixpkgs) is ideal for people who want to use
the latest and greatest available version of a package, or for those who want to test things
out. [Channels](https://nixos.org/channels/) on the other hand, are essentially snapshots of the git
repository at an earlier version.


#### <a name="nixpkgsgit"></a> Git checkout

Updates to the git repository happen frequently—as you are reading this
article,
[new commits](https://github.com/nixos/nixpkgs/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aclosed) are
made to the main tree. To use the git checkout, clone
the [repository](https://github.com/nixos/nixpkgs):

    $ git clone https://github.com/nixos/nixpkgs ~/nixpkgs

This command creates a `nixpkgs/` directory under your home. If your username is `ogag`, the
clone of the repository is available at `/home/ogag/nixpkgs/` or `/Users/ogag/nixpkgs`, if you’re
using a GNU/Linux or macOS, respectively.

To install a package, say emem—a Markdown to HTML converter—using the git checkout, run:

    $ nix-env -f ~/nixpkgs/default.nix -iA emem

This will download emem along with all its dependencies, and then it will make the program available
to you. To make sure that emem has successfully installed, run:

    $ emem --version

If your shell doesn’t barf and complain that you’re looking for something that does not exist, and instead
you see a version number, it means that you have successfully installed emem.

To get the most recent changes from the git repo, run:

    $ cd ~/nixpkgs && git pull origin master


#### <a name="nixpkgschannels"></a> Channels

Installing packages via channels is nicer, because the commands to install packages with it are more
convenient. The trade-off is that the packages will be out-of-date by a few weeks. If you’re fine
with it, then use channels instead of the git checkout.

Channels are labeled **stable**, **unstable**, or with a specific version number, e.g., **16.09** or
**17.03**. For this article, let’s use the unstable channel—it’s not as dated as stable, nor as
recent as the git checkout. To subscribe to the unstable channel, run:

    $ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs

This fetches the channel labeled `nixpkgs-unstable` from nixos.org, then installs it to your user
profile.

To browse the list of channels, go [here](https://nixos.org/channels/).

Using the example above, to install emem, run the following commands for NixOS and other systems,
respectively:

    $ nix-env -iA nixos.emem

    $ nix-env -iA nixpkgs.emem

To update your channels, run:

    $ nix-channel --update

Over time, trees in `/nix/store/` accumulate and there may be paths that are no longer referenced by
any package. To clean it up, run:

    $ nix-collect-garbage


### <a name="nixpkgsother"></a> Other commands

To uninstall a package, run:

    $ nix-env -e emem

To list all your installed packages, run:

    $ nix-env -q --installed

To list all available packages, run:

    $ nix-env -q --available

If you know the binary name of a program, and you want to know which package does it belong to, run:

    $ command-not-found emem


### <a name="nixpkgsconfiguration"></a> Configuration

The file `~/.nixpkgs/config.nix` is a Nix expression, which is read by the Nix commands. In it, we’re
able to specify package overrides—configuration that supplants default settings, and other knobs
including, but not limited to, browser plugins, GUI configurations, SSL, etc.

Let’s take a look at a trimmed-down version of my `config.nix`:

```
{ pkgs }:

{
  packageOverrides = pkgs: {
    emacs = pkgs.emacs.override {
      withGTK2 = false;
      withGTK3 = false;
      withXwidgets = false;
    };
  };

  firefox = {
    jre = true;
    enableGoogleTalkPlugin = true;
  };

  allowUnfree = true;
}
```

This is a function, that takes an attribute as parameter, then yields another attribute set as
return value. My _config.nix_ says that I don’t want GTK for Emacs. For Firefox, I specified that I
want to use the JRE and the Google Talk plugin. Lastly, I am specifying that I want to be able to
install software which doesn’t have open source licenses, or software that doesn’t follow the free
software model.


### <a name="nixpkgscontribute"></a> Contributing

The collaboration model of Nixpkgs rests with git and GitHub. To contribute a package or update an
existing one, fork the [Nixpkgs](https://github.com/nixos/nixpkgs/) repository into your own GitHub
account, make changes into a new branch, then create a pull request.


#### <a name="nixpkgsupdateexisting"></a> Updating existing package

After you have forked the repository, clone your version of the repository.

    $ git clone git@github.com:ogag/nixpkgs.git ~/nixpkgs

This will create a copy of your fork in the root of your home directory. Head over to that
directory, then let’s examine its contents:

```bash
$ cd ~/nixpkgs
$ tree -aFL 1
.
├── COPYING
├── default.nix
├── doc/
├── .editorconfig
├── .git/
├── .github/
├── .gitignore
├── lib/
├── maintainers/
├── .mention-bot
├── nixos/
├── pkgs/
├── README.md
├── .travis.yml
├── .version
└── .version-suffix

7 directories, 9 files
```

Next, let’s find where the package lives, for example Hello.

    $ grep hello pkgs/top-level/all-packages.nix
      hello = callPackage ../applications/misc/hello { };

It says here that the package Hello is available under `../applications/misc/hello`. Relative to the
file `all-packages.nix`, the path is at `pkgs/applications/misc/hello` or
`~/nixpkgs/pkgs/applications/misc/hello`. Let’s go there:

    $ cd pkgs/applications/misc/hello
    $ ls
    default.nix

Open the file `default.nix`:

```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "hello-2.10";

  src = fetchurl {
    url = "mirror://gnu/hello/${name}.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };

  doCheck = true;

  meta = {
    description = "A program that produces a familiar, friendly greeting";
    longDescription = ''
      GNU Hello is a program that prints "Hello, world!" when you run it.
      It is fully customizable.
    '';
    homepage = http://www.gnu.org/software/hello/manual/;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.eelco ];
    platforms = stdenv.lib.platforms.all;
  };
}
```

This tells us that `default.nix`, is a function with a parameter as an attribute with two
elements. The function returns the result of calling `stdenv.mkDerivation` with the input of an
attribute value. The value for the `name` attribute is a string with the format *packagename-X.Y.Z*,
where packagename is the name of the package and X.Y.Z is the version number. The value for the
`src` attribute is the value returned by calling the `fetchurl` function, with another set attribute
argument. The value for the `url` attribute should either be a mirror specification, as described in
`pkgs/build-support/fetchurl/mirrors.nix`, or a standard URL. In this instance, we used the GNU
mirror and we interpolated the `name` variable inside that string. The value of the `sha256`
attribute is the one we get by running `nix-prefetch-url` against the URL. To get the checksum for
`hello-2.10`, run:

```bash
$ nix-prefetch-url http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz
downloading ‘http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz’... [622/709 KiB, 64.6 KiB/s]
path is ‘/nix/store/3x7dwzq014bblazs7kq20p9hyzz0qh8g-hello-2.10.tar.gz’
0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i
```

It matched the SHA256 specification above.

The `doCheck` attribute instructs Nix to run the tests for this package.

The value for the `meta` attribute is another attribute set specification for other details
regarding the package. The values specified here will help Nix programs classify the package, among
other things. The `description` attribute is a short string describing the purpose of the
package. The `longDescription` attribute is a longer, possibly multi-line string describe the
package in more details. The `homepage` attribute is a URL to the WWW home of the package. You don’t
need to quote it with single or double quotes explicitly—it does that internally. You still have to
quote a URL if you use variable interpolation. The `maintainers` attribute is a list of the people
handling that package. The `platforms` attribute is important; it categorizes a package properly—we
don’t want to build a package on macOS that only runs on GNU/Linux.

If a newer version of Hello comes out, say version 2.11, modify the appropriate attributes. But
first, let’s create a separate branch for it:

    $ git checkout -b hello-2.11

In `default.nix`, change the name to `hello-2.11` and update the `sha256` attribute,
too. Additionally, if you’re on NixOS, add the following values to `/etc/nixos/configuration.nix`:

    nix.useSandbox = true;

If you’re using another GNU/Linux system, or macOS, add the following to `/etc/nix/nix.conf`:

    build-use-sandbox = relaxed

Next, build the package:

    $ cd ~/nixpkgs
    $ nix-build -A hello

If the build went successful, a symlink named `result`, in the current directory will be
created. This symlink points to a path in `/nix/store/`. Let’s run the program:

    $ ./result/bin/hello
    Hello, world!

Good. Commit the changes.

    $ git add -u
    $ git commit -m 'hello: 2.10 -> 2.11'
    $ git push origin hello-2.11

Finally, go to the GitHub repo [page](https://github.com/nixos/nixpkgs), then create a pull request
(PR) between `nixos/nixpkgs:master` and `ogag/nixpkgs:hello-2.11`.


#### <a name="nixpkgssubmitnew"></a> Submitting a new package

The steps for submitting a new package is pretty much the same as with updating an existing one,
except for a few things.

At the start, create a new branch for your package:

    $ cd ~/nixpkgs
    $ git checkout -b tthsum-1.3.2

Then, decide what category should it belong to:

    $ cd pkgs/applications/misc
    $ mkdir tthsum

Create the `default.nix` file:

```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "tthsum-${version}";
  version = "1.3.2";

  src = fetchurl {
    url = "http://tthsum.devs.nu/pkg/tthsum-${version}.tar.bz2";
    sha256 = "0z6jq8lbg9rasv98kxfs56936dgpgzsg3yc9k52878qfw1l2bp59";
  };

  installPhase = ''
    mkdir -p $out/bin $out/share/man/man1
    cp share/tthsum.1.gz $out/share/man/man1
    cp obj-unix/tthsum $out/bin
  '';

  meta = with stdenv.lib; {
    description = "An md5sum-alike program that works with Tiger/THEX hashes";
    longDescription = ''
      tthsum generates or checks TTH checksums (root of the THEX hash
      tree). The Merkle Hash Tree, invented by Ralph Merkle, is a hash
      construct that exhibits desirable properties for verifying the
      integrity of files and file subranges in an incremental or
      out-of-order fashion. tthsum uses the Tiger hash algorithm for
      both the internal and the leaf nodes.
    '';
    homepage = http://tthsum.devs.nu/;
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.ebzzry ];
    platforms = platforms.unix;
  };
}
```

What’s new here is the `installPhase` attribute. The default build procedures of the tthsum package
is different from the way Nix handles installations, so we have to be explicit about it. The `$out`
identifier refers to the final directory where the program will reside in `/nix/store/`. In the user
environment, the program will be available as `~/.nix-profile/bin/tthsum`, and for the system
environment, it will be available as `/run/current-system/sw/bin/tthsum`.

At this point, Nix is still not aware of tthsum. We have to declare it at the top level. To do so,
edit the file `pkgs/top-level/all-packages.nix`, and add the following in the correct category:

```nix
tthsum = callPackage ../applications/misc/tthsum { };
```

Next, build the package as described above:

    $ cd ~/nixpkgs
    $ nix-build -A tthsum

If everything goes well, commit the changes:

    $ git add pkgs/applications/misc/tthsum
    $ git add pkgs/top-level/all-packages.nix
    $ git commit -m "tthsum: init at 1.3.2"
    $ git push origin tthsum-1.3.2

Finally, go to the GitHub repo [page](https://github.com/nixos/nixpkgs), then create a pull request
(PR) between `nixos/nixpkgs:master` and `ogag/nixpkgs:tthsum-1.3.2`.


### <a name="nixpkgsnotes"></a> Notes

If at any point during the installation of a package, the process is interrupted, the package being
installed will not be in a half-baked state. The very last step of installing a package is
atomic. The secret to it is that it the operation that makes it available to a user creates a
symlink from `/nix/store`, where the actual program data is, to your profile, which is located at
`~/.nix-profile/`. Symbolic link creation in GNU/Linux and macOS are either successful or
not.

On NixOS, the channel used by the root user is important because it is the one used when rebuilding
the system with `nixos-rebuild switch` after changes to `/etc/nixos/configuration.nix` are made. To
make sure that you using the right channel, list it with:

    $ sudo nix-channel --list

To change the root channel similar to the one used above:

    $ sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos


<a name="environments"></a> Environments
----------------------------------------

An environment is a way of Nix of providing component isolation between system and users. In NixOS,
there are three environments: system environment, user environment, and development environment.


### <a name="systemenvironment"></a> System environment

The system environment is modified only by the root user who declares its value in
`/etc/nixos/configuration.nix`. It is a list which contains the packages that will be made available
to all users of the system. An excerpt of `/etc/nixos/configuration.nix` that uses the system
environment is:

```nix
{ config, lib, pkgs, ... }:

{
  ...
  environment.systemPackages = with pkgs; [ zsh vim ];
  ...
}
```

This declares that the packages named *zsh* and *vim* will be available for all users of the
system. The binaries will be available as `/run/current-system/sw/bin/zsh` and
`/run/current-system/sw/bin/vim`, for Zsh and Vim, respectively.


### <a name="userenvironment"></a> User environment

The user environment is the one that is used whenever the command `nix-env` is used. For example,
when installing Zsh using nix-env:

    $ nix-env -iA nixos.zsh

Zsh only becomes explicitly available for the user invoking it. If `john` is the username who ran
that command, then the Zsh binary will be available as `/home/john/.nix-profile/bin/zsh`. If the
user `mary` hasn’t installed Zsh to her profile, then it is unavailable to her. If Mary has the same
channel as John, and she runs the same nix-env command, then Nix will no longer need to fetch the
Zsh program data, from scratch. Instead, Nix makes the Zsh program data, created by the nix-env
process that John used earlier, to make Zsh available to Mary. However, if Mary uses the git
checkout, or a different version of channels than the one used by John, and the versions of Zsh
differ from the version of John, then the invocation of `nix-env` by Mary will fetch a newer
instance of Zsh.


### <a name="developmentenvironment"></a> Development environment

The third environment, development environments, are created with the use of
*nix-shell*. `nix-shell` allows the user to create sandboxed environments. The environment created is
isolated from the system and regular user environments. The environment created will still use
`/nix/store`, but neither `/run/current-system/sw/` nor `~/.nix-profile/` will be modified. What
*nix-shell* provides is an environment that is separated from the rest of the system, allowing the
user to create ad-hoc deployments, without worries of altering system state. With this, a user gains
the ability, for example, to use an environment to test out different deployments of an application,
or to compare features prior to delivery.

On macOS, the system environment is not used.

To create environments that are disjunct from the rest of the system, we need to have a way to
separate the dependencies of an application and its data itself, from normal system
intervention. The `nix-shell` allows us to create thin layers of abstraction while still taking
advantage of the determinism and resource management of Nix itself.

To illustrate, let’s check that we don’t have [GNU Hello](https://www.gnu.org/software/hello/)
installed, yet:

    $ which hello
    hello not found

If that is the case, good. Otherwise, remove the Hello package first.

Now, to demonstrate `nix-shell`, let’s run GNU Hello in the nix-shell, then it will return back to
the user shell:

    $ nix-shell --packages hello --pure --run hello
    Hello, world!
    $ which hello
    hello not found

What this does is that fetches the binary package for Hello, creates an clean shell environment,
then proceeds to run the `hello` binary, which will display to the screen the familiar greeting. If
the run option was omitted, we will be dropped in a shell:

    $ nix-shell --packages hello --pure
    [nix-shell:~]$ hello
    Hello, world!

This shell instance is special because it only contains sufficient information just to make Hello,
available. We can even inspect the value of `$PATH`, here:

```bash
[nix-shell:~]$ echo $PATH | tr ':' '\n'
/nix/store/kc912zn1ry1xilcm901ip7p8s1iqv0f1-hello-2.10/bin
/nix/store/f9q8k36x9jpi8jmdpwifcywzywpxvhrs-patchelf-0.9/bin
/nix/store/xx2bclrflkcvrddvp6bd3wsasqs7vsp1-paxctl-0.9/bin
/nix/store/4d6f8hg5gv20nsbq7b52qzn6bcs4fvlh-coreutils-8.26/bin
/nix/store/f3vl26f3n18khgq1kybnzvwjbm0r9grg-findutils-4.6.0/bin
/nix/store/mvnjpifk06yjffrsd50rpr3jjfrjsqiv-diffutils-3.5/bin
/nix/store/0xwrn1p8fp8h3cynszpgbmhmydbzhns5-gnused-4.4/bin
/nix/store/avmxym1w34sc17nrilsmgrk469l3ml0z-gnugrep-3.0/bin
/nix/store/2vh4wllg66rw61ffdfwp1xm4r2yns44j-gawk-4.1.3/bin
/nix/store/rhjsykhxrzj3ca8da6b4g6v1yx53xpi3-gnutar-1.29/bin
/nix/store/w1vlvxlavmz39by5xpnhva36q2lbi9hf-gzip-1.8/bin
/nix/store/mgvqw07ssjhf1hb96md97rjkfsrmfmp6-bzip2-1.0.6.0.1-bin/bin
/nix/store/69y0laqzizjycwaqivbsp273n0ag3ayi-gnumake-4.2.1/bin
/nix/store/86blj9iqyxwmdgkn3dyrpib1gkbmz91v-bash-4.4-p5/bin
/nix/store/qjklkl51d6qp98n8nncvbv62p01pp6qf-patch-2.7.5/bin
/nix/store/8pcap19p6qwf06ra4iaja3n6k6p2jzwg-xz-5.2.2-bin/bin
```

Your output is going to be different from mine because of the hashes in the store paths. Aside from
the store path of Hello, the rest are the minimal components of a nix-shell instance. This cluster
is called the *stdenv*.

nix-shell looks for the files `shell.nix` or `default.nix`, in that order, in the current directory
during startup, to load definitions from. Let’s create one, saving it as `default.nix`:

```nix
{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ hello emem ];
}
```

A *.nix* file is a Nix expression. In this example, it’s a function that takes one argument, with a default
value. The odd-looking `<nixpkgs>` refers to the value of the `nixpkgs` attribute declared in the
`NIX_PATH` environment variable. On NixOS, it looks like this:

    $ echo $NIX_PATH
    nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels

In the directory being pointed by the nixpkgs attribute, there’s a `.git-revision` file. Let’s view
its contents:

    $ cat /nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs/.git-revision
    1e8c01784a6a121fc94d111f4af7cc88dd932186

This tells us the version of Nixpkgs using channels on this profile.

Going back, the `with pkgs` declaration puts all the identifiers in the local scope, making them
visible. `stdenv`, which was mentioned earlier, is an attribute set which, among many things,
contain the `mkDerivation` identifier. `mkDerivation`, in turn, is a function that accepts one
attribute set argument. Let me remind you, that the curly braces after `mkDerivation` specify a
single unit of argument, which is the attribute set; it has no semantic resemblance to the curly
braces found in other languages to delimit the start and end of a function scope. There are many
knobs to it, but for the purposes of simplicity, we’ll only look at `name` and `buildInputs`—the
bare attribute parameters.

For our trivial example, the value of `name` can be anything. The value of `buildInputs`, however,
is important. Here, they’re declared to be `hello` and `emem`. These are references to values inside
the `nixpkgs` marker that we saw earlier. Had we not used `with pkgs`, the expression would be:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ pkgs.hello pkgs.emem ];
```

To feed this expression to nix-shell, making use of both *hello* and *emem*, run:

    $ nix-shell --pure --run "hello | emem -w"
    <p>Hello, world!</p>

nix-shell gives us strong abstraction mechanisms that are deemed very difficult to do in other
approaches. It banks on the deterministic properties of Nix, creating a very strong leverage.


<a name="closing"></a> Closing remarks
--------------------------------------

Nix provides powerful tools to make managing systems and development configurations, significantly
easier. It has flexible facilities for creating efficient workflows and distribution models. If I
had to list down the most important features of the Nix ecosystem that I like, they are:

- deterministic
- reproducible
- stateless
- declarative
- consistent
- portable
- reliable
- purely functional
- has transactional updates

Another important member of the Nix family is [NixOps](https://nixos.org/nixops); it enables one to
deploy NixOS on bare metal machines, virtual machines, or cloud using the declarative approach that
we are familiar with. It is able to deploy to VirtualBox, Amazon EC2, Google Compute Engine,
Microsoft Azure, Hetzner, Digital Ocean, and Libvirtd. Head over to
the [manual](https://nixos.org/nixops/manual/) for more details.

In-depth details about instantiations, derivations, realisations were elided on purpose, in this
article. They may become a topic on their own, or I may update this article to add those topics. I
may also write a new section about NixOps.

An Emacs major mode is [available](https://github.com/NixOS/nix/blob/master/misc/emacs/nix-mode.el)
from the main repository. It is also [available](https://melpa.org/#/nix-mode) via MELPA. You may
install it with:

```
M-x package-install RET nix-mode RET
```

There are other package management systems that are trying to solve this problem domain, too. The
ones that I’m aware of are
[AppImage](http://appimage.org/), [Zero Install](http://0install.net/), [Snapcraft](https://snapcraft.io/),
and [Flatpak](http://flatpak.org/).

The [Guix System Distribution (GuixSD)](https://www.gnu.org/software/guix/) is a GNU/Linux distribution
that is based on Nix. It uses Guile Scheme as its API language. The key differences between
GuixSD and NixOS is that the former uses [GNU Shepherd](https://www.gnu.org/software/shepherd/)
instead of systemd; it doesn’t allow non-free packages; and it
uses [Linux-libre](https://www.fsfla.org/ikiwiki/selibre/linux-libre/), a stripped down version of
the mainstream kernel with all the proprietary blobs removed. More information about their
differences can be found [here](https://sandervanderburg.blogspot.de/2012/11/on-nix-and-gnu-guix.html).

Aside from GuixSD, there are also other projects that Nix has inspired. There
is [Habitat](https://habitat.sh) an application automation framework,
and [ied](https://github.com/alexanderGugel/ied), an alternative package manager for Node.

The articles
of [Luca Bruno](https://lethalman.blogspot.com/2014/07/nix-pill-1-why-you-should-give-it-try.html),
[James Fisher](https://lethalman.blogspot.com/2014/07/nix-pill-1-why-you-should-give-it-try.html),
and [Oliver Charles](https://ocharles.org.uk/blog/posts/2014-02-04-how-i-develop-with-nixos.html), together with
the [NixOS](https://nixos.org/nixos/manual), [Nixpkgs](https://nixos.org/nixpkgs/manual),
and [Nix](https://nixos.org/nix/manual) manuals, significantly helped me in understanding
Nix. Special thanks goes to [François-René Rideau](https://fare.livejournal.com) for introducing me
to Nix several years ago.

The NixOS Foundation is a registered non-profit organization;
your [donations](https://nixos.org/nixos/foundation.html) will significantly help in the development
of Nix. Join the [community](https://nixos.org/nixos/community.html) and help make it grow!


<a name="bonus"></a> Bonus
--------------------------

Here’s the [Y combinator](/en/y) in Nix, applied to the factorial function:

```nix
nix-repl> y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v)))))

nix-repl> b = p: (n: if n == 0 then 1 else (n * (p (n - 1))))

nix-repl> f = y b

nix-repl> f 20
2432902008176640000
```

Or, in one expression, using let:

```nix
nix-repl> let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v)))));
              b = p: (n: if n == 0 then 1 else (n * (p (n - 1))));
              f = y b;
          in f 20
2432902008176640000
```

You may also pipe stdout to nix-repl:

```nix
$ echo 'let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20' | nix-repl
Welcome to Nix version 1.11.8. Type :? for help.

nix-repl> let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20
2432902008176640000

nix-repl>
```
