Mia Markdown-Stila Gvidilo
==========================

<div class="center">Esperanto ◆ [English](/en/markdown/)</div>
<div class="center">Laste ĝisdatigita: la 31-an de Aŭgusto 2021</div>

>La reglamentoj kiuj direktas cirkonstancojn nuliĝis per novaj cirkonstancoj.<br>
>―Napoleono BONAPARTE

Skribi per Markdown plaĉas al mi. Ĝi estas legebla, plumpeza, kaj portebla. Ĝi estas platteksta do
specialajn apojn oni ne plu bezonas por legi kaj skribi kun ĝi. En ĉi tiu artikolo miajn proprajn
gvidnormojn pri kiel Markdown-dosierojn skribi mi priparolos. Specifajn arojn de reguloj mi observas
por ke miaj dosierroj povu aspekti koheraj kun unu la aliaj, kaj por ke ĝin emakso povu formati
bele.


<a name="et"></a>Enhavotabelo
-----------------------------

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


<a name="cxapoj"></a>Ĉapoj
--------------------------


### <a name="nivelo1a"></a>Nivelo 1-a

Nivelaj 1-aj ĉapeloj idealas kiam uzitas kiel dokumentaj titoloj. Ili devas esti uzataj nur unufoje
kaj ili devas esti en la unua linio de dosiero. La celon de la dosiero ĝi devas priskribi. La
egalosignon (=) mi uzas por la 1-an nivelon indiki anstataŭ la kradosigno (#). La egalosignon uzante
plifaciliĝas por la ĉapon vidi, kaj ĝin ĝi distingas kontraŭ la aliaj markiloj. Ĝin mi uzas tiel:

```markdown
Kiel Flugi Samkiel Omaro
========================
```

anstataŭ

```markdown
# Kiel Flugi Samkiel Omaro
```



### <a name="nivelo2a"></a>Nivelo 2-a

La supraj partoj de dokumento nivelaj 2-aj ĉapeloj montras. Ili estas la ĉefaj apartigiloj en
dosiero. Similas al la nivela 1-a ĉapelo, la streketon (-) mi uzas por la ĉapon marki. Ĝin mi uzas
tiel:

```markdown
La Pinĉilojn Pretigi
--------------------
```

anstataŭ

```markdown
## La Pinĉilojn Pretigi
```


### <a name="malplialtaj"></a>Malpli altaj niveloj

Por nivelo 3-a kaj malpli altaj niveloj, la kradon (#) mi uzas kun la konvenaj nombroj de ripetoj
por la nivelon indiki.

Nivelo 3-a:

```markdown
### Bruligaĵo
```

Nivelo 4-a:

```markdown
#### Organa
```

Kaj tiel plu.


<a name="distanco"></a>Interlinia distanco
------------------------------------------

La spaco inter dokumentaj eroj devas esti akordaj por legeblecon plifaciligi. Post ĉapo, malplenan
linion kreu:

```markdown
Ja, ja, ja
==========

Teksto ĉi tie
```

Novan linion kreante, du malplenajn liniojn antaŭ ĝi kreu:

```markdown
Ja, ja, ja
==========

Teskto ĉi tie


La Pinĉilojn Pretigi
--------------------

Ve
```

Alia bona kialo por malplenan spacon havi post ĉiu ĉapo estas por helpi al redaktiloj kiel emakso
por la tekston formati. Teksblokon la klavkombino <kbd>M-q</kbd> formatas—defaŭlte bindita al
`fill-paragraph`—por ke la maksimuma linia larĝo estu ĝuste plenumiĝita. La variablon
`fill-column`—defaŭlte bindita al 70—la komando `fill-paragraph` uzas por tekskorpon formati.

Do se la jenan tekston oni havas:

```markdown
La Pinĉilojn Pretigi
--------------------

Ve ve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve veve ve ve
```

kaj je <kbd>M-q</kbd> oni premas dum la punkto estas ie en la lasta linio, ĝi fariĝos:

```markdown
La Pinĉilojn Pretigi
--------------------

Ve ve ve veve ve veve ve veve ve veve ve veve ve veve ve
veve ve veve ve veve ve veve ve veve ve ve
```


<a name="kodblokoj"></a>Kodblokoj
---------------------------------

Kiam du aŭ pli liniojn kodo aŭ komandbloko okupas, ĝin krommarĝenigu per kvar spacetoj:

```bash
    VAR=blahblahblah
    function ve () { echo ve }
```


Se estas tri aŭ pli linioj, paroj de tri maldekstraj kornoj (```) uzu por la komencon kaj finon de
la kodbloko limigi:

    ˋˋˋbash
    $ mkdir hundo
    $ echo hundo > hundo/hundo
    $ rm -rf hundo
    $ date
    ˋˋˋ

<a name="bullistoj"></a>Bullistoj
---------------------------------

Listojn kreante, la streketon (-) mi ofte uzas por la nivelon 1-an indiki. Tiam, la pluson (+) mi
uzas por la nivelon 2-an indiki. Fine, por la nivelo 3-a kaj malpli altaj, la steleton (*) mi uzas.

La streketo pli facilas por maŝinskribi sur klavaro ol la steleto. Oni ne estas devigita por la
<kbd>Shift</kbd> klavon uzi sur kutimaj klavaroj. Kaj cetere, kontraste kun la steleto, pli koheran
signobildon la streketo havas inter malsamaj litertipoj.

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

<a name="ankroj"></a>Ankroj
---------------------------

Se la cela dokumenta formato de la Markdown-dosieroj estas HTML, estas bona rutino por la sekciojn
etikedi ĝuste. Ekzemple, ĉi tiu sekcio estas skribita tiel:

```markdown
<a name="ankroj"></a>Ankroj
---------------------------

```


La kreadon de la enhavotabelo ĉi tio plifaciligos poste tiel:

```markdown
Enhavotebelo
------------

- [Ankroj](#ankroj)
```

<a name="largxo"></a>Linia larĝo
--------------------------------

De longe, estis bona ideo por la liniojn faldi ĝis la 70 kolumnon. Nuntempe, pli alta limo—ebligita
per modernaj grafikaj sistemoj—estas pli dezirata por ke plian informon ni povu enpaki en unu linio:

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

Ĉi tiu gvidnormo, bedaŭrinde, eble ne aplikiĝas se la redaktilojn de servoj kiel GitHub aŭ GitLab
oni uzas, en kiu, estas pli oportune por la grafikfasadon permesi por la tekston faldi.


<a name="ekstraj"></a>Ekstraj
-----------------------------

Emakson uzante, [ĉi tiujn](https://gist.github.com/ebzzry/1206a1922805a872713bdaf2e8c419f5)
komandojn mi uzas, binditaj al <kbd>M-g =</kbd>, <kbd>M-g -</kbd>, kaj <kbd>M-g `</kbd>, respektive,
por la enmetadojn de la apartigiloj plifaciligi. Ekzemple, se la jenan tekston oni havas, en kiu,
`^` estas la punkto:

```markdown
Kio Estas Tie?

^
```

tiam se je <kbd>M-g =</kbd> oni premas, ĝi fariĝos:

```markdown
Kio Estas Tie?
==============
              ^
```

La sama aplikas al nivelaj 2-aj ĉapoj. Do se la jenan oni havas:

```markdown
Monstroj kaj anĝeloj

^
```

tiam se je <kbd>M-g -</kbd> oni premas, ĝi fariĝos:

```markdown
Monstroj kaj anĝeloj
--------------------
                    ^
```

Se la jenan oni havas:

```markdown
Kodeto:


^
```

tiam se je <kbd>M-g `</kbd> oni premas, ĝi fariĝos:

```markdown
Kodeto:

``````
   ^
```


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Per ĉi tiujn simplajn gvidnormojn observante, koherecon inter miaj Markdown-dosieroj mi kreas. Ĉi
tiuj gvidnormoj servas kiel miaj ŝablonoj kiam novajn dokumentojn krei aŭ ekzistantan dosierojn
modifi. Se proponojn aŭ kritikojn oni havas, la tirpetojn sendu al mi!
