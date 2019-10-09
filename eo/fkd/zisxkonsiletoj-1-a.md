Ziŝaj Konsiletoj 1-a: Alinomoj kaj Funkcioj
===========================================

<div class="center">Esperanto ▪ [English](/en/zsh-tips-1/)</div>
<div class="center">la 26-an de Septembro 2018</div>
<div class="center">Laste ĝisdatigita: la 3-an de Oktobro 2019</div>

>Malsaĝulo miras pri nekutimaj aferoj. Ŝagulo miras pri la kutimaj aferoj.<br>
>―Konfuceo

Unu el la ĝuoj de ekskluzive labori sur la terminalsimulilo estas la laboron pri komandoj, dosieroj,
kaj dosieroj ĝi plifaciligas. Esti kapabla por iri de ideo al ideo okazas en malmulte da tempo. Por
interaga ŝela uzo, [ziŝon](http://zsh.sourceforge.net/) mi uzas preskaŭ eksklusive. En ĉi tiu
artikolo mi parolos pri la aĵoj por la interagan uzon de la ŝelo plibonigi.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Alinomoj](#alinomoj)
- [Funkcioj](#funkcioj)
- [Ĉion rikolti](#cxio)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Estas almenaŭ tri tipoj de komandoj en Ziŝo: duumdosieroj, alinomoj, kaj funkcioj. Duumdosieroj,
estas tiuj kiuj troveblas en la `$PATH`; ili estas la programoj, kiujn oni instalis per la
pakadministrilo. Alinomoj kaj funkcioj, aliflanke, ne loĝas kiel dosieroj sur la dosiersistemo. Ili
estas difinitaj kiel parto de la agorddosiero, aŭ entekstitaj en la seanco.


<a name="alinomoj"></a>Alinomoj
-------------------------------

Alinomoj estas tiuj beletaj malsaĝaj aĵoj kiujn oni metas en la agorddosieroj kiuj bagatelajn unu
liniajn komandojn faras. Kelke da ili aspektas jene:

    alias ls="ls -F"

Aliaj estas pli agresivaj kiel tutmondaj alinomoj, kiuj malvolvojn povas fari ie sur la komandlinio:

    alias -g G="|& rg --color auto"
    alias -g NF='*(.om[1])'

La ĉefenigujon kaj ĉefeligujon la unua tutmonda alinomo filtras al *egrep* kun kolorita eligo. La
plej novan kutiman dosieron en la aktuala dosierujo la dua tutmonda alinomo revenas.

Por ĉiom da alinomoj montru, plenumu:

    alias


<a name="funkcioj"></a>Funkcioj
-------------------------------

Funkcioj, aliflanke, estas la pli grandaj parencoj de alinomoj. Ili povas fari pli multe ol siaj
malpliaj kolegoj povas fari. Unu el la plej gravaj kontrastoj por teni en la kalkulo, estas,
funckiojn povas fari pli ol anstataŭigon. Ekzemple, en la jena alinomo:

    alias ve="echo hundo"

tekstan anstataŭigon nur faras. Tio estas, kiam la tekston `hundo` ziŝo trafas kiel la unua ero de la
komandlinio, ĝin ĝi anstataŭigas per `echo hundo`. Nenio plu. Do, plenumante jene:

    ve

fariĝas

    echo hundo

La jenajn liniojn kontrastu:

    alias hundo0="for x in hundo kato muso; do echo $x; done"
    function hundo1 () { for x in hundo kato muso; do echo $x; done }

La ŝlosilvorto `function` estas redunda kaj povas esti ellasita. Ilin plenumu kaj la resultojn rimarku:

    % hundo0
    % hundo1

Pli altan prioritaton alinomoj havas pli ol funkcioj. La jenajn liniojn konsideru:

    alias hundo="echo hundo"
    function hundo () { echo hundo, ankaux }

La nomon `hundo` ambaŭ uzas, sed malsaman nomspacon ĉiu uzas. Kiam na `hundo` oni kuras:

    % hundo
    hundo

Nur na `hundo` ĝi montras, anstataŭ na `hundo, too` eĉ ĉi tiu venas de pli nova difino. Por la alinomon
`hundo` forigi, plenumu:

    % unalias hundo
    % hundo
    hundo, too

Tiel longe kiel eble, funkciojn plenumu:

Por ĉiom da funkcioj montri, plenumu:

    % functions


<a name="cxio"></a>Ĉion rikolti
-------------------------------

La agorddosieron malpurigi per plenaj funciaj difinioj por ĉiu malgranda komando, kiun oni volas
havi estas malŝaga. Anstataŭe, pli bonan manieron por tutmondajn alinomojn kaj malgrandajn funkciojn
ni uzos. La dosieron `~/.zshenv` malfermu per la plej ŝatata redaktilo.

La funkciojn, kiu la aliajn difinas, ni unue difinu:

```bash
function def_real_alias () {
  while [[ $# -ge 2 ]]; do
    alias "$1=$2"
    shift 2
  done
}

function def_real_aliases () {
  def_real_alias $real_aliases
  unset real_aliases
}

function def_global_alias () {
  while [[ $# -ge 2 ]]; do
    alias -g "$1=$2"
    shift 2
  done
}

function def_global_aliases () {
  def_global_alias $global_aliases
  unset global_aliases
}

function def_fun () {
  while [[ $# -ge 2 ]]; do
    eval "function $1 () { $2 \$@ }"
    shift 2
  done
}

function def_funs () {
  def_fun $funs
  unset funs
}
```

Sekve, la tabelojn ni difinu:

```bash
real_aliases=(
  ve "echo hundo"
); def_real_aliases

global_aliases=(
  :: ':>!'

  B '`git rev-parse --abbrev-ref HEAD`'

  V "|& less"
  G "|& rg --color auto"
  S "|& sort"
  R "|& sort -rn"
  L "|& wc -l | sed 's/^\ *//'"

  H  "|& head"
  T  "|& tail"
  H1 "H -n 1"
  T1 "T -n 1"

  ZF '*(.L0)'     # zero-length regular files
  ZD '*(/L0)'     # zero-length directories

  AE '{,.}*'      # all files, including dot files
  AF '**/*(.)'    # all regular files
  AD '**/*(/)'    # all directories
  AS '**/*(@)'    # all symlinks

  OF '*(.om[-1])' # oldest regular file
  OD '*(/om[-1])' # oldest directory
  OS '*(@om[-1])' # oldest symlink

  NF '*(.om[1])'  # newest regular file
  ND '*(/om[1])'  # newest directory
  NS '*(@om[1])'  # newest symlink

); def_global_aliases

funs=(
  z "exec zsh"
  s "sudo"

  d "pushd"
  \- "popd"
  ds "dirs -l"

  cp "command cp -i"
  mv "command mv -i"

  l "ls -GFAtr --color"
  la "ls -AF --color"
  ll "l -l
  l1 "l -1"
  lh "l -H"
  lr "l -R"
  lk "la -l"

  sl "ln -sf"
  md "mkdir -p"

  f "fd"
  g "ripgrep --color auto"
  gi "g -i"
  tf "tail -F"
  rh "rehash"

  mount "s mount"
  umount "s umount"
  reboot "s reboot"
  poweroff "s poweroff"
  halt "s halt -p"
); def_funs
```


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Komandojn grupigi tiel la procedon por novajn erojn aldoni kaj forigi plifaciligas. Ĉion porti en
unu kunfandita loko la agorddosieron igas aserteble pura. Por la restantajn difinojn iru
[ĉi tien](https://github.com/ebzzry/dotfiles/tree/master/zsh).

Se giton vi uzas, la artikolo pri kiel ĝi mi uzas, eble ankaŭ plaĉas al vi. Ĝi
troviĝas [ĉi tie](/eo/gito/).

_Dank’ al [Jakub JAREŠ](https://github.com/nohwnd) pro la korektoj._
