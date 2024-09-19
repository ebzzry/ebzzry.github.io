Mia Markdaŭna Stilgvidilo
=========================

<div class="center">Esperanto • [English](/en/markdown/)</div>
<div class="center">Laste ĝisdatigita: la 29-an de marto 2022</div>

>La reguloj kiuj direktas cirkonstancojn estas nuligitaj per novaj cirkonstancoj.<br>
>—Napoleono BONAPARTE

<img src="/images/site/luca-bravo-bTxMLuJOff4-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="luca-bravo-bTxMLuJOff4-unsplash" title="luca-bravo-bTxMLuJOff4-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Ĉapoj](#cxapoj)
  + [Nivelo 1-a](#nivelo1a)
  + [Nivelo 2-a](#nivelo2a)
  + [Malpli altaj niveloj](#malplialtaj)
- [Interlinia distanco](#distanco)
- [Kodblokoj](#kodblokoj)
- [Bullistoj](#bullistoj)
- [Ankroj](#ankroj)
- [Linia larĝo](#largxo)
- [Ekstraj](#ekstraj)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Skribi per markdaŭno plaĉas al mi. Ĝi estas legebla, plumpeza, kaj portebla. Ĝi estas platteksta do
oni ne plu bezonas specialajn apojn por legi kaj skribi kun ĝi. En ĉi tiu artikolo mi priparolos
miajn proprajn gvidnormojn pri kiel skribi markdaŭnajn dosierojn. Mi observas specifajn arojn de
reguloj por ke miaj dosierroj povu aspekti koheraj al unu la aliaj, kaj por ke emakso povu
formati ĝin bele.


<a name="cxapoj">Ĉapoj</a>
--------------------------


### <a name="nivelo1a">Nivelo 1-a</a>

Nivelaj 1-aj ĉapeloj idealas kiam uziĝas kiel dokumentaj titoloj. Ili devas esti uzataj nur unufoje
kaj ili devas esti en la unua linio de dosiero. Ĝi devas priskribi La celon de la dosiero. Mi uzas
la egalosignon (=) por indiki la 1-an nivelon anstataŭ la kradosigno (#). Uzante la egalosignon 
plifaciliĝas por vidi la ĉapon, kaj ĝi distingas ĝin kontraŭ la aliaj markiloj. Mi uzas ĝin tiel:

```markdown
Kiel Flugi Samkiel Omaro
========================
```

anstataŭ

```markdown
# Kiel Flugi Samkiel Omaro
```



### <a name="nivelo2a">Nivelo 2-a</a>

Nivelaj 2-aj ĉapeloj montras la suprajn partojn de dokumento. Ili estas la ĉefaj apartigiloj en
dosiero. Similas al la nivela 1-a ĉapelo, mi uzas la streketon (-) por marki la ĉapon. Mi uzas ĝin
tiel:

```markdown
Pretigi La Pinĉilojn 
--------------------
```

anstataŭ

```markdown
## Pretigi La Pinĉilojn
```


### <a name="malplialtaj">Malpli altaj niveloj</a>

Por nivelo 3-a kaj malpli altaj niveloj, mi uzas la kradon (#) kun la konvenaj nombroj de ripetoj
por indiki la nivelon.

Nivelo 3-a:

```markdown
### Bruligaĵo
```

Nivelo 4-a:

```markdown
#### Organa
```

Kaj tiel plu.


<a name="distanco">Interlinia distanco</a>
------------------------------------------

La spaco inter dokumentaj eroj devas esti akordaj por plifaciligi legeblecon. Post ĉapo, kreu
malplenan linion:

```markdown
Ja, ja, ja
==========

Teksto ĉi tie
```

Kreante novan linion, kreu du malplenajn liniojn antaŭ ĝi:

```markdown
Ja, ja, ja
==========

Teskto ĉi tie


Pretigi La Pinĉilojn 
--------------------

Ve
```

Alia bona kialo por havi malplenan spacon post ĉiu ĉapo estas por helpi redaktilojn kiel emakso
formati la tekston. La klavkombino <kbd>M-q</kbd> formatas teksblokon—defaŭlte bindita al
`fill-paragraph`—por ke la maksimuma linia larĝo estu ĝuste ruliĝita. La komando `fill-paragraph`
uzas la variablon `fill-column`—defaŭlte bindita al 70— por formati tekskorpon.

Do se la jenan tekston oni havas:

```markdown
Pretigi La Pinĉilojn 
--------------------

Ve ve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve ve
```

kaj oni premas <kbd>M-q</kbd> dum la punkto estas ie en la lasta linio, ĝi fariĝos:

```markdown
Pretigi La Pinĉilojn
--------------------

Ve ve ve veve ve veve ve veve ve veve ve veve ve veve ve
veve ve veve ve veve ve veve ve veve ve ve
```


<a name="kodblokoj">Kodblokoj</a>
---------------------------------

Kiam kodo aŭ komandbloko okupas du aŭ pli liniojn, krommarĝenigu ĝin per kvar spacetoj:

```bash
    VAR=blahblahblah
    function ve () { echo ve }
```


Se estas tri aŭ pli linioj, uzu parojn de tri maldekstraj kornoj (```) por limigi la komencon kaj
finon de la kodbloko:

    ˋˋˋbash
    $ mkdir hundo
    $ echo hundo > hundo/hundo
    $ rm -rf hundo
    $ date
    ˋˋˋ

<a name="bullistoj">Bullistoj</a>
---------------------------------

Kreante listojn, mi ofte uzas la streketon (-) por indiki la nivelon 1-an. Tiam, mi uzas la pluson
(+) por indiki la nivelon 2-an. Fine, por la nivelo 3-a kaj malpli altaj, mi uzas la steleton (*).

La streketo pli facilas por maŝinskribi sur klavaro ol la steleto. Oni ne estas devigita por uzi la
klavon <kbd>Shift</kbd> per kutimaj klavaroj. Kaj cetere, kontraste kun la steleto, la streketo
havas pli koheran signobildon inter malsamaj litertipoj.

Ekzemple:

```markdown
- Omaroj
  + pinĉiloj
  + torako
- Kraboj
  + pinĉiloj
    * laserpafilego
    * ĉensegilo
      * forprenebla
- Unikornuloj
```

<a name="ankroj">Ankroj</a>
---------------------------

Se la cela dokumenta formato de la markdaŭnaj dosieroj estas HTML, estas bona rutino por etikedi la
sekciojn ĝuste. Ekzemple, ĉi tiu sekcio estas skribita tiel:

```markdown
<a name="ankroj">Ankroj</a>
---------------------------

```


Ĉi tio plifaciligos la kreadon de la enhavotabelo poste tiel:

```markdown
Enhavotebelo
------------

- [Ankroj](#ankroj)
```

<a name="largxo">Linia larĝo</a>
--------------------------------

De longe, estis bona ideo por faldi la liniojn ĝis la 70 kolumnon. Nuntempe, pli alta limo—ebligita
per modernaj grafikaj sistemoj—estas pli dezirata por ke ni povu enpaki plian informon en unu linio:

70 signoj:

```
Ve ve ve veve ve veve ve veve ve veve ve veve ve
veve ve veve ve ve ve ve veve ve veve ve veve ve ve
```

100 signoj:

```
Ve ve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve ve ve ve
veve ve veve ve veve ve ve
```

Ĉi tiu gvidnormo, bedaŭrinde, eble ne aplikiĝas se oni uzas la redaktilojn de servoj kiel GitHub aŭ
GitLab, en kiu, estas pli oportune por permesi la grafikfasadon por faldi la tekston .


<a name="ekstraj">Ekstraj</a>
-----------------------------

Uzante emakson, mi uzas [ĉi tiujn](https://gist.github.com/ebzzry/1206a1922805a872713bdaf2e8c419f5)
komandojn, binditaj al <kbd>M-g =</kbd>, <kbd>M-g -</kbd>, kaj <kbd>M-g `</kbd>, respektive, por
plifaciligi la enmetadojn de la apartigiloj. Ekzemple, se oni havas la jenan tekston, en kiu, `^`
estas la punkto:

```markdown
Kio Estas Tie?

^
```

tiam se oni premas <kbd>M-g =</kbd>, ĝi fariĝos:

```markdown
Kio Estas Tie?
==============
              ^
```

La sama aplikeblas al nivelaj 2-aj ĉapoj. Do, se oni havas la jenan:

```markdown
Monstroj kaj anĝeloj

^
```

tiam se oni premas <kbd>M-g -</kbd>, ĝi fariĝos:

```markdown
Monstroj kaj anĝeloj
--------------------
                    ^
```

Se oni havas la jenan:

```markdown
Kodeto:


^
```

tiam se oni premas <kbd>M-g `</kbd>, ĝi fariĝos:

```markdown
Kodeto:

``````
   ^
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Observante ĉi tiujn simplajn gvidnormojn, mi kreas koherecon inter miaj markdaŭnaj dosieroj. Ĉi tiuj
gvidnormoj servas kiel miaj ŝablonoj kiam krei novajn dokumentojn aŭ modifi ekzistantan dosierojn.
Se oni havas proponojn aŭ kritikojn, sendu tirpetojn al mi!
