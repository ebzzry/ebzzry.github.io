Agordi Skimprogramadon en Emakso
================================

<div class="center">Esperanto ▪ [English](/en/emacs-scheme/)</div>
<div class="center">la 13-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 3-an de Februaro 2022</div>

>Ĉiom da bonaj ideoj ne kuŝas sub unu ĉapelo.<br>
>―Dale TURNER

En ĉi tiu afiŝo, priparolos mi la plej facilan metodon, kiun uzis mi
agordi [skiman](https://eo.wikipedia.org/wiki/Skimo) programadan medion
emakse. Notu, ke ĉi tiu ne estas la sola aliro—traktis iuj ĝin en aserteble pli
bonaj manieroj. En ĉi tiu afiŝo, provos klarigi mi la malpli longan vojon, kiun
vojaĝigis mi.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Uzado](#uzado)
  + [Skima bufro](#skimbufro)
  + [LTPI-bufro](#ltpibufro)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo">Superrigardo</a>
---------------------------------------

Redakti skimkodon emakse estis tradicie farita per rudimentaj reĝimoj, kiuj malhavis flekson. Ili
estis kapablaj por taksi aktualajn difinojn, lastajn difinojn, kaj tutajn bufrojn, ĉefparte.
Bedaŭrinde, tio ne sufiĉis pri la maniero, en kiu traktadis skimo la aferojn. Pli inteligenta
maniero de trakti kodon estis bezonita.

Bonŝance, estas [Geiser](http://www.nongnu.org/geiser/). Estas aliaj reĝimoj, kiuj provis
fari, kiujn faras Geiser, tamen fariĝas mi pli bonfarta al tiuj, kiujn ofertis Geiser. Kelkaj
similaj bibliotekoj ankaŭ povas kunekzisti kun Geiser. Ankaŭ provis tiujn mi, bedaŭrinde, fariĝis
tro malsimplaj, por mi. Finvenis uzi mi nur je Geiser. Kaj kiel parte rilata noto, uzas mi emakson
por redakti skimkodon tial, ke ne konas mi ian ajn redaktilon kiu tiel bonfartas.


<a name="instalo"></a>Instalo
-----------------------------

Per [ELPA](https://www.emacswiki.org/emacs/ELPA), instali je Geiser facilas. Simple plenumi la jenan
komandon

    M-x package-install EN geiser EN

tiam post malmultajn sekundojn, havos oni je Geiser, instalita en via emaksa
profilo. Sekve, metos oni en la efektivan kodon, kiu envokas kaj agordas je
Geiser:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(mit))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

Ŝargas la unuesprimo je Geiser mem. Precizigas la duesprimo, ke ne invitos ĝi onin por la aliaj
realigoj, se trovas ĝi ilin. La lastesprimo malnepras—ebligas onin por plenumi

    M-x geiser-save EN

en la legada-taksada-presada iteracio (LTPI, angle
[REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)), por devigi la
konservadon de la historio al la diskdosiero, kiu troveblas en `~/.geiser_history.mit` implicite.
Estas utile se oni tuj volas konservi la LTPI-historion. Ne ekzistas pli teruran aferon ol perdi
TIUN esprimon. Por certigi, ke efektiviĝos ĉiomaj emaksaj kodoj supre, nun povas taksi oni ilin per
la membroj de la EVAL-trupo—`eval-defun`, `eval-last-sexp`, `eval-region`—aŭ ankoraŭ elektas oni
naski novan emaksan procezon.


<a name="uzado"></a>Uzado
-------------------------

Por rikolti tiujn, kiujn semis oni, kreu aŭ malfermu `.scm`-dosieron, kun malpleje ĝusta modula
deklaro. Tiam, premu:

    M-x run-geiser EN

Kaj, hura! Aperas nova emaksa fenestro, enhavante la `* MIT REPL *`-bufron. Kio ajn povas oni fari
per la LTPI—vokita per la vanila komandlinia `mit-scheme`-programo—ankaŭ povas oni fari tiujn, per
ĉi tiu kaj pli. Ĉi tiu ĉefreĝimo fakte estas la Comint-reĝimo sub la kovrilo, kun kroĉiloj al skima
procezo. Por tiuj, kiuj ne konas la Comint-reĝimon, ĝi estas la sama reĝimo kiu traktas `M-x
shell EN`.

Do, kion oni povas fari per tio? Dum redakti `.rkt`-dosieron, jen kelkaj kutimaj fulmoklavoj, kiujn
uzas mi. Haveblas la plena listo [ĉi tie](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet).
Notu, ke la priskribo de la klavoj, kiujn uzas mi malsupre, estas por mi mem komence, por helpi min
komprenas tion, kion faras ĝi. Eble ili malsimilas al la oficiala priskribo, listigita sur la
antaŭmenciita ligilo.


### <a name="skimbufro">Skima bufro</a>

| Klavo                         | Kion faras ĝi                                       |
| :---------------------------- | :-------------------------------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iru al la LTPI-bufro                                |
| <kbd>C-c</kbd> <kbd>C-a</kbd> | Taksu la aktualan bufron, tiam iru al la LTPI-bufro |
| <kbd>C-M-x</kbd>              | Taksu la aktualan esprimon                          |
| <kbd>C-x</kbd> <kbd>C-e</kbd> | Taksu la lastan esprimon                            |
| <kbd>C-c</kbd> <kbd>C-r</kbd> | Taksu regionon                                      |
| <kbd>C-c</kbd> <kbd>C-\</kbd> | Enmetu lambdsimbolon (λ)                            |


### <a name="ltpibufro"></a>LTPI-bufro

| Klavo                         | Kion faras ĝi                  |
| :---------------------------- | :----------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iru al la skima bufro          |
| <kbd>M-p</kbd>                | Montru la antaŭan historieron  |
| <kbd>M-n</kbd>                | Montru la sekvan historieron   |
| <kbd>C-c</kbd> <kbd>M-p</kbd> | Saltu al la antaŭinvito        |
| <kbd>C-c</kbd> <kbd>M-n</kbd> | Saltu al la sekvinvito         |
| <kbd>C-c</kbd> <kbd>C-q</kbd> | Eliru de la LTPI               |


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Laŭcele preterpasis mi multan temon de la [oficialdokumento](http://www.nongnu.org/geiser/) tial, ke
fariĝas ĝi malĉarma al multe da homo, kiuj malinklinas legi longajn blokojn da teksto. Ironie,
ĉi tiu artikolo povas kvalifi kiel tio. La priskribitaj metodoj supre ne reprezentiĝas de kial faras
la ĝenerala komunumo ilin. Do, ĝis!

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
