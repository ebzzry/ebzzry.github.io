Sekurkopiojn Krei per Ugarit
============================

<div class="center">Esperanto · [English](/en/ugarit/)</div>
<div class="center">la 18-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 9-an de marto 2019</div>

>Bona juĝo devenas el sperto, kaj sperto devenas el malbona juĝo.<br>
>―Fred BROOKS

Kiom da fojoj oni spertis komprenon, post kiam katastrofo okazis? Kiom da fojoj oni diris al si mem,
ke se oni kreis sekurkopiojn de siaj altvaloraj datumoj, oni ne devus esti en tiu terura situacio,
eltirante sian hararon kiel rabia maniulo?

Plejmulto da ni jam spertis ĝin—ni perdis niajn altvalorajn dosierojn pro malatentecaj kaŭzoj. Ni
perdis ilin pro diskkraŝo, datuma putro, sekureca rompo, kaj aliaj kialoj. Tamen se oni kreis
retropaŝan agon—granda, sekura ŝaŭmo kiun ni surteriĝas—ne estus multe da ĝeno kaj
korpremo. Aliflanke, krei kaj mastrumi sekurkopiojn povas esti senkuraĝigaj kaj egale danĝaj.

En ĉi tiu afiŝo, mi parolos pri
[Ugarit](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki), agrabla peco
de teĥnologio, kiu kunmiksas facilecon de uzado kaj sekurecon en unu ilo.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
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


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Ugarit estas klasika ekzemplo de ilo, kiu postulas minimuman agordon kaj agordaĵon. Ke, unu fojon
la komenca alĝustigado okazis, ĉio kion oni bezonas fari estas reuzi la ilon. Tamen, tio ne estas la
ĉefforto de Ugarit—estas la preskaŭ malsankta edziĝo de oportuneco kaj sekureco.

Pleje, se ne ĉiam, oportuneco estas inverse proporcie kun sekureco. Tio estas, ju pli io
oportunecas, de malpli sekura estas. Per Ugarit, krei kaj mastrumi sekurkopiojn estas kiel facile
tiel maŝinskribi mallongan komandon.


<a name="instalo"></a>Instalo
-----------------------------

### <a name="apt"></a>Per APT:

