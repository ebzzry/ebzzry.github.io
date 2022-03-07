Agordi Skimprogramadon en Emakso
================================

<div class="center">Esperanto ▪ [English](/en/emacs-scheme/)</div>
<div class="center">Laste ĝisdatigita: la 7-an de Marto 2022</div>

>Ĉiom da bonaj ideoj ne kuŝas sub unu ĉapelo.<br>
>―Dale TURNER

En ĉi tiu afiŝo, mi priparolos la plej facilan metodon, kiun mi uzis por agordi
[skiman](https://eo.wikipedia.org/wiki/Skimo) programadan medion emakse. Notu, ke ĉi tiu ne estas la
sola aliro—iuj traktis ĝin en aserteble pli bonaj manieroj. En ĉi tiu afiŝo, mi provos klarigi la
malpli longan vojon, kiun mi vojaĝigis.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Uzado](#uzado)
  + [Skima bufro](#skimbufro)
  + [REPL-bufro](#replbufro)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo">Superrigardo</a>
---------------------------------------

Redakti skimkodon emakse estis tradicie farita per rudimentaj reĝimoj, kiuj malhavis flekson. Ili
estis kapablaj por taksi aktualajn difinojn, lastajn difinojn, kaj tutajn bufrojn, ĉefparte.
Bedaŭrinde, tio ne sufiĉis pri la maniero, en kiu skimo traktadis la aferojn. Pli inteligenta
maniero por trakti kodon estis bezonita.

Bonŝance, ekzistas [Geiser](http://www.nongnu.org/geiser/). Estas aliaj reĝimoj, kiuj provas fari
tiujn, kiujn Geiser faras, tamen mi fariĝas pli bonfarta al tiuj, kiujn Geiser ofertis. Kelkaj
similaj bibliotekoj ankaŭ povas kunekzisti kun Geiser. Mi ankaŭ provis tiujn, bedaŭrinde, ili fariĝis
tro malsimplaj al mi. Mi finvenis uzi nur Geiser. Kaj kiel parte rilata noto, mi uzas emakson
por redakti skimkodon tial, ke mi ne konas ian ajn redaktilon kiu tiel bonfartas.


<a name="instalo">Instalo</a>
-----------------------------

Per [ELPA](https://www.emacswiki.org/emacs/ELPA), instali Geiser facilas. Simple plenumi la jenan
komandon

    M-x package-install EN geiser EN

tiam post malmultajn sekundojn, oni havos Geiser, instalita en via emaksa profilo. Sekve, oni
metos la efektivan kodon, kiu envokas kaj agordas Geiser:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(mit))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

La unuesprimo ŝargas Geiser mem. La duesprimo precizigas, ke ĝi ne invitos la uzanton por la
aliaj realigoj, se ĝi trovas ilin. La lastesprimo malnepras—ebligas onin por plenumi

    M-x geiser-save EN

en la [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)-bufro, por devigi
la konservadon de la historio al la diskdosiero, kiu implicite troveblas en `~/.geiser_history.mit`
Estas utile se oni tuj volas konservi la REPL-historion. Ne ekzistas pli terura afero ol perdi
gravajn esprimojn. Por certigi, ke ĉiomaj emaksaj kodoj supre efektiviĝos, oni nun povas taksi ilin
per la membroj de la EVAL-trupo—`eval-defun`, `eval-last-sexp`, `eval-region`—aŭ oni ankoraŭ elektas
naski novan emaksan procezon.


<a name="uzado">Uzado</a>
-------------------------

Por rikolti tiujn, kiujn oni semis, kreu aŭ malfermu `.scm`-dosieron, kun malpleje ĝusta modula
deklaro. Tiam, premu:

    M-x run-geiser EN

Kaj, hura! Aperas nova emaksa fenestro enhavante la `* MIT REPL *`-bufron. Kio ajn oni povas fari
per la REPL-bufro—vokita per la vanila komandlinia `mit-scheme`-programo—oni ankaŭ povas fari, per
ĉi tiu kaj pli. Ĉi tiu ĉefreĝimo fakte estas la Comint-reĝimo sub la kovrilo, kun kroĉiloj al skima
procezo. Al tiuj, kiuj ne konas la Comint-reĝimon, ĝi estas la sama reĝimo kiu traktas `M-x shell
EN`.

Do, kion oni povas fari per tio? Dum redakti `.rkt`-dosieron, jen kelkaj kutimaj klavkombinoj, kiujn
mi uzas. La plena listo haveblas [ĉi tie](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet).
Notu, ke la priskribo de la klavoj, kiujn mi uzas malsupre, estas por mi mem komence, por helpi min
kompreni tion, kion ĝi faras. Eble ili malsimilas al la oficiala priskribo, listigita ĉe la
antaŭmenciita ligilo.


### <a name="skimbufro">Skima bufro</a>

| Klavkombinoj                  | Kion ĝi faras                                                     |
| :---------------------------- | :---------------------------------------------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iri al la REPL-bufro                                              |
| <kbd>C-c</kbd> <kbd>C-a</kbd> | Taksi la aktualan bufron, tiam iri al la REPL-bufro               |
| <kbd>C-M-x</kbd>              | Taksi la aktualan esprimon                                        |
| <kbd>C-x</kbd> <kbd>C-e</kbd> | Taksi la lastan esprimon                                          |
| <kbd>C-c</kbd> <kbd>C-r</kbd> | Taksi la regionon                                                 |
| <kbd>C-c</kbd> <kbd>C-\</kbd> | Enmeti lambdsimbolon (λ)                                          |


### <a name="replbufro">REPL-bufro</a>

| Klavkombinoj                  | Kion ĝi faras                                                     |
| :---------------------------- | :---------------------------------------------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Iri al la skima bufro                                             |
| <kbd>M-p</kbd>                | Montri la antaŭan historieron                                     |
| <kbd>M-n</kbd>                | Montri la sekvan historieron                                      |
| <kbd>C-c</kbd> <kbd>M-p</kbd> | Salti al la antaŭinvito                                           |
| <kbd>C-c</kbd> <kbd>M-n</kbd> | Salti al la sekvinvito                                            |
| <kbd>C-c</kbd> <kbd>C-q</kbd> | Eliri de la REPL                                                  |


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Mi laŭcele preterpasis multan temon de la [oficialdokumento](http://www.nongnu.org/geiser/) tial, ke
ĝi fariĝas malĉarma al multaj homoj, kiuj malinklinas legi longajn blokojn da teksto. Ironie, ĉi tiu
artikolo povas kvalifi kiel tio! La priskribitaj metodoj supre ne reprezentiĝas de kiel la ĝenerala
komunumo faras ilin. Do, ĝis!
