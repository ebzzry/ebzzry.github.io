Agordi Rakidan Programadon Emakse
=================================

<center>[Esperante](#)  [English](/en/emacs-racket)</center>
<center>la 13-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 13-an de Februaro 2018</center>

>Ĉiom da bonaj ideoj ne kuŝas sub unu ĉapelo.<br>
>―Dale TURNER

En ĉi tiu afiŝo, mi priparolos la plej facilan alproksimiĝon, kiun mi uzis por agordi
[Rakidan](https://racket-lang.org) programadan medion Emakse. Notu tion, ke ĉi tiu ne estas la sola
aliro—iuj traktis ĝin en aserteble pli bonaj manieroj. En ĉi tiu afiŝo, mi provos klarigi la malpli
longan vojon, kiun mi vojaĝis.


Enhavotabelo
------------

- [Superrigardo](#superrigardo)
- [Instalado](#instalado)
- [Uzado](#uzado)
  + [Rakida bufro](#rakidbufro)
  + [LTPI-a bufro](#ltpiabufro)
- [Finaj rimarkoj](#finaj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Redakti Rakidan kodon Emakse estis tradicie farita per rudimentaj reĝimoj, kiuj malhavis
flekseblecon. Ili estis kapablaj por taksi nunajn difinojn, lastajn difinojn, kaj tutajn bufrojn,
ĉefparte. Bedaŭrinde, tio ne sufiĉis pri la maniero, en kiu Rakido traktadis la aferojn. Pli
inteligenta maniero de trakti kodon, estis bezonita.

Bonŝance, ekzistas [Geiser-on](http://www.nongnu.org/geiser/). Ekzistis aliaj reĝimoj, kiuj provis
fari, kiujn Geiser-o faras, tamen mi fariĝas pli bonfarta al tiuj, kiujn Geiser ofertis. Kelkaj
similaj bibliotekoj ankaŭ povas kunekzisti kun Geiser-o. Mi ankaŭ provis tiujn, bedaŭrinde, fariĝis
tro malsimplaj, por mi. Mi finvenis uzi nur Geiser-on. Kaj kiel parte rilata noto, mi uzas Emakson
por redakti Rakidan kodon, tial ke, mi ne konas ian ajn redaktilon, kiu tiel bonfartas. Mi ne uzas
DrRacket-on krom mi bezonas uzi ĝian agrablan grafikan fasadan sencimigilon.


<a name="instalado"></a>Instalado
---------------------------------

Per [ELPA](https://www.emacswiki.org/emacs/ELPA), instali Geiser-on facilas. Simple plenumi la jenan
komandon

    M-x package-install REV geiser REV

Tiam post malmultajn sekundojn, vi havos Geiser-on, instalita en via Emaksa profilo. Sekve, vi metos en
la efektivan kodon, kiu envokas kaj agordas Geiser-on:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(racket))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

La unua esprimo ŝarĝas Geiser-on mem. La dua esprimo precizigas, ke ne invitos onin por la aliaj
realigoj, se trovas ilin. La lasta esprimo malnepras—ŝaltas onin por plenumi

    M-x geiser-save REV

en la legad-taksad-presada iteracio (LTPI, angle REPL), por devigi la konservadon de la historio al
la diska dosiero, kiu troveblas en `~/.geiser_history.racket` defaŭlte. Estas utila se vi tuj volas
konservi vian LTPI-an historion. Ne ekzistas pli teruran aferon ol perdi TIUN esprimon. Por ĉiuj de
la Emaksaj kodoj supraj, por efektiviĝi, vi nun povas taksi ilin per la membroj de la EVAL-a
trupo—`eval-defun`, `eval-last-sexp`, `eval-region`—aŭ, vi ankoraŭ elektas naski novan Emaksan
procezon.


<a name="uzado"></a>Uzado
-------------------------

Por rikolti tiujn, kiujn vi semis, kreu aŭ malfermu `.rkt`-an dosieron, kun malpleje ĝusta modula
deklaro. Tiam, premu:

    M-x run-geiser REV

Kaj, hura! Aperas nova Emaksa fenestro, enhavi la `* Racket REPL *`-an bufron. Kio ajn vi povas fari
per la LTPI-a envokito per la vanila komandlinia `racket`, vi ankaŭ povas fari tiujn, per ĉi tiu, kaj
pli. Ĉi tiu ĉefreĝimo fakte estas la Comint-a reĝimo sub la kovrilo, kun kroĉiloj al Rakida
procezo. Por tiuj de vi, kiuj estas malkutimaj pri la Comint-a reĝimo, estas la sama reĝimo kiu
traktas `M-x shell REV`.

Do, kion oni povas fari per tio? Dum redakti `.rkt`-an dosieron, jen estas kelke de kutimaj
fulmoklavoj, kiujn mi uzas. La plena listo haveblas [ĉi tie](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet).
Notu tion, ke la priskribo de la klavoj, kiujn mi mi uzas malsupre, estas por mi mem komence, por
helpi min komprenas tion, kion ĝi faras. Eble ili malsimilas al la oficiala priskribo, listigita sur
la antaŭmenciita ligilo.


### <a name="rakidbufro"></a>Rakida bufro

| Klavo   | Kion ĝi faras                                           |
| :------ | :------------------------------------------------------ |
| C-c C-z | Iru al la LTPI-a bufro                                  |
| C-c C-a | Taksu la nunan bufron, tiam iru al la LTPI-a bufro      |
| C-M-x   | Taksu la nunan esprimon                                 |
| C-x C-e | Taksu la lastan esprimon                                |
| C-c C-r | Taksu regionon                                          |
| C-c C-\ | Enmetu lambdan (λ) simbolon                             |


### <a name="ltpiabufro"></a>LTPI-a bufro

| Klavo   | Kion ĝi faras                       |
| :------ | :---------------------------------- |
| C-c C-z | Iru al la Rakida bufro              |
| M-p     | Montru la antaŭan historian eron    |
| M-n     | Montru la sekvan historian eron     |
| C-c M-p | Saltu al la antaŭa invito           |
| C-c M-n | Saltu al la sekva invito            |
| C-c C-q | Eliru el la LTPI                    |


<a name="finaj"></a>Finaj rimarkoj
----------------------------------

Mi laŭcele preterpasis multe da temo de la [oficiala dokumento](http://www.nongnu.org/geiser/), tial
ke, fariĝas malĉarma al multe da homo, kiuj estas malinklinaj por legi longajn blokojn de
teksto. Ironie, ĉi tiu artikolo povas kvalifi kiel tiu. La priskribitaj metodoj supre ne
reprezentiĝas de konsilitaj manieroj, de la komunumo, de instali kaj uzi Rakidon Emakse. Do, ĝis!
