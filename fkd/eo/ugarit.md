Krei Sekurkopiojn per Ugarit
============================

<div class="center">Esperanto ■ [English](/en/ugarit/)</div>
<div class="center">Laste ĝisdatigita: la 17-an de Marto 2022</div>

>Bona juĝo devenas el sperto, kaj sperto devenas el malbona juĝo.<br>
>―Fred BROOKS

<img src="/bil/omar-flores-lQTbOWtysE-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="omar-flores-lQTbOWtysE-unsplash" title="omar-flores-lQTbOWtysE-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Instalo](#instalo)
  + [Per APT](#apt)
  + [Per Nixpkgs](#nixpkgs)
- [Agordo](#agordo)
- [Baza uzado](#baza)
  + [Krei dosierkopiojn](#krei)
  + [Esplori dosierkopiojn](#esplori)
  + [Rekte eltiri dosierkopiojn](#eltiri)
- [Konsiletoj](#konsiletoj)
  + [Defora dosiersistemo](#defora)
  + [Miksaĵo](#miksajxo)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Kiom da fojoj oni spertis komprenon post kiam katastrofo okazis? Kiom da fojoj oni diris al si mem,
ke se oni kreis sekurkopiojn de siaj altvaloraj datumoj, oni ne devus esti en tiu terura situacio,
eltirante sian hararon kiel rabia maniulo?

Plejmulto da ni jam spertis ĝin—ni perdis niajn altvalorajn dosierojn pro malatentecaj kaŭzoj. Ni
perdis ilin pro diskkraŝo, datuma putro, sekureca rompo, kaj aliaj kialoj. Tamen se oni kreis
retropaŝan agon—granda, sekura ŝaŭmo kie ni surteriĝas—ne estus multe da ĝeno kaj korpremo.
Aliflanke, krei kaj administri sekurkopiojn povas esti senkuraĝigaj kaj egale danĝeraj.

En ĉi tiu afiŝo, mi parolos pri
[Ugarit](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki), agrabla peco
de teĥnologio, kiu kunmiksas facilecon de uzado kaj sekurecon, en unu ilo.

Ugarit estas klasika ekzemplo de ilo, kiu postulas minimuman agordon kaj agordaĵon. Ke, kiam la
komenca alĝustigado estas farita, ĉio kion oni bezonas fari estas reuzi la ilon. Tamen, tio ne
ankoraŭ estas la ĉefforto de Ugarit—estas la preskaŭ malsankta edziĝo de oportuneco kaj sekureco.

Pleje, se ne ĉiam, oportuneco estas inverse proporcia al sekureco. Tio signifas, ke ju pli io
oportunecas, de malpli sekura ĝi estas. Per Ugarit, krei kaj administri sekurkopiojn estas tiel
facile kiel maŝinskribi mallongan komandon.


<a name="instalo">Instalo</a>
-----------------------------

### <a name="apt">Per APT:</a>

Unue, oni devas instali [Chicken](https://www.call-cc.org/). Plej verŝajne, ĝi povas esti instalita
per la pako-administrilo:

    $ sudo apt-get install chicken-bin

Se ĝi ne haveblas ĉe la sistemo, oni povas elŝuti gin el
[code.call-cc.org](https://code.call-cc.org/).

Post kiam Chicken instaliĝis, ni instalu Ugarit mem kaj ĝiajn dependecojn:

    $ chicken-install -s ugarit tiger-hash aes

Post kiam ĉi tiu komando finiĝas, la komando `ugarit` fariĝos havebla. Por montri la uzadon:

    $ ugarit -h


### <a name="nixpkgs">Per Nixpkgs</a>

Se oni uzas Nixpkgs, simple rulu la jenan komandon:

    $ nix-env -i ugarit


<a name="agordo">Agordo</a>
---------------------------

Ugarit ĉi-momente ne ankoraŭ utilas—oni bezonas precizigi kien ĝi devas enmemorigi la dosierkopiojn.
Kreante dosierkopion de dosierujo kiu havas kelke da terajbato, estas ideale por enmemorigi la
datumon ĉe rapida, fidebla, strestoleranta disko. Ne estas nekomune, ke la komando `ls` por sperti
rimarkeblan malakcelon kiam ĝi estas rulita ene datuma dosierujo. Ni supozu, ke `/dev/sdb1` estas
granda dosiersistemo kaj oni volas surmeti ĝin al `/ugarit/`.

    $ sudo mkdir /ugarit
    $ sudo mount /dev/sdb1 /ugarit
    $ sudo chown -R $USER /ugarit

Alia egale grava bezono, kiun oni devas havi estas la agordosiero, kutime nomita `ugarit.conf`. Ĝi
estas disponigita kiel parto de la bezonataj komandliniaj argumentoj. Memoru, ke kie ĉi tiu dosiero
ne loĝas en fiksita loko, kontraste kun iuj programoj kiuj serĉas agorddosieron dum la startigo.
Antaŭ oni fakte kreas tiun dosieron, oni devas ruli iujn komandojn. Konservu la eligojn de ĉi tiuj
komandoj ĉar oni bezonos ilin poste.

Krei salon por la haketfunkcio:

    $ dd if=/dev/random bs=1 count=64 2>/dev/null \
    | base64 -w 0 \
    | tail -1

Krei ŝlosilon por la kripto:

    $ dd if=/dev/random bs=32 count=1 2>/dev/null \
    | od -An -tx1 \
    | tr -d ' \t\n'

Tiujn komandojn rulinte, oni kreos la agorddosieron `ugarit.conf`. Por fari ĝin akorde kun la
supra ekzamplo, oni konservos ĝin ene `/ugarit`:

    $ emacs /ugarit/ugarit.conf

Metu la jenajn, anstaŭigante SALO kaj ŜLOSILO per la salaj kaj ŝlosilaj ĉenoj, kiun oni generis
antaŭe.

```scheme
(storage "backend-fs splitlog /ugarit /ugarit/metadata")
(file-cache "/ugarit/cache")
(hash tiger "SALO")
(encryption aes "ŜLOSILO")
(compression deflate)
```

Konservu la dosieron, tiam sekurigu ĝin.

    $ chmod 600 /ugarit/ugarit.conf


<a name="baza">Baza uzado</a>
-----------------------------

### <a name="krei"></a>Krei dosierkopiojn

Por krei dosierkopiojn, rulu:

    $ ugarit snapshot /ugarit/ugarit.conf ETIKEDO DOSIERUJO

_ETIKEDO_ estas nomo kiun oni bezonas por identigi la dosierkopion poste, kaj _DOSIERUJO_ estas la
dosiersistema arbo, kiun oni volas krei dosierkopion de. Ekzemple, por krei dosierkopion de la
dosierujo `bildoj/`, kun la etikedo `bil`, rulu Ugarit jene:

    $ ugarit snapshot /ugarit/ugarit.conf bil bildoj

Kreinte la dosierkopion, oni vidos ion kiel la jena:

```
Archiving bildoj to tag bil...
Root hash: ddc888c86db6d7c468a27cc4af9b2907d219936df82e0971
Successfully snapshotted bildoj to tag bil
Snapshot hash: ab290399f31fff1e3158c0ede8f90f59b2b41387af48f597
Written 910460 bytes to the vault in 4 blocks, and reused 0 bytes in 0 blocks
(before compression)
File cache has saved us 1 file hashings / 638104 bytes (before compression)
```


### <a name="esplori">Esplori dosierkopiojn</a>

Por interage administri la enhavojn de la kripto, rulu:

    $ ugarit explore /ugarit/ugarit.conf

Por listigi la haveblajn komandojn:

    > help

Per la konsiletoj el la helpa uzado, oni eltiros dosierujon kiu estas parto de la dosierkopio
antaŭe. Ni supozu, ke la originala vojo de tiu dosierujo estis `bildoj/festo/`. Do, por eltiri la
dosierujon `festo/` el la aktuala dosierujo, rulu:

```
> cd bil
/bil> cd current
/bil/current> cd contents
/bil/current/contents> get festo
Extracted festo
/bil/current/contents> exit
```


### <a name="eltiri">Rekte eltiri dosierkopiojn</a>

Tamen, se oni konas la ekzaktan dosierindikon de dosiero aŭ dosierujon kiun onivolas eltiri, oni
anstataŭ povas ruli Ugarit kun la eltira reĝimo. Por eltiri la dosierujon `festo/` el supre,
rekte, rulu:

    $ ugarit extract /ugarit/ugarit.conf /bil/current/contents/festo


<a name="konsiletoj">Konsiletoj</a>
-----------------------------------

### <a name="defora">Defora dosiersistemo</a>

Ugarit ne estas limigita por krei dosierkopiojn de loka dosiersistemo. Ĝi ankaŭ povas esti uzita por
krei dosierkopiojn de arboj de defora gastiganto muntita loke. Se oni ekzemple havas
[SSHFS](https://github.com/libfuse/sshfs)-surmeton, Ugarit ankoraŭ povas krei dosierkopion de tiu, same
kiel ia alia loka dosiersistemo.

    $ sshfs remotehost:/ ~/mnt/sshfs/remotehost
    $ cd ~/mnt/sshfs
    $ ugarit snapshot /ugarit/ugarit.conf remotehost

La sama estas aplikebla al [SMBFS](https://www.samba.org/samba/smbfs/)-surmetoj:

    $ sudo mount -t cifs -o user=$USER,uid=$USER //winhost/c \
    ~/mnt/smbfs/winhost/c
    $ cd ~/mnt/smbfs
    $ ugarit snapshot /ugarit/ugarit.conf winhost


### <a name="miksajxo">Miksaĵo</a>

Por malŝalti eligon kreante dosierkopiojn:

    $ ugarit snapshot /ugarit/ugarit.conf -q ...

Por ŝalti tre babileman eligon:

    $ ugarit snapshot -:a256 /ugarit/ugarit.conf ...


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Kiam oni ne fidas je la funkciado de la disko kie oni enmemorigas la dosierkopiojn, malŝalti la
locate- kaj updatedb-servojn. Kutime ĝi estas rulita per cron. Bedaŭrinde, ĝi metas multe da
ŝargo al la disko kaj eble trostresi ĝin. La sperto povas varii.

Por malŝalti tiujn servojn ĉe NixOS, aldonu la jenan al `/etc/nixos/configuration.nix`:

```nix
services.locate.enable = false;
```

Grava menciinda averto estas ke pro la maniero kiel Ugarit funkcias: ne ekzistas forviŝado de
dosierkopioj. La enmemoriga meĥanismo funkcias laŭe kiel Gito, sed ne ekzistas `rebase`-opcioj.

Ugarit estas kreita de [Alaric SNELL-PYM](http://www.snell-pym.org.uk/alaric/). Se oni volas lerni
pli da informo de la projekto, iru
[ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki). Por raporti
cimojn, iru [ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/reportlist).
