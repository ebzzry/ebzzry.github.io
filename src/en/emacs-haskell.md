---
title: Emacs: Haskell Programming
keywords: emacs, haskell, programming, configuration, setup, settings
image: https://ebzzry.com/images/site/kevin-mueller-0gJqD3dtluU-unsplash-2000x1125.jpg
---
Emacs: Haskell Programming
==========================

<div class="center">English ⊻ [Esperanto](/eo/emakso-haskelo/)</div>
<div class="center">2025-12-25</div>

>You can’t truly call yourself peaceful unless you are capable of great violence. If you’re not capable of violence, you’re not peaceful, you’re harmless.<br>
>—Stef Starkgaryen

<img src="/images/site/kevin-mueller-0gJqD3dtluU-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Doom](#doom)
- [Direnv](#direnv)
- [Stack](#stack)
- [Nix](#nix)
- [Miscellany](#miscellany)
- [Testing](#testing)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

Haskell is a beautiful language. Let me just say that. It is one of those
languages that was designed to be elegant and powerful. On the other side of the
rainbow is Lisp and on the other side is Haskell. It’s not just because it is
purely functional, statically typed, lazily evaluated, implements type classes
powerfully, abounding with research, and has rich community. It is because it has
all those. 

But with Haskell, things are different. You look at things from a different
perspective. You go out of your comfort zones. You become curious what’s all
those fireworks there on that side of the city? You choose Haskell because you
not only want to become a better programmer, but because you want to become a
better thinker.

In this article I’m going to talk about I setup my own Haskell development
environment. Of course, Emacs is just one part of it. If I had to put all the
parts that I need, then the title of the article would have already become too
long. I use GHC, Stack, Doom Emacs, Nix, and Direnv.

Beware, though, that this is a highly opinionated guide. The commands and
instructions that I use are finely tuned for my use cases.


<a name="doom">Doom</a>
-----------------------

For the past six years, I’ve been steadily using
[Doom Emacs](https://github.com/doomemacs/doomemacs) as my main editor instead
of vanilla Emacs. Doom is fast, reliable, and comes with batteries. Despite
being marketed as a beginner-friendly Emacs distribution, it also works well for
advanced users. I have also tried Spacemacs but it wasn’t stable enough.

First, we need to enable Haskell support in `~/.doom.d/init.el`. Find the `:lang`
section, and add the following:

```lisp
:lang
…
(haskell +lsp)
…
```

I also like to enable ligatures, so that the symbols will look prettier. Find
the `:ui` section, and the following:

```lisp
:ui
…
(ligatures +extra)
…
```

Then, we need to add support for direnv, so that opening a `.hs` file will also
load direnv. Open the file `~/.doom.d/config.el` and put the following:

```lisp
(use-package! direnv
  :config
  (direnv-mode)
  (setq direnv-always-show-summary nil))
```

Then, let’s tell the Haskell mode to use GHCi that comes with Stack. Open the
file `~/.doom.d/config.el`, again, and put the following:

```lisp
(after! haskell
  (setq haskell-process-type 'stack-ghci))
```

Finally, reload your config on the command line with:

```sh
doom sync
```

or inside Doom itself:

```
SPC h r r
```


<a name="direnv">Direnv</a>
---------------------------

[direnv](https://github.com/direnv/direnv) is a nice little tool that allows you
to create directory-specific environment variables. The creation of these
variables happen when you change to a directory where direnv is enabled.

You can install direnv by enabling it in your configuration.nix file or install
it to your local profile. For simplicity, let’s go with the latter:

```sh
nix profile install nixpkgs#direnv nixpkgs#nix-direnv
```

Then, let’s create the top-level configuration file for direnv. Put the
following in the file `~/.direnvrc`:

```sh
use_flake() {
  watch_file flake.nix
  watch_file flake.lock
  eval "$(nix print-dev-env)"
}

source $HOME/.nix-profile/share/nix-direnv/direnvrc
```

<a name="stack">Stack</a>
-------------------------

It’s now time to create a new project. Let’s do it with
[Stack](https://docs.haskellstack.org/en/stable/) because it stable, has sane
defaults, and integrates well with [Hackage](https://hackage.haskell.org/) and
[Stackage](https://www.stackage.org/).

Let’s presume that we’re in the home directory of user `john`—`/home/john/`:

```sh
nix run nixpkgs#stack new foo
```

When the command completes, the directory `/home/john/foo/` will contain the
following files:

```
foo
├── app
│   └── Main.hs
├── CHANGELOG.md
├── foo.cabal
├── LICENSE
├── package.yaml
├── README.md
├── Setup.hs
├── src
│   └── Lib.hs
├── stack.yaml
└── test
    └── Spec.hs
```

This is also a good time to add the following to the Stack user config file,
`~/.stack/config.yaml`:

```
notify-if-nix-on-path: false
```


<a name="nix">Nix</a>
---------------------

To create a reproducible environment, we’re now going to populate the `foo`
directory with files that will integrate everything together. Create the
following files inside the directory `foo/` that was just created. More
importantly, we’re going to use Nix flakes.

First up is `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells = import ./shells.nix { inherit nixpkgs pkgs; };
      }
    );
}

```

Next is `shells.nix`:

```nix
{
  nixpkgs,
  pkgs,
  ...
}:
with pkgs;
let
  comPkgs = [
    which
    rlwrap
  ];
  addComPkgs = l: l ++ comPkgs;
  inherits = {
    inherit nixpkgs pkgs addComPkgs;
  };
  import' = m: import m inherits;
in
rec {
  haskell = import' ./haskell.nix;
  default = haskell;
}
```

Then, `haskell.nix`:

```nix
{
  nixpkgs,
  pkgs,
  addComPkgs,
  ...
}:
with pkgs;
let
  extraPkgs = [
  ];
  haskellPkgs = haskell.packages."ghc9103";
  stackWrapped = symlinkJoin {
    name = "stack";
    paths = [ stack ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/stack \
        --add-flags "\
          --no-nix \
          --system-ghc \
          --no-install-ghc \
        "
    '';
  };
  mainPkgs = [
    haskellPkgs.ghc
    haskellPkgs.haskell-language-server
    stackWrapped
    fourmolu
  ];
in
mkShell {
  buildInputs = addComPkgs mainPkgs ++ extraPkgs;
  LD_LIBRARY_PATH = lib.makeLibraryPath mainPkgs;
}
```

Finally, create `.envrc`:

```sh
nix_direnv_manual_reload
use flake
if [[ -f .env ]]; then dotenv .env; fi
```


<a name="misc">Miscellany</a>
-----------------------------

While inside the `foo/` directory, you need to enable—or allow— direnv:

```sh
direnv allow
```

and you have to create the lock file for Nix:

```sh
nix-direnv-reload
```

In [VTI](https://veda-tech.com), we like to use Ormolu's default of using two
spaces for indentation. We use this `fourmolu.yaml` config for our needs:

```yaml
indentation: 2
column-limit: none
function-arrows: trailing
comma-style: leading
import-export-style: diff-friendly
import-grouping: legacy
indent-wheres: false
record-brace-space: false
newlines-between-decls: 1
haddock-style: multi-line
haddock-style-module: null
haddock-location-signature: auto
let-style: auto
in-style: right-align
if-style: indented
single-constraint-parens: always
single-deriving-parens: always
sort-constraints: false
sort-derived-classes: false
sort-deriving-clauses: false
trailing-section-operators: true
unicode: never
respectful: true
fixities: []
reexports: []
local-modules: []
```

<a name="testing">Testing</a>
-----------------------------

At this point, the directory `foo/` will look like the following:

```
foo
├── app
│   └── Main.hs
├── CHANGELOG.md
├── flake.lock
├── flake.nix
├── foo.cabal
├── fourmolu.yaml
├── haskell.nix
├── LICENSE
├── package.yaml
├── README.md
├── Setup.hs
├── shells.nix
├── src
│   └── Lib.hs
├── stack.yaml
└── test
    └── Spec.hs
```

When you cd to `~/foo/` you’ll be informed that direnv has loaded.

```sh
cd ~/foo
```

When you find the file `~/foo/app/Main.hs` with Doom:

```
SPC f f ~/foo/app/Main.hs RET
```

you’ll also be notified that direnv has loaded.

To verify that the Haskell program indeed builds, run:

```sh
stack build
```

Bear in mind that this `stack` binary is the one that came inside the Nix
environment as specified by `flake.nix`. When the build completes, run it with:

```sh
stack exec foo-exe
```


<a name="closing">Closing remarks</a>
-------------------------------------

If you’re already a Nix user, you’ll find these instructions relatively easy to
follow. If you’re not familiar with Nix, however, you may need to invest time
learning more about it, its ecosystem, and what makes it unique.

I have yet to see a better integrated development environment for Haskell than
the one that I described above. The initial setup can be daunting, but once you
get past the intial hurdle everything becomes easy.
