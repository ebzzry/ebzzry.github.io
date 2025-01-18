Manipuli Dosierujojn en Emakso
==============================

<div class="center">[English](/en/emacs-dired/) • Esperanto</div>
<div class="center">Laste ĝisdatigita: la 17-an de marto 2022</div>

>Supozi bonas, tamen eltrovi pli bonas.<br>
>—Samuel CLEMENS

<img src="/images/site/lucas-benjamin-V-mEcfI8fsI-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="lucas-benjamin-V-mEcfI8fsI-unsplash" title="lucas-benjamin-V-mEcfI8fsI-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Komunaj komandoj](#komunaj)
- [Markaj komandoj](#markaj)
- [Aliaj komandoj](#aliaj)
- [WDired-reĝimo](#wdired)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

En ĉi tiu afiŝo, mi fokusas pri unu el la plej lertaj manieroj kiel emakso traktas dosierujan
administradon. La dosierujrekdatilo _Dired_ (angle prononcata *dir-ed*), estas la emaksa
ekvivalento de dosieradministrilo. Kio ajn oni povas fari al regulaj bufroj, oni ankaŭ povas fari ĝin
al Dired-bufroj.

Por ruli Dired, rulu emakson ĉe la komandlinio, disponigi dosierujon kiel la argumento:

    $ emacs ~/Desktop

Aŭ alterne, oni povas premi <kbd>C-x d</kbd> ene emakso. Se oni nune redaktas dosieron, la dosierujo
de tiu dosiero estos prezentita kiel la implicita valoro en la etbufra areo. Ambaŭmaniere, kiam
oni premas <kbd>Enter</kbd>, bufro aperos de la dosierujo, kiu aspektas kiel la eligo de `ls -l`:

```
/home/vakelo/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 vakelo users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 vakelo users 4096 Sep 26 17:42 bildoj
drwxr-xr-x 3 vakelo users 4096 Sep 26 05:39 filmoj
```

Bone. Nun, ke oni havas ĝin, kion oni povas fari per ĝi? Nu, la jena estas mallonga listo de tiuj,
kiujn oni bezonas fari per ĝi. Notu, ke la fulmoklavoj en ĉi tiu artikolo estas usklecivaj, krom se
eksplicite esprimis alie.


<a name="komunaj">Komunaj komandoj</a>
--------------------------------------

Jen la kutimaj komandoj kiujn oni uzus, en Dired-bufro. Kaj cetere, ili povas funkcii al unuobla
aŭ pluraj eroj. Uzi ilin al pluraj eroj estos klarigitaj sekve.

| Fulmoklavo                    | Kion ĝi faras                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>R</kbd>                  | Renomi eron                                                        |
| <kbd>C</kbd>                  | Kopii eron                                                         |
| <kbd>D</kbd>                  | Forviŝi eron                                                       |
| <kbd>O</kbd>                  | Ŝanĝi proprulon                                                    |
| <kbd>G</kbd>                  | Ŝanĝi grupon                                                       |
| <kbd>M</kbd>                  | Ŝanĝi permesosjn                                                   |
| <kbd>S</kbd>                  | Krei simbolligilon                                                 |
| <kbd>T</kbd>                  | Tuŝi eron                                                          |
| <kbd>!</kbd> aŭ <kbd>x</kbd>  | Ruli ŝelan komandon al ero                                      |


<a name="markaj">Markaj komandoj</a>
------------------------------------

La jenaj komandoj faras operaciojn kiuj rilatas al markoj. Krei markojn simple signifas, meti etikodon
sur eroj, por ke oni povu presti la operaciojn en la antaŭa sekcio, sur ili:

| Fulmoklavo                    | Kion ĝi faras                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>m</kbd>                  | Marki eron                                                         |
| <kbd>d</kbd>                  | Marki eron por forviŝi                                             |
| <kbd>x</kbd>                  | Ruli operacion                                                  |
| <kbd>u</kbd>                  | Malmarki soleron                                                   |
| <kbd>U</kbd>                  | Malmarki ĉiujn erojn                                               |
| <kbd>t</kbd>                  | Baskuligi markojn inter markitaj kaj nemarkitaj eroj               |
| <kbd>c</kbd>                  | Densigi erojn                                                      |


<a name="aliaj">Aliaj komandoj</a>
----------------------------------

la jenaj komandoj agas laŭ ili mem. Ili operacias sur solaj eroj kaj ili ne uzas markojn. La komando
<kbd>w</kbd>, tamen, estas escepto.

| Fulmoklavo                    | Kion ĝi faras                                                      |
| :---------------------------- | :----------------------------------------------------------------- |
| <kbd>+</kbd>                  | Kreu dosierujon                                                    |
| <kbd>&#94;</kbd>              | Iru supren, per unu nivelo, kiel `cd ..`                           |
| <kbd>e</kbd> aŭ <kbd>f</kbd>  | Redaktu eron                                                       |
| <kbd>v</kbd>                  | Vidu eron, kiel `less`                                             |
| <kbd>g</kbd>                  | Reŝargu la aktualan dosierujon                                     |
| <kbd>j</kbd>                  | Saltu al ero                                                       |
| <kbd>s</kbd>                  | Ŝanĝu ordigan ordon                                                |
| <kbd>y</kbd>                  | Montru dosiertipon de ero, kiel `file`                             |
| <kbd>w</kbd>                  | Kopiu eron al la tondejo                                           |


<a name="wdired">WDired-reĝimo</a>
------------------------------------

Tamen, unu el la plej mojosaj kaj ofte malatentitaj funkcioj de Dired estas la _WDired_-reĝimo. Tio,
kion ĝi faras, estas ke, ĝi donas potenca kapablo por redakti la nomojn de eroj ene Dired-bufro,
similas al tio, kion oni faras al kutima bufro. Por eniri al WDired-reĝimo, premu:

    M-x wdired-change-to-wdired-mode EN

La ĉefreĝimo ŝanĝiĝas de `Dired` al `Editable Dired`. Oni nun povas renomi la dosierojn kaj
dosierujon facile. Oni eĉ povas uzi ortangulajn kaj anstataŭigajn funkciojn sur ili, por fari
aferojn pli facile. La ŝanĝoj, kiujn oni faris en ĉi tiu punkto, ne ankoraŭ konserviĝis. Por
konservi la ŝanĝojn, premu <kbd>C-c C-c</kbd>.


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Ni nur tuŝis la pinton de la glacimonto. Liberiĝu esplori. Por vidi pli da informo, vizitu la
Dired-manlibron [ĉi tie](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).
