A Gentle Introduction to Nix Flakes
===================================

<div class="center">English • [Esperanto](/eo/adv360/)</div>

>But every decision for something is a decision against something else.<br>
>—H. G. Tannhaus, Dark (2017)

<img src="/images/site/raisa-milova-eiV7yq_7dhU-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="adv360" title="adv360"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Basics](#basics)
  + [NixOS](#nixos)
  + [Darwin](#darwin)
- [Flakes](#flakes)
  + [packages](#packages)
  + [devShells](#devshells)
  + [apps](#apps)
  + [nixosConfiguration](#nixosconfiguration)
  + [darwinConfiguration](#darwinconfiguration)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

When I discovered Nix almost two decades ago, I learned that there's still so
much to computing than what I already know. I was blown away. It was
astonishing. It was nothing short of marvel. My passion for systems
administration was rekindled, again.

As someone who has spent an inordinate amount of time in the
BSD-land—configuring everything by hand, memorizing all of the key places where
important configuration should be—I found Nix and NixOS to be breath of fresh
air.

Not long after, NixOS became my primary development machine. I could do
everything with it, even using devices that were not designed from the start to
be used with Linux. With the help of the official documentation and helpful
articles of people who have used it before me, I was able to set it up according
to my preferences. I wrote about what I have learned [here](/en/nix).


<a name="basics">Basics</a>
---------------------------

### <a name="nixos">NixOS</a>

The way that I've always used my NixOS system was that, I would install user
packages via `nix-env` and I'm good to go. But no matter how much I optimized
the process, it was still slow and cumbersome. I found out that the system was
loading more things than necessary, severely impacting performance. 

I dug deeper and discovered Nix Flakes. It says on the
[wiki](https://wiki.nixos.org/wiki/Flakes) that it is an experimental feature. I
don't know exactly what that means, but it feels like an alpha feature that's
already good to go.

To enable it, I edited `/etc/nixos/configuration.nix` and added the following:

```conf
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

then did a

```sh
sudo nixos-rebuild switch
```

I got a new set of commands from the `nix` command, and found out that they are
significant departure to the commands that I'm already acquainted with.

To install a package—say emem—without flakes and to uninstall it, run

```sh
nix-env --install -A nixpkgs.emem
nix-env --uninstall emem
```

With flakes, to install and remove it, run

```sh
nix profile install nixpkgs#emem
nix profile remove emem
```

### <a name="darwin">Darwin</a>

When I got my hands on an M1 MBP, I got naturally curious if there's a way for
me to use Nix on it. Soon after, I learned about
[nix-darwin](https://github.com/LnL7/nix-darwin/). After about an hour of
tinkering, I finally got the incantation that would build everything.

```sh
darwin-rebuild switch --flake ~/.config/nix
```

Just like with flakes on NixOS, I got the new set of commads.

Most, if not all important Nix commands, have already coalesced into `nix`.  I
went by fine with it for a year, until I decided that it's time to take the dive
and use flakes outside of the basic configuration.


<a name="flakes">Flakes</a>
---------------------------

One of the things that has always bothered me was transitioning from the old
mode of using `shell.nix` to create portable Nix shells, to `flake.nix`. To use
flakes, you need to create the file `flake.nix`, which will be the basis of
everything. The command `nix` reads this file from the current directory. The
`init` subcommand creates one for us, conveniently.

```sh
nix flake init
```

the resulting file, `flake.nix`, will look something like the following:

```nix
{
  description = "❄️️";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }: {
    packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
    packages.x86-64_linux.default = self.packages.x86-64_linux.hello;
  };
}
```

We can see, immediately, that it is an attribute set, of three parts:

```nix
{
  description = ...;
  inputs = ...;
  outputs = ...;
}
```

Put a nice value in `description` so that we can use that as information when
grepping for flakes. `inputs` specify the things that will go to the flake,
while `outputs` are the ones that will produced by it, that will then be used by
`nix` commands.  `inputs` itself is an attribute set, and we need first to
specify the location for `nixpkgs`.

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
}
```

or

```nix
inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
```

Here we're using `ref` to specify a branch name. You can have other
specifiers, like a commit ID, with `rev`,

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  oldnixpkgs.url = "github:nixos/nixpkgs?rev=d73ab2f14214a587059fa38cacf82198409e54eb";
}
```

The value of `outputs` should be a function that takes an attribute list as an
argument and returns an attribute list containing the outputs specification. The
form is as follows,

```nix
outputs = { }: { }
```

The outputs of a flake correspond with specific Nix commands. Some of the ones
that I use are listed below.

| output               | used by                |
|----------------------|------------------------|
| packages             | nix build              |
| devShells            | nix develop            |
| apps                 | nix run                |
| nixosConfigurations  | nixos-rebuild --flake  |
| darwinConfigurations | darwin-rebuild --flake |


### <a name="packages">packages</a>

```nix
outputs = { self, nixpkgs }: {
  packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
  packages.x86-64_linux.default = self.packages.x86-64_linux.hello;
};
```

The argument of the function is an attribute set, with two keys: `self` and
`nixpkgs`. `self`, there, is the attribute itself. This allows us to make
references to other parts inside. `nixpkgs` contains all the packages for a
specific system, which, in our example above, is `x86-64_linux`.

In

```nix
packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
```

we create an output package named `packages.x86-64_linux.hello`, assigning it
the `hello` derivation from nixpkgs. We have to specify the arch, or as Nix calls
it, system, because packages are system-specific. Next, we create a
default output package which would be evaluated if no package is specified. We use the
identifier `self.packages.x86-64_linux.hello` to select
`packages.x86-64_linux.hello` that was previously defined in this same
attribute set.

Let's refactor `outputs` to make it more readable:

```nix
outputs = { nixpkgs }:
 let
   system = "x86-64_linux";
   pkgs = nixpkgs.legacyPackages.${system};
 in with pkgs; {
   packages.${system} = rec {
     hello = pkgs.hello;
     default = hello;
   };
 };
```

With flakes, everything has to be commited with Git. The `nix` commands won't
work unless, they're part of the repository. Any `.nix` file that is referenced
by the flakes, has to be part of the repository.

```sh
git init
git add .
git commit -m 'Initial commit'
```

To build the `hello` package, run

```sh
nix build .#hello
```

The `.` indicate the current directory at the flake source, while `#hello` says
that we build the `hello` package. If the current directory is
`/Users/foo/tmp/`, the following commands are equivalent.

```sh
nix build .#hello
nix build $PWD#hello
nix build /Users/foo/tmp#hello
```

To build the default package, we simply omit `#hello`,

```sh
nix build
nix build $PWD
nix build .
nix build /Users/foo/tmp
```

The command creates the symlink `result` in the current directory that points to
the build output in the Nix store. To run `hello`,

```sh
./result/bin/hello
```


### <a name="devshells">devshells</a>

Perhaps the output that I use the most is `devShells`. It allows me to create
«development shells» that contain environments that are completely isolated from
my main system. It is (essentially) the flakes version of `nix-shell`.

Here's a simple one,

```nix
devShells.${system} = rec {
  lisp = mkShell { buildInputs = [ sbcl ]; };
  default = lisp;
};
```

It defines a lisp shell with `pkgs.mkShell` and takes an attribute list. The
most important key is `buildInputs` which is a list of the packages. Here it is
`pkgs.sbcl`. Just like with the `packages` output, we define a default shell
with `default`.

Our `flake.nix` file now looks like

```nix
{
  description = "❄️️";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable"; };
  outputs = { nixpkgs, ... }:
    let
      system = "x86-64_linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
      packages.${system} = rec {
        hello = hello;
        default = hello;
      };
      devShells.${system} = rec {
        lisp = mkShell { buildInputs = [ sbcl ]; };
        default = lisp;
      };
    };
}
```

To enter the default shell, which is `lisp`, run

```sh
nix develop
```

You then have access to the packages that you have declared,

```sh
sbcl --version
```


### <a name="apps">Apps</a>

An app output on the other hand allows you to conveniently execute any arbitrary
program from a package.

Let go and define an app output that launches a system monitor.

```nix
apps.${system} = rec {
  btop = {
    type = "app";
    program = "${pkgs.btop}/bin/btop";
  };
  default = btop;
};
```

The attribute type has to have the vaule `"app"`. The attribute `program`
contains the package path to the program that you want to run.

To launch it, run

```sh
nix run
```


### <a name="nixosconfiguration">nixosConfiguration</a>

One of the best things that I have discovered with flakes is the ability to
provision the managing of the NixOS configuration. You don't need to change
anything with the existing file, `/etc/nixos/configuration.nix`. You only need
to tell `flake.nix` how to manage it.

```nix
nixosConfigurations."hostname" = nixos.lib.nixosSystem {
  modules = [ ./configuration.nix ];
  specialArgs = { inherit pkgs; };
};
```

The file `configuration.nix` is a copy of the file
`/etc/nixos/configuration.nix` which will be tracked by version control, too.
Add it to the repository

```sh
git add configuration.nix
```

The string `"hostname"` should be replaced with the hostname of the machine that
would use that configuration. You can have configurations for multiple systems,
like so

```nix
nixosConfigurations = {
  "john-laptop" = nixos.lib.nixosSystem {
    modules = [ ./laptop-configuration.nix ];
    specialArgs = { inherit pkgs; };
  };
  "alice-desktop" = nixos.lib.nixosSystem {
    modules = [ ./desktop-configuration.nix ];
    specialArgs = { inherit pkgs; };
  };
};
```

To rebuild the NixOS configuration for `john-laptop`, run

```sh
sudo nixos-rebuild switch --flake .#john-laptop
```

If there's only one configuration, the following would use the only one declared.

```sh
sudo nixos-rebuild switch --flake .
```

### <a name="darwinconfiguration">darwinConfiguration</a>

When you're using `nix-darwin`, you can do the same as above.

```nix
darwinConfigurations."bob-mbp" = nix-darwin.lib.darwinSystem {
  modules = [ ./bob-mbp-configuration.nix ];
  specialArgs = { inherit pkgs; };
};
darwinPackages = self.darwinConfigurations."bob-mbp".pkgs;
```

To rebuild your Darwin configuration, run


```sh
darwin-rebuild switch --flake .
```

### <a name="refactoring">Refactoring</a>

flake-utils
many systems
//
