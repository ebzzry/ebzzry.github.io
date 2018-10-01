Rakidprogramadon Agordi per Emakso
==================================

<div class="center">Esperanto · [English](/en/emacs-racket/)</div>
<div class="center">la 13-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 28-an de septembro 2018</div>

>Ĉiom da bonaj ideoj ne kuŝas sub unu ĉapelo.<br>
>―Dale TURNER

En ĉi tiu afiŝo, mi priparolos la plej facilan alproksimiĝon, kiun mi uzis agordi
[Rakidan](https://racket-lang.org) programadan medion Emakse. Notu, ke ĉi tiu ne estas la sola
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

Redakti Rakidkodon Emakse estis tradicie farita per rudimentaj reĝimoj, kiuj malhavis
flekson. Ili estis kapablaj por taksi aktualajn difinojn, lastajn difinojn, kaj tutajn bufrojn,
ĉefparte. Bedaŭrinde, tio ne sufiĉis pri la maniero, en kiu Rakido traktadis la aferojn. Pli
inteligenta maniero de trakti kodon, estis bezonita.

Bonŝance, estas [Geiser](http://www.nongnu.org/geiser/). Estas aliaj reĝimoj, kiuj provis
fari, kiujn Geiser-o faras, tamen mi fariĝas pli bonfarta al tiuj, kiujn Geiser ofertis. Kelkaj
similaj bibliotekoj ankaŭ povas kunekzisti kun Geiser-o. Mi ankaŭ provis tiujn, bedaŭrinde, fariĝis
tro malsimplaj, por mi. Mi finvenis uzi nur Geiser-on. Kaj kiel parte rilata noto, mi uzas Emakson
por redakti Rakidkodon, tial ke, mi ne konas ian ajn redaktilon, kiu tiel bonfartas. Mi ne uzas
DrRacket-on krom mi bezonas uzi ĝian agrablan grafikfasadan sencimigilon.


<a name="instalo"></a>Instalo
-----------------------------

Per [ELPA](https://www.emacswiki.org/emacs/ELPA), instali Geiser-on facilas. Simple plenumi la jenan
komandon

    M-x package-install EN geiser EN

Tiam post malmultajn sekundojn, vi havos Geiser-on, instalita en via Emaksa profilo. Sekve, vi metos en
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
la Emaksaj kodoj supraj, por efektiviĝi, vi nun povas taksi ilin per la membroj de la EVAL-trupo—`eval-defun`, `eval-last-sexp`, `eval-region`—aŭ, vi ankoraŭ elektas naski novan Emaksan
procezon.


<a name="uzado"></a>Uzado
-------------------------

Por rikolti tiujn, kiujn vi semis, kreu aŭ malfermu `.rkt`-dosieron, kun malpleje ĝusta modula
deklaro. Tiam, premu:

    M-x run-geiser EN

Kaj, hura! Aperas nova Emaksa fenestro, enhavi la `* Racket REPL *`-bufron. Kio ajn vi povas fari
per la LTPI-envokito per la vanila komandlinia `racket`, vi ankaŭ povas fari tiujn, per ĉi tiu, kaj
pli. Ĉi tiu ĉefreĝimo fakte estas la Comint-reĝimo sub la kovrilo, kun kroĉiloj al Rakida
procezo. Por tiuj de vi, kiuj estas malkutimaj pri la Comint-reĝimo, estas la sama reĝimo kiu
traktas `M-x shell EN`.

Do, kion oni povas fari per tio? Dum redakti `.rkt`-dosieron, jen estas kelke de kutimaj
fulmoklavoj, kiujn mi uzas. La plena listo haveblas [ĉi tie](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet).
Notu, ke la priskribo de la klavoj, kiujn mi uzas malsupre, estas por mi mem komence, por
helpi min komprenas tion, kion ĝi faras. Eble ili malsimilas al la oficiala priskribo, listigita sur
la antaŭmenciita ligilo.


### <a name="rakidbufro"></a>Rakida bufro

| Klavo   | Kion ĝi faras                                 |
| :------ | :-------------------------------------------- |
| C-c C-z | Iru al la LTPI-bufro                          |
| C-c C-a | Taksu la nunbufron, tiam iru al la LTPI-bufro |
| C-M-x   | Taksu la nunesprimon                          |
| C-x C-e | Taksu la lastesprimon                         |
| C-c C-r | Taksu regionon                                |
| C-c C-\ | Enmetu lambdsimbolon (λ)                      |


### <a name="ltpibufro"></a>LTPI-bufro

| Klavo   | Kion ĝi faras                  |
| :------ | :----------------------------- |
| C-c C-z | Iru al la Rakida bufro         |
| M-p     | Montru la antaŭan historieron  |
| M-n     | Montru la sekvan historieron   |
| C-c M-p | Saltu al la antaŭinvito        |
| C-c M-n | Saltu al la sekvinvito         |
| C-c C-q | Eliru el la LTPI               |


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Mi laŭcele preterpasis multe da temo de la [oficialdokumento](http://www.nongnu.org/geiser/), tial
ke, fariĝas malĉarma al multe da homo, kiuj malinklinas por legi longajn blokojn de
teksto. Ironie, ĉi tiu artikolo povas kvalifi kiel tiu. La priskribitaj metodoj supre ne
reprezentiĝas de konsilitaj manieroj, de la komunumo, de instali kaj uzi Rakidon Emakse. Do, ĝis!

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
