Agordi na GPG kaj na SSH en KDE
===============================

<div class="center">Esperanto ▪ [English](/en/gsk/)</div>
<div class="center">la 19-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 14-an de Aŭgusto 2019</div>

>Ne tute estas grave por prave atingi tion en la unua fojo. Estas vitale grava atingi tion en la
>lasta tempo.<br>
>―Andrew HUNT kaj David THOMAS

Kiam kaj GPG kaj SSH bone enkonstruitas kun KDE, estas facile por kunoperacii tiujn
sistemojn. Estas kontrasto inter malfirme adaptita ganto kaj tiu, kiu tre bone adaptiĝas.

Ĉi tiu mallonga gvidilo traktos la paŝojn kiel fari tion. Por gastigi ĉiujn, mi ankoraŭ diskutos
kiel instali kaj agordi la bezonatajn komponantojn. Ni uzos na [nano](https://www.nano-editor.org/)
por ĉi tiu seanco, tamen oni liberas uzi ian redaktilon.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Postuloj](#postuloj)
- [Agordi na SSH](#ssh)
- [Agordi na GPG](#gpg)
- [Agordi na KDE](#kde)
- [Kontrolo](#kontrolo)
- [Finrimarkoj](#finrimarkoj)


<a name="postuloj"></a>Postuloj
-------------------------------

Por ĉi tiu gvidilo, oni bezonas havi na GPG, na SSH, kaj na Pinentry.

Per Nixpkgs:

    $ nix-env -i gnupg openssh pinentry

Per APT:

    $ sudo apt-get install gnupg2 ssh pinentry-qt4

Per DNF:

    $ sudo dnf install gnupg openssh pinentry


<a name="ssh"></a>Agordi na SSH
-------------------------------

Nu, nun oni havas la partojn antaŭ ĝi, estas tempo por munti la komponantojn. La unua afero kiun oni
bezonas fari—kvankam vere la dosieroj kiun oni bezonas malfermi povas esti farita en ia ordo kiun oni
volas—estas krei siajn sekurŝelajn ŝlosilojn:

    $ ssh-keygen -t ed25519

NE ENIGU malplenan pasfrazon. Se oni insistas, pafu la kapon.

La supra komando kreos du dosierojn:

    ~/.ssh/id_ed25519.pub
    ~/.ssh/id_ed25519

Tiam, permesu la mem sur la defora servilo, por ke la senpasvortaj ensalutoj funkciu poste:

    $ ssh-copy-id uzanto@deforgastiganto


<a name="gpg"></a>Agordi na GPG
-------------------------------

Sekve, oni bezonas krei siajn GPG-ŝlosilojn. Observu la invitojn, kiuj aperas, certigi ke oni
elektas la plej fortajn opciojn:

    $ gpg2 --gen-key

Se oni volas uzi pli bonajn pasfrazojn, uzu
[dajsvaron](http://world.std.com/~reinhold/diceware.html). XKCD-bildstrio kreitas pro tio.

La sekva afero por fari estas por redakti la ĉefan GPG-agorddosieron:

    $ nano ~/.gnupg/gpg.conf

Trovu la linion kiu enhavas `use-agent` kaj malkomentigu ĝin, se ĝi estas komentigita. Se tiu linio
ne ekzistas, simple metu `use agent` ĉe la fino de tiu dosiero.

Tiam, oni bezonas redakti la perilan dosieron:

    $ nano ~/.gnupg/gpg-agent.conf

Metu la jenan kodaĵon:

    no-grab
    default-cache-ttl 10800
    default-cache-ttl-ssh 10800
    pinentry-program /usr/bin/pinentry-qt4

Anstataŭigu la valoron de `pinentry-program` per la efektiva dosierindiko de pinentry sur la
sistemo. Por precizigi la lokon de pinentry-o, plenumu:

    $ which pinentry-qt4


<a name="kde"></a>Agordi na KDE
-------------------------------

Oni nun bezonas ligi la GPG-perilon al KDE. Oni bezonas krei startigan skripton por KDE, kiu
alvokos la GPG-perilon dum startigo. Oni ankaŭ bezonas diri al la GPG-perilo por ŝalti SSH-apogon.

    $ mkdir ~/.kde/env
    $ nano ~/.kde/env/01_gpg-agent.sh

Tiam metu la jenan kodaĵon:

```bash
#!/usr/bin/env bash

killall gpg-agent
eval `gpg-agent --enable-ssh-support --daemon`
```

Faru ĝin plenumebla:

    $ chmod +x ~/.kde/env/01_gpg-agent.sh

Fine, kreu la sistemferman skripton por la GPG-perilo:

    $ mkdir ~/.kde/shutdown
    $ nano ~/.kde/shutdown/01_gpg-agent.sh

Tiam metu la jenan kodaĵon:

```bash
#!/bin/sh

killall gpg-agent
```

Ne forgesu por fari ĝin plenumebla:

    $ chmod +x ~/.kde/shutdown/01_gpg-agent.sh


<a name="kontrolo"></a>Kontrolo
-------------------------------

Bedaŭrinde, oni bezonas reŝargi la KDE-seancon, por ke ĉi tiuj agordaĵoj efektiviĝu. Se oni konas
metodon kiu ne bezonas reŝargi la seancon, avizu min, mi petas.

Premu <kbd>Ctrl+Alt+Del</kbd> por elsaluti, tiam ensalutu al la konto:

Malfermu Konsole-fenestron, tiam konektu al la plej ŝatata SSH-servilo:

    $ ssh uzanto@deforgastiganto

Aperas pinentry-dialogujo demandi onin por ĝia pasfrazo. Ĉi tiu pasfrazo estos kaŝmemorigita laŭ
la agordoj en `~/.gnupg/gpg-agent.conf`. Sekvaj SSH-konektaj klopodoj ne plu demandos la
uzanton por la pasfrazon ene la tempolima periodo:

Okazos samspeca agmaniero se oni ĉifras dosieron GPG-e:

    $ gpg2 -sea -r john@foo.bar file.dat


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

La paŝoj parolis supre estis intencitaj por esti mallongaj sen priparoli la malsimplajn
detalojn. Mi esperas ke oni trovis ĉi tiun utila.

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
