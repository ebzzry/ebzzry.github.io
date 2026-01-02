---
title: Emakso: Haskela Programado
keywords: emakso, haskell, programado, agordo, agordaĵo, agordajxo 
image: https://ebzzry.com/images/site/kevin-mueller-0gJqD3dtluU-unsplash-2000x1125.jpg
---
Emakso: Haskela Programado
==========================

<div class="center">[English](/en/emacs-haskell/) ⊻ Esperanto</div>
<div class="center">2025-12-25</div>

>Oni ne povas nomi sin pacema krom se oni estas kapabla de granda perforto. Se oni ne estas kapabla por granda perforto, oni ne estas pacema, oni estas nenoca.<br>
>—Stef STARKGARYEN

<img src="/images/site/kevin-mueller-0gJqD3dtluU-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Doom](#doom)
- [Direnv](#direnv)
- [Stack](#stack)
- [Nix](#nix)
- [Diversaĵoj](#diversajxoj)
- [Testado](#testado)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Haskelo estas bela programlingvo. Mi simple diru tion. Ĝi estas unu el tiuj
programlingvoj kiu estis desegnite eleganta kaj potenca. En la alia flanko de la
ĉielarko estas Lispo kaj en la alia flanko estas Haskelo. Ne estas nur pro ĝi
estas pure funkcia, statike tipigita, maldiligente taksita, potence realigas
tipklasajn, riĉa per esplorado, kaj havas aktivan komunumon. Estas pro ĝi havas
ĉion.

Sed per Haskelo, aferoj estas malsimilaj. Oni rigardas aferojn el malsama
perspektivo. Oni iras ekster la komfortaj zonoj. Oni elektas Haskelon ĉar oni ne
nur deziras fariĝi pli bona programisto, sed oni ankoraŭ deziras fariĝi pli bona
pensanto.

En ĉi tiu artikolo, mi parolos kiel mi agordas mian propran Haskelan programadan
medion. Kompreneble, Emakso estas nur unu parto da ĝi. Se mi metis ĉiom da
partoj kiujn mi bezonas, do la titolo jam fariĝos tre longa. Mi uzas GHC, Stack,
Doom-emakso, Nix, kaj Direnv.

Estu konscie, ke ĉi tiu gvidilo estas tre opinia. La komandoj kaj instrukcioj
kiuj mi uzas estas fajne desegnita por mia uzado. 


<a name="doom">Doom</a>
-----------------------

Dum la pasintaj ses jaroj, mi jam neŝanĝiĝeme uzis [Doom-emakso](https://github.com/doomemacs/doomemacs) kiel mia ĉefa
redaktilo anstataŭ vanila emakso. Doom estas rapida, fidebla, kaj venas kun
baterioj. Malgraŭ promociite kiel emakso por komencantoj, ĝi ankaŭ funkcias
bonege por altgradaj uzantoj. Mi ankaŭ provis uzi je Spacemacs sed ĝi ne estis
sufiĉe stabila.

Unue, ni devas havi subtenon por Haskelo en `~/.doom.d/init.el`. Trovi la
`:lang`-sekcion, kaj metu la jenan:

```lisp
:lang
…
(haskell +lsp)
…
```

Mi ankaŭ ŝatas ebligi ligaturojn, por ke la signoj aspektu pli bene. Trovi la
`:ui`-sekcion, kaj metu la jenan:

```lisp
:ui
…
(ligatures +extra)
…
```

Tiam, ni devas aldoni subtenon por direnv, por ke malfermu `.hs`-dosierojn ankaŭ
ŝargas direnv. Malfermu la dosieron `~/.doom.d/config.el` kaj metu la jenan:

```lisp
(use-package! direnv
  :config
  (direnv-mode)
  (setq direnv-always-show-summary nil))
```

Tiam, ni devas diri al haskelo-reĝimo uzi GHCi kiu venas kun Stack. Malfermu la
dosieron `~/.doom.d/config.el`, denove, kaj metu la jenan:

```lisp
(after! haskell
  (setq haskell-process-type 'stack-ghci))
```

Fine, reŝargi la agordon ĉe la komandlinio per:

```sh
doom sync
```

aŭ ene Doom mem:

```
SPC h r r
```


<a name="direnv">Direnv</a>
---------------------------

[direnv](https://github.com/direnv/direnv) estas eta plaĉa ilo kiu igas onin
krei mediajn variablojn unikaj al dosierujoj. La kreado de ĉi tiu variabloj
okazas kiam oni ŝanĝas la dosierujo en kiu direnv estas ŝaltita.

Oni povas instali direnv per aldoni ĝin al configuration.nix aŭ oni povas
instali ĝin por la loka profilo. Por simpleco, ni faru la posta:

```sh
nix profile install nixpkgs#direnv nixpkgs#nix-direnv
```

Tiam, ni kreu la supran agorddosieron de direnv. Metu la jenan en la agordo
`~/.direnvrc`:

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

Estas nun la tempo por krei novan projekton. Ni faru ĝin per
[Stack](https://docs.haskellstack.org/en/stable/) ĉar ĝi estas stabila, havas
sanajn implicitajn agordojn, kaj integriĝas bone kun
[Hackage](https://hackage.haskell.org/) kaj
[Stackage](https://www.stackage.org/).

Ni antaŭsupozu, ke ni estas en la hejma dosierujo de uzanto
`john`—`/home/john/`:

```sh
nix run nixpkgs#stack new foo
```

Kiam la komando finas ruli, la dosierujo `/home/john/foo/` enhavas la jenajn dosierojn:

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


<a name="nix">Nix</a>
---------------------

Krei reprodukteblan medion, ni nun plenigos la dosierujon `foo` per dosieroj
kiuj integrigas ĉion kune. Kreu la jenajn dosierojn ene la dosierujo `foo/` kiu
estis tuj kreita. Pli grave, ni uzos nix-flokojn.

Unue estas `flake.nix`:

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

Sekve, estas `shells.nix`:

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

Tiam, `haskell.nix`:

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
          --nix \
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

Tiam, `haskell.nix`:

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
          --nix \
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

Fine, kreu `.envrc`:

```sh
nix_direnv_manual_reload
use flake
if [[ -f .env ]]; then dotenv .env; fi
```


<a name="diversajxoj">Diversaĵoj</a>
------------------------------------

Dum oni estas en la `foo/` dosierujo, oni devas ebligi direnv:

```sh
direnv allow
```

kaj oni devas krei la ŝlosilan dosieron por Nix:

```sh
nix-direnv-reload
```

En [VTI](https://veda-tech.com), ni ŝatas uzi la implicitajn valorojn de Ormolu
de uzi du spacetojn por krommarĝenado. Ni uzas ĉi tiun `fourmolu.yaml` agordo
por niaj bezonoj:

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

<a name="testado">Testado</a>
-----------------------------

En ĉi tiu punkto, la dosierujo `foo/` aspektos kiel jene:

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

Kiam oni ŝanĝiĝas al la dosierujo `~/foo/`, one estas sciigita ke direnv
ŝarĝiĝis.

```sh
cd ~/foo
```

Kiam oni malfermas la dosieron `~/foo/app/Main.hs` per Doom:

```
SPC f f ~/foo/app/Main.hs RET
```

oni ankaŭ estas sciigita ke direnv ŝarĝiĝis.

Por kontroli ke la haskela programo ja muntas, rulu:

```sh
stack build
```

Tenu en la kalkulo, ke ĉi tiu `stack` duumdosiero estas tiu kiu loĝas ene la
Nix-medio precizigita de `flake.nix`. Kiam la muntado finiĝas, rulu ĝin per:

```sh
stack exec foo-exe
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Se oni jam estas Nix-uzanto, oni trovas la instrukciojn relative facilaj por
sekvi. Tamen, se oni ne ankoraŭ estas kutima al Nix, oni devas investi tempon
por lerni ĝin, ĝia ekosistemo, kaj tio kio igas ĝin unika.

Mi ankoraŭ devas trovi pli bonan integritan programadan medion por Haskell pli
ol tio kion mi priskribis ĉi-supre. La iniciala agordo povas iĝi senkuraĝiga,
sed post kiam oni trairas la inicialan branĉbarileton, ĉio iĝas facila.
