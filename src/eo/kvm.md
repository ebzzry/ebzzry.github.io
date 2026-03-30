---
title: Virtualigado en Linukso per KVM
keywords: kvm, qemu, linukso, virtualigado 
image: https://ebzzry.com/images/site/pierre-chatel-innocenti-N6Hx4HT4mHg-unsplash-2000x1125.jpg
---
Virtualigado en Linukso per KVM
===============================

<div class="center">2018-09-09</div>

>Se oni faras tion, kion oni ĉiam faras; oni akiros tion , kion oni ĉiam akiras.<br>
>—Anthony ROBBINS

<img src="/images/site/pierre-chatel-innocenti-N6Hx4HT4mHg-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Agordaĵo](#agordajxo)
  + [Aparataro](#aparataro)
  + [Programaro](#programaro)
- [Agordo](#agordo)
  + [Bildoj](#bildoj)
  + [KVM-grupo](#grupo)
  + [Retkonektado](#retkonektado)
- [Rulo](#rulo)
  + [La bildon ŝargi](#sxargu)
  + [Konekti al la SPICE-ekrano](#ekrano)
  + [La gastan reton agordi](#gastareto)
- [La kurtenojn fermi](#kurtenoj)
  + [La retkonektadon restaŭri](#restauxri)
- [Ĉion kolekti](#cxio)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Plejmulto da ni konas la [tutvirtualigadajn](https://en.wikipedia.org/wiki/Full_virtualization)
solvojn kiel *VMware Workstation*, *Oracle VirtualBox*, kaj *Parallels*. En ĉi tiu afiŝo, mi
reenkondukos al oni alian metodon por aferojn fari.

La dolarsigno ($) uziĝos por indiki la ŝelan inviton de normuzanto, dum la kradsigno (#) uziĝos por
indiki la ŝelan inviton de la ĉefuzanto. Estas fojoj kiam la
[EUID](https://en.wikipedia.org/wiki/User_identifier#Effective_user_ID) de komando estos nulo (0)
pro la uzado de *sudo*.


<a name="agordajxo">Agordaĵo</a>
--------------------------------


### <a name="aparataro">Aparataro</a>

Unu el la plej unuaj aferoj kiujn oni devas fari estas ŝalti la [aparataro-asistitan
virtualigadon](https://en.wikipedia.org/wiki/Hardware-assisted_virtualization), ankaŭ nomiĝas
plirapigita virtualigado, ĉe la aparataro. Se la ĉefprocezilo estis kreita antaŭ 2006, plej
verŝajne, ĉi tiu kapablo ne ĉeestas en la ico. Ankaŭ, memoru, ke ĉi tiu paŝo ne estas devigita por
uzi iujn ajn kapablojn en ĉi tiu afiŝo, tamen ĝi _atentinde_plirapidigos la aferojn.

Por ŝalti plirapigitan virtualigadon, iru al la BIOS/UEFI-agordoj, kaj trovu la tenilon por ĉi tiun
kapablon. La nomo de ĉi tiu kapablo malsamas inter fabrikanto al fabrikanto. Konservu la agordon,
tiam la sistemon reŝargu. Tiam, oni nun povas verigi la kapablon komandlinie.

    $ egrep '(vmx|svm)' /proc/cpuinfo

Se ĝi revenigas kelkajn tekstojn, oni pretas.


### <a name="programaro">Programaro</a>

Sekve, oni devas instali la havendajn apojn:

Nix:

    $ nix-env -i qemu vde2 spice_gtk

APT:

    $ sudo apt-get install -y qemu-kvm vde2 spice-client-gtk

Ĉi tiu instalas la [QEMU](http://wiki.qemu-project.org/Main_Page)-hiperregilon, la
[VDE](http://vde.sourceforge.net/)-ilojn, kaj [SPICE](http://www.spice-space.org/)-subtenon. QEMU,
almenaŭ dum siaj fruaj tagoj ne estis impresa—ĝi estis bona, sed ne bonegas. Ekde versio 0.10.1,
QEMU komencis subteni [KVM](http://www.linux-kvm.org/)-kapablojn—virtualigada subsistemo por
linukso—kiu preskaŭ disponigas denaskan virtualigadon per aparataro-asistita virtualigado. Ĝi eĉ
konkurigas la ekonomiojn de la aliaj virtualigadaj sistemoj menciitaj ĉi-supre.

Aliaj aplikaĵaroj ofertas la opcion de konekti al la gasta maŝina ekrano per
[VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) . Bedaŭrinde, ĝi malrapidas kaj
malviglas. La respondtempo teruras. Uzi la [SPICE](http://www.spice-space.org/)-protokolon, ne
nur plirapidigas la aferojn, ĝi ankaŭ ebligas aliajn aferojn. Memoru, ke SPICE ne estas anstataŭaĵo
por VNC, anstataŭe, ĝi estas alia maniero por renkonti la celojn.


<a name="agordo">Agordo</a>
---------------------------

### <a name="bildoj">Bildoj</a>

QEMU subtenas tabelon de bildaj tipoj, tamen la [QCOW2](https://en.wikipedia.org/wiki/Qcow)-formato
estas la plej fleksebla, kaj kapable riĉas, por la uzado de QEMU.

Oni havas se ekzistantan VirtualBox-dosieron (VDI), oni povas konverti ĝin al QCOW2 per:

    $ qemu-img convert -f vdi -O qcow2 vm.vdi vm.qcow2

Tamen, se oni ne jam havas bildon, oni povas krei ĝin per:

    $ qemu-img create -f qcow2 vm.qcow2 20G

La lasta paŝo kreas 20GiB-bildon, kiu nomiĝas `vm.qcow2`. Memoru, ke la dosiersufikso
ne fakte gravas—oni povas nomigi la bildon kiel `index.html`, tamen tio ne estus sencema, ĉu ne? 😄


### <a name="grupo">KVM-grupo</a>

La komandoj ĉi-sube postulas, ke grupo nomiĝas `kvm` devas ekzisti kaj oni estas ano de tiu
grupo. Por efektivigi tion, rulu la jenajn komandojn:

    $ sudo groupadd kvm
    $ sudo usermod -G $(groups | sed 's/ /,/g'),kvm $USER
    $ newgrp kvm

La lasta komando varbas onin al la grupo `KVM ` grupo senelsalutante el la seanco.


### <a name="retkonektado">Retkonektado</a>

QEMU subtenas [multajn manierojn](http://wiki.qemu-project.org/Documentation/Networking) por
agordi retkonektadon por siaj gastoj, tamen por ĉi tiu afiŝo ni uzos nur VDE.

Oni devas ruli kelkajn komandojn por pretigi la retan medion. Ideale, oni volas konservi la
komandojn en ŝela funkcio aŭ skripto:

    $ sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
    $ sudo ip addr add 10.0.2.1/24 dev tap0
    $ sudo ip link set dev tap0 up
    $ sudo sysctl -w net.ipv4.ip_forward=1
    $ sudo iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j MASQUERADE

La ĉi-supraj komandoj:

1. Kreos la VDE-aparaton kreos;
2. Agordos la TCP/IP-opciojn por tiu aparato;
3. Ŝaltos la VDE-aparaton;
4. Ŝaltos La paketan plusendadon en la gastiga sistemo; kaj
5. Agordos la enkursigan agordon.


<a name="rulo">Rulo</a>
-----------------------------


### <a name="sxargu">La bildon ŝargi</a>

Oni nun devas alvoki la komandon `qemu-kvm`—la komando kiu lanĉas ĉion. La nomo de la komando eble
malsamas kun tiu, kiu instaliĝas ĉe la sistemo.

Se oni instalas operaciumon el praŝargebla bildo—kutime la ISO-dosiero—rulu la jenajn komandojn:

    $ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
    -net vde -soundhw all -vga qxl \
    -spice port=9999,addr=127.0.0.1,password=sekretŝlosilo \
    -boot once=d -cdrom installer.iso \
    vm.qcow2

Por sekvaj uzadoj:

    $ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
    -net vde -soundhw all -vga qxl \
    -spice port=9999,addr=127.0.0.1,password=sekretŝlosilo \
    vm.qcow2

Ni malkomponu tiun:

    -cpu host

Uzu la KVM-procezilon, per ĉiom da subtenitaj kapabloj.

    -m 2G

Asignu 2GiB de gastiga maŝino por la gasto. Adaptu, kiel necese.

    -net nic,model=virtio -net vde

Kreu virtualan NIC-adaptilo, kaj ŝaltu VDE-retkonektadon.

    -soundhw all

Ŝaltu ĉiomajn aŭdiajn pelilojn.

    -vga qxl

Precizigu la videan adaptilon por imiti. Uzu QXL kiam uzi SPICE.

    -spice addr=127.0.0.1,port=9999,password=sekretŝlosilo

Precizigu la opciojn por SPICE, apartigitaj per komoj. _addr_ kaj _port_ estas la IP-adreso kaj
TCP-pordo kiujn SPICE aŭskultos. Ideale, aliro al tiu pordo devas esti ĝuste agordita, kaj
sekurigita. _password_ etas la ŝlosilo, kiu estis uzota de la SPICE-kliento, _spicy_, por konekti al
la gasta ekrano poste.

    -boot once=d -cdrom instalilo.iso

Praŝargu komence el `instalilo.iso`, tiam por sekvontaj praŝargoj, praŝargu per la kutima ordo.

Kurante la _qemu-kvm_-komandon ĉi-supre, ŝargiĝos la bildon, tamen oni ne ankoraŭ povas vidi la
ekranon.


### <a name="ekrano">Konekti al la SPICE-ekrano</a>

Por ke oni povu uzi la gastan ekranon, oni devas konekti al la SPICE-servilo, per la SPICE-kliento:

    $ spicy -h 127.0.0.1 -p 9999 -w sekretŝlosilo

Memoru, ke fermi la spicy-fenestron ne mortigos la QEMU-seancon. Se la gasta operaciumo kaptas la
musenigon, premu <kbd>Shift+F12</kbd> por eskapi.


### <a name="gastareto">La gastan reton agordi</a>

Sekve, oni devas ĝuste agordi la retan agordon de la gasta operaciumo, por ke ĝi povu konekti al
la lokreto, kaj la interreto se la gastiga maŝino havas aliron al ĝi.

IP-adreso:

    10.0.2.2

Implicita kluzo:

    10.0.2.1

DNS-serviloj:

    8.8.8.8
    8.8.4.4


<a name="kurtenoj">La kurtenojn ferm</a>
----------------------------------------


### <a name="restauxri">La retkonektadon restaŭri</a>

Se oni volas specife restaŭri la retkonektadon, rulu la jenajn komandojn:

```sh
$ sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 \
-j MASQUERADE
$ sudo sysctl -w net.ipv4.ip_forward=0
$ sudo ip link set dev tap0 down
$ sudo ip link delete tap0
$ sudo pkill -9 vde_switch
$ sudo rm -f /run/vde.ctl/ctl
```

La ĉi-supraj komandoj:

1. Restaŭros la enkursigan agordon;
2. Malŝaltos la paketan plusendadon;
3. Malŝaltos La VDE-aparaton;
4. Forviŝos la VDE-aparaton;
5. Mortigos la VDE-procezon; kaj
6. Forviŝos la regajn dosierojn.


<a name="cxio">Ĉion kolekti</a>
------------------------------

Jen ĉiom da komandoj de supre, kompiligitaj kiel funkcioj, por ke oni povu ruli ilin ĉe la
komandlinio facile:

```
function kvm-net () {
  case $1 in
    up)
      sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
      sudo ip addr add 10.0.2.1/24 dev tap0
      sudo ip link set dev tap0 up
      sudo sysctl -w net.ipv4.ip_forward=1
      sudo iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j MASQUERADE
      ;;
    down)
      sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 -j MASQUERADE
      sudo sysctl -w net.ipv4.ip_forward=0
      sudo ip link set dev tap0 down
      sudo ip link delete tap0
      sudo pkill -9 vde_switch
      sudo rm -f /run/vde.ctl/ctl
      ;;
  esac
}

function kvm-boot () {
    sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio -net vde \
    -soundhw all -vga qxl \
    -spice port=9999,addr=127.0.0.1,disable-ticketing \
    $@
}

function kvm-iso () {
    kvm-boot -boot once=d -cdrom $1 ${argv[2,-1]}
}

function kvm-display () {
    spicy -p 9999 -h 127.0.0.1 -w sekretŝlosilo
}
```

Mi gvidos onin:

Komence, agordu la retkonektadon:

    $ kvm-net up

Tiam,  ŝargu la bildon:

    $ kvm-boot vm.qcow2

Fine, konektu al la ekrano:

    $ kvm-display

Kiam oni finiĝas pri la virtuala maŝino, fermu la spice-ekranon, tiam malŝaltu la KVM-retkonektadon.

    $ kvm-net down


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

QEMU subtenas miriadojn da mojosaj opcioj kiujn ni ne eĉ diskutis ĉi tie, inkluzive statojn konservi
kaj ŝargi, ekranaj kaj aŭdiaj kaptoj, kaj plu. Por lerni pli pri ili, alklaku [ĉi
tiun](http://wiki.qemu-project.org/Main_Page).

QEMU kun KVM estas potencaj, rapidaj, kaj flekseblaj solvoj por fari tutvirtualigadon. Almenaŭ en
mia kazo, ĝi superas la plej konatajn opciojn en la bazaro. Se oni volas kontribui al ĉi tiu
projekto, iru al ĝia [GitHub-paĝo](https://github.com/qemu/qemu).

Mi esperas, ke ĉi tiu afiŝo helpis onin , iel aŭ aliel, lerni pli pri QEMU kaj KVM kaj kiujn ili
povas doni.
