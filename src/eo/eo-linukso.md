---
title: Esperanto-signoj en Linukso
keywords: esperanto, linukso, linukse, klavaro, signoj, literoj, agordo, agardaĵo, agordajxo 
image: https://ebzzry.com/images/site/stefan-stefancik-6whwCHgsMiA-unsplash-2000x1125.jpg
---
Esperanto-signoj en Linukso
===========================

<div class="center">2018-07-22</div>

>Se ion oni volas, kion oni neniam havis, oni devas esti servopreta tion fari, kion oni neniam
>faris.<br>
>—Thomas JEFFERSON

<img src="/images/site/stefan-stefancik-6whwCHgsMiA-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Multi‎ߺ‎key](#multikey)
- [Mode‎ߺ‎switch](#modeswitch)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Mi opinias, ke la [h-](https://eo.wikipedia.org/wiki/H-sistemo) kaj la
[x-sistemoj](https://eo.wikipedia.org/wiki/x-sistemo) ne plu devas esti uzitaj por la enigi signojn
specife al Esperanto, krom se, ne estas fizike farebla. Nune, estas du manieroj por la enigi
Esperanto-signojn linukse—la klavoj <kbd>Multi‎ߺ‎key</kbd> kaj <kbd>Mode‎ߺ‎switch</kbd>.

En ĉi tiu artikolo la klavo <kbd>🐧</kbd> signifas la  klavon <kbd>Mode‎ߺ‎switch</kbd>.

<a name="multikey"></a>Multi‎ߺ‎key
--------------------------------

La *Multi‎ߺ‎key* klavo, kiu ankaŭ nomiĝas la klavo «Compose» estas speciale asignita klavo, kiu devas
esti premita kaj malpremita kun aliaj klavoj por enigi signon aŭ seriojn de signoj. Male al
<kbd>Shift</kbd> aŭ <kbd>Ctrl</kbd>, ĝi devas esti malpremita kaj ne premita dum la sinsekvo de la
premoj.

Por uzi la klavon <kbd>Pause</kbd> kiel *Multi‎ߺ‎key*, redaktu la dosieron `~/.xmodmap`, tiam la
aldonu jenan kodeton:

    keycode 127 = Multi‎ߺ‎key

Tiam, je `~/.xmodmap` reŝargu:

    xmodmap ~/.xmodmap

Se oni volas uzi la klavon <kbd>Pause</kbd>, rulu `xev`:

    xev

Aperos malgranda fenestro kun blanka malfono. Movu la musmontrilon ene la fenestro, tiam premu
klavon per la klavaro. Aperos en la terminalo la klavkodo de la premita klavo.

```
…
KeyRelease event, serial 36, synthetic NO, window 0x2e00001,
    root 0x299, subw 0x0, time 131237513, (16,285), root:(978,647),
    state 0x0, keycode 107 (keysym 0xff61, Print), same_screen YES,
               ^^^^^^^^^^^
…
```

Do, por uzi la klavon <kbd>Print</kbd> kiel *Multi‎ߺ‎key*, redaktu `~/.xmodmap` por enhavi:

    keycode 107 = Multi‎ߺ‎key

Tiam, reŝargu `~/.xmodmap` kiel priskribite ĉi-supre.

Nun, ke oni povas aliri *Multi‎ߺ‎key*, plifaciliĝas komposti signojn. Ni supozu, ke ni uzis la klavon
<kbd>Pause</kbd> kiel *Multi‎ߺ‎key*, por eniri la literon **ĉ**, oni premas kaj malpremas
<kbd>Pause</kbd>, tiam oni premas kaj malpremas <kbd>&#94;</kbd> , tiam fine, oni premas kal
malpremas <kbd>c</kbd>.

Jen la tabuleto kiu la kombinadojn por la esperantaj signoj listigas.

| signo     | sinsekvo       |
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



<a name="modeswitch">Mode‎ߺ‎switch</a>
------------------------------------

Pli rapida kaj pli facila manieroj por enigi esperantajn signojn estas per la uzo de la
*Mode‎ߺ‎switch* klavo. Kiel *Multi‎ߺ‎key*, oni devas asigni klavon al ĝi. Mi ŝatas bindi du klavojn 
por tiu celo por ke mi povu maŝinskribi per du manojn. Male al *Multi‎ߺ‎key*, oni devas premi ĝin kaj
teni kiel la <kbd>Shift</kbd>- aŭ <kbd>Ctrl</kbd>-klavoj.

Se la vindozo-klavojn oni volas uzi kiel la *Mode‎ߺ‎switch*-klavo, redaktu la `~/.xmodmap` dosieron,
tiam enmetu la jenan kodeton:

```
!! maldekstra vindozo-klavo
keycode 133 = Mode‎ߺ‎switch

!! dekstra vindozo-klavo
keycode 134 = Mode‎ߺ‎switch

!! menua klavo
keycode 135 = Mode‎ߺ‎switch
```

Sekve, oni devas uzi la ĝustajn nomojn de la klavoj. Uzu la jenajn kodetojn por la QWERTY- kaj
Dvoraka klavaroj, respektive.

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

Tiam, reŝargu `~/.xmodmap`:

    xmodmap ~/.xmodmap

Por eniri la literon **ĉ**, premu kaj tenu 🐧, tiam premu la klavon <kbd>c</kbd>. Por enigi la
literon **Ŭ**, premu kaj tenu 🐧, tiam premu <kbd>Shift</kbd>, tiam premu <kbd>u</kbd>. Per
ĉi tiuj metodoj, eblas senokulmaŝinskribi.

En kelkaj klavaroj, estas nur unu vindozo-klavo, kutime lokiĝas maldekstre, dum tiu dekstra klavo
estas la klavo <kbd>PrtSc</kbd>. Multfoje ili estas sandviĉitaj inter la klavoj <kbd>Ctrl</kbd> kaj <kbd>Alt</kbd>. Por uzi tiun klavon, rulu `xev` rulu kiel ĉi-supre por akiri la klavkodon,
    tiam ĝisdatigu `~/.xmodmap` laŭe.

Per mia ThinkPad-komputilo, mi havas la jenan kodeton en `~/.xmodmap`:

```
!! maldekstra vindozo-klavo
keycode 133 = Mode‎ߺ‎switch

!! PrtSc
keycode 107 = Mode‎ߺ‎switch
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

La resumitaj metodoj supre faras pli ol montri Esperanto-signojn. *Multi‎ߺ‎key* sistemo povas enigi
pliartifikajn signojn kaj signojn. Por vidi la plenan liston de signoj, rulu la jenan komandon se oni
estas ĉe kutima linuksa sistemo:

    less /usr/share/x11/locale/en_US.UTF-8/Compose

Se oni uzas Nix, rulu:

    less ~/.nix-profile/share/x11/locale/en_US.UTF-8/Compose

Male al tio, la avantaĝo de la *Mode‎ߺ‎switch*-metodo estas rapideco. Por vidi la tutan liston de validaj
signojn iru [ĉi tien](https://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap).

Ne ekzistas la plej bona metodo por ĉi tiuj aferoj—uzu kiun ajn oportunan sistemon. Se la
vindozo-klavoj estas jam por io ajn aŭ oni povas uzi nur unu kromaĵan klavon, do uzu la
*Multi‎ߺ‎key*-metodon. Se oni preferas facilon de uzado, uzu la *Mode‎ߺ‎switch*-metodon. Ankaŭ
gravas noti, ke oni povas uzi ambaŭ metodojn samtempe.
