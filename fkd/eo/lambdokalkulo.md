Aboco de la Lambdokalkulo
=========================

<div class="center">Esperanto ■ [English](/en/lambda-calculus/)</div>
<div class="center">Laste ĝisdatigita: la 16-an de Marto 2022</div>

>Oni ne vere komprenas ion krom se oni povas klarigi ĝin al sia avino.<br>
>―Alberto EJNŜTEJNO

<img src="/bil/joel-filipe-Wc8k-KryEPM-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="joel-filipe-Wc8k-KryEPM-unsplash" title="joel-filipe-Wc8k-KryEPM-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
  + [Kio ĝi estas?](#kio)
  + [Ĉu oni devas lerni ĝin?](#lerni)
  + [Kion oni devas fari?](#fari)
- [Etaj paŝoj](#pasxoj)
  + [Funkcioj](#funkcioj)
  + [Variabloj](#variabloj)
  + [Funkciapliko](#apliko)
- [Ni nombru](#nombri)
  + [Komenco](#komenco)
  + [Postanto](#postanto)
  + [Adicio](#adicio)
  + [Multipliko](#multipliko)
- [Vereco, malvereco, kaj amikoj](#vereco)
  + [Buleaj valoroj](#buleaj)
  + [Logikaj funkciadoj](#logikaj)
- [Ni nombru malantaŭen](#malantauxen)
  + [Antaŭanto](#antauxanto)
  + [Subtraho](#subtraho)
- [Finrimarkoj](#finrimarkoj)
- [Fontindikoj](#fontindikoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Ĉi tiu estas mia provo por fari ja tion, tamen la avino ĉi tie estas mi mem. Mi firme kredas, ke mi
ne vere povas kompreni ion, krom se mi povas klarigi ĝin. Ĉi tiu afiŝo estas malstreĉa aliro por
fari tion, kaj evitas tre teĥnikajn temojn, krom se ili estas ege bezonitaj.


### <a name="kio">Kio ĝi estas?</a>

La lambdokalkulo estas minimuma sistemo por esprimi komputadon kiu konformas al la universalaj
modeloj de komputado, igi ĝin mem universala modelo de komputado. Alidire ĝi povas esti nomita kiel
unu el la plej simplaj programlingvoj, tamen ĝi aspektas kaj alie kondutas el la unuj, kiuj ni
kutime konas. La lambdokalkulo ankaŭ formiĝas kiel la bazo por la popolaj funkciaj programlingvoj
kiuj nune uziĝas.


### <a name="lerni">Ĉu oni devas lerni ĝin?</a>

Jes kaj ne. Se oni volas kompreni la profundan meĥanismon kiel programaro funkcias, aŭ se oni volas
konstrui la sekvan bonegan programlingvon, aŭ se oni simple volas aprezi la elegantecon de ĝia arto,
do jes. Tamen, se oni simple volas flugi aviadilon sen scii kiel ĝi funkcias, do ne.


### <a name="fari">Kion oni devas fari?</a>

Diskutante novajn konceptojn, tre gravas aranĝi la aksiomojn aŭ la komencajn regularojn. Pensu ĝin
kiel difini novajn terminojn en ludo, kaj doni al ili sencojn. La koncepto, en kiu, ĉi tiuj sencoj
vivas, estas gravaj. Ekzemple, laŭ la ĝardenisto, la akvokondukilo estas uzata por akvi la plantojn,
dum laŭ la fajrobrigadisto, la akvokondukilo estas uzata por mortigi la fajron. Kiam la ĝardenisto
aŭ la fajrobrigadisto tenas la akvokondukilon, ili ne dubas kion ili tenas aŭ kio estas la celumo.
Oni simple kredas en sia intuo, por precizigi la signifon de la akvokondukilo en la tempo, ke ili
tenis ĝin.

La vorto _alta_ havas plurajn signifojn. Tamen, en ĉiom da difinitaj signifoj de la vorto, ne
ekzistas apriora scio de la valoro de la vorto. Ni akceptas la difinon tiel estas. Ni devas konsenti
al la uzado de la vorto en la limigita kunteksto de la uzantoj de la vorto. Se ni provas devii el la
establiĝita signifo de la vorto, ekzemple, se ni hazarde kreas novan difinon de la vorto pro
kaprico, plej verŝajne ĝi ne estos akceptita. Ni bezonas kredi la difinitajn kaj montritajn
signifojn de la vorto, por ke ĝi havu sencon al ni. La sama veras pri la lambdokalkulo—ni aŭ akcepti
ĉi tiujn aksiomojn kaj operaciu en ĝia domajno, aŭ ni vivu en Neverlando.


<a name="pasxoj">Etaj paŝoj</a>
-------------------------------

### <a name="funkcioj">Funkcioj</a>

Kerna ludanto en la lambdokalkulo estas la nocio de funkcio. Plejmulto da ni konas funkciojn en
altnivelaj programlingvoj, tamen funkcioj en la lambdokalkulo iomete malsimilas—ili devas havi plej
minimume unu parametron. En plejparto de produktadaj programlingvoj nune uzataj, oni povas alvoki
funkcion kiu ne prenas argumenton. Tio okazas kutime por kromefikoj. Tamen, lamdokalkule, apenaŭa
minimumo de unu argumento estas devigita. Jen kiel minimuna funkcio en la lambdokalkulo aspektas. La
jena

```scheme
λx.x
```

estas ekvivalenta al

```scheme
(λz.z)
(λc.c)
```

Ĉi tiu ekvivalenteco nomiĝas la alfakonverto. La nomoj ne gravas, tiel longe kiel ili estas uzitaj
konsekvence. Rondkrampoj povas esti uzataj por forigi plursensecon aplikante funkciojn. La funkcio
ĉi-supre ekvivalentas al:

```scheme
(λx.x)
```

La Greka litero `λ` montras, ke la ĉirkaŭa kunteksto estas funkcio—aŭ iu, kiu povas esti
aplikata. The simbol `λ` estas uzata anstataŭ alia simbolo pro la kompostada atentindaĵo kiu estas
diskutita [ĉi tie](https://goo.gl/vxMkW4). Do, ne maltrankviliĝu. Oni simple povas uzi ĝin.

Kio sekvas post la simbolo `λ`, antaŭ la signo `.`, estas la parametro. Teĥnike, ĝi povas esti ia
simbolo. Tio simple signifas la nomon, kiu povas esti uzita aplikante tiun funkcion, por referenci
al ĝia argumento.

La simbolo `.`, ĉi tie, estas la apartigilo inter la parametra listo kaj la funkciokorpo. En la
funkcio `(λx.x)`, la korpo simple estas la simbolo `x`.


### <a name="variabloj">Variabloj</a>

En la lambdokalkulo, la simboloj kiuj estas uzataj ene funkcio nomiĝas variabloj. Reiri al la
difinita funkcio supre:

```scheme
(λx.x)
```

La parametro `x` estas variablo, kiu ligiĝas tial, ke ĝi estas sandviĉiĝita inter `λ` kaj
`.`. Tamen, en la funkcio:

```scheme
(λx.xy)
```

La parametro `y` estas variablo kiu liberas tial, ke ĝi ne vivas inter `λ` kaj `.`.


### <a name="apliko"></a>Funkciapliko

Por uzi funkcion, oni devas apliki ĝin al io. La ligitaj variabloj estas anstataŭigitaj per tiuj, kiuj
ili estas aplikitaj—procedo nomiĝas betaredukto.

Ekzemple:

```scheme
(λx.x)y
y
```

Ni disapartigu ĝin:

1. Apliki `(λx.x)` al `y`:
2. Konsumi la argumentojn, tiam anstataŭigi ĉiujn instancojn de `x` en la korpo, per `y`.

_«Atendu, ĝi nur revenas la argumenton y.»_ oni eble diras. Tio pravas. La funkcio `(λx.x)` estas la
identeca funkcio—unuopa-parametra funkcio kiu revenas kion ajn ĝi estas aplikita al.

Funkcioj ne estas limigitaj, por esti aplikataj al simboloj. Ili ankaŭ povas esti aplikataj al aliaj
funkcioj.

```scheme
(λx.x)(λy.y)
(λy.y)
```

En la ekzemplo ĉi-supre, la identeca funkcio estas aplikata al identeca funkcio, revenonte identecan
funkcion.

Jen alia apliko kun liberaj variabloj:

```scheme
(λa.ab)(λy.y)
(λy.y)b
b
```

La ligita variablo `a` estis anstataŭigita per `(λy.y)`, kiu estas do aplikata al la libera
variablo `b`, rezultante al `b`.

Memoru, ke la jena funkciapliko:

```scheme
(λx.(λy.y))ab
(λy.y)b
b
```

ekvivalentas al:

```scheme
(λxy.y)ab
b
```

Havi plurajn parametrajn nomojn estas steno de pluraj lambdoj, igante al la malplilongigita versio la
efekton, ke ĝi konsumas plurajn argumentojn samtempe.

Ene la korpo da funkcio, kiam du simboloj tuŝas al si reciproke, la unua simbolo estas supozita por
esti funkcio aplikata al la dua simbolo, sen la rondkrampoj. Ekzemple, la jena kodaĵo:

```scheme
(λxy.xy)
```

ekvivalentas al:

```scheme
(λxy.x(y))
```


<a name="nombri">Ni nombru</a>
------------------------------

### <a name="komenco"></a>Komenco

Pro tio ke preskaŭ ĉio en la lambdokalkulo esprimiĝas kiel funkcioj, ĝia opinio pri nombroj unikas.
Aserteble, la plej grava nombro en la lambdokalkulo estas la nulo—0. Jen la difino de `0`:

```scheme
(λsz.z)
```

Por oportunecaj celoj, ni etikedu tiun esprimon kiel `0`, kun la simbolo `=` legita kiel
_«ekvivalentas al.»_

```scheme
0 ≡ (λsz.z)
```

Konstrui el `0`, ni nombru la unuajn tri nombradaj nombroj:

```scheme
1 ≡ (λsz.s(z))
2 ≡ (λsz.s(s(z)))
3 ≡ (λsz.s(s(s(z))))
```


### <a name="postanto"></a>Postanto

La postanto de entjero estas difinita kiel la sekva entjero, kalkulante supren. Do, la postanto de `0`
estas `1`. Jen la difino de la postanta funkcio:

```scheme
S ≡ (λxyz.y(xyz))
```

Ni provu tiun per `0`. En la ekzemploj malsupre, la `=` simbolo estas legita kiel
_«malpligrandiĝas al»_:

```scheme
S0
≡ (λxyz.y(xyz))(λsz.z)
= (λyz.y((λsz.z)yz))
= (λyz.y((λz.z)z))
= (λyz.y(z))
≡ 1
```

Ni disapartigu ĝin:

1. Precizigi la postanton (S) de nulo (0);
2. Precizigi la ekvivalentan funkcian notadon;
3. Apliki `(λsz.z)` al `y` anstataŭigi la ligitan variablon `s` al `y`;
4. Apliki `(λz.z)` al `z` anstataŭigi la ligitan variablon `z` al `z`; kaj
5. La taksado ĉesas kaj liveriĝas `(λyz.y(z))` , kiu estas la nombro 1.


### <a name="adicio">Adicio</a>

Kio se oni volas efektivigi `2+3`? Bonŝance, la postanta funkcio povas fari tion. Oni esprimu tion
kiel `2S3`, en kiu, oni uzos `+` kiel la intermeta operatoro. Jen la difino de la adicia funkcio:

```scheme
Nomo: A
Profilo: S ≡ (λxyz.y(xyz))
Enigoj: x, y
Eligoj: c
Uzado: xAy
```

Ni elprovu tion:

```scheme
2+3 ≡ 2A3
≡ (λsz.s(sz))(λxyz.y(xyz))(λuv.u(u(uv)))
= SS3
≡ (λxyz.y(xyz))((λxyz.y(xyz))(λuv.u(u(uv))))
= (λxyz.y(xyz))(λyz.y((λuv.u(u(uv)))yz))
= (λxyz.y(xyz))(λyz.y(y(y(yz))))
≡ S4
= (λyz.y((λyz.y(y(y(yz))))yz))
= (λyz.y(y(y(y(yz)))))
≡ 5
```

Ni disapartigu ĝin:

0. Eldiri la problemon;
1. Precizigi la ekvivalentan funkcian notadon de `2`, `S`, kaj `3`;
2. Malpligrandigi ĝin donas `SS3`
3. La plena versio de `SS3`, kiu kongruas al `2S3` aŭ du `S` kaj `3`;
4. Malpligrandigi plu;
5. Eĉ malpligrandigi plu;
6. Nun malpligrandiĝitas al `S4`;
7. Apliki `S` al `4`; kaj
8. Oni alvenas ĉe `5`.


### <a name="multipliko">Multipliko</a>

La multiplika funkcio difinitas kiel:

```scheme
Nomo: M
Profilo: (λxyz.x(yz))
Enigoj: a, b
Eligoj: c
Uzado: Mab
```

Male al adicio, kiu uzas intermetan sintakson, multipliki du nombrojn sekvas antaŭmetan
operaciskribon. Do, por multipliki `2` kaj `3`, oni diras `M23`.

Ni elprovu tion:

```scheme
2*3 ≡ M23
≡ (λabc.a(bc))(λsz.s(sz))(λxy.x(x(xy)))
= (λc.(λsz.s(sz))((λxy.x(x(xy)))c)
= (λcz.((λxy.x(x(xy)))c)(((λxy.x(x(xy)))c)z))
= (λcz.(λy.c(c(cy))))(c(c(cz)))
= (λcz.c(c(c(c(c(cz))))))
≡ 6
```

Multipliki du nombrojn en la lambdokalkulo estas tiel facila kaj simpla. Tamen, antaŭ ol daŭri al
pli aritmetikaj funkcioj, ni unue traktu verecajn valorojn kaj kondiĉaĵojn, kiuj estas antaŭkondiĉoj
en lerni la aliajn funkciojn.


<a name="vereco">Vereco, malvereco, kaj amikoj</a>
--------------------------------------------------

### <a name="buleaj">Buleaj valoroj</a>

La prezentoj de vereco kaj malvereco en la lambdokalkulo mallongas kaj elegantas:

```scheme
T ≡ (λxy.x)
F ≡ (λxy.y)
```

En agado:

```scheme
Tab ≡ (λxy.x)ab = a
Fab ≡ (λxy.y)ab = b
```


### <a name="logikaj">Logikaj funkciadoj</a>

La tri abocaj operatoroj: KAJ, AŬ, kaj NE:

```scheme
∧ ≡ λxy.xy(λuv.v) ≡ λxy.xyF
∨ ≡ λxy.x(λuv.u)y ≡ λxy.xTy
¬ ≡ λx.x(λuv.v)(λab.a) ≡ λx.xFT
```

Ni kontrolu se `¬T` estas jam `F`:

```scheme
¬T
≡ λx.x(λuv.v)(λab.a)(λcd.c)
≡ TFT
≡ (λcd.c)(λuv.v)(λab.a)
= (λuv.v)
≡ F
```


<a name="malantauxen">Ni nombru malantŭen</a>
---------------------------------------------

### <a name="antauxanto">Antaŭanto</a>

La antaŭanto de nombro estas difinita kiel la antaŭa nombro precizigita kiam kalkuli malantaŭen. La
motivo kial la diskuto pri la antaŭanta funkcio estas farita aparte estas, ke ne estas intue por lerni
ĝin komence, kaj la scio pri la aliaj funckioj gravas lerni ĝin.

Ni supozu, ke oni havas duon, io kiel (y, x), en kiu, la unua ero estas unu paŝo supre, aŭ la
postanto de la dua ero. Pro tio ke la unua ero estas la postanto, tio signifas ke la dua ero estas
la antaŭanto. Vide:

```scheme
(z+1, z) = (z, z-1)
```

Pro tio:

```scheme
x = Py iff y = Sx
```

Tio signifas, ke `x` estas la antaŭanto de `y`, se kaj nur se, `y` estas la postanto de `x`. Do, por
precizigi la antaŭanton de nombro `x`, oni kreu duon kiel supre, tiam elektu la duan eron:

Ni difinu iujn bazajn unuojn. Duo aspektas kiel:

```scheme
(λz.zab)
```

Kaj la plej mallonga unuo de duo estas:

```scheme
(λz.z00) ≡ (λz.z(λsz.z)(λsz.z))
```

Por elekti la unuan kaj duan erojn de duo, oni uzas `T` kaj `F`:

```scheme
(λz.zab)(λxy.x) ≡ (λz.zab)T = Tab = a
(λz.zab)(λxy.y) ≡ (λz.zab)F = Fab = b
```

Oni bezonas funkcion kiu ricevas duon kaj kreas novan duon, en kiu, la unua ero estas la postanto de
la unua ero de la enigo kaj la dua ero estas la unua ero de la enigo:

```scheme
Nomo: Q
Profilo: (λpz.z(S(pT))(pT))
Enigoj: (a, b)
Eligoj: (S(a), a)
Uzado: Q(a,b)
```

Ni elprovu tion:

```scheme
Q(λz.z00)
≡ (λpz.z(S(pT))(pT))(λz.z00)
= (λpz.z(S(pT))(pT))(λz.z(λsz.z)(λsz.z))
= (λz.z(λsz.s(z)(λsz.z)))
≡ (λz.z10)
```

Aspektas prave. Oni nun povas konstrui la antaŭantan funkcion:

```scheme
Nomo: P
Profilo: (λn.nQ(λz.z00))F
Enigoj: N, en kiu, estas naturnombro
Eligoj: N-1
Uzado: PN
```

Ni elprovu tion:

```scheme
P1
≡ ((λn.nQ(λz.z00))F)1
≡ ((λn.nQ(λz.z00))F)(λsz.s(z))
= (1Q(λz.z00))F
= ((λsz.s(z)((λpz.z((S(pT))(pT)))(λz.z(λsz.z)(λsz.z)))))(λxy.y)
= (λz.((λpz.z((S(pT))(pT)))(λz.z(λsz.z)(λsz.z)))z)(λxy.y)
≡ (λu.((λpz.z((S(pT))(pT)))(λz.z(λsz.z)(λsz.z)))u)(λxy.y)
= ((λpz.z((S(pT))(pT)))(λz.z(λsz.z)(λsz.z)))(λxy.y)
= (λz.z((S((λz.z(λsz.z)(λsz.z))T)((λz.z(λsz.z)(λsz.z))T))))(λxy.y)
= (λz.z((S(λsz.z)(λsz.z))))(λxy.y)
= (λz.z((λsz.s(z)(λsz.z))))(λxy.y)
= (λxy.y)((λsz.s(z)(λsz.z)))
= (λsz.z)
≡ 0
```


### <a name="subtraho">Subtraho</a>

Nu, nun ke oni havas la antaŭantan funkcion, oni nun povas konstrui la subtrahan funkcion.

```scheme
B ≡ (λxy.yPx)
```

Ni elprovu tion:

```scheme
B11
≡ (λxy.yPx) (λsz.s(z)) (λsz.s(z))
= (λsz.s(z)) (P(λsz.s(z)))
= (λsz.s(z)) (λsz.z)
= (λz.(λsz.z)z)
= (λz.(λz.z))
≡ (λsz.z)
≡ 0
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Oni simple ungogratis la tegon de la lambdokalkulo, tamen oni ĵus spektis ĝian vastegan espriman
potencon, konsidere al kiel minimune la sistemo estas difinita.

_Dank’ al [Lucas LUGAO](https://github.com/lucaslugao) pro la korektoj._


<a name="fontindikoj">Fontindikoj</a>
-------------------------------------

- <http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf>
- <http://www.cse.chalmers.se/research/group/logic/TypesSS05/Extra/geuvers.pdf>
- <http://palmstroem.blogspot.com/2012/05/lambda-calculus-for-absolute-dummies.html>
- <https://goo.gl/ae1hjS>
