Dosierujojn Mastrumi per Emakso
===============================

<div class="center">Esperanto ▪ [English](/en/emacs-dired/)</div>
<div class="center">la 12-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 9-an de marto 2019</div>

>Supozi bonas, tamen eltrovi pli bonas.<br>
>―Samuel CLEMENS

En ĉi tiu afiŝo, mi fokusas sur unu el la plej lertaj manieroj, kiel Emakso traktas dosierujan
administradon. La dosierujrekdatilo _Dired_ (angle prononcata *dir-ed*), estas la Emaksa
egalvaloro de dosieradministrilo. Kio ajn oni povas fari al regulaj bufroj, oni ankaŭ povas fari ĝin
al Dired-bufroj.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Komunaj komandoj](#komunaj)
- [Markaj komandoj](#markaj)
- [Aliaj komandoj](#aliaj)
- [WDired-reĝimo](#wdired)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Por kuri je Dired, plenumu Emakson sur la komandlinio, disponigi dosierujon, kiel la argumento:

    $ emacs ~/Desktop

Aŭ alterne, oni povas premi <kbd>C-x d</kbd> ene Emakso. Se oni nune redaktas dosieron, la
dosierujo de tiu dosiero estos prezentita kiel la defaŭlta valoro en la etbufra areo. Ambaŭmaniere,
kiam oni premas <kbd>Enter</kbd>, bufro de la dosierujo aperos, kiu aspektas kiel la eligo de
`ls -l`:

```
/home/vakelo/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 vakelo users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 vakelo users 4096 Sep 26 17:42 bildoj
drwxr-xr-x 3 vakelo users 4096 Sep 26 05:39 filmoj
```

Bone, nun, ke oni havas ĝin, kion oni povas fari per ĝi? Nu, la jena estas mallonga listo de tiuj,
kiujn oni bezonas fari per gi. Notu, ke la fulmoklavoj en ĉi tiu artikolo usklecodistingas, krom se
eksplicite esprimis alie.


<a name="komunaj"></a>Komunaj komandoj
--------------------------------------

Jen la kutimaj komandoj kiujn oni uzus, en Dired-bufro. Kaj cetere, ili povas funkcii sur unuobla
aŭ pluraj eroj. Uzi ilin por pluraj eroj estos klarigitaj sekve.

| Klavo                         | Kion ĝi faras                  |
| :---------------------------- | :----------------------------- |
| <kbd>R</kbd>                  | Renomu eron                    |
| <kbd>C</kbd>                  | Kopiu eron                     |
| <kbd>D</kbd>                  | Forviŝu eron                   |
| <kbd>O</kbd>                  | Ŝanĝu proprulon                |
| <kbd>G</kbd>                  | Ŝanĝu grupon                   |
| <kbd>M</kbd>                  | Ŝanĝu permesosjn               |
| <kbd>S</kbd>                  | Kreu simbolligilon             |
| <kbd>T</kbd>                  | Tuŝu eron                      |
| <kbd>!</kbd> aŭ <kbd>X</kbd>  | Plenumu ŝelan komandon al ero  |


<a name="markaj"></a>Markaj komandoj
------------------------------------

La jenaj komandoj faras operaciojn kiuj rilatas al markoj. Krei markojn simple signifas, meti etikodon
sur eroj, por ke oni povu presti la operaciojn en la antaŭa sekcio, sur ili:

| Klavo        | Kion ĝi faras                                        |
| :----------- | :--------------------------------------------------- |
| <kbd>m</kbd> | Marku eron                                           |
| <kbd>d</kbd> | Marku eron por forviŝi                               |
| <kbd>x</kbd> | Plenumu operacion                                    |
| <kbd>u</kbd> | Malmarku soleron                                     |
| <kbd>U</kbd> | Malmarku ĉiujn erojn                                 |
| <kbd>t</kbd> | Baskuligu markojn inter markitaj kaj nemarkitaj eroj |
| <kbd>c</kbd> | Densigu erojn                                        |


<a name="aliaj"></a>Aliaj komandoj
----------------------------------

La jenaj komandoj agas laŭ ili mem. Ili operacias sur solaj eroj kaj ili ne uzas markojn. La
<kbd>w</kbd> komando, tamen, estas escepto.

| Klavo                        | Kion ĝi faras                                |
| :--------------------------- | :------------------------------------------- |
| <kbd>+</kbd>                 | Kreu dosierujon                              |
| <kbd>&#94;</kbd>             | Iru supren, per unu nivelo, kiel `cd ..`     |
| <kbd>e</kbd> aŭ <kbd>f</kbd> | Redaktu eron                                 |
| <kbd>v</kbd>                 | Vidu eron, kiel `less`                       |
| <kbd>g</kbd>                 | Reŝarĝu la aktualan dosierujon               |
| <kbd>j</kbd>                 | Saltu al ero                                 |
| <kbd>s</kbd>                 | Ŝanĝu ordigan ordon                          |
| <kbd>y</kbd>                 | Montru dosiertipon de ero, kiel `file`       |
| <kbd>w</kbd>                 | Kopiu eron al tondejo                        |


<a name="wdired"></a>WDired-reĝimo
------------------------------------

Tamen, unu el la plej mojosa, kaj ofte malatentita funkcio de Dired estas la _WDired_-reĝimo. Tio,
kion ĝi faras, estas, ĝi donas al oni potenca kapablo por redakti la nomojn de eroj ene Dired-bufro,
similas al tio, kion oni faras al kutima bufro. Por eniri la WDired-reĝimo, premu:

    M-x wdired-change-to-wdired-mode EN

La ĉefreĝimo ŝanĝiĝas de `Dired` al `Editable Dired`. Oni nun povas renomi la dosierojn kaj
dosierujon facile. Oni eĉ povas uzi ortangulajn kaj anstataŭigajn funkciojn sur ili, por fari
aferojn pli facile. La ŝanĝoj, kiujn oni faris, en ĉi tiu punkto ne ankoraŭ konservitas. Por
konservi la ŝanĝojn, premu <kbd>C-c C-c</kbd>.


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Ni tuŝis nur la pinton de la glacimonto. Liberiĝu por esplori. Por vidi pli da informo, vizitu la
Dired-manlibron [ĉi tie](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