Unue, oni devas instali je [Chicken](https://www.call-cc.org/). Plej verŝajne, povas esti instalita
per la pako-administrilo:

    $ sudo apt-get install chicken-bin

Se ne haveblas sur la sistemo, oni povas elŝuti gin el
[code.call-cc.org](https://code.call-cc.org/).

Post kiam Chicken instalitas, ni instalu je Ugarit mem kaj ĝiajn dependecojn:

    $ chicken-install -s ugarit tiger-hash aes

Post kiam ĉi tiu komando finiĝas, la komando `ugarit` haveblos. Por montri la uzadon:

    $ ugarit -h


### <a name="nixpkgs"></a>Per Nixpkgs

Se oni uzas je Nixpkgs, simple plenumu la jenan komandon:

    $ nix-env -i ugarit


<a name="agordo"></a>Agordo
---------------------------

Ugarit ĉi-momente ne ankoraŭ utilas—oni bezonas precizigi kie ĝi devas enmemorigi la
dosierkopiojn. Kiam krei dosierkopion de dosierujo kie havas kelke da terajbato, estas ideale por
enmemorigi la datumon sur rapida, fidebla, strestoleranta disko. Ne estas nekomuna por la komando
`ls` por sperti rimarkeblan malakcelon kiam kuriĝis ene datuma dosierujo. Ni supozu, ke
`/dev/sdb1` estas granda dosiersistemo kaj oni volas surmeti ĝin al `/ugarit/`.

    $ sudo mkdir /ugarit
    $ sudo mount /dev/sdb1 /ugarit
    $ sudo chown -R $USER /ugarit

Alia egale grava bezono, kiun oni devas havi estas ĝia agordosiero, kutime nomita
`ugarit.conf`. Estas disponigite kiel parto de la bezonataj komandliniaj argumentoj. Tenu en la
kalkulo, kie ĉi tiu dosiero ne loĝas en fiksita loko, kontraste kun iuj programoj kiu serĉas
agorddosieron dum startigo. Antaŭ oni fakte kreas tiun dosieron, oni bezonas kuri iujn
komandojn. Konservu la eligojn de ĉi tiuj komandoj ĉar oni bezonados ilin poste.

Kreu salon por la haketfunkcio:

    $ dd if=/dev/random bs=1 count=64 2>/dev/null \
    | base64 -w 0 \
    | tail -1

Kreu ŝlosilon por la kripto:

    $ dd if=/dev/random bs=32 count=1 2>/dev/null \
    | od -An -tx1 \
    | tr -d ' \t\n'

Tiujn komandojn kurinte, oni kreos la agorddosieron, `ugarit.conf`. Por fari ĝin akorde kun la
supra ekzamplo, oni konservos ĝin ene `/ugarit`:

    $ emacs /ugarit/ugarit.conf

Metu la jenajn, anstaŭigi SALO kaj ŜLOSILO per la salaj kaj ŝlosilaj ĉenoj, kiun oni generis
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


<a name="baza"></a>Baza uzado
-----------------------------

### <a name="krei"></a>Krei dosierkopiojn

Por krei dosierkopiojn, plenumu:

    $ ugarit snapshot /ugarit/ugarit.conf ETIKEDO DOSIERUJO

_ETIKEDO_ estas nomo kiu oni bezonas identigi la dosierkopion poste, dum _DOSIERUJO_ estas la
dosiersistema arbo, kiun oni volas krei dosierkopion pri. Por krei ekzemple dosierkopion de la
dosierujo `bildoj/`, kun la etikedo `bil`, plenumu je Ugarit jene:

    $ ugarit snapshot /ugarit/ugarit.conf bil bildoj

La dosierkopion kreinte, oni vidos ion kiel la jena:

```
Archiving bildoj to tag bil...
Root hash: ddc888c86db6d7c468a27cc4af9b2907d219936df82e0971
Successfully snapshotted bildoj to tag bil
Snapshot hash: ab290399f31fff1e3158c0ede8f90f59b2b41387af48f597
Written 910460 bytes to the vault in 4 blocks, and reused 0 bytes in 0 blocks
(before compression)
File cache has saved us 1 file hashings / 638104 bytes (before compression)
```


### <a name="esplori"></a>Esplori dosierkopiojn

Por interage mastrumi la enhavojn de la kripto, plenumu:

    $ ugarit explore /ugarit/ugarit.conf

Por listigi la haveblajn komandojn:

    > help

Per la konsiletoj el la helpa uzado, oni eltiros dosierujon kiu estas parto de la dosierkopio
antaŭe. Ni supozu, ke la originala vojo de tiu dosierujo estis `bildoj/festo/`. Do, por eltiri la
dosierujon `festo/` al la aktuala dosierujo, plenumu:

```
> cd bil
/bil> cd current
/bil/current> cd contents
/bil/current/contents> get festo
Extracted festo
/bil/current/contents> exit
```


### <a name="eltiri"></a>Rekte eltiri dosierkopiojn

Tamen, se oni konas la ekzaktan dosierindikon de dosiero aŭ dosierujon kiun ĝi volas eltiri, oni
povas anstataŭ kuras je Ugarit kun la eltira reĝimo. Por eltiri la dosierujon `festo/` el supre,
rekte, plenumu:

    $ ugarit extract /ugarit/ugarit.conf /bil/current/contents/festo


<a name="konsiletoj"></a>Konsiletoj
-----------------------------------

### <a name="defora"></a>Defora dosiersistemo

Ugarit ne limigitas krei dosierkopiojn de loka dosiersistemo. Ankaŭ povas uzita krei
dosierkopiojn de arboj de defora gastiganto muntita loke. Se oni ekzemple havas je
[SSHFS](https://github.com/libfuse/sshfs)-surmeton, ĝi ankoraŭ povas krei dosierkopion de
tiu, same kiel ia alia loka dosiersistemo.

    $ sshfs remotehost:/ ~/mnt/sshfs/remotehost
    $ cd ~/mnt/sshfs
    $ ugarit snapshot /ugarit/ugarit.conf remotehost

La samo aplikatas al [SMBFS](https://www.samba.org/samba/smbfs/)-surmetoj:

    $ sudo mount -t cifs -o user=$USER,uid=$USER //winhost/c \
    ~/mnt/smbfs/winhost/c
    $ cd ~/mnt/smbfs
    $ ugarit snapshot /ugarit/ugarit.conf winhost


### <a name="miksajxo"></a>Miksaĵo

Por malŝalti eligon kiam krei dosierkopiojn:

    $ ugarit snapshot /ugarit/ugarit.conf -q ...

Por ŝalti tre babileman eligon:

    $ ugarit snapshot -:a256 /ugarit/ugarit.conf ...


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Kiam oni ne fidas al la funkciado de la disko kie oni enmemorigas la dosierkopiojn, malŝalti la
[locate- kaj updatedb-](http://linux.about.com/od/commands/fl/updatedb-Linux-Command-Unix-Command.htm)servojn. Estas kutime periode plenumis per cron. Metas multe da ŝarĝo sur la disko kaj eble
trostresi ĝin. La sperto povas varii.

Por malŝalti tiujn servojn sur NixOS, aldonu la jenan al `/etc/nixos/configuration.nix`:

```nix
services.locate.enable = false;
```

Grava averto menciinda estas ke pro la maniero kiel Ugarit funkcias, ne ekzistas forviŝi de
dosierkopioj. La enmemoriga meĥanismo funkcias laŭe kiel Gito, nur tio ne ekzistas `rebase`-opcioj.

Ugarit estas kreita de [Alaric Snell-Pym](http://www.snell-pym.org.uk/alaric/). Se oni volas lerni
pli da informo de projekto, iru [ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki).
Por raporti cimojn, iru [ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/reportlist).
