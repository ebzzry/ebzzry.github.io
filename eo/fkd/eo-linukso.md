Esperanto-signoj en Linukso
===========================

<div class="center">Esperanto ▪ [English](/en/eo-linux/)</div>
<div class="center">la 22-an de julio 2018</div>
<div class="center">Laste ĝisdatigita: la 20-an de Majo 2019</div>

>Se ion oni volas, kion oni neniam havis, oni devas esti servopreta tion fari, kion oni neniam
>faris.<br>
>―Thomas JEFFERSON

Mi opinias, ke la [h-](https://eo.wikipedia.org/wiki/H-sistemo) kaj la
[x-sistemoj](https://eo.wikipedia.org/wiki/X-sistemo) ne plu devas uzitaj por la signojn enigi
specifaj al Esperanto, krom se, ne fizike fareblas. Nune, estas du manieroj por la
esperantajn signojn enigi linukse—la <kbd>Multi‎ߺ‎key</kbd> kaj <kbd>Mode‎ߺ‎switch</kbd> klavoj.

En ĉi tiu artikolo la <kbd>Mode‎ߺ‎switch</kbd> klavon la <kbd>🐧</kbd> klavo signifas.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Multi‎ߺ‎key](#multikey)
- [Mode‎ߺ‎switch](#modeswitch)
- [Finrimarkoj](#finrimarkoj)


<a name="multikey"></a>Multi‎ߺ‎key
--------------------------------

La *Multi‎ߺ‎key* klavo, kiu ankaŭ nomatas la «Compose» klavo estas speciale asignita klavo, kiu devas
esti premita kaj malpremita kun aliajn klavojn por signon enigi, aŭ seriojn de signoj. Male al
<kbd>Shift</kbd> aŭ <kbd>Ctrl</kbd>, ĝi devas esti malpremita kaj ne premita dum la sinsekvo de
premoj.

Por je <kbd>Pause</kbd> klavon uzi kiel *Multi‎ߺ‎key*, la dosieron `~/.Xmodmap` redaktu, tiam la
jenan kodeton aldonu:

    keycode 127 = Multi‎ߺ‎key

Tiam, je `~/.Xmodmap` reŝarĝu:

    xmodmap ~/.Xmodmap

Se je <kbd>Pause</kbd> klavon oni ne volas uzi, je `xev` plenumu:

    xev

Aperos malgranda fenestro kun blanka malfono. La musmontrilon movu ene la fenestro, tiam klavon
premu per la klavaro. Aperos en la terminalo la klavkodo de la premita klavo.

```
…
KeyRelease event, serial 36, synthetic NO, window 0x2e00001,
    root 0x299, subw 0x0, time 131237513, (16,285), root:(978,647),
    state 0x0, keycode 107 (keysym 0xff61, Print), same_screen YES,
               ^^^^^^^^^^^
…
```

Do por je <kbd>Print</kbd> klavon uzi kiel *Multi‎ߺ‎key*, je `~/.Xmodmap` redaktu por enhavi:

    keycode 107 = Multi‎ߺ‎key

Tiam, je `~/.Xmodmap` reŝarĝu, kiel priskribite ĉi-supre.

Nun, ke je *Multi‎ߺ‎key* oni povas aliri, signojn komposti plifaciliĝas. Ni supozu, ke je
<kbd>Pause</kbd> klavo ni uzis kiel *Multi‎ߺ‎key*, por la literon **ĉ** eniri, je <kbd>Pause</kbd> oni
premas kaj malpremas, tiam je <kbd>&#94;</kbd> oni premas kaj malpremas, tiam fine, je <kbd>c</kbd>
oni premas kaj malpremas.

Jen la tabuleto kiu la kombinadojn por la esperantaj signoj listigas.

| Signo     | Sinsekvo       |
| :-------- | :------------- |
| ĉ         | Multi‎ߺ‎key ^ c  |
| Ĉ         | Multi‎ߺ‎key ^ C  |
| ĝ         | Multi‎ߺ‎key ^ g  |
| Ĝ         | Multi‎ߺ‎key ^ G  |
| ĥ         | Multi‎ߺ‎key ^ h  |
| Ĥ         | Multi‎ߺ‎key ^ H  |
| ĵ         | Multi‎ߺ‎key ^ j  |
| Ĵ         | Multi‎ߺ‎key ^ J  |
| ŝ         | Multi‎ߺ‎key ^ s  |
| Ŝ         | Multi‎ߺ‎key ^ S  |
| ŭ         | Multi‎ߺ‎key u u  |
| Ŭ         | Multi‎ߺ‎key U U  |



<a name="modeswitch"></a>Mode‎ߺ‎switch
------------------------------------

Pli rapida kaj pli facila manieroj por esperantajn signojn enigi estas per la uzo de la
*Mode‎ߺ‎switch* klavo. Similas al *Multi‎ߺ‎key* klavon oni devas asigni al ĝi. Du klavojn mi ŝatas bindi
por tiu celo por ke per du manojn mi povu maŝinskribi. Male al *Multi‎ߺ‎key*, ĝin oni devas premi kaj
teni kiel la <kbd>Shift</kbd> aŭ <kbd>Ctrl</kbd> klavoj.

Se la vindozklavojn oni volas uzi kiel la *Mode‎ߺ‎switch*-klavo, la `~/.Xmodmap` dosieron redaktu, tiam la
jenan kodeton enmeti:

```
!! maldekstra vindozklavo
keycode 133 = Mode‎ߺ‎switch

!! dekstra vindozklavo
keycode 134 = Mode‎ߺ‎switch

!! menua klavo
keycode 135 = Mode‎ߺ‎switch
```

Sekve, la ĝustajn nomojn de la klavoj oni devas uzi. La jenajn kodetojn uzu por la QWERTY- kaj Dvoraka klavaroj, respektive.

```
keycode 54 = c C ccircumflex Ccircumflex
keycode 42 = g G gcircumflex Gcircumflex
keycode 43 = h h hcircumflex Hcircumflex
keycode 44 = j J jcircumflex Jcircumflex
keycode 39 = s S scircumflex Scircumflex
keycode 30 = u U ubreve Ubreve
```

```
keycode 31 = c C ccircumflex Ccircumflex
keycode 30 = g G gcircumflex Gcircumflex
keycode 44 = h h hcircumflex Hcircumflex
keycode 54 = j J jcircumflex Jcircumflex
keycode 47 = s S scircumflex Scircumflex
keycode 41 = u U ubreve Ubreve
```

Tiam, je `~/.Xmodmap` reŝarĝu:

    xmodmap ~/.Xmodmap

Por la literon **ĉ** eniri, je 🐧 premu kaj tenu, tiam <kbd>c</kbd> klavon premu. Por la **Ŭ**
literon eniri, je 🐧 premu kaj tenu, tiam je <kbd>Shift</kbd> premu, tiam je <kbd>u</kbd> premu. Per
ĉi tiuj metodoj, onin permesas por senokulmaŝinskribi.

En kelkaj klavaroj, estas nur unu vindozklavo, kutime lokitas maldekstre, dum tiu dekstre estas
la <kbd>PrtSc</kbd> klavo. Multfoje ili sandviĉitas inter la <kbd>Ctrl</kbd> kaj la
<kbd>Alt</kbd> klavoj. Por tiun klavon uzi, je `xev` plenumu kiel ĉi-supre por la klavkodon akiri, tiam
je `~/.Xmodmap` dosiero ĝisdatigi laŭe.

Sur mia ThinkPad, la jenan kodeton mi `~/.Xmodmap` havas:

```
!! Maldekstra vindozo
keycode 133 = Mode‎ߺ‎switch

!! PrtSc
keycode 107 = Mode‎ߺ‎switch
```


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Ambaŭ resumitaj metodoj supre, faras pli ol esperantajn signojn montri. Pliartifikajn signojn
kaj signojn *Multi‎ߺ‎key* sistemo povas enigi. Por la plenan liston de signoj, la jenan komandon
plenumu se oni estas en kutimaj linuksaj sistemoj:

    less /usr/share/X11/locale/en_US.UTF-8/Compose

Se je Nix oni uzas, plenumu:

    less ~/.nix-profile/share/X11/locale/en_US.UTF-8/Compose

Male al tio, la avantaĝo de la *Mode‎ߺ‎switch*-metodo estas rapideco. Por la tutan liston de validaj
signojn vidi [ĉi tien](http://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap)
iru.

Ne ekzistas la plej bona metodo por ĉi tiuj aferoj—kiun ajn oportunan sistemon uzu. Se la
vindozklavoj jam uzatas por iu ajn, aŭ nur unu kromaĵan klavon oni povas uzi, tiam
*Multi‎ߺ‎key*-metodon uzu. Se facilon de uzado oni preferas, la *Mode‎ߺ‎switch*-metodon uzu. Ankaŭ
gravas por noti, ke ambaŭ metodojn oni povas uzi samtempe.

🐧—Ĝis la revido!

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
