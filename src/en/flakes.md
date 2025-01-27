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

### NixOS

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

### Darwin

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
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }: {
    packages.aarch64-darwin.hello = nixpkgs.legacyPackages.aarch64-darwin.hello;
    packages.aarch64-darwin.default = self.packages.aarch64-darwin.hello;
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

`description` is self-explanatory, so we're only going to look at `inputs` and
`outputs`. `inputs` specify the things that will go to the flake, while
`outputs` are the ones that will produced by it, that will then be used by `nix`
commands.  `inputs` itself is an attribute set, and we need first to specify the
location for `nixpkgs`.

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
}
```

or

```nix
inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
```

Here we're using `?ref=` to specify a branch name. You can specify other things,
like a specific commit ID, with `?rev=`,

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  oldnixpkgs.url = "github:nixos/nixpkgs?rev=d73ab2f14214a587059fa38cacf82198409e54eb";
}
```


<a name="etc">Etc</a>
---------------------

git is mandatory

flake.nix is an attribute set

it is all about outputs

what are the outputs

what are the basics commands

what are the use cases
