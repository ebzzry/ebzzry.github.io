Kiel Uzas Mi Giton
==================

<div class="center">Esperanto ▪ [English](/en/git/)</div>
<div class="center">la 26-an de Julio 2019</div>
<div class="center">Laste ĝisdatigita: la 23-an de Aŭgusto 2021</div>

>Male, tiuj kun senĉeseco povas malatenti kiujn aliaj pensas. Ion ajn ili povas
>fari en ilia propra mondo senzorgeme al la opinioj de tiuj ĉirkaŭ ili.<br>
>―Daigo UMEHARA

<a name="et">Enhavotabelo</a>
-----------------------------

- [Superrigardo](#superrigardo)
- [Mallongaj komandoj](#mallongaj)
  + [Alinomoj](#alinomoj)
  + [Alternativo](#alternativo)
- [Agordo](#agordo)
  - [Baza funkcio](#bazafunkcio)
  - [Gravaj komandoj](#komandoj1)
  - [Aliaj komandoj](#komandoj2)
- [Ĉion rikolti](#cxio)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo">Superrigardo</a>
---------------------------------------

En mia ilaro estas terminalsimulilo, ŝelo, redaktilo, retumilo, kompililo, kaj
gito. Ekde kiam giton mi konis antaŭ multaj jaroj, ĝi fariĝis unu el miaj plej
uzataj iloj. Pro ĝia rapideco kaj amplekso de uzo, ĝin mi uzas kiel mia tria
brako.

Pro tio ke emakson mi uzas, je [Magit](https://magit.vc/) mi ankaŭ havas. Tamen,
en ĉi tiu artikolo mi parolos pri kiel giton mi uzas ĉiutage sur la komandlinio.

La komandoj kaj funckioj kiujn ni havos ĉi tie estas por Ziŝo kaj Baŝo. Eblas,
ke ili ankaŭ povas funkcii sur aliaj ŝeloj, tamen, ilin mi ne testis.


<a name="mallongaj">Mallongaj komandoj</a>
------------------------------------------

Per gito, se la staton de deponejo ni volas vidi, la jenan komandon ni plenumos:

    git status

Tamen, estas pluraj kazoj kiam pli mallongan version ni deziras uzi:

    git s

La pli mallongan version ni uzas eble aŭ por la ŝparado de maŝinskribado aŭ
estas fizike malfacilas por la plenan komandon maŝinskribi. En ĉi tiu sekcio mi
diskutos pri la ekzistantaj metodoj por pli mallongajn komandojn fari.


### <a name="alinomoj">Alinomoj</a>

Manierojn por la difinado de mallongaj komandoj gito jam havas. Ekzemple, se ni
deziras, ke anstataŭ

    git clone

ni uzas je

    git c

alinomon por la `clone`-komando ni povas difini per la alinoma sistemo de
gito. Tion ni povas fari per du metodoj.

La unua metodo estas rekte per la komandlinio:

    git config --global alias.c clone

La dua metodo estas per la agorda dosiero, kiu troviĝas en `~/.gitconfig`. La
jenan tekston ni metu en tiun dosieron:

```
[alias]
  c = clone
```

Arbitrajn komandojn oni ankaŭ povas uzi ene la `alias`-klaŭzo. Estas du
metodoj por tion fari.

La unua metodo estas rekte kiel ŝela komando:

```
[alias]
  hello = "! echo hello world"
```

Se la komandon

    git hello

oni plenumas, ŝajnos, ke la jenan komandon oni plenumis:

    echo hello world

Do, konsekvece la eligo estas

    hello world

La dua metodo estas per la difinado de ŝelaj funkcioj:

```
[alias]
  hi = "! hi () { echo hi world; }; hi"
```

Se la komandon

    git hi

oni plenumas, ŝajnos, ke la jenan komandon oni plenumos:

    hi () { echo hi world; }
    hi

Per ĝi, ŝelan funkcion kiu nomiĝas `hi` oni unue difinis. Sekve, tiun funkcion
ni vokis. Do, la eligo estas:

    hi world


### <a name="alternativo">Alternativo</a>

Dum tiuj metodoj bonas por multaj uzantoj, ili ne sufiĉas por mi tial, ke aliron
al mia tuta ŝela agordo ĝi ne havas. Aliajn funkciojn kiujn mi havas en mia
ŝelagordo ĝi ne povas voki. Pli grave, la funkciado per alinomoj estas limigita
nur ene la medio de la gitagordo.

Kion mi uzas anstataŭe estas ke ŝelan funkcion mi difinis, en kiu, ilin mi
povas voki per falsaj alinomoj kaj per validaj gitkomandoj. Per tiu sistemo, se la
jenan komandon mi uzos:

    git clone

Gito kondutas same kiel la originala komando. Tamen se la jenan komandon mi
uzos:

    git abc

la subkomandon `abc`, kiun mi difinis, vi vokos. Eĉ se alinomon kun
sama nomo mi jam havas en `~/.gitconfig`, ĉi tiu komando kuras per pli alta
prioritato.


<a name="agordo">Agordo</a>
---------------------------

En ĉi tiu sekcio estas difinoj kiujn ni devas meti en la agorddosiero de
Ziŝo kaj Baŝo. Ilin mi havas en `~/.zshenv` kaj `~/.bashrc`, respektive.


### <a name="bazafunkcio">Baza funkcio</a>

Jen la baza funcio:

```
function git () {
  local git= self= op=

  if [[ -n "${BASH}" ]]; then
    git=$(which git)
    self=${FUNCNAME}
  elif [[ -n "${ZSH_NAME}" ]]; then
    git=$(whence -p git)
    self=$0
  else
    echo "Meh"
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    if [[ -n "${BASH}" ]]; then
      type "${self}" | less
    elif [[ -n "${ZSH_NAME}" ]]; then
      which "${self}" | less
    else
      echo "Meh"
      return 1
    fi
  else
    op="$1"
    shift

    case "${op}" in
      # komandoj ĉi tie
      (*) =git "${op}" "$@" ;;
    esac
  fi
}
```

Se ne estas komando por gito:

    git

la difinon de la funkcio mem la ŝelo montras.

La subkomandoj loĝos en la areo markita `# komandoj ĉi tie`. La retropaŝa ago
markita per `*` signifas, ke se ne estas propra komando el mi, la internan
komandon de gito plenumi anstataŭ.


### <a name="komandoj1">Gravaj komandoj</a>

Jen la plej gravaj komandoj kiujn ni unue devas havi.


**Ĉefaj operacioj**

```
      (s) "${git}" status ;;
      (c) "${git}" clone "$@" ;;
      (h) "${git}" show "$@" ;;
      (mv) "${git}" mv "$@" ;;
      (mv!) "${git}" mv -f "$@" ;;
      (me) "${git}" merge "$@" ;;
      (ta) "${git}" tag "$@" ;;
      (bl) "${git}" blame "$@" ;;

      (a) "${git}" add "$@" ;;
      (au) "${self}" a -u ;;
      (a.) "${self}" a . ;;

      (ci) "${git}" commit "$@" ;;
      (cia) "${self}" ci --amend "$@" ;;
      (cim) "${self}" ci --message "$@" ;;

      (co) "${git}" checkout "$@" ;;
      (com) "${self}" co master ;;
      (cot) "${self}" co trunk ;;
      (co!) "${self}" co --force "$@" ;;
      (cob) "${self}" co -b "$@" ;;

      (rt) "${git}" reset "$@" ;;
      (rt!) "${self}" rt --hard "$@" ;;
      (rv) "${git}" revert "$@" ;;

      (g) "${git}" grep "$@" ;;
      (gi) "${self}" g -i "$@" ;;

      (f) "${git}" fetch "$@" ;;
      (fa) "${self}" f --all "$@" ;;

      (rm) "${git}" rm "$@" ;;
      (rmr) "${self}" rm -r "$@" ;;
      (rm!) "${self}" rm -rf "$@" ;;

```


**Puŝado kaj tirado**

```
      (ph) "${git}" push "$@" ;;
      (phu) "${self}" ph -u "$@" ;;
      (ph!) "${self}" ph --force "$@" ;;
      (pho) "${self}" phu origin "$@" ;;
      (phom) "${self}" pho master "$@" ;;

      (pl) "${git}" pull "$@" ;;
      (pl!) "${self}" pl --force "$@" ;;
      (plr) "${self}" pl --rebase "$@" ;;
      (plro) "${self}" plr origin "$@" ;;
      (plru) "${self}" plr upstream "$@" ;;
      (plrom) "${self}" plro master ;;
      (plrum) "${self}" plru master ;;
      (plrot) "${self}" plro trunk ;;
      (plrut) "${self}" plru trunk ;;

```


**Branĉoj kaj dosierdiferencoj**

```
      (br) "${git}" branch "$@" ;;
      (bra) "${self}" br -a ;;
      (brh) "${git}" rev-parse --abbrev-ref HEAD ;;
      (brm) "${self}" br -m "$@" ;;
      (brmh) "${self}" brm "$(git brh)" ;;
      (brd) "${self}" br -d "$@" ;;
      (brD) "${self}" br -D "$@" ;;

      (d) "${git}" diff "$@" ;;
      (dc) "${git}" diff --cached "$@" ;;
      (dh) "${self}" d HEAD ;;
      (dhw) "${self}" d --word-diff=color ;;
```


**Protokoloj**

```
      (l) "${git}" log "$@" ;;
      (l1) "${self}" l -1 --pretty=%B ;;
      (lo) "${self}" l --oneline ;;
      (lp) "${self}" l --patch ;;
      (lp1) "${self}" lp -1 ;;
      (lpw) "${self}" lp --word-diff=color ;;
```


### <a name="komandoj2">Aliaj komandoj</a>

Jen aliaj komandoj kiujn ni ankaŭ devas difini.


**Pravaloriziĝado kaj puŝadheloj**

```
      (i) touch .gitignore; "${git}" init; "${self}" a.; "${self}" cim "$@" ;;
      (oo) "${self}" ph origin "$(git brh)" ;;
      (oo!) "${self}" ph! origin "$(git brh)" ;;
```

Kiam ajn novajn deponejon mi kreas, la jenan komandon mi plenumas:

    git i Pravaloriziĝu

Kion la `oo` subkomando faras estas ke la kodo puŝiĝos al la fordeponejo kiu
nomiĝas `origin` sub la nomo de la aktuala branĉo. Ekzemple, se la aktuala
branĉo nomiĝas `trunk`, kaj la jenan komandon oni plenumas:

    git oo

la komando fariĝos

    git ph origin trunk


**Ŝanĝado de arboj**

```
      (rb) "${git}" rebase "$@" ;;
      (rbi) "${self}" rb --interactive "$@" ;;
      (rbc) "${self}" rb --continue "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rba) "${self}" rb --abort "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rbi!) "${self}" rbi --root "$@" ;;

      (ri) "${self}" rbi HEAD~"$1" ;;
      (rs) "${self}" rt --soft HEAD~"$1" && "${self}" cim "$(git log --format=%B --reverse HEAD..HEAD@{1} | head -1)" ;;
```

La subkomandon `rs` mi uzas kiam ŝanĝojn mi volas kunpremegi neinterage. La
argumento al ĝi estas cifero kio prezicigas kiom da ŝanĝo oni volas
kunpremigi. Ekzemple, se la lastajn du ŝanĝojn mi volas kunpremegi, la jenan
komandon mi uzas:

    git rs 2


**Aldonado**

```
      (aum) "${self}" au; "${self}" cim "$@" ;;
      (aux) "${self}" aum "x" ;;
      (a.m) "${self}" a.; "${self}" cim "$@" ;;
      (a.x) "${self}" a.m "x" ;;

      (auxx) "${self}" aux; "${self}" rs 2 ;;
      (au.x) "${self}" a.x; "${self}" rs 2 ;;
      (auxx!) "${self}" auxx; "${self}" oo! ;;
```

La subkomando `aum` fariĝos mallongigo de `au` kaj `cm` orde. La subkomandon
`auxx` mi uzas kiam ajn nur etajn ŝanĝojn mi faris sed novan videblan enskribon
en la protokolo mi ne deziras havi.


**Foraj deponejoj**

```
      (re) "${git}" remote "$@" ;;
      (rea) "${self}" re add "$@" ;;
      (reao) "${self}" rea origin "$@" ;;
      (reau) "${self}" rea upstream "$@" ;;
      (rer) "${self}" re remove "$@" ;;
      (ren) "${self}" re rename "$@" ;;
      (rero) "${self}" rer origin "$@" ;;
      (reru) "${self}" rer upstream "$@" ;;
      (res) "${self}" re show "$@" ;;
      (reso) "${self}" res origin ;;
      (resu) "${self}" res upstream ;;
```


**Revizioj, filtrado, kaj kaŝujoj**

```
      (rl) "${git}" rev-list "$@" ;;
      (rla) "${self}" rl --all "$@" ;;
      (rl0) "${self}" rl --max-parents=0 HEAD ;;

      (cp) "${git}" cherry-pick "$@" ;;
      (cpc) "${self}" cp --continue "$@" ;;
      (cpa) "${self}" cp --abort "$@" ;;

      (fb) "${git}" filter-branch "$@" ;;
      (fb!) "${self}" fb -f "$@" ;;
      (fbm) "${self}" fb! --msg-filter "$@" ;;
      (fbi) "${self}" fb! --index-filter "$@" ;;
      (fbe) "${self}" fb! --env-filter "$@" ;;

      (rp) "${git}" rev-parse "$@" ;;
      (rph) "${self}" rp HEAD ;;

      (st) "${git}" stash "$@" ;;
      (stp) "${self}" st pop "$@" ;;
```

Kiam ajn tekstojn de ĉiuj antaŭaj ŝanĝmesaĝoj mi volas ŝanĝi, ekzemple la vorton
`hundo` mi volas ŝanĝi al `kato`, la jenan komandon mi plenumas:

    git fbm 'sed "s/hundo/kato/"'

Kiam ajn dosieron mi volas forigi tute el la deponejo, ekzemple `dosiero.dat`,
la jenan komandon mi plenumas:

    git fbi 'git rm --cached --ignore-unmatch dosiero.dat' HEAD

Kiam ajn la retpoŝadreson mi volas ŝanĝi, ekzemple, al `kato@mondo.io`, la jenan
komandon mi plenumas:

    git fbe 'export GIT_AUTHOR_EMAIL="kato@mondo.io"; export GIT_COMMITTER_EMAIL="kato@mondo.io"' --tag-name-filter cat -- --branches --tags

La jenan komandon mi tiam uzas sekve, por certigi ke la ŝanĝoj aperas en la fora deponejo:

    git oo!


**Subarboj, kaj submoduloj**

```
      (subt) "${git}" subtree "$@" ;;
      (subta) "${self}" subt add "$@" ;;
      (subtph) "${self}" subt push "$@" ;;
      (subtpl) "${self}" subt pull "$@" ;;

      (subm) "${git}" submodule "$@" ;;
      (subms) "${self}" subm status "$@" ;;
      (submy) "${self}" subm summary "$@" ;;
      (submu) "${self}" subm update "$@" ;;
      (subma) "${self}" subm add "$@" ;;
      (submi) "${self}" subm init "$@" ;;

      (ref) "${git}" reflog "$@" ;;
```

**Priskribado**

```
      (de) "${git}" describe "$@" ;;
      (det) "${self}" de --tags "$@" ;;
```


<a name="cxio">Ĉion rikolti</a>
-------------------------------

Jen da difinoj en unu loko:

```
function git () {
  local git= self= op=

  if [[ -n "${BASH}" ]]; then
    git=$(which git)
    self=${FUNCNAME}
  elif [[ -n "${ZSH_NAME}" ]]; then
    git=$(whence -p git)
    self=$0
  else
    echo "Meh"
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    if [[ -n "${BASH}" ]]; then
      type "${self}" | less
    elif [[ -n "${ZSH_NAME}" ]]; then
      which "${self}" | less
    else
      echo "Meh"
      return 1
    fi
  else
    op="$1"
    shift

    case "${op}" in
      (i) touch .gitignore; "${git}" init; "${self}" a.; "${self}" cim "$@" ;;
      (i!) "${self}" i "Pravaloriziĝu" ;;

      (s) "${git}" status ;;
      (c) "${git}" clone "$@" ;;
      (h) "${git}" show "$@" ;;
      (mv) "${git}" mv "$@" ;;
      (mv!) "${git}" mv -f "$@" ;;
      (me) "${git}" merge "$@" ;;
      (ta) "${git}" tag "$@" ;;
      (bl) "${git}" blame "$@" ;;

      (cl) "${git}" clean "$@" ;;
      (cl!) "${self}" cl -f ;;

      (ci) "${git}" commit "$@" ;;
      (cia) "${self}" ci --amend "$@" ;;
      (cim) "${self}" ci --message "$@" ;;

      (co) "${git}" checkout "$@" ;;
      (com) "${self}" co master ;;
      (cot) "${self}" co trunk ;;
      (co!) "${self}" co --force "$@" ;;
      (cob) "${self}" co -b "$@" ;;

      (ls) "${git}" ls-files "$@" ;;
      (lsm) "${self}" ls -m ;;
      (lsd) "${self}" ls -d ;;
      (lsdrm) "${self}" lsd | xargs "${git}" rm ;;

      (rt) "${git}" reset "$@" ;;
      (rt!) "${self}" rt --hard "$@" ;;
      (rv) "${git}" revert "$@" ;;

      (g) "${git}" grep "$@" ;;
      (gi) "${self}" g -i "$@" ;;

      (f) "${git}" fetch "$@" ;;
      (fa) "${self}" f --all "$@" ;;

      (rm) "${git}" rm "$@" ;;
      (rmr) "${self}" rm -r "$@" ;;
      (rm!) "${self}" rm -rf "$@" ;;

      (rb) "${git}" rebase "$@" ;;
      (rbi) "${self}" rb --interactive "$@" ;;
      (rbc) "${self}" rb --continue "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rba) "${self}" rb --abort "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rbi!) "${self}" rbi --root "$@" ;;

      (ri) "${self}" rbi HEAD~"$1" ;;
      (rs) "${self}" rt --soft HEAD~"$1" && "${self}" cim "$(git log --format=%B --reverse HEAD..HEAD@{1} | head -1)" ;;

      (ph) "${git}" push "$@" ;;
      (phu) "${self}" ph -u "$@" ;;
      (ph!) "${self}" ph --force "$@" ;;
      (pho) "${self}" phu origin "$@" ;;
      (phom) "${self}" pho master "$@" ;;

      (oo) "${self}" ph origin "$(git brh)" ;;
      (oo!) "${self}" ph! origin "$(git brh)" ;;

      (pl) "${git}" pull "$@" ;;
      (pl!) "${self}" pl --force "$@" ;;
      (plr) "${self}" pl --rebase "$@" ;;
      (plro) "${self}" plr origin "$@" ;;
      (plru) "${self}" plr upstream "$@" ;;
      (plrom) "${self}" plro master ;;
      (plrum) "${self}" plru master ;;
      (plrot) "${self}" plro trunk ;;
      (plrut) "${self}" plru trunk ;;

      (a) "${git}" add "$@" ;;
      (au) "${self}" a -u ;;
      (a.) "${self}" a . ;;

      (aum) "${self}" au; "${self}" cim "$@" ;;
      (aux) "${self}" aum "x" ;;
      (a.m) "${self}" a.; "${self}" cim "$@" ;;
      (a.x) "${self}" a.m "x" ;;

      (auxx) "${self}" aux; "${self}" rs 2 ;;
      (au.x) "${self}" a.x; "${self}" rs 2 ;;
      (auxx!) "${self}" auxx; "${self}" oo! ;;

      (l) "${git}" log "$@" ;;
      (l1) "${self}" l -1 --pretty=%B ;;
      (lo) "${self}" l --oneline ;;
      (lp) "${self}" l --patch ;;
      (lp1) "${self}" lp -1 ;;
      (lpw) "${self}" lp --word-diff=color ;;

      (br) "${git}" branch "$@" ;;
      (bra) "${self}" br -a ;;
      (brm) "${self}" br -m "$@" ;;
      (brmh) "${self}" brm "$(git brh)" ;;
      (brd) "${self}" br -d "$@" ;;
      (brD) "${self}" br -D "$@" ;;
      (brh) "${git}" rev-parse --abbrev-ref HEAD ;;

      (d) "${git}" diff "$@" ;;
      (dc) "${git}" diff --cached "$@" ;;
      (dh) "${self}" d HEAD ;;
      (dhw) "${self}" d --word-diff=color ;;

      (re) "${git}" remote "$@" ;;
      (rea) "${self}" re add "$@" ;;
      (reao) "${self}" rea origin "$@" ;;
      (reau) "${self}" rea upstream "$@" ;;
      (rer) "${self}" re remove "$@" ;;
      (ren) "${self}" re rename "$@" ;;
      (rero) "${self}" rer origin "$@" ;;
      (reru) "${self}" rer upstream "$@" ;;
      (res) "${self}" re show "$@" ;;
      (reso) "${self}" res origin ;;
      (resu) "${self}" res upstream ;;

      (rl) "${git}" rev-list "$@" ;;
      (rla) "${self}" rl --all "$@" ;;
      (rl0) "${self}" rl --max-parents=0 HEAD ;;

      (cp) "${git}" cherry-pick "$@" ;;
      (cpc) "${self}" cp --continue "$@" ;;
      (cpa) "${self}" cp --abort "$@" ;;

      (fb) "${git}" filter-branch "$@" ;;
      (fb!) "${self}" fb -f "$@" ;;
      (fbm) "${self}" fb! --msg-filter "$@" ;;
      (fbi) "${self}" fb! --index-filter "$@" ;;
      (fbe) "${self}" fb! --env-filter "$@" ;;

      (rp) "${git}" rev-parse "$@" ;;
      (rph) "${self}" rp HEAD ;;

      (st) "${git}" stash "$@" ;;
      (stp) "${self}" st pop "$@" ;;

      (subt) "${git}" subtree "$@" ;;
      (subta) "${self}" subt add "$@" ;;
      (subtph) "${self}" subt push "$@" ;;
      (subtpl) "${self}" subt pull "$@" ;;

      (subm) "${git}" submodule "$@" ;;
      (subms) "${self}" subm status "$@" ;;
      (submy) "${self}" subm summary "$@" ;;
      (submu) "${self}" subm update "$@" ;;
      (subma) "${self}" subm add "$@" ;;
      (submi) "${self}" subm init "$@" ;;

      (ref) "${git}" reflog "$@" ;;

      (de) "${git}" describe "$@" ;;
      (det) "${self}" de --tags "$@" ;;

      (*) "${git}" "${op}" "$@" ;;
    esac
  fi
}
```

Mi devas mencii, ke se la funkcion supre ni jam havas en nia ŝela agordo kaj la
jenan alinomon ni havas en `~/.gitconfig`:

```
[alias]
  ls = "! echo hello world"
```

tiam la jenan komandon ni plenumos

    git ls

aperos la listoj de dosieroj mastrumitaj de git, anstataŭ la teksto
`hello world` sur la ekrano.


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Do, per tiu funkcio, mi povas labori per gito pli facile tial, ke mi nur
devas pensi pli la mallongigoj. Krome aliron al miaj aliaj ŝelaj komandoj mi
havas. Pro tio ke je [tmux](/eo/tmux/) mi uzas, kiam ajn giton mi bezonas uzi,
klavkombinon por la malfermado de alia tmux-fenestro sube mi nur devas
premi. Tie, tiujn gitkomandojn mi povas facile sen la ŝanĝon de ekranvido kiun
Magit bedaŭrinde faras. Min ĝi ebligas por pensi aparte inter la kodo kaj la
mastrumado de la kodo mem.
