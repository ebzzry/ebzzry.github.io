Mastrumi Dosierujojn Emakse
===========================

<center>[Esperante](#)  [English](/en/emacs-dired)</center>
<center>la 12-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 12-an de Februaro 2018</center>

>Supozi estas bona, sed eltrovi estas pli bona.<br>
>―Samuel CLEMENS

En ĉi tiu enskribo, mi fokusas sur unu el la plej lertaj manieroj, kiel Emakso traktas dosierujan
administradon. La dosieruja rekdatilo, aŭ _Dired_ (angle elparolas kiel dir-ed), estas la emaksa
egalvaloro de dosieradministrilo. Kio ajn vi povas fari al regulaj bufroj, vi ankaŭ povas fari ĝin
al Dired-aj bufroj.


Enhavotabelo
------------

- [Superrigardo](#superrigardo)
- [Komunaj komandoj](#komunaj)
- [Markaj komandoj](#markaj)
- [Aliaj komandoj](#aliaj)
- [wDired-a reĝimo](#wdired)
- [Finaj rimarkoj](#finaj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Por kuri Dired-on, kuru Emakson sur la komandlinio, provizi dosierujon, kiel la argumento:

    $ emacs ~/Desktop

Aŭ alternative, vi povas premi <kbd>C-x d</kbd> ene Emakso. Se vi nune redaktilas dosieron, la
dosierujo de tiu dosiero estos prezentita kiel la defaŭlta valoro en la etbufra areo. Ambaŭmaniere,
kiam vi premas <kbd>Enter</kbd>, bufro de la dosierujo aperos, kiu aspektas kiel la eligo de
`ls -l`:

```
/home/john/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 john users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 john users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 john users 4096 Sep 26 05:39 vids
```

Bone, nun, ke vi havas ĝin, kion vi povas fari per ĝi? Nu, la jena estas mallonga listo de tiuj,
kiujn vi bezonas fari per gi. Notu, ke la fulmoklavoj en ĉi tiu artikolo usklecodistingas, krom le
eksplicite esprimis alie.


<a name="komunaj"></a>Komunaj komandoj
--------------------------------------

Jen la kutimaj komandoj kiujn vi uzus, en Dired-a bufro. Krome, ili povas funkcii sur unuobla aŭ
pluraj eroj. Uzi ilin por pluraj eroj estos klarigitaj sekve.

| Klavo   | Kion ĝi faras               |
| :------ | :-------------------------- |
| R       | Renomu eron                 |
| C       | Kopiu eron                  |
| D       | Forviŝu eron                |
| O       | Ŝanĝu proprulon             |
| G       | Ŝanĝu grupon                |
| M       | Ŝanĝu permosjn              |
| S       | Kreu simbolligilon          |
| T       | Tuŝu eron                   |
| ! or X  | Kuru ŝelan komandon al ero  |


<a name="markaj"></a>Markaj komandoj
------------------------------------

La jenaj komandoj faras operaciojn kiuj rilatas al markoj. Krei markojn simple signifas, meti etikodon
sur eroj, por ke vi povas presti la operaciojn en la antaŭa sekcio, sur ili:

| Klavo | Kion ĝi faras                                        |
| :---- | :--------------------------------------------------- |
| m     | Marku eron                                           |
| d     | Marku eron por forviŝi                               |
| x     | Plenumu operacion                                    |
| u     | Malmarku solan eron                                  |
| U     | Malmalku ĉiujn erojn                                 |
| t     | Baskuligu markojn inter markitaj kaj nemarkitaj eroj |
| c     | Densigu erojn                                        |


<a name="aliaj"></a>Aliaj komandoj
----------------------------------

La jenaj komandoj agas laŭ si mem. Ili operacias sur solaj eroj kaj ili ne uzas markojn. La
<kbd>w</kbd> komando, tamen, estas escepto.

| Klavo   | Kion gi faras                             |
| :------ | :---------------------------------------- |
| +       | Kreu dosierujon                           |
| ^       | Iru supren, per unu nivelo, kiel `cd ..`  |
| e aŭ f  | Redaktu eron                              |
| v       | Vidu eron, kiel `less`                    |
| g       | Reŝarĝu la nunan dosierujon               |
| j       | Saltu al ero                              |
| s       | Ŝanĝu ordigan ordon                       |
| y       | Montru dosiertipon de ero, kiel `file`    |
| w       | Kopiu eron al tondejo                     |


<a name="wdired"></a>wDired-a reĝimo
------------------------------------

Tamen, ulu el la plej mojosa, kaj ofte malatentita funkcio de Dired-o estas la _WDired-a_
reĝimo. Kion ĝi faras, estas, ĝi donas al vi potenca kapablo por redakti la nomojn de eroj ene
Dired-a bufro, similas al kion vi faras al kutima bufro. Por eniri la wdired-a reĝimo, premu:

    M-x wdired-change-to-wdired-mode REV

La ĉefreĝimo ŝanĝiĝas de `Dired` al `Editable Dired`. Oni nun povas renoni la dosierojn kaj
dosierujon facile. Oni eĉ povas uzi ortangulajn kaj anstataŭigajn funkciojn sur ili, por fari
aferojn pli facile. La ŝanĝoj, kiujn oni faris, en ĉi tiu punkto ne ankoraŭ konservitas. Por
konservi la ŝanĝojn, premu <kbd>C-c C-c</kbd>.


<a name="finaj"></a>Finaj rimarkoj
----------------------------------

Ni nur tuŝis la pinton de la glacimonto. Liberiĝu por esplori. Por vidi pli da informo, vizitu la
Dired-an manlibron [ĉi tie](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).
