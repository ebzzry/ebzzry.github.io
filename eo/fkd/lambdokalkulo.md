Aboco de l’ Lambdokalkulo
=========================

<center>[Esperante](#) · [English](/en/lambda-calculus)</center>
<center>la 21-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 3-an de Marto 2018</center>

>Oni ne vere komprenas ion krom se oni povas klarigi tion al sia avino.<br>
>―Alberto EJNŜTEJNO

Ĉi tio estas mia provo por fari ja tion, tamen la avino ĉi tie estas mi mem. Mi firme kredas, ke mi
ne vere povas kompreni ion, krom se mi povas klarigi ĝin. Ĉi tiu afiŝo estas malstreĉa aliro por
fari tion, kaj evitas tre teĥnikajn temojn, krom se ege bezonatas.


Enhavotabelo
------------

- [Enkonduko](#enkonduko)
  + [Kio ĝi estas?](#kio)
  + [Ĉu oni devas lerni ĝin?](#lerni)
  + [Kion oni devas fari?](#fari)
- [Etaj paŝoj](#paŝoj)
  + [Funkcioj](#funkcioj)
  + [variabloj](#variabloj)
  + [Funkciapliko](#apliko)
- [Ni nombru](#nombri)
  + [Komenco](#komenco)
  + [Postanto](#postanto)
  + [Adicio](#adicio)
  + [Multipliko](#multipliko)
- [Vereco, malvereco, kaj amikoj](#vereco)
  + [Buleaj](#buleaj)
  + [Logikaj funkciadoj](#logikaj)
- [Ni nombru malantaŭen](#malantaŭen)
  + [Antaŭanto](#antaŭanto)
  + [Subtraho](#subtraho)
- [Finrimarkoj](#finrimarkoj)
- [Fontindikoj](#fontindikoj)


<a name="enkonduko"></a>Enkonduko
---------------------------------

### <a name="kio"></a>Kio ĝi estas?

La lambdokalkulo estas minimuma sistemo por esprimi komputadon kiu konformas al la universalaj
modeloj de komputado, de tie, fari ĝin universala modelo de komputado. Alidire ĝi povas esti nomita
kiel unu el la plej simplaj programlingvoj, tamen aspektas kaj alie kondutas el la unuj ni kutime
konas. La lambdokalkulo ankaŭ formiĝas kiel la bazo por la popolaj funkciaj programlingvoj kiuj nune
uzatas.


### <a name="lerni"></a>Ĉu oni devas lerni ĝin?

Jes kaj ne. Se ĉu oni volas kompreni la profundan meĥanismon kiel programaro funkcias, aŭ se oni
volas konstrui la sekvan bonegan programlingvon, aŭ oni simple volas aprezi la elegantecon de ĝia
arto, do jes. Tamen, se oni simple volas flugi aviadilon sen scii kiel ĝi funkcias, do ne. Serioze,
lernu ĝin.


### <a name="fari"></a>Kion oni devas fari?

Kiam diskuti novajn konceptojn, tre gravas por aranĝi la aksiomojn aŭ la komencajn regularojn. Pensu
ĝin kiel difini novajn terminojn en ludo, kaj doni al ili sencojn. La koncepto, en kiu, ĉi tiuj
sencoj vivas, tre gravas. Ekzemple, de l’ ĝardenisto la akvokondukilo uzatas por akvi la plantojn,
dum de l’ fajrobrigadisto, la akvokondukilo uzatas por mortigi la fajron. Kiam la ĝardenisto aŭ la
fajrobrigadisto tenas la akvokondukilon, ili ne dubas kion ili tenas aŭ kio estas la celumo. Ili simple
kredas en la fato de intuo, por precizigi la signifon de l’ akvokondukilo en la tempo ili tenis ĝin.

Esperante, la vorto _alta_ havas kelkajn signifojn. Tamen, en ĉiuj de l’ difinitaj signifoj de
l’ vorto, ne ekzistas apriora scio de l’ valoro de l’ vorto. Ni akceptas la difino tiel estas. Ni
devas konsenti al la uzado de l’ vorto en la limigita konteksto de l’ uzantoj de l’ vorto. Se ni
provas devii el la establiĝita signifo de l’ vorto, ekzemple, se ni hazarde krei novan difinon de l’
vorto pro kaprico, plej verŝajne ĝi ne estos akceptita. Ni bezonas kredi la difinitajn indikitajn
kaj montritajn signifojn de l’ vorto, por ke ĝi havas sencon al ni. La samo veras pri l’
lambdokalkulo—ni aŭ akcepti ĉi tiujn aksiomojn kaj operacii en sia domajno, aŭ ni vivu en
Neverland-o.


<a name="paŝoj"></a>Etaj paŝoj
------------------------------

### <a name="funkcioj"></a>Funkcioj

Kerna ludanto en la lambdokalkulo estas la nocio de funkcio. Plejmulto da ni kutimas pri funkcioj en
la al altnivelaj programlingvoj, tamen funkcioj en la lambdokalkulo iomete malsimilas—ili devas havi
plej minimume unu parametro. En plejmulto da produkta programlingvoj nune uzataj, oni povas alvoki
funkcion kiu ne prenas argumenton. Ili estas kutime por kromefikoj. Tamen, per lamdokalkulo, apenaŭa
minimuma de unu argumento estas devigita. Jen minimuna funkcio en la lambdokalkulo aspektas:

```scheme
λx.x
```

Ekvivalentas al:

```scheme
(λz.z)
(λc.c)
```

Ĉi tiu ekvivalenteco estas nomita la α-konverto. La nomoj ne gravas, tiel longe kiel ili estas
uzitaj konsekvence. Rondkrampoj povas esti uzataj por forigi plursensecon kiam apliki funkciojn. La
funkcio ĉi-supre ekvivalentas al:

```scheme
(λx.x)
```

La Greka litero `λ` montras, ke la ĉirkaŭa konteksto estas funkcio—aŭ iuk, kiu povas esti
aplikata. The `λ` simbolo uzatas anstataŭ alia simbolo pro l’ kompostada atentindaĵo kiu estas
diskutita [ĉi tie](https://goo.gl/vxMkW4). Do, ne maltrankviliĝu. Simple uzu ĝin.

Kion sekvas post la `λ` simbolo, antaŭ la `.`, estas la parametro. Teĥnike, povas esti ia
simbolo. Simple signifas la nomon, kiu povas esti uzita kiam apliki tiun funkcion, por referenci al
sia argumento.

La `.` simbolo ĉi tie, estas la apartigilo inter la parametra listo kaj la korpo de funkcio. En la
funkcio `(λx.x)`, la korpo simple estas la simbolo `x`.


### <a name="variabloj"></a>Variabloj

En la lambdokalkulo, la simboloj kiuj uzatas ene funkcio estas nomitaj variabloj. Reiri al la
difinita funkcio supre:

```scheme
(λx.x)
```

La parametro `x` estas variablo, kiu estas ligita, tial ke ĝi estas sandviĉiĝita inter `λ` kaj
`.`. Tamen, en la funkcio:

```scheme
(λx.xy)
```

La parametro `y` estas variablo kiu estas libera, tial ke, ĝi ne vivas inter `λ` kaj `.`.


### <a name="apliko"></a>Funkciapliko

Por uzi funkcion, oni devas apliki ĝin al io. La ligita variabloj estas anstataŭigitaj per tio, kio
estas ĝi estas aplikata al—procedo nomita kiel β-redukto.

Ekzemple:

```scheme
(λx.x)y
y
```

Ni disapartigu ĝin:

1. Apliki `(λx.x)` al `y`:
2. Konsumi la argumentojn, tiam anstataŭigi ĉiujn aperaĵojn de `x` en la korpo, per `y`.

“Atendu, ĝi nur revenas la argumenton y.” oni eble diras. Tio pravas. La funkcio `(λx.x)` estas la
identeca funkcio—estas unuopa-parametro funkcio kiu revenas kio ajn ĝi estas aplikita al.

Funkcioj ne estas ligimitaj esti aplikataj al simboloj. Ili ankaŭ povas esti aplikata ol aliaj
funkcioj.

```scheme
(λx.x)(λy.y)
(λy.y)
```

En la ekzemplo ĉi-supre, la identeca funkcio aplikatas ol identeca funkcio, reveni identecan
funkcion.

Jen alia apliko kun liberaj variabloj:

```scheme
(λa.ab)(λy.y)
(λy.y)b
b
```

La ligita variablo `a` estis anstataŭigita per `(λy.y)`, kiu estas tiam aplikata al la libera
variablo `b`, rezulti al `b`.

Tenu en la kalkulo, ke ĉi tiu funkciapliko:

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

Havi plurajn parametrajn nomojn estas steno de pluraj lambdoj, doni la malplilongigitan version la
efekto, ke ĝi konsumas plurajn argumentojn samtempe.

Ene la korpo da funkcio, kiam do simboloj estas tuŝanta al si reciproke, la unua simbolo estas
supozita funkcio esti aplikata al la dua simbolo, sen la rondkrampoj. Ekzemple, la jena kodaĵo:

```scheme
(λxy.xy)
```

Ekvivalentas al:

```scheme
(λxy.x(y))
```


<a name="nombri"></a>Ni nombru
------------------------------

### <a name="komenco"></a>Komenco

Pro preskaŭ ĉio en la lambdokalkulo estas esprimita kiel funkcioj, ĝia opinio pri nombroj
unikas. Asertebl, la plej grava nombro en la lambdokalkulo estas nul (0), kiu estas esprimita kiel:

```scheme
(λsz.z)
```

Por oportunecaj celoj, ni etikedu tiun esprimon kiel `0`, kun la simbolo `=` legita kiel
__“ekvivalentas al”__.

```scheme
0 ≡ (λsz.z)
```

Konstrui el `0`, ni nombru la unuaj tri nombradaj nombroj:

```scheme
1 ≡ (λsz.s(z))
2 ≡ (λsz.s(s(z)))
3 ≡ (λsz.s(s(s(z))))
```


### <a name="postanto"></a>Postanto

La postanto de entjero estas difinita kiel la sekva entjero, kalkuli supren. Do, la postanto de `0`
estas `1`. La difino de l’ postanta funkcio estas:

```scheme
S ≡ (λxyz.y(xyz))
```

Ni provu tion al `0`. En la ekzemploj malsupre, la `=` simbolo estas legita kiel
__“malpligrandiĝitas al”__:

```scheme
S0
≡ (λxyz.y(xyz))(λsz.z)
= (λyz.y((λsz.z)yz))
= (λyz.y((λz.z)z))
= (λyz.y(z))
≡ 1
```

Ni disapartigu ĝin:

1. Precizigi la postanton (S) de nulo (0).
2. Precizigi la ekvivalentan funkcian notadon.
3. Apliki `(λsz.z)` al `y` anstataŭigi la ligitan variablon `s` al `y`.
4. Apliki `(λz.z)` al `z` anstataŭigi la ligitan variablon `z` al `z`.
5. La taksado ĉesas kaj `(λyz.y(z))` liveritas, kiu estas la nombro 1.


### <a name="adicio"></a>Adicio

Kio se oni volas efektivigi `2+3`? Bonŝance, la postanta funkcio povas fari tion al oni. Oni esprimu
tion kiel `2S3`, en kiu, oni uzas `+` kiel la intermeta operatoro. La adicia funkcio difinitas kiel:

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

0. Eldiri la problemon.
1. Precizigi la ekvivalentan funkcian notadon de `2`, `S`, kaj `3`.
2. Malpligrandigi ĝin donas `SS3`
3. La plena versio de `SS3`, kiu kongruas al `2S3` aŭ du `S` kaj `3`.
4. Malpligrandigi plu.
5. Eĉ malpligrandigi plu.
6. Nun estas malpligrandiĝita al `S4`.
7. Apliki `S` al `4`.
8. Oni alvenas ĉe `5`.


### <a name="multipliko"></a>Multipliko

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

Multipliki du nombrojn en la lambdokalkulo estas tiel facila kaj simpla. Tamen, antaŭ daŭri al pli
aritmetikaj funkcioj, ni unue traktu verecajn valorojn kaj kondiĉaĵojn, kiuj estas antaŭkondiĉoj en
lerni la aliajn funkciojn.


<a name="vereco"></a>Vereco, malvereco, kaj amikoj
--------------------------------------------------

### <a name="buleaj"></a>Buleaj

La prezento de vreco kaj malvereco en la lambdokalkulo mallongas kaj elegantas:

```scheme
T ≡ (λxy.x)
F ≡ (λxy.y)
```

En agado:

```scheme
Tab ≡ (λxy.x)ab = a
Fab ≡ (λxy.y)ab = b
```


### <a name="logikaj"></a>Logikaj funkciadoj

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


<a name="malantaŭen"></a>Ni nombru malantŭen
--------------------------------------------

### <a name="antaŭanto"></a>Antaŭanto

La antaŭanto de nombro difinitas kie la antaŭa nombro precizigita kiam malantaŭen kalkuli. La motivo
kial la diskuto pri l’ antaŭanta funkcio faritas aparte estas, ke ne estas intue por lerni ĝin
komence, ka la scio pri l’ aliaj funckioj gravas por lerni ĝin.

Ni supozu, ke oni havas duon, io kiel (y, x), en kiu, la unua ero estas unu paŝo supre, aŭ la
postanto de l’ dua ero. Pro l’ unua ero estas la postanto, signifas ke la dua ero estas la
antaŭanto. Vide:

```scheme
(z+1, z) = (z, z-1)
```

Pro tio,

```scheme
x = Py iff y = Sx
```

Tio estas, `x` estas la antaŭanto de `y`, se kaj nur se, `y` estas la postanto de  `x`. Do, por
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
l’ dua ero:

```scheme
Nomo: Q
Profilo: (λpz.z(S(pT))(pT))
Enigoj: (a, b)
Eligoj: (S(a), b)
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


### <a name="subtraho"></a>Subtraho

Nu, nun ke vi havas sa antaŭantan funkcion, oni nun povas konstrui la subtrahan funkcion.

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


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Oni simple ungogratis la tegon de l’ lambdokalkulo, tamen oni ĵus spektis ĝia vastegan espriman
potencon, konsidere al kiel minimuna la sistemo difinitas.


<a name="fontindikoj"></a>Fontindikoj
-------------------------------------

- <http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf>
- <http://www.cse.chalmers.se/research/group/logic/TypesSS05/Extra/geuvers.pdf>
- <http://palmstroem.blogspot.com/2012/05/lambda-calculus-for-absolute-dummies.html>
- <http://www.users.waitrose.com/~hindley/SomePapers_PDFs/2006CarHin,HistlamRp.pdf>
