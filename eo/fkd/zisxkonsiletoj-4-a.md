Ziŝaj Konsiletoj 4-a: Ĝeneralhelpiloj
=====================================

<div class="center">Esperanto ◆ [English](/en/zsh-tips-4/)</div>
<div class="center">Laste ĝisdatigita: la 23-an de Februaro 2022</div>

>Vidpunkto meritas okdek poentojn da inteligentecaj kvocientoj.<br>
>―Alan KAY

Lastfoje, mi parolis pri la helpilaj funkcioj por asisti en la mastrumado de radikigmedioj. En ĉi
tiu artikolo, mi parolos pri ĝeneralaj helpiloj por labori ĉe la komandlinio. Mi ankaŭ parolos pri
helpemaj klavkombinoj por maŝinskribadon plirapidigi.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Funkcioj](#funkcioj)
  + [map](#map)
  + [rmap](#rmap)
  + [fp](#fp)
  + [d](#d)
  + [d!](#d_krisigno)
  + [rm!](#rm_krisigno)
  + [rm+](#rm_pluso)
  + [rm@](#rm_heliko)
  + [def_mk](#defmk)
  + [cp!](#cp_krisigno)
  + [mv!](#mv_krisigno)
- [Klavkombinoj](#klavkombinoj)
  + [insert-last-word](#insertlastword)
  + [copy-prev-shell-word](#copyprevshellword)
  + [Anstataŭigoj](#anstatauxigoj)
  + [Citiloj](#citiloj)
- [Ĉion rikolti](#cxio)
- [Finrimarkoj](#finrimarkoj)


<a name="funkcioj"></a>Funkcioj
-------------------------------

Bela afero pri funkcioj, estas, ke ili estas tiel facile por skribi kaj uzi. Jen kelkaj funkcioj
kiujn mi uzas ofte.


### <a name="map"></a>map

Kiam komandon kiu nur unu argumenton akceptas oni havas, plurajn uzojn de tiu komando oni volas
simuli per ĉi tiu funkcio. Ĝi estas difinita jene:

```bash
function map () {
  for i (${argv[2,-1]}) { ${(ps: :)${1}} $i }
}
```

Ekzemple, je `map` oni povas uzi por plurajn gitaj deponejon, serie:

    % map 'git clone' git@github.com:nixos/nixpkgs.git git@github.com:tmux/tmux.git


### <a name="rmap"></a>rmap

Kiel la nomo implicas, `rmap` funkcias kiel la inverso de `map`—la cetaraj argumentoj estas
aplikitaj kiel komandoj al la unua argumento. Ĝi estas difinita jene:

```bash
function rmap () {
  for i (${argv[2,-1]}) { ${(ps: :)${i}} $1 }
}
```

Ĝi oni povas uzi, ekzemple, por diskuzadon kontroli, dosierinformon vidi, kaj la malfermajn
dosiernumerojn de dosiero aŭ dosierujo vidi:

    % rmap iudosierujo 'du -h' stat 'sudo lsof'


### <a name="fp"></a>fp

Rapidan manieron por la realan kaj absolutan dosierindikon de dosiero aŭ dosierujo precizigi mi volas
havi. Min ĉi tio helpas multe en skriptado. Ĝi estas difinita jene:

```bash
function fp () {
  echo "${1:A}"
}
```

Se mi estas en simbolligita dosierujo, kaj la realdosierindikon de `.` mi volas precizigi, la jenan
mi povas plenumi:

    % fp .

Ĉi tiu funkcio estos grava en la sekva sekcio.


### <a name="d"></a>d

Ofte, kiam mi iras al dosierujo, serion de komandoj mi bezonas plenumi. Tempon por maŝinskribado mi volas
savi, do anstataŭ du komandojn plenumi, nur unu mi nur devas plenumi. Manieron por dosierujon rapide
ŝanĝigi tra la dosierujstakoj per `pushd` mi volas havi. Ĝi estas difinita jene:

```bash
function d () {
  if (( ! $#@ )); then
      builtin cd
  elif [[ -d $argv[1] ]]; then
      builtin cd "$(fp $argv[1])"
      $argv[2,-1]
  elif [[ "$1" = -<-> ]]; then
      builtin cd $1 > /dev/null 2>&1
      $argv[2,-1]
  else
    echo "$0: no such file or directory: $1"
  fi
}
```

Kiam je `d` mi plenumas sole:

    % d

Mi iros al la hejmdosierujo, samkiel kion memstara `cd` devus fari:

Kiam je `d` mi plenumas kun dosierujo kaj komando:

    % d ~/Downloads ls -l

La aktuala dosierujo ŝanĝiĝos al `~/Downloads`, tiam je `ls -l` mi plenumas por la enhavon de tiu
dosierujo montri.

Se la eligo de `dirs -v` estas la jena:

```
0       /usr/local
1       /tmp
```

Tiam, je `d` mi plenumu, kaj la dua enskribo estas uzota kun komando:

    % d -1 date

La dosierujo ŝanĝiĝos al `/tmp/`, tiam la komando `date` kuros.


### <a name="d_krisigno"></a>d!

Kiel la nomo implicas, `d!` similas al sia kuzo nur, ke se la cela dosierujo ne ekzistas, ĝin ĝi
kreas, kaj la saman konduton de `d` ĝi faras poste. Ĝi estas difinita jene:

```bash
function d! () {
  mkdir -p $argv[1]
  d "$@"
}
```

Ekzemple, je `d!` mi povas uzi por dosierujon scenigi antaŭ ISO-dosieron elŝuti:

    % d! ~/Downloads/iso https://www.hundo.kato/muso/ve/ve.iso


### <a name="rm_krisigno"></a>rm!

Kiam mi certas, ke dosieron aŭ dosierujon mi volas forviŝi, mi ne volos ĝenita per invitoj, dum
samtempe escepton por la hejmdosieron ne akcidente forviŝi mi volas havi. Ĝi estas difinita jene:

```bash
function rm! () {
  if [[ "$1" == "$HOME" || "$1" == "$HOME/" || "$1" == "~" || "$1" == "~/" ]]; then
      return 1
  else
    command rm -rf $@
  fi
}
```

La komando `commando` certigas, ke la sistemduumdosieron `rm` mi alvokas anstataŭ ia ŝela alinomo aŭ
funkcio.


### <a name="rm_pluso"></a>rm+

Kiam ajn mi volas rapide forviŝi arbon kiu havas multe da dosiero kaj dosierujo,
la komandon `parallel` mi uzas por la forviŝadon plenumi paralele, anstataŭ
serie. Ĝi estas difinita jene:

```bash
function rm+ () {
  parallel 'rm -rf {}' ::: $@
}
```

La pakadministrilon de la sistemo kontrolu kiel je `parallel` instali.


### <a name="rm_heliko"></a>rm@

Kelkfoje, dosieron aŭ dosierujon mi bezonas forviŝi sen la ŝancoj de retrovado. Por tion fari, la
komandon `shred` mi uzas. Ĝi estas difinita jene:

```bash
function rm@ () {
  if [[ -d $1 ]]; then
      find $1 -type f -exec shred -vfzun 10 {} \;
      command rm -rf $1
  else
    shred -vfzun 10 $1
  fi
}
```

La pakadministrilon de la sistemo kontrolu kiel je `shred` instali.


### <a name="defmk"></a>def_mk

Helpilojn ci tiu helpilo generas. Onin ĝi permesas por funkciojn krei kiuj antaŭproduktajn dosierojn
kreas antaŭ la vera komando estas plenumita. Ĝi estas difinita kiel:

```bash
function def_mk () {
  eval "function ${argv[1]} () {
            if [[ \$# -ge 2 ]]; then
                if [[ ! -e \${@: -1} ]]; then
                     mkdir -p \${@: -1}
                fi

                command ${argv[2,-1]} \$@
            fi
        }"
}
```

Por ĝin uzi, la nomon de la funkcio kiu estos uzita kiel komando donu, kaj la malvolvo mem. Ĉi tiuj
alvokoj estas ideale difinita en la agorddosiero.

### <a name="cp_krisigno"></a>cp!

Por je `def_mk` uzi kun `cp` ĝin alvoku jene:

    def_mk cp! cp -rf

kiu malvolvas al:

```
function cp! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command cp -rf $@
  fi
}
```

Onin la komando `cp!` permasas por dosierojn kaj dosierujojn kopii, la celan dosierujon kreante kiel
necese:

```bash
%  tree
.
├── bar.txt
└── foo.txt

0 directories, 2 files

%  cp! * a

%  tree
.
├── a
│   ├── bar.txt
│   └── foo.txt
├── bar.txt
└── foo.txt

1 directory, 4 files
```


### <a name="mv_krisigno"></a>mv!

Por je `def_mk` uzi kun `mv` ĝin alvoku jene:

    def_mk mv! mv -f

kiu malvolvas al:

```
function mv! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command mv -f $@
  fi
}
```

Onin la komando `mv!` permasas por dosierojn movi al dosierujo, la celan dosirujon kreante kiel
necese:

```bash
%  tree
.
├── bar.txt
└── foo.txt

0 directories, 2 files

%  mv! * b

%  tree
.
└── b
    ├── bar.txt
    └── foo.txt

1 directory, 2 files
```


<a name="klavkombinoj"></a>Klavkombinoj
---------------------------------------

Ekster la komandoj kiuj estas maŝinskribitaj, klavkombinoj oni ankaŭ povas alvoki por ajnajn komandojn
fari. Jen kelkaj, kiujn mi uzas ofte:


### <a name="insertlastword"></a>insert-last-word

Kiam la lastan vorton de la lasta komando mi volas enmeti, je `insert-last-word` mi vokas. Ekzemple,
se la jenan oni havas, en kiu la ĉapelo estas la kursoro:

    % dig hundo12345.kato.muzo.io
    % mtr
          ^

Kiam je `M-x insert-last-word EN` mi plenumas, la lastan vorton de la lasta komando ĝi enmetas, ĝin
fari al:

    % dig hundo12345.kato.muzo.io
    % mtr hundo12345.kato.muzo.io
                                 ^

Ĉi tio certigas, ke la argumento estas ĝuste kopiita.

La klavo estas defaŭlte bindita al <kbd>M-.</kbd>. Se oni volas certigi, ke tiun klavkombinon oni
havas, la jenan metu en la agordo:

    bindkey "\e." insert-last-word


### <a name="copyprevshellword"></a>copy-prev-shell-word

Se la lastan vorton en la aktuala komandlinio mi volas ripeti, je `copy-prev-shell-word` mi
alvokas. Ekzemple, se la jenan oni havas:

    % cp cxi.tio.estas.tre.longa.nomo
                                      ^

Kiam je `M-x copy-prev-shell-word EN` mi plenumas, la lastan vorton ziŝo enmetas, gin fari al:

    % cp cxi.tio.estas.tre.longa.nomo cxi.tio.estas.tre.longa.nomo
                                                                  ^

Ĝin mi bindis al <kbd>M-=</kbd>. Por ĝin bindi al la agorddosiero:

    bindkey "\e=" copy-prev-shell-word


### <a name="anstatauxigoj"></a>Anstataŭigoj

Krome la plenumado de `M-x` komandoj, onin ziŝo permesas por klavkombinojn difini kiu ajnan tekston
enmeti ĉe la komandlinion, inkluzive stirsignoj.

La eligon de komandoj mi ofte bezonis akiri. Kutime la jenan mi faras:

    % foo `some command`

aŭ

    % foo $(some command)

La antaŭa pli facilas por maŝinskribi, tamen ĝi ne povas nestiĝi; la ĉi tiu estas tro malfacila por maŝinskribi. Por tio, la klavkombinon <kbd>M-`</kbd> mi bindis jene:

    % bindkey -s '\e`' '$()\C-b'

Do, se la jenan mi havas:

    % foo
          ^

Kiam je <kbd>M-`</kbd> mi premas, la jenan mi akiros:

    % foo $()
            ^


### <a name="citiloj"></a>Citiloj

La bezonon por la argumenton de komandon citi mi ofte havas, precipe se metaesprimojn ĝi havas. Ofta
kazo estas de jutubaj retadresoj, kiu la `?` signon havas:

Por tio, je <kbd>M-'</kbd> bindis kiel jene:

    % bindkey -s "\e'" "''\C-b"

Do, kiam la jenan mi havas:

    % youtube-dl
                 ^

Kiam je <kbd>M-'</kbd> mi premas, la jenan mi akiros:

    % youtube-dl ''
                  ^

Anstataŭ tri klavojn premi per mia klavaro, nur du mi nur devas premi, kaj ĝi certigas, ke paron de
citiloj mi akiras.


<a name="cxio"></a>Ĉion rikolti
-------------------------------

Jen ĉiom da difinoj, kun kelkaj aldonaj helpiloj, en unu loko:

```bash
function map () {
  for i (${argv[2,-1]}) { ${(ps: :)${1}} $i }
}

function rmap () {
  for i (${argv[2,-1]}) { ${(ps: :)${i}} $1 }
}

function fp () {
  echo "${1:A}"
}

function d () {
  if (( ! $#@ )); then
      builtin cd
  elif [[ -d $argv[1] ]]; then
      builtin cd "$(fp $argv[1])"
      $argv[2,-1]
  elif [[ "$1" = -<-> ]]; then
      builtin cd $1 > /dev/null 2>&1
      $argv[2,-1]
  else
    echo "$0: no such file or directory: $1"
  fi
}

function d! () {
  mkdir -p $argv[1]
  d "$@"
}

function rm! () {
  if [[ "$1" == "$HOME" || "$1" == "$HOME/" || "$1" == "~" || "$1" == "~/" ]]; then
      return 1
  else
    command rm -rf $@
  fi
}

function rm+ () {
  parallel 'rm -rf {}' ::: $@
}

function rm@ () {
  if [[ -d $1 ]]; then
      find $1 -type f -exec shred -vfzun 10 {} \;
      command rm -rf $1
  else
    shred -vfzun 10 $1
  fi
}

function def_mk () {
  eval "function ${argv[1]} () {
            if [[ \$# -ge 2 ]]; then
                if [[ ! -e \${@: -1} ]]; then
                     mkdir -p \${@: -1}
                fi

                command ${argv[2,-1]} \$@
            fi
        }"
}

def_mk cp! cp -rf
def_mk mv! mv -f

function def_key () {
  while [[ $# -ge 2 ]]; do
    bindkey "$1" "$2"
    shift 2
  done
}

function def_keys () {
  def_key $keys
  unset keys
}

function def_out_key () {
  while [[ $# -ge 2 ]]; do
    bindkey -s "$1" "$2"
    shift 2
  done
}

function def_out_keys () {
  def_out_key $out_keys
  unset out_keys
}

keys=(
  "\e." insert-last-word
  "\e=" copy-prev-shell-word
); def_keys

out_keys=(
  '\e`' '$()\C-b'
  "\e'" "''\C-b"
); def_out_keys
```


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

La komandlinion uzante, precipe per ŝelo tiel potenca kiel ziŝo, estas devige por esti konscie, kiun
la ŝelon povas fari. Ne blinde uzu pakojn kiujn la ŝelon personecigas, sen kompreni kiujn ili faras.

Bonan ziŝigadon!
