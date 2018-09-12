Signoj kaj Interpunkcioj
========================

<div class="center">[Esperante](#) · [English](/en/symbols-marks)</div>
<div class="center">la 16-an de julio 2018</div>
<div class="center">Laste ĝisdatigita: la 12-an de septembro 2018</div>

>Se grandiozon oni volas atingi, konsentojn ĉesu peti.<br>
>―Eddie COLLA

*[Ĉi tien](/eo/signoj-interpunkcioj-mallongigite) klaku por la mallongigita versio.*

Rondvojaĝo por kiel la ĝis-strekan (-), unuoblan citilan ('), kaj duoblan citilan (") signojn uzi
sur la klavaro, kiuj estas pli bone adaptitaj por signajn devojn fari ol siaj malsanaj kuzoj el la
skribmaŝina epoĥo, ĉi tiu mallonga gvidilo donas. Kaj cetere, mi ankaŭ parolos pri la anstataŭigoj
al ofte uzataj malĝustaj signoj.

Ĉiu sekcio komencas pri eniga sinsekvo por Linuksa, Makintoŝa, kaj Vindoza sistemoj, respektive. La
plusa (+) signo signifas, ke la maldekstran klavon oni premas, antaŭ la dekstran klavon. Tio estas,
por je <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd> enigi, je <kbd>⌥</kbd> premu kaj tenu, tiam je
<kbd>Shift</kbd> premu kaj tenu, tiam je <kbd>-</kbd> premu.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Linuksaj notoj](#linukso)
- [Streketoj](#streketoj)
- [Ĝis-strekoj](#gxisstrekoj)
- [Haltostrekoj](#haltostrekoj)
- [Duoblaj citiloj](#duoblajcitiloj)
- [Unuoblaj citiloj](#unuoblajcitiloj)
- [Primaj signoj](#primajsignoj)
- [Tripunkto](#tripunkto)
- [Finrimarkoj](#finrimarkoj)


<a name="linukso"></a>Linuksaj notoj
------------------------------------

Jam estas metodo por signojn enmeti linukse. Estas la uzo de la <kbd>Compose</kbd>
klavo. Bedaŭrinde, ĉi tiun metodon ni ne uzas ĉar ĝi estas neekonomia. Anstataŭ la
<kbd>Mode‎ߺ‎switch</kbd> klavon ni uzu. En ĉi tiu artikolo la <kbd>Mode‎ߺ‎switch</kbd> klavon la
<kbd>🐧</kbd> klavo signifas.

Ĝin ni devas bindi en la ĝusta agorda dosiero. La dosieron `~/.Xmodmap` malfermu, tiam jenan
kodeton enmetu:

```
!! prema klavo
keycode 107 = Mode‎ߺ‎switch

!! maldekstra vindozklavo
keycode 133 = Mode‎ߺ‎switch

!! dekstra vindozklavo
keycode 134 = Mode‎ߺ‎switch

!! menua klavo
keycode 135 = Mode‎ߺ‎switch

!! interpunkcioj
keycode 48 = minus underscore endash emdash
keycode 49 = grave asciitilde leftsinglequotemark
keycode 24 = apostrophe quotedbl rightsinglequotemark
keycode 25 = comma less minutes seconds
keycode 26 = period greater ellipsis
keycode 20 = bracketleft braceleft leftdoublequotemark
keycode 21 = bracketright braceright rightdoublequotemark
```

Tiam, la jenan komandon kuru:

    xmodmap ~/.Xmodmap


<a name="streketoj"></a>Streketoj (-)
-------------------------------------

- Linukse: <kbd>-</kbd>
- Makintoŝe: <kbd>-</kbd>
- Vindoze: <kbd>-</kbd>

La streketoj uzatas por la distributan sencon, kaj kunmetitajn vortojn montri. Ekzemple, se oni
volas esprimi:

- sunleviĝo kaj sunsubiro
- h-sistemo kaj x-sistemo

Oni ankaŭ povas esprimi:

- sunleviĝo kaj -subiro
- h- kaj x-sistemo

Se oni volas esprimi:

- unua paŝo

Oni ankaŭ povas esprimi:

- 1-a paŝo

Se oni volas esprimi:

- 500-a aĝa urbeto

Oni ankaŭ povas esprimi:

- kvincent-jar-aĝa urbeto

Se la kunmeton de vortoj oni volas esprimi:

- «ĝis» kaj «strekoj»

Oni esprimas:

- ĝis-strekoj

La streketoj ankaŭ uzatas por vortojn mallongigi. Ekzemple:

- samideano iĝas s-ano
- fraŭlino iĝas f-ino
- doktoro iĝas d-ro

Laste, la streketoj uzatas por neesperantigitajn vortojn esprimi. Ekzemple:

- PDF-dosieroj
- HTML-risurcoj
- LiveJournal-uzantnomo


<a name="gxisstrekoj"></a>Ĝis-strekoj (–)
-----------------------------------------

- Linukse: <kbd>🐧</kbd> + <kbd>-</kbd>
- Makintose: <kbd>⌥</kbd> + <kbd>-</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>5</kbd> <kbd>0</kbd>

La ĝis-streko uzatas por ampleksojn de valoroj esprimi. Spacetojn ne metu ĉirkaŭ ili. Ekzemple,
se oni volas esprimi:

- 1960 ĝis 2016

Oni esprimas:

- 1960–2016

Alia uzo de ĝis-strekoj estas por la parencecojn aŭ kostrastojn inter vortoj esprimi:

- Patrina–filina parenceco

- Sudkoreia–Ĉina vojaĝo

Se monatojn oni volas esprimi:

- Januaro ĝis Marto

Oni esprimas:

- Januaro–Marto

Tamen, se aliajn formojn de ampleksoj oni volas esprimi la konduto iomete ŝanĝiĝas. Se la esprimataj
datoj estas de malsamaj monatoj, la jenan uzu:

- Ŝi marŝis la 1-an de Januaro – la 15-an de Februaro 1800

Kiam la monatoj samas, la ĝis-strekojn sen spacetoj uzu:

- La 14–15-ajn de Marto 1900


<a name="haltostrekoj"></a>Haltostrekoj (—)
-------------------------------------------

- Linukse: <kbd>🐧</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>5</kbd> <kbd>1</kbd>

La haltostrekoj povas esti uzataj en multaj manieroj. Samkiel ĝis-strekoj, spacetojn ne enmetu
ĉirkaŭ ili. Se ĝin oni volas esprimi kiel dupunkto:

- Mortis du viroj: Petro kaj Miĥaelo
- Mortis du viroj—Petro kaj Miĥaelo

Por ĝin uzi kiel inversa dupunkto:

- Ĉi tiuj estas ĝiaj kvalitoj: malmola, ŝlima, pika.
- Malmola, ŝlima, pika—ĉi tiuj estas ĝiaj kvalitoj.

Por ĝin uzi kiel rondaj krampoj:

- Du viroj (Petro kaj Miĥaelo) mortis.
- Du viroj—Petro kaj Miĥaelo—mortis.

Por la maldaŭrigon de la parolanto esprimi:

- Mi opinias, ke mi iras kaj—diable, ne.


<a name="duoblajcitiloj"></a>Duoblaj citiloj (“) (”)
----------------------------------------------------

Maldekstra duobla citilo (“)

- Linukse: <kbd>🐧</kbd> + <kbd>[</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>[</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>7</kbd>

Dekstra duobla citilo (”)

- Linukse: <kbd>🐧</kbd> + <kbd>]</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>[</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>8</kbd>

Duoblaj citiloj uzatas por vortojn montri kiuj estas parolataj de parolanto.

- Ŝi venis al mi kaj diris, “Ĉu ni povas precizigi ĝian iĝeblecon?”

Ili ankaŭ uzatas kiam citaĵojn (atribuadojn) skribi:

- “Rompu, rompu la murojn inter la popoloj!”—Ludoviko Lazaro ZAMENHOF

Alia fama uzo de duoblaj citiloj estas kiam ili estas uzatj kiel ĉikanaj citiloj—uzataj por ironion
indiki kaj aliajn mallaŭnormajn signifoj:

- La “sekura” aparato poves esti rekte legita.

Laste, ili uzatas por parton da tuto mencii:

- “Return of the Jedi” estas filmo en la Star Wars sagao, plenitaj de beletaj pluŝursetoj.

Por plifaciliĝi al kiel ili aperas, ilin pensu kiel flosantaj paroj de sesoj kaj naŭoj:

- ⁶⁶Citita Teksto⁹⁹


<a name="unuoblajcitiloj"></a>Unuoblaj citiloj (‘) (’)
----------------------------------------------------

Maldekstra unuobla citilo (‘)

- Linukse: <kbd>🐧</kbd> + <kbd>`</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>]</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>5</kbd>

Dekstra unuobla citilo (’)

- Linukse: <kbd>🐧</kbd> + <kbd>'</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>]</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>6</kbd>

Unuoblaj citiloj uzatas kiam parolo estas enkorpigita ene alia parolo:

- Li murmuris al si mem, “Mi opinias, ke li diris ‘Ne fareblas’ kiam ni interparolis hieraŭ.”

Multe da uzo la desktra unuobla citilo aŭ pli ofte konata kiel apostrofo en la esperantujo, havas.

La o-finaĝon substantivoj povas ellasi:

- vespero
- vesper’

Se la vorto «la» estas antaŭita de la vortoj «de», «ĉe», «je», «tra», «pri», aŭ «pro»; la «a»
litero povas esti ellasita:

- de l’
- ĉe l’
- je l’
- tra l’
- pri l’
- pro l’

En la vorto «danko» la «o» litero ankaŭ povas esti ellasita en la jena kunteksto:

- Dank’ al Rejmundo.

Kiam ritmojn kaj taktojn oni kalkulas, la litero «u» en «unu» povas esti ellasita:

- Un’, du, tri, …


<a name="primajsignoj"></a>Primaj signoj (′) (″)
------------------------------------------------

Primo (′)

- Linukse: <kbd>🐧</kbd> + <kbd>,</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>2</kbd> <kbd>0</kbd> <kbd>3</kbd> <kbd>2</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>8</kbd> <kbd>2</kbd> <kbd>4</kbd> <kbd>2</kbd>

Duobla primo (″)

- Linukse: <kbd>🐧</kbd> + <kbd>Shift</kbd> + <kbd>,</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>2</kbd> <kbd>0</kbd> <kbd>3</kbd> <kbd>3</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>8</kbd> <kbd>2</kbd> <kbd>4</kbd> <kbd>3</kbd>

La citiloj signoj sur la klavaro (') kaj (") aspektas kiel primaj signoj, bedaŭrinde, ili ne
estas. Ili estas fuŝaj postsignoj de la skribmaŝina epoĥo. La ĝustaj signobildoj estas (′) kaj
(″). La prima signo (′) uzatas por futojn, minutojn, kaj minutojn de arko esprimi, dum la duobla
prima signo (″) uzatas por colojn, sekundojn, kaj sekundojn de arko esprimi.

Por alton de ses funtoj kaj du colojn esprimi, oni skribas:

- 6′2″

Por kvin gradojn, kvar minutojn de arko, kaj tri sekundojn de arko esprimi, oni skribas:

- 5°4′3″

La duoblaj primaj signoj povas esti uzataj kiel la idema marko. La idema marko uzatas por
indiki, ke la vortoj ĉi-supre devas esti ripetitaj. Ekzemple:

- Ruĝaj ardeoj, gruoj, kaj mantoj.
- Bluaj  ″            ″         ″    ″


<a name="tripunkto"></a>Tripunkto (…)
-------------------------------------

- Linukse: <kbd>🐧</kbd> + <kbd>.</kbd>
- Makintoŝe: <kbd>⌥</kbd> + <kbd>;</kbd>
- Vindoze: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>3</kbd> <kbd>3</kbd>

La tripunkto uzatas por la forlason de vorto, frazero, frazo, aŭ tuta bloko de teksto
montri, kiel parto de pli granda teksto. Ĝi estas unu el la plej miskomprenitaj signoj. Mi ofte
rimarkas, ke la tri punktoj—plenaj ĉesoj—uzitas anstataŭ la ĝusta tripunkta signo. En epoĥo,
en kiu, la skribmaŝino estis la plej bona maniero por tekston komposti, la tri punktoj funkciis. Tiutempe, tamen, jam longe pasis; la haveblajn ilojn oni nun devas uzi.

Ekzemple, ĝi povas uzita jene:

- Tiam, ŝi diris al si mem …

Kiam uzitis kiel la komenco de frazo, kortuŝojn kaj dramojn ĝi enkondukas:

- … Mia amo, kie vi estas?

Kiam ĝi uzitas en la fino de bloko, spaceton antaŭ ol ĝi metu; kiam ĝi uzitas en la komenco,
spaceton post kiam ĝi metu; kiam ĝi uzitas en la mezo, spacetojn ĉirkaŭ metu.


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

La ĝustajn signojn kaj interpunkciojn uzante, la linion inter fajneco kaj malfajneco skribitas. Kiam
la ĝustajn interpunkciojn oni uzas, oni komunikas al la legantoj, ke oni zorgas pri la sintaksa
ĝusteco tiom multe kiel enhava valoro.
