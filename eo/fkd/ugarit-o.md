Krei Sekurkopiojn Ugarit-e
==========================

<center>[Esperante](#) · [English](/en/ugarit)</center>
<center>la 18-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 19-an de Februaro 2018</center>

>Bona juĝo devenas el sperto, kaj sperto devenas el malbona juĝo.<br>
>―Fred BROOKS

Kiom da fojoj oni spertis komprenon, post katastrofo okazis? Kiom da fojoj oni diris al si mem, ke se
si kreis sekurkopiojn de siaj altvaloraj datumoj, oni ne devus esti en tiu terura situacio, eltiri
sian hararon kiel rabia maniulo?

Plejmulto da ni jam spertis ĝin—ni perdis niajn altvalorajn dosierojn pro malatentecaj kaŭzoj. Ni
perdis ilin pro diskkraŝo, datuma putro, sekureca rompo, kaj aliaj kialoj. Tamen se oni kreis
retropaŝan agon—granda, sekura ŝaŭmo kiun ni surteriĝas—ne estus multe da ĝeno kaj
korpremo. Aliflanke, krei kaj mastrumi sekurkopiojn povas esti senkuraĝigaj kaj egale danĝaj.

En ĉi tiu afiŝo, mi parolos pri
[Ugarit-o](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki), agrabla peco
de teĥnologio, kiu kunmiksas facilecon de uzado kaj sekurecon en unu ilo.


Enhavotabelo
------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
  + [Per APT-o](#apt-o)
  + [Per Nix-o](#nix-o)
- [Agordo](#agordo)
- [Baza uzado](#baza)
  + [Krei dosierkopiojn](#krei)
  + [Esplori dosierkopiojn](#esplori)
  + [Rekte eltiri dosierkopiojn](#eltiri)
- [Konsiletoj](#konsiletoj)
  + [Defora dosiersistemo](#defora)
  + [Miksaĵo](#miksaĵo)
- [Notoj](#notoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Ugarit-o estas klasika ekzemplo de ilo, kiu postulas minimuman agordon kaj agordaĵon. Ke, unu fojon
la komenca alĝustigado okazis, ĉio kion oni bezonas fari estas reuzi la ilon. Tamen, tio ne estas la
ĉefforto de Ugarit-o—estas la preskaŭ malsankta edziĝo de oportuneco kaj sekureco.

Pleje, se ne ĉiam, oportuneco estas inverse proporcie kun sekureco. Tio estas, ju pli io
oportunecas, de malpli sekura estas. Per Ugarit-o, krei kaj mastrumi sekurkopiojn estas kiel facile
tiel maŝinskribi mallongan komandon.


<a name="instalo"></a>Instalo
-----------------------------

### <a name="apt-o"></a>Per APT-o

Unue, oni devas instali je [Chicken](https://www.call-cc.org/). Plej verŝajne, povas esti instalita
per la pako-administrilo:

    $ sudo apt-get install chicken-bin

Se ne haveblas sur la sistemo, oni povas elŝuti gin el
[code.call-cc.org](https://code.call-cc.org/).

Post Chicken-o instalitas, ni instalu Ugarit-on mem kaj siajn dependecojn:

    $ chicken-install -s ugarit tiger-hash aes

Post ĉi tiu komando finiĝas, la komando `ugarit` haveblos. Por montri la uzadon:

    $ ugarit -h


### <a name="nix-o"></a>Per Nix-o

Se oni ozas Nix-on, simple kuru la jenan komandon:

    $ nix-env -i ugarit


<a name="agordo"></a>Agordo
---------------------------

Ugarit-o ĉi-momente ne ankoraŭ utilas—oni bezonas precizigi kie ĝi devas enmemorigi la
dosierkopiojn. Kiam krei dosierkopion de dosierujo kie havas kelke da terajbato, estas ideale por
enmemorigi la datumon sur rapida, fidebla, strestoleranta disko. Ne estas nekomuna por la komando
`ls` por sperti rimarkeblan malakcelon kiam kuriĝis ene datuma dosierujo. Ni supozu, ke
`/dev/sdb1` estas granda dosiersistemo kaj oni volas surmeti ĝin al `/ugarit/`.

    $ sudo mkdir /ugarit
    $ sudo mount /dev/sdb1 /ugarit
    $ sudo chown -R $USER /ugarit

Alia egale grava bezono, kiun oni devas havi estas ĝia agordosiero, kutime nomita
`ugarit.conf`. Estas provizite kiel parto de l’ bezonataj komandliniaj argumentoj. Tenu en la
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

Post kuri tiujn komandojn, oni kreos la agorddosieron, `ugarit.conf`. Por fari ĝin akorde kun la
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

Por krei dosierkopiojn, kuru:

    $ ugarit snapshot /ugarit/ugarit.conf ETIKEDO DOSIERUJO

_ETIKEDO_ estas nomo kiu oni bezonas identigi la dosierkopion poste, dum _DOSIERUJO_ estas la
dosiersistema arbo, kiun oni volas krei dosierkopion pri. Por krei ekzemple dosierkopion de l’
dosierujo `bildoj/`, kun la etikedo `bil`, kuru Ugarit-on jene:

    $ ugarit snapshot /ugarit/ugarit.conf bil bildoj

Post krei la dosierkopion, oni vidos ion kiel la jena:

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

Por interage mastrumi la enhavojn de l’ kripto, kuru:

    $ ugarit explore /ugarit/ugarit.conf

Por listigi la haveblajn komandojn:

    > help

Per la konsiletoj el la helpa uzado, oni eltiros dosierujon kiu estas parto de l’ dosierkopio
antaŭe. Ni supozu, ke la originala vojo de tiu dosierujo estis `bildoj/festo/`. Do, por eltiri la
dosierujon `festo/` al la nuna dosierujo, kuru:

```
> cd bil
/bil> cd current
/bil/current> cd contents
/bil/current/contents> get festo
Extracted festo
/bil/current/contents> exit
```


### <a name="eltiri"></a>Rekte eltiri dosierkopiojn

Tamen, se oni konas la ekzaktan dosierindikon de dosiero aŭ dosierujon kiun si volas eltiri, oni
povas anstataŭ kuras Ugarit-on kun la eltira reĝimo. Por eltiri la dosierujon `festo/` el supre,
rekte, kuru:

    $ ugarit extract /ugarit/ugarit.conf /bil/current/contents/festo


<a name="konsiletoj"></a>Konsiletoj
-----------------------------------

### <a name="defora"></a>Defora dosiersistemo

Ugarit-o ne limigitas por krei dosierkopiojn de loka dosiersistemo. Ankaŭ povas uzita por krei
dosierkopiojn de arboj de defora gastiganto muntita loke. Se oni ekzemple havas
[SSHFS-an](https://fuse.sourceforge.net/sshfs.html) surmeton, si ankoraŭ povas krei dosierkopion de
tiu, same kiel ia alia loka dosiersistemo.

    $ sshfs remotehost:/ ~/mnt/sshfs/remotehost
    $ cd ~/mnt/sshfs
    $ ugarit snapshot /ugarit/ugarit.conf remotehost

La samo aplikatas al [SMBFS-aj](https://www.samba.org/samba/smbfs/) surmetoj:

    $ sudo mount -t cifs -o user=$USER,uid=$USER //winhost/c \
    ~/mnt/smbfs/winhost/c
    $ cd ~/mnt/smbfs
    $ ugarit snapshot /ugarit/ugarit.conf winhost


### <a name="miksaĵo"></a>Miksaĵo

Por malŝalti eligon kiam krei dosierkopiojn:

    $ ugarit snapshot /ugarit/ugarit.conf -q ...

Por ŝalti tre babileman eligon:

    $ ugarit snapshot -:a256 /ugarit/ugarit.conf ...


<a name="notoj"></a>Notoj
-------------------------

Kiam ne fidas la rendimenton de l’ disko kie oni enmemorigas la dosierkopiojn, malŝalti la
[locate-ajn kaj updatedb-ajn](http://linux.about.com/od/commands/fl/updatedb-Linux-Command-Unix-Command.htm)
servojn. Estas kutime periode kuradi per cron-o. Metas multe da ŝarĝo sur la disko kaj eble
trostresi ĝin. La sperto povas varii.

Por malŝalti tiujn servojn sur NixOS, aldonu la jenajn al `/etc/nixos/configuration.nix`:

```nix
services.locate.enable = false;
```

Grava averto menciinda estas ke pro l’ maniero kiel Ugarit-o funkcias, ne ekzistas forviŝi de
dosierkopioj. La enmemoriga meĥanismo funkcias laŭe kiel Gito, nur tio ne ekzistas `rebase`-aj
opcioj.

Ugarit-o estas kreita de [Alaric Snell-Pym](http://www.snell-pym.org.uk/alaric/). Se oni volas lerni
pli da informo de projekto, iru [ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki).
Por raporti cimojn, iru [ĉi tien](https://www.kitten-technologies.co.uk/project/ugarit/reportlist).
