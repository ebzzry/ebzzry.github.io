Rakidprogramadon Agordi per Emakso
==================================

<div class="center">Esperanto · [English](/en/emacs-racket/)</div>
<div class="center">la 13-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 14-an de decembro 2018</div>

>Ĉiom da bonaj ideoj ne kuŝas sub unu ĉapelo.<br>
>―Dale TURNER

En ĉi tiu afiŝo, mi priparolos la plej facilan alproksimiĝon, kiun mi uzis agordi
[rakidan](https://racket-lang.org) programadan medion emakse. Notu, ke ĉi tiu ne estas la sola
aliro—iuj traktis ĝin en aserteble pli bonaj manieroj. En ĉi tiu afiŝo, mi provos klarigi la malpli
longan vojon, kiun mi vojaĝis.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Uzado](#uzado)
  + [Rakida bufro](#rakidbufro)
  + [LTPI-bufro](#ltpibufro)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Redakti rakidkodon emakse estis tradicie farita per rudimentaj reĝimoj, kiuj malhavis
flekson. Ili estis kapablaj por taksi aktualajn difinojn, lastajn difinojn, kaj tutajn bufrojn,
ĉefparte. Bedaŭrinde, tio ne sufiĉis pri la maniero, en kiu rakido traktadis la aferojn. Pli
inteligenta maniero de trakti kodon, estis bezonita.

Bonŝance, estas [Geiser](http://www.nongnu.org/geiser/). Estas aliaj reĝimoj, kiuj provis
fari, kiujn Geiser-o faras, tamen mi fariĝas pli bonfarta al tiuj, kiujn Geiser ofertis. Kelkaj
similaj bibliotekoj ankaŭ povas kunekzisti kun Geiser-o. Mi ankaŭ provis tiujn, bedaŭrinde, fariĝis
tro malsimplaj, por mi. Mi finvenis uzi nur Geiser-on. Kaj kiel parte rilata noto, mi uzas emakson
por redakti rakidkodon, tial ke, mi ne konas ian ajn redaktilon, kiu tiel bonfartas. Mi ne uzas
DrRacket-on krom mi bezonas uzi ĝian agrablan grafikfasadan sencimigilon.


<a name="instalo"></a>Instalo
-----------------------------

Per [ELPA](https://www.emacswiki.org/emacs/ELPA), instali Geiser-on facilas. Simple plenumi la jenan
komandon

    M-x package-install EN geiser EN

Tiam post malmultajn sekundojn, vi havos Geiser-on, instalita en via emaksa profilo. Sekve, vi metos en
la efektivan kodon, kiu envokas kaj agordas Geiser-on:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(racket))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

La unuesprimo ŝarĝas Geiser-on mem. La duesprimo precizigas, ke ne invitos onin por la aliaj
realigoj, se trovas ilin. La lastesprimo malnepras—ŝaltas onin por plenumi

    M-x geiser-save EN

en la legad-taksad-presada iteracio (LTPI, angle REPL), por devigi la konservadon de la historio al
la diskdosiero, kiu troveblas en `~/.geiser_history.racket` defaŭlte. Estas utila se vi tuj volas
konservi vian LTPI-historion. Ne ekzistas pli teruran aferon ol perdi TIUN esprimon. Por ĉiuj de
la emaksaj kodoj supraj, por efektiviĝi, vi nun povas taksi ilin per la membroj de la EVAL-trupo—`eval-defun`, `eval-last-sexp`, `eval-region`—aŭ, vi ankoraŭ elektas naski novan emaksan
procezon.


<a name="uzado"></a>Uzado
-------------------------

Por rikolti tiujn, kiujn vi semis, kreu aŭ malfermu `.rkt`-dosieron, kun malpleje ĝusta modula
deklaro. Tiam, premu:

    M-x run-geiser EN

Kaj, hura! Aperas nova emaksa fenestro, enhavi la `* Racket REPL *`-bufron. Kio ajn vi povas fari
per la LTPI-envokito per la vanila komandlinia `racket`, vi ankaŭ povas fari tiujn, per ĉi tiu, kaj
pli. Ĉi tiu ĉefreĝimo fakte estas la Comint-reĝimo sub la kovrilo, kun kroĉiloj al rakida
procezo. Por tiuj de vi, kiuj estas malkutimaj pri la Comint-reĝimo, estas la sama reĝimo kiu
traktas `M-x shell EN`.

Do, kion oni povas fari per tio? Dum redakti `.rkt`-dosieron, jen estas kelke de kutimaj
fulmoklavoj, kiujn mi uzas. La plena listo haveblas [ĉi tie](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet).
Notu, ke la priskribo de la klavoj, kiujn mi uzas malsupre, estas por mi mem komence, por
helpi min komprenas tion, kion ĝi faras. Eble ili malsimilas al la oficiala priskribo, listigita sur
la antaŭmenciita ligilo.


### <a name="rakidbufro"></a>Rakida bufro

| Klavo                         | Kion ĝi faras                                       |
| :---------------------------- | :-------------------------------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iru al la LTPI-bufro                                |
| <kbd>C-c</kbd> <kbd>C-a</kbd> | Taksu la aktualan bufron, tiam iru al la LTPI-bufro |
| <kbd>C-M-x</kbd>              | Taksu la aktualan esprimon                          |
| <kbd>C-x</kbd> <kbd>C-e</kbd> | Taksu la lastan esprimon                            |
| <kbd>C-c</kbd> <kbd>C-r</kbd> | Taksu regionon                                      |
| <kbd>C-c</kbd> <kbd>C-\</kbd> | Enmetu lambdsimbolon (λ)                            |


### <a name="ltpibufro"></a>LTPI-bufro

| Klavo                         | Kion ĝi faras                  |
| :---------------------------- | :----------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iru al la rakida bufro         |
| <kbd>M-p</kbd>                | Montru la antaŭan historieron  |
| <kbd>M-n</kbd>                | Montru la sekvan historieron   |
| <kbd>C-c</kbd> <kbd>M-p</kbd> | Saltu al la antaŭinvito        |
| <kbd>C-c</kbd> <kbd>M-n</kbd> | Saltu al la sekvinvito         |
| <kbd>C-c</kbd> <kbd>C-q</kbd> | Eliru de la LTPI               |


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Mi laŭcele preterpasis multe da temo de la [oficialdokumento](http://www.nongnu.org/geiser/), tial
ke, fariĝas malĉarma al multe da homo, kiuj malinklinas por legi longajn blokojn de
teksto. Ironie, ĉi tiu artikolo povas kvalifi kiel tiu. La priskribitaj metodoj supre ne
reprezentiĝas de konsilitaj manieroj, de la komunumo, de instali kaj uzi rakidon emakse. Do, ĝis!

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
