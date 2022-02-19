Manipuli Dosierujojn en Emakso
==============================

<div class="center">Esperanto ▪ [English](/en/emacs-dired/)</div>
<div class="center">la 12-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 4-an de Februaro 2022</div>

>Supozi bonas, tamen eltrovi pli bonas.<br>
>―Samuel CLEMENS

En ĉi tiu afiŝo, fokusas mi pri unu el la plej lertaj manieroj kiel traktas emakso dosierujan
administradon. La dosierujrekdatilo _Dired_ (angle prononcata *dir-ed*), estas la emaksa
ekvivalento de dosieradministrilo. Kio ajn povas fari oni al regulaj bufroj, ankaŭ povas fari oni ĝin
al Dired-bufroj.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Superrigardo](#superrigardo)
- [Komunaj komandoj](#komunaj)
- [Markaj komandoj](#markaj)
- [Aliaj komandoj](#aliaj)
- [WDired-reĝimo](#wdired)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo">Superrigardo</a>
---------------------------------------

Por plenumi Dired plenumi, plenumu emakson ĉe la komandlinio, disponigi dosierujon kiel la argumento:

    $ emacs ~/Desktop

Aŭ alterne, povas oni premi <kbd>C-x d</kbd> ene emakso. Se nune redaktas oni dosieron, la dosierujo
de tiu dosiero estos prezentita kiel la implicita valoro en la etbufra areo. Ambaŭmaniere, kiam
premas oni <kbd>Enter</kbd>, aperos bufro de la dosierujo, kiu aspektas kiel la eligo de `ls -l`:

```
/home/vakelo/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 vakelo users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 vakelo users 4096 Sep 26 17:42 bildoj
drwxr-xr-x 3 vakelo users 4096 Sep 26 05:39 filmoj
```

Bone. Nun, ke havas oni ĝin, kion povas fari oni per ĝi? Nu, la jena estas mallonga listo de tiuj,
kiujn bezonas fari oni per gi. Notu, ke usklecodistingas la fulmoklavoj en ĉi tiu artikolo, krom se
eksplicite esprimis alie.


<a name="komunaj"></a>Komunaj komandoj
--------------------------------------

Jen la kutimaj komandoj kiujn uzus oni, en Dired-bufro. Kaj cetere, povas funkcii ili al unuobla
aŭ pluraj eroj. Uzi ilin al pluraj eroj estos klarigitaj sekve.

| Fulmoklavo                    | Kion faras ĝi                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>R</kbd>                  | Renomu eron                                                        |
| <kbd>C</kbd>                  | Kopiu eron                                                         |
| <kbd>D</kbd>                  | Forviŝu eron                                                       |
| <kbd>O</kbd>                  | Ŝanĝu proprulon                                                    |
| <kbd>G</kbd>                  | Ŝanĝu grupon                                                       |
| <kbd>M</kbd>                  | Ŝanĝu permesosjn                                                   |
| <kbd>S</kbd>                  | Kreu simbolligilon                                                 |
| <kbd>T</kbd>                  | Tuŝu eron                                                          |
| <kbd>!</kbd> aŭ <kbd>x</kbd>  | Plenumu ŝelan komandon al ero                                      |


<a name="markaj">Markaj komandoj</a>
------------------------------------

Faras la jenaj komandoj operaciojn kiuj rilatas al markoj. Krei markojn simple signifas, meti etikodon
sur eroj, por ke povu presti oni la operaciojn en la antaŭa sekcio, sur ili:

| Fulmoklavo                    | Kion faras ĝi                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>m</kbd>                  | Marku eron                                                         |
| <kbd>d</kbd>                  | Marku eron por forviŝi                                             |
| <kbd>x</kbd>                  | Plenumu operacion                                                  |
| <kbd>u</kbd>                  | Malmarku soleron                                                   |
| <kbd>U</kbd>                  | Malmarku ĉiujn erojn                                               |
| <kbd>t</kbd>                  | Baskuligu markojn inter markitaj kaj nemarkitaj eroj               |
| <kbd>c</kbd>                  | Densigu erojn                                                      |


<a name="aliaj">Aliaj komandoj</a>
----------------------------------

Agas la jenaj komandoj laŭ ili mem. Operacias ili sur solaj eroj kaj ne uzas ili markojn. La komando
<kbd>w</kbd>, tamen, estas escepto.

| Fulmoklavo                    | Kion faras ĝi                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>+</kbd>                  | Kreu dosierujon                                                    |
| <kbd>&#94;</kbd>              | Iru supren, per unu nivelo, kiel `cd ..`                           |
| <kbd>e</kbd> aŭ <kbd>f</kbd>  | Redaktu eron                                                       |
| <kbd>v</kbd>                  | Vidu eron, kiel `less`                                             |
| <kbd>g</kbd>                  | Reŝarĝu la aktualan dosierujon                                     |
| <kbd>j</kbd>                  | Saltu al ero                                                       |
| <kbd>s</kbd>                  | Ŝanĝu ordigan ordon                                                |
| <kbd>y</kbd>                  | Montru dosiertipon de ero, kiel `file`                             |
| <kbd>w</kbd>                  | Kopiu eron al la tondejo                                           |


<a name="wdired">WDired-reĝimo</a>
------------------------------------

Tamen, unu el la plej mojosaj kaj ofte malatentitaj funkcioj de Dired estas la _WDired_-reĝimo. Tio,
kion faras ĝi, estas ke, donas ĝi al oni potenca kapablo por redakti la nomojn de eroj ene Dired-bufro,
similas al tio, kion faras oni al kutima bufro. Por eniri al WDired-reĝimo, premu:

    M-x wdired-change-to-wdired-mode EN

Ŝanĝiĝas la ĉefreĝimo de `Dired` al `Editable Dired`. Nun povas oni renomi la dosierojn kaj
dosierujon facile. Eĉ povas uzi oni ortangulajn kaj anstataŭigajn funkciojn sur ili, por fari
aferojn pli facile. La ŝanĝoj, kiujn faris oni, en ĉi tiu punkto, ne ankoraŭ konserviĝis. Por
konservi la ŝanĝojn, premu <kbd>C-c C-c</kbd>.


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Tuŝis ni nur la pinton de la glacimonto. Liberiĝu esplori. Por vidi pli da informo, vizitu la
Dired-manlibron [ĉi tie](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
