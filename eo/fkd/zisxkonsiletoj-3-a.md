Ziŝaj Konsiletoj 3-a: Ŝanĝradikighelpiloj
=========================================

<div class="center">Esperanto ▪ [English](/en/zsh-tips-3/)</div>
<div class="center">Laste ĝisdatigita: la 4-an de Marto 2022</div>

>Ni ridas pri tio, kion ni ne povas toleri por alfronti.<br>
>―Aristotelo

Teĥnologioj kiel Dakero, *QEMU*, kaj *VirtualBox* estas bonegaj iloj kiam
procezojn oni volas plenumi aparte de la gastiga sistemo. Tute izolitajn mediojn
ĉi tiuj teĥnikoj provizas al ni kiuj la reprodukteblecon de kodo plifaciligas
testi. Tamen, estas okazoj en kiu ĉi tiuj solvoj tro pezas, kaj ion malplipezan
ni bezonas. Eniras ŝanĝradikigado. Male al siaj pliplezaj amikoj, ŝanĝradikigado
sidas ie proksima al la dosiersistemo, kie la risurcojn de la medio kiun ĝin
alvokas ĝi povas facile aliri.

En ĉi tiu artikolo, mi parolos kiel ŝanĝradikigmedion agordi en linukso per ziŝo. Teĥnike, ĉi tio
estas kunmeto de diskutoj pri ŝelo kaj sistemadministrado, sed pro kapablojn kiuj estas ekskluzivaj
al ziŝo mi uzas—aŭ alie malfacila por fari en aliaj ŝeloj—tiun paĝtitolon mi uzis.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Antaŭkondiĉoj](#antauxkondicxoj)
- [Instalo](#instalo)
- [Agordo](#agordo)
- [La komandojn difini](#komandoj)
- [Elprovado](#elprovado)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Kelkfoje komandojn de aliaj sistemoj mi bezonas rapide plenumi, ekzemple, de Ubunto, por ke mian
programaron mi povu testi, kun daŭra konservaj mekanismoj kaj aliro al sistemduumdosieroj. Aliaj
opcioj estas laborintensivaj kaj la taskojn mi povas kuri rapide, kaj nun.


<a name="antauxkondicxoj"></a>Antaŭkondiĉoj
-------------------------------------------

Por la efektivan disan medion krei, manieron por ĝin elŝuti kaj instali ĉe la disko ni
bezonas. Por tion fari, je Bootstrap ni bezonas.

Per Nixpkgs:

    % nix-env -i debootstrap

Per APT:

    % sudo apt-get install -y debootstrap

Por la aferojn fluigi, la saman uzantnomon kaj uzantnumeron de la gasgita sistemo ni uzos:

    % id -un; id -u


<a name="instalo"></a>Instalo
-----------------------------

Unue la celan dosierujon ni kreu:

    % sudo mkdir -p /home/chrt/ubuntu

Sekve, ni diru al debootstrap, ke specifan ubuntan distribuon ĝi devas instali:

    % sudo debootstrap xenial /home/chrt/ubuntu http://archive.ubuntu.com/ubuntu

Kiam ĝi finis kuri, la bindsurmetojn de la sistemo al la cela sistemo ni devas krei:

    % sudo mount --bind /proc /home/chrt/ubuntu/proc
    % sudo mount --bind /sys /home/chrt/ubuntu/sys
    % sudo mount --bind /tmp /home/chrt/ubuntu/tmp
    % sudo mount --bind /home /home/chrt/ubuntu/home
    % sudo mount --bind /dev /home/chrt/ubuntu/dev
    % sudo mount --bind /dev/pts /home/chrt/ubuntu/dev/pts


<a name="agordo"></a>Agordo
---------------------------

Por ke la ŝanĝradikigmedio funkciu ĝuste, enen ni devas iri kaj ŝanĝojn fari:

    % sudo chroot /home/chrt/ubuntu

En ĉi tiu punkto, oni estas ensalutita kiel la ĉefuzanto per Baŝo. Kelkajn ilojn ni instalu:

    # apt-get install -y zsh sudo

Tiam la ŝanĝradikigmedian specifan konton ni kreu. Ĝin ni devas akordigi al tiu, kiun oni nune
uzas. Ni supozu, ke la aktuala uzantnomo estas `vakelo` kun la uzantnumero `1000`.

    # useradd -u 1000 -m vakelo
    # passwd vakelo

Tiam, la uzanton `vakelo` ni aligu parto de la `sudo` grupo:

    # usermod -aG sudo vakelo

Tiam, ni diru al *sudo*, ke nin ĝi ne devas invitigi por la pasvorto. Por tion fari, je `visudo` ni
devas uzi:

    # visudo

*Visudo* estas agrabla kovrilo por la sudo-agorddosieron redakti tial, ke okaze erarojn ni faris,
nin ĝi informos pri tio, kaj ne pluigas kun la ŝanĝoj, invitante al ni por ĝin ripari.  Por nia
kazo, ni devas instrui al *sudo*, ke la inviton por la pasvorto ni ne bezonas. La jenan linion
ŝanĝu:

    %sudo   ALL=(ALL:ALL) ALL

al

    %sudo   ALL=(ALL:ALL) NOPASSWD: ALL

La redaktilon fermu. Post tio, ankaŭ eliru de la ŝanĝradikigmedio:

    # exit


<a name="komandoj"></a>La komandojn difini
------------------------------------------

De nun ni estas reen ĉe la gastiga maŝino. La komandojn kiuj estas efektive uzitaj por interagi al
la ŝanĝradikigmedio ni devas difini. La dosieron `~/.zshenv` ni malfermu per la redaktilo, tiam la
jenan metu:

```bash
CHROOT=/home/chrt/ubuntu

function crmount () {
  for i (proc sys tmp home dev) {
    if [[ ! -d $1/$i ]]; then
      mkdir -p $1/$i
    fi

    sudo mount --bind /$i $1/$i
  }

  sudo mount --bind /dev/pts $1/dev/pts
}

function crumount () {
  for i (proc sys tmp home dev) {
    sudo umount -fl $1/$i
  }
}

function crm () {
  crmount $1
}

function cru () {
  crumount $CHROOT 2> /dev/null
}

function crch () {
  sudo chroot $@
}

function crr () {
  if ! mount | grep -q $1; then
    crm $1
  fi

  crch $1 ${argv[2,-1]}
}

function crs () {
  crr $1 /usr/bin/sudo -i -u $USER ${argv[2,-1]}
}

function cre () {
  if [[ -e $CHROOT ]]; then
      crs $CHROOT $@
  fi
}

function cr () {
  if (( ! $#@ )); then
      cr ${${SHELL:t}:-sh}
  else
    cre zsh -c "cd \"$PWD\"; exec $*"
  fi
}
```

La ŝanĝojn konservu, tiam la redaktilon fermu. Post tio, novan ŝelon plenumu por ke la novaj komandoj
estu legitaj de la startiga dosiero.


<a name="elprovado"></a>Elprovado
---------------------------------

La daton el la ŝanĝradikigmedio ni akiru:

    % cr date

La daton de la uname-komando ni ankaŭ vidu:

    % cr uname -a

Je `cr` oni ankaŭ povas plenumi por eniri al ŝelo:

    % cr

Ene ĉi tiu ŝelo, aliron al la ekstermedio la aktuala medio havas, inkluzive la hejmdosierujon. Ĉi
tio ebligas onin por instali apojn kiuj povas aliri la datumon en la gastiga maŝina medio.

Se la ŝanĝradikigmedion oni volas malŝalti eksplicite, plenumu:

    % cru


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Medion havante por programojn testi kaj programojn plenumi kiuj estas ekskluzivaj al tiu platformo,
en malpli peza medio, certe estas helpema aldono.
