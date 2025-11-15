---
title: Milda Enkonduko al Nix-Flokoj
keywords: nix, nix flakes, nix-flokoj, darwin, nixos, linux, linukso 
image: https://ebzzry.com/images/site/aaron-burden-vtCZp-9GvrQ-unsplash-1008x250.jpg
---
Milda Enkonduko al Nix-Flokoj
=============================

<div class="center">[English](/en/flakes) | Esperanto</div>
<div class="center">2025-01-30 07:13:01 +0800</div>

>Tamen ĉiu decido por io estas decido kontraŭ io alia.<br>
>—H. G. Tannhaus, Dark (2017)

<img src="/images/site/aaron-burden-vtCZp-9GvrQ-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="flokoj" title="flokoj"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Enkonduko](#enkonduko)
  + [NixOS](#nixos)
  + [Darwin](#darwin)
- [Flokoj](#flokoj)
  + [packages](#packages)
  + [devShells](#devshells)
  + [apps](#apps)
  + [nixosConfiguration](#nixosconfiguration)
  + [darwinConfiguration](#darwinconfiguration)
  + [flake-utils](#flake-utils)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Kiam mi malkovris je Nix preskaŭ du jardekoj antaŭe, mi lernis, ke estas ankoraŭ
multaj aferoj kiujn mi ne scias. Mi estis forblovita. Mi miris. Ĝi estis
mirinda. Mia ardo por sistemadministrado reardiĝis.

Kiel iu kiu elspezis multan tempon en la BSD-lando—agordante ĉion mane,
memorante ĉiom da lokoj kiu grava agordo loĝis—mi opiniis, ke Nix kaj NixOS
estas spiro de freŝa aero.

Post ne longe, NixOS fariĝis mia ĉefa labora maŝino. Mi povis fari ĉion per ĝi,
eĉ uzi aparatojn kiuj ne estis antaŭdesignita por funkcii sur linukso. Per la
helpo de la oficiala dokumentoj kaj helpemaj artikoloj de homoj kiuj jam uzis
ĝin antaŭ mi, mi povis agordi ĝin laŭ miaj preferoj. Mi skribis pri tio sperto
[ĉi tie](/eo/nix).


### <a name="nixos">NixOS</a>

La maniero en kiu mi ĉiam uzis mian NixOS-sistemon estas, ke mi instalu pakojn
per `nix-env`. Bedaŭrinde, tutegale kiom mi optimumigis la procedon, ĝi estis
ankoraŭ malrapida kaj laborintensiva. Mi malkovris, ke la sistemo ŝargis aĵojn
pli ol necesitaj, severe influi la rendimenton.


Mi pli fosis kaj malkovris la Nix-flokojn. Estis menciite ĉe la
[vikio](https://wiki.nixos.org/wiki/Flakes), ke ĝi estas eksperimenta kapablo.
Mi fakte ne scias kion tio signifas, sed ĝi sentis kiel alfaa kapablo kiu estas
jam preta.


Por ebligi ĝin, mi redaktis la dosieron `/etc/nixos/configuration.nix` kaj
aldonis la jenan:


```conf
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

kaj faris la jenan


```sh
sudo nixos-rebuild switch
```

Mi akiris novan aron de kamondoj el la `nix`-komando, kaj malkovris ke ili estas
malbagatelaj foriroj el la komandoj kiuj mi jam konis.

Por instali pakon, ekzemple emem—sen flokoj kaj por malinstali ĝin, ruli

```sh
nix-env --install -A nixpkgs.emem
nix-env --uninstall emem
```

Per flokoj—por instali kaj malinstali ĝin—ruli

```sh
nix profile install nixpkgs#emem
nix profile remove emem
```


### <a name="darwin">Darwin</a>

Kiam mi akiris M1 Macbook Pro-tekkomputilon, mi nature sciemis ĉu estas maniero
por mi por instali je Nix sur ĝi. Post ne longe, mi malkovris
[nix-darwin](https://github.com/LnL7/nix-darwin/). Post unu horo de
alĝustigetado, mi fine akiris la sorĉelvokon kiu muntus ĉion.  Same kiel flokoj
sur NixOS, mi prenis la novan aron de komandoj.

Plejmulte da—se ne ĉiom—da gravaj Nix-komandoj jam kunfandiĝis al `nix`. Mi
iris per ĝi senprobleme dum unu jaro. Baldaŭ, mi decidis, ke estas jam la ŝanco
por plenplonĝi kaj uzi flokojn ekster la baza agordo.


<a name="flokoj">Flokoj</a>
---------------------------

Unu el la aferoj kiuj ja ĉiam ĝenis mi estis la transiro el la malnova reĝimo de
uzi `shell.nix` por krei porteblajn nix-ŝelojn, al `flake.nix`. Por uzi flokojn,
oni devas krei la dosieron `flake.nix`, kiu estos la bazo por ĉio. La komando
`nix` legas ĉi tiun dosieron el la aktuala dosierujo, implicite. La `init`
sub-komando kreas unu, por ni, oportune.

```sh
nix flake init
```

La rezulto, `flake.nix`, aspektos kiel la jena:

```nix
{
  description = "A flake️️";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }: {
    packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
    packages.x86-64_linux.default = self.packages.x86-64_linux.hello;
  };
}
```

Oni povas vidi, tuje, ke ĝi estas atribua aro, de tri parto:


```nix
{
  description = ...;
  inputs = ...;
  outputs = ...;
}
```

Metu plaĉan valoron en `description` por ke ni povu uzi ĝin kiel informon kiam
«grep» por flokoj. `inputs` indikas la aferojn kiuj iros al la floko, dum
`outputs` estas tiuj kiuj estos produktita per ĝi, kiam tiam estos uzita de la
`nix`-komandoj. `inputs` mem estas atribua aro, kaj ni unue difinos la lokon de
`nixpkgs`.


```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
}
```

Jen ni uzas `ref` por indiki la branĉan nomon. Oni povas havi aliajn indikilojn,
kiel enmeta-identigilo, per `rev`.

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  oldnixpkgs.url = "github:nixos/nixpkgs?rev=d73ab2f14214a587059fa38cacf82198409e54eb";
}
```

La valoro de `outputs` estas funkcio kiu ricevas atribuan liston kiel argumento
kaj revenas atribuan liston enhavante la eligajn specifojn. La formo estas la
jena:

```nix
outputs = { }: { };
```

La eligoj de floko kongruas kun specifaj Nix-komandoj. Kelke da ili kiujn mi
uzas estas listigita jene.


| eligo                  | uzita de                 |
| :--------------------- | :----------------------- |
| `packages`             | `nix build`              |
| `devShells`            | `nix develop`            |
| `apps`                 | `nix run`                |
| `nixosConfigurations`  | `nixos-rebuild --flake`  |
| `darwinConfigurations` | `darwin-rebuild --flake` |


### <a name="packages">packages</a>

Ni priparolu la plej bazan tipon de eligo—packages.


```nix
outputs = { self, nixpkgs }: {
  packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
  packages.x86-64_linux.default = self.packages.x86-64_linux.hello;
};
```

La argumento de tiu funkcio estas atribua aro, kun du ŝlosilaj: `self` kaj
`nixpkgs`. `self`, tie, estas la atribuo mem. Tio ebligas nin por skribi
referencojn al la partoj ene. `nixpkgs` enhavas ĉiom da pakoj por specifa
sistemo, kiu, en la ekzemplo supre, estas `x86-64_linux`.

En


```nix
packages.x86-64_linux.hello = nixpkgs.legacyPackages.x86-64_linux.hello;
```

ni kreas eligan pakon kiu nomiĝas `packages.x86-64_linux.hello`, valorizante ĝin
la `hello`-derivaĵon el Nixpkgs. Ni ankaŭ devas precizigi la arkitekturon, ĉar
pakoj estas sistemspecifaj. Sekve, ni kreu implicitan eligan pakon kiu estos
taksita se iu ajn pako ne estas precizigita. Ni uzas la identigilon
`self.packages.x86-64_linux.hello` por elekti `packages.x86-64_linux.hello` kiu
estas antaŭe difinita en la sama atribua aro.

Ni restrukturu `outputs` por igi ĝin pli legeblan:

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

Estas norma praktiko por havi `pkgs`-variablon kiu indikas ĉiam da pakoj. Tiam,
mi forigis `self` el la atribua aro, por ke mi povu havi pli da libero por uzi
`rec.`

Per flokoj, ĉio devas esti enmetita kun gito. La `nix`-komando ne funkcios
kromse ili estas parto de la deponejo. Ajna `.nix`-dosiero estas referencita de
la flokoj, devas esti parto de la deponejo.

```sh
git init
git add .
git commit -m 'Initial commit'
```

Por munti la `hello`-pakon, ruli

```sh
nix build .#hello
```

La `.`-signo indikas la aktualan dosierujon ĉe la floka fonto, dum `#hello`
indikas, ke ni muntas la `hello`-pakon. Se la aktuala dosierujo estas
`/Users/foo/tmp`, la jenaj komandoj estas ekvivalentaj.


```sh
nix build .#hello
nix build $PWD#hello
nix build /Users/foo/tmp#hello
```

Por munti la implicitan pakon, ni simple forigas `#hello`.

```sh
nix build
nix build $PWD
nix build .
nix build /Users/foo/tmp
```

La komando kreas la simbilligilon `result` en la aktuala dosierujo kiu indikas
la muntan eligon en la Nix-konservejo. Por ruli `hello`,

```sh
./result/bin/hello
```


### <a name="devshells">devshells</a>

Eble la eligo kiun mi plej ofte uzas estas `devShells`. Ĝi ebligas min krei
«programadajn mediojn» (kio ajn tio signifas) kiu esence enhavas mediojn kiu
estas tute izolitaj el mia ĉefa sistemo. Ĝi estas (esence) la flaka versio de
tiuj kiuj estas kreitaj per `nix-shell`.

Jen simpla ekzemplo

```nix
devShells.${system} = rec {
  lisp = mkShell { buildInputs = [ sbcl ]; };
  default = lisp;
};
```

Tio difinas lispan ŝelon per `pkgs.mkShell` kaj prenas atribuan liston. La plej
grava ŝlosilo estas `buildInputs` kiu estas listo de la pakoj. Ĉi tie, ĝi estas
`pkgs.sbcl`. Kiel la `packages`-eligo, ni difinas implicitan ŝelon per
`default`.

Nia `flake.nix`-dosiero nun aspektas jene


```nix
{
  description = "A flake️️";
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

Por eniri la implicitan ŝelon, kiu estas `lisp`, ruli

```sh
nix develop
```

Oni tiam havas aliron al la pakoj kiuj oni ĵus deklaris,

```sh
sbcl --version
```


### <a name="apps">Apps</a>

`app`-eligo, aliflanke, ebligas onin por oportune plenumi iu ajn programon el
pako.

Ni iru kaj difinu apan eligon kiu lanĉas sisteman kontrolilon.


```nix
apps.${system} = rec {
  btop = {
    type = "app";
    program = "${pkgs.btop}/bin/btop";
  };
  default = btop;
};
```

La atribua tipo devas havi la valoron `"app"`. La atribuo `program` enhavas la
pakan vojon al la programo kiun oni volas ruli. Por lanĉi ĝin, rulu

```sh
nix run
```


### <a name="nixosconfiguration">nixosConfiguration</a>

Unu el la plej bonaj aferoj kiun mi malkovris per flakoj estas la kapablo por
provizi la administradon de la NixOS-agordo. Oni ne bezonas ŝanĝi ion ajn al la
ekzistanta dosiero, `/etc/nixos/configuration.nix`. Oni nur devas diri al
`flake.nix` kiel regi ĝin.

```nix
nixosConfigurations."hostname" = nixos.lib.nixosSystem {
  modules = [ ./configuration.nix ];
  specialArgs = { inherit pkgs; };
};
```

La dosiero `./configuration.nix` ĉi-supre estas kopio de la dosiero
`/etc/nixos/configuration.nix` kiu ankaŭ estos spurita per versikontrolo. Aldonu
ĝin al la deponejo


```sh
git add configuration.nix
```

La ĉeno `"hostname"` devas esti anstataŭigita per la nomo de la maŝino kiu uzus
tiun agordon.


```nix
{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { nixpkgs, ... }:
    let
      system = "x86-64_linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
      nixosConfigurations = {
        "ebzzry-tpad" = nixpkgs.lib.nixosSystem {
          modules = [ ./nixos-configuration.nix ];
          specialArgs = { inherit pkgs; };
        };
      };
    };
}
```

Por remunti la NixOS-agordon por la maŝino `ebzzry-tpad`, rulu

```sh
sudo nixos-rebuild switch --flake .#ebzzry-tpad
```

Se nur ekzistas unu agordo, la jena komando sufiĉus,

```sh
sudo nixos-rebuild switch --flake .
```


### <a name="darwinconfiguration">darwinConfiguration</a>

Per `nix-darwin`, oni povas fari la saman kiel ĉi-supre,

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, nix-darwin }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
      darwinConfigurations = {
        "ebzzry-mbp" = nix-darwin.lib.darwinSystem {
          modules = [ ./darwin-configuration.nix ];
          specialArgs = { inherit pkgs; };
        };
      };
      darwinPackages = self.darwinConfigurations."ebzzry-mbp".pkgs;
    };
}
```

Por remunti la Darwin-agordon, rulu

```sh
darwin-rebuild switch --flake .
```


### <a name="flake-utils">flake-utils</a>

Tre baldaŭ, oni malkovros ke la agordo estas fuŝaĵo:

```nix
{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable"; };
  outputs = { nixpkgs, ... }:
    let
      nixosSystem = "x86-64_linux";
      nixosPackages = nixpkgs.legacyPackages.${nixosSystem};
      darwinSystem = "aarch64-darwin";
      darwinPackages = nixpkgs.legacyPackages.${darwinSystem};
    in {
      packages.${nixosSystem} = with nixosPackages; rec {
        hello = hello;
        default = hello;
      };
      devShells.${nixosSystem} = with nixosPackages; rec {
        lisp = mkShell { buildInputs = [ sbcl ]; };
        default = lisp;
      };
      apps.${nixosSystem} = with nixosPackages; rec {
        btop = {
          type = "app";
          program = "${pkgs.btop}/bin/btop";
        };
        default = btop;
      };
      packages.${darwinSystem} = with darwinPackages; rec {
        hello = hello;
        default = hello;
      };
      devShells.${darwinSystem} = with darwinPackages; rec {
        lisp = mkShell { buildInputs = [ sbcl ]; };
        default = lisp;
      };
      apps.${darwinSystem} = with darwinPackages; rec {
        btop = {
          type = "app";
          program = "${pkgs.btop}/bin/btop";
        };
        default = btop;
      };
    };
}
```

Ĉiu eligo kiun oni kreas por sistemo, devas esti skribita por la aliaj sistemoj,
kiun oni deziras subteni. Tie estas ie kie
[flake-utils](https://github.com/numtide/flake-utils) helpas. Ĝi estas aro de
utilecaj funkcioj kiu helpas en skribi pli bonajn Nix-esprimojn. Unue ni
restrukturu la eligojn por igin ilin pli belajn.

apps.nix:
```nix
{ pkgs }: rec {
  hello = {
    type = "app";
    program = "${pkgs.hello}/bin/hello";
  };
  default = hello;
}
```

packages.nix:
```nix
{ pkgs }: rec {
  btop = pkgs.btop;
  default = btop;
}
```

shells.nix:
```nix
{ nixpkgs, pkgs, ... }:
with pkgs; rec {
  lisp = mkShell { buildInputs = [ sbcl ]; };
  default = lisp;
}
```

flake.nix:
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        apps = import ./apps.nix { inherit pkgs; };
        packages = import ./packages.nix { inherit pkgs; };
        devShells = import ./shells.nix { inherit nixpkgs pkgs; };
      });
}
```

Ne forgesu aldoni la novajn `.nix`-dosierojn kiujn oni krenas. 

Tio kio ekazas ĉi tie estas ke ni aldonas novan enigon, `flake-utils`, kaj
sekve, ni pasas ĝin al `outputs`, fine ni vokas funkcion.

La funkcio `flake-utils.lib.eachDefaultSystem` prenas funkcion kiel sia
argumento—`(system: ...)`. Tiu funkcio prenas unuopan argumenton, `system`, kiu
kongruas al la haveblaj sistemoj. Ĝi tiam iteracias tra ĉiu sistemo kaj generi
la esprimojn.


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Per Nix-flokoj, ĉio fariĝas pli deklara, pli komprenebla, kaj pli lakona. Mi
opinias, ke estas facile administri miajn sistemojn per simpla aliro.

Troviĝas ĉiom da dosieroj kiujn mi uzas en ĉi tiu artikolo
[ĉi tie](https://github.com/ebzzry/dotfiles/tree/main/dev).

Ĝi povas ŝanĝiĝi en la estonteco, tamen, flokoj nun, estas la plej bona maniero
por administri pakojn kaj agordojn. Oni provu uzi ĝin!
