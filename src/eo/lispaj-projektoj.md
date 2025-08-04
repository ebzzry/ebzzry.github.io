---
title: Kiel Mi Kreas Lispajn Projektojn
keywords: lispo, komuna lispo, komunlispo, linukso , makintoŝo
image: https://ebzzry.com/images/site/lisp-lizard.png
---
Kiel Mi Kreas Lispajn Projektojn
================================

<div class="center">[English](/en/lisp-projects/) ∅ Esperanto</div>
<div class="center">2025-08-04 19:25:07 +0800</div>

>Oni ne havas ideon kion oni provas atingi ĝis oni jam atingis ĝin.<br>
>—Gerald Jay SUSSMAN

<img src="/images/site/lisp-lizard-1008x250.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="lisp lizard" title="lisp lizard"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Motivo](#motivo)
- [Instalo](#instalo)
  + [SBCL](#sbcl)
  + [Quicklisp](#quicklisp)
  + [Marie](#marie)
- [Bazaferoj](#bazaferoj)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Mia originala intenco krei ĉi tiun artikolon estas por krei la duan parton de la
unua artikolo pri skriptado en lispo. Mia plano estas paroli kiel mi aliras
komandlinian skritadon per lispo. Anstataŭe, tio kion mi deziras priparoli nun
estas kiel mi kreas lispajn projekton, per maniero kiu malplilongigas la
inicialan tempon por krei reuzeblan kodon. Mi faras ĉi tion ofte, kaj mi pensas,
ke estus pli bone se mi parolas pri ĝi, anstataŭe. Kunokaze, ĉi tiu aliro ja
uzas la manieron kiel mi skribas lispajn skriptojn por la komandlinio. Mi
kredas, ke mi eblas povi pafi du birdojn per ĉi tio.


<a name="motivo">Motivo</a>
---------------------------

Skribi propran projektan kreilon estas maturiĝrito en lisplando. Oni diras, ke
vi ne povas nomi vin «lispisto» ĝis vi povas krei duonan decan ilon kiu kreas
projektajn ostarojn.

Mia ĉefa motivo en skribi mian propran projektan kreilon venis ne pro ne ŝati la
haveblajn ilojn ĉie. Mi ne ŝatas ilin ne pro tio ke ili malbonas. Mi ne ŝatas
ilin ĉar ili ne estas taŭgaj por miaj bezonoj. Mi havas propran manieron por
strukturi miajn dozierojn kaj dosierujojn, kaj modifi la ekzistantajn ilojn por
adapti miajn bezonojn signifus ke mi devas krei mian ilon, eventuale.

Alia tialo kial mi deziras krei mian propran ilon estas la kapablo por specifi
la erojn kiujn mi bezonas por la projektoj kiujn ni bezonas. Mia teamo havas
specialajn bezonojn kiuj bezonas atenton. Ni uzas [Nix](https://nixos.org) kaj
[Flakes](https://nixos.wiki/wiki/flakes). Por tio, ni uzas la metodojn kiuj
estas skribitaj [ĉi tie](/en/nix) kaj [ĉi tie](/en/flakes). Ni ankaŭ faras plene
da komandlinian verkon, do ni bezonas manieron por analizi komandliniajn opciojn
kaj argumentojn.


<a name="instalo">Instalo</a>
-----------------------------

Oni eble venas al ĉi tiu artikolo ĉar oni estas kurioza, sed oni ne ankoraŭ
havas la bazilojn; aŭ oni venas ĉi tien, por ekzameni pri kio estas la tedaĵo.
Ambaŭmaniere, mi estas ĉi tie por gvidi vin.

La programaro kiu oni bezonas estas la jene:

1. SBCL
2. Quicklisp
3. Marie

### <a name="sbcl">SBCL</a>

La nura deca malfermitkoda lispa realigo, nuntempe, estas
[SBCL](http://sbcl.org). Ĝi funkcias sur x86, x86_64,kaj aarch64. Ĝi kuras sur
linukso, makintoŝo, kaj vindozo. Ĝi liveras altkvalitan plejbonigitan kodon. Ĉe
la komerca flako, estas [LispWorks](https://lispworks.com), kiun mi uzas ĉefe.
La aliaj realigoj estas afablaj, sed ĝi ne estas haveblaj sur aŭ linukso x86_64
kaj makintoŝo aarch64, kiuj estas la operaciumoj kiujn mi nune prizorgas.

Oni povas rekte iri al la retejo de SBCL por elŝuti ĝin, aŭ oni povas uzi la
pakajn administrilojn de la operaciumo. La komando devus aspekti jene:

```sh
sudo apt install -y sbcl
```

### <a name="quicklisp">Quicklisp</a>

Quicklisp estas la defakta normo por instali lispajn bibliotekojn. Ne estas
surfacaj sonoriloj kaj fajfiloj. Ĝi simple funkcias. Jen unu-linia komando por
instali ĝin sur linukso aŭ makintoŝo:

```sh
curl -O https://beta.quicklisp.org/quicklisp.lisp && sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(let ((ql-util::*do-not-prompt* t)) (ql:add-to-init-file) (sb-ext:quit))'
```

Por kontroli se ĝi jam estis instalita, rulu:

```sh
sbcl --noinform --eval '(princ (ql:client-version))' --quit
```

Ĝi devas mencii ion kiel

```
"2021-02-13"
```

### <a name="marie">Marie</a>

[Marie](https://github.com/vedainc/marie), aliflake, estas la biblioteko kiu
faras la artifikojn de krei la projekton. Ni ankaŭ bezonas
[Clingon](https://github.com/dnaeon/clingon) por helpi nin pri komandlinia
analizado. Por preni ilin, rulu:


```sh
mkdir ~/common-lisp
cd ~/common-lisp
git clone https://github.com/vedainc/marie
sbcl --noinform --eval '(ql:quickload :clingon)' --quit
```

Sekve, ni metu etan funkcion en la ŝelagordo por igi la aferojn pli facilaj.
Rulu la jenan komandod, ŝanĝante `~/.zshenv` al `~/.bashrc`, taŭge:

```sh
cat >> ~/.zshenv << EOF
function mk {
  sbcl --noinform --eval '(ql:quickload :marie)' --eval "(marie:make-project \"\$1\")" --quit
}
EOF
. ~/.zshenv
```

Sed, vi jam scias la ĉefan ideon.


<a name="bazaferoj">Bazaferoj</a>
---------------------------------

Do, ni nun havas la ilojn instalitaj, oni nun povas krei projekton `foo`:

```sh
mk foo
```

Tio kion ĝi kreas estas la jena arbo:

```sh
├── flake.nix
├── foo-tests.asd
├── foo.asd
├── makefile
├── README.org
├── shells.nix
├── src
│   ├── build.lisp
│   ├── core.lisp
│   ├── driver.lisp
│   ├── main.lisp
│   ├── specials.lisp
│   ├── user.lisp
│   └── version.lisp
└── t
    ├── driver-tests.lisp
    ├── main-tests.lisp
    ├── user-tests.lisp
    └── version.lisp

3 dosierujoj, 17 dosieroj
```

Por kontroli se `foo` ja funkcias, ni muntu ĝian plenumeblan dosieron:

```sh
cd ~/common-lisp/foo
make
./foo --help
```

Ĝi devas montri ion kiel la jena:

```sh
NAME:
  foo - 0.0.0

USAGE:
  foo [global-options] [<command>] [command-options] [arguments ...]

OPTIONS:
      --help     display usage information and exit
      --version  display version and exit
  -v, --verbose  verbosity [default: 0]

COMMANDS:
  find, f               find files
  zsh-completions, zsh  generate the Zsh completion script
  print-doc, doc        print the documentation
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Marie ebligas min rapide krei prototipan kodon el ideo kaj igi ĝin ruleblan
frue. Ĉi tiu ilo ebligas mi krei plenumeblajn dosierojn kiujn mi povas ĵeti
ĉien. Mi uzas ĉi tiujn ilojn por krei [Vix](https://github.com/vedainc/vix),
(tre) maldika kovrilo ĉirkaŭ la Nix-ekosistemo.
