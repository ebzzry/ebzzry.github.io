Virtualigado en Linukso per KVM
===============================

<div class="center">Esperanto ▪ [English](/en/kvm/)</div>
<div class="center">Laste ĝisdatigita: la 28-an de Septembro 2021</div>

>Se tion oni faras, kion oni ĉiam faras; tion oni akiros, kion oni ĉiam akiras.<br>
>―Anthony ROBBINs

La [tutvirtualigadajn](https://en.wikipedia.org/wiki/Full_virtualization) solvojn kiel
*VMware Workstation*, *Oracle VirtualBox*, kaj *Parallels* plejmulto da oni konas. En
ĉi tiu afiŝo, alian metodon por aferojn fari, mi reenkondukos al oni.

La dolarsigno ($) uzitos por la ŝelan inviton de normuzanto indiki, dum la kradsigno (#) uzitos
por la ŝelan inviton de la ĉefuzanto indiki. Estas fojoj kiam la
[EUID](https://en.wikipedia.org/wiki/User_identifier#Effective_user_ID) de komando estos nulo (0)
pro la uzado de *sudo*.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Agordaĵo](#agordajxo)
  + [Aparataro](#aparataro)
  + [Programaro](#programaro)
- [Agordo](#agordo)
  + [Bildoj](#bildoj)
  + [KVM-grupo](#grupo)
  + [Retkonektado](#retkonektado)
- [Plenumo](#plenumo)
  + [La bildon ŝarĝi](#sxargxu)
  + [Konekti al la SPICE-ekrano](#ekrano)
  + [La gastan reton agordi](#gastareto)
- [La kurtenojn fermi](#kurtenoj)
  + [La retkonektadon restaŭri](#restauxri)
- [Ĉion kolekti](#cxio)
- [Finrimarkoj](#finrimarkoj)


<a name="agordajxo"></a>Agordaĵo
--------------------------------


### <a name="aparataro"></a>Aparataro

Unu el la plej unuaj aferoj kiujn oni devas fari estas por la
[aparataro-asistitan virtualigadon](https://en.wikipedia.org/wiki/Hardware-assisted_virtualization)
ŝalti, ankaŭ nomiĝas plirapigita virtualigado, en la aparataro. Se la ĉefprocezilo estis kreita
antaŭ 2006, plej verŝajne, ĉi tiu kapablo ne ĉeestas en la ico. Ankaŭ, tenu en la kalkulo, ke ĉi
tiu paŝo ne devigatas por iun ajn kapablojn en ĉi tiu afiŝo uzi, tamen la aferojn ĝi _atentinde_
plirapidigos.

Por plirapigitan virtualigadon ŝalti, iru al la BIOS/UEFI-agordoj, kaj la tenilon por ĉi tiun
kapablon trovu. La nomo de ĉi tiu kapablo malsamas inter fabrikanto al fabrikanto. La agordon
konservu, tiam la sistemon reŝarĝu. Tiam, la kapablon oni nun povas verigi komandlinie.

    $ egrep '(vmx|svm)' /proc/cpuinfo

Se kelkajn tekstojn ĝi revenigas, oni bonas.


### <a name="programaro"></a>Programaro

Sekve, la havendajn apojn oni devas instali:

Nix:

    $ nix-env -i qemu vde2 spice_gtk

APT:

    $ sudo apt-get install -y qemu-kvm vde2 spice-client-gtk

La [QEMU](http://wiki.qemu-project.org/Main_Page)-hiperregilon, la
[VDE](http://vde.sourceforge.net/)-ilojn, kaj [SPICE](http://www.spice-space.org/)-subtenon ĉi tio
instalas. QEMU, almenaŭ dum siaj fruaj tagoj ne estis impresa—ĝi estis bona, bedaŭrinde ne
bonegas. Ekde versio 0.10.1, je [KVM](http://www.linux-kvm.org/)-kapablojn—virtualigada subsistemo
por linukso—kiu preskaŭ denaskan virtualigadon disponigas per aparataro-asistita virtualigado, QEMU
komencis subteni. La ekonomiojn de la aliaj virtualigadaj sistemoj menciitaj ĉi-supre ĝi eĉ
konkuras.

La opcion de konekti al la gasta maŝina ekrano
per [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) aliaj aplikaĵaroj
ofertas. Bedaŭrinde, ĝi malrapidas kaj malviglas. La respondtempo teruras. La
[SPICE](http://www.spice-space.org/)-protokolon uzante, ne nur aferojn ĝi plirapidigas, ankaŭ
aliajn aferojn ĝi ebligas. Tenu en la kalkulo, ke SPICE ne estas anstataŭaĵo por VNC, anstataŭe, ĝi
estas alia maniero por la celojn renkonti.


<a name="agordo"></a>Agordo
---------------------------

### <a name="bildoj"></a>Bildoj

Tabelon de bildaj tipoj QEMU subtenas, tamen la [QCOW2](https://en.wikipedia.org/wiki/Qcow)-formato
estas la plej fleksebla, kaj kapable riĉas, por la uzo do QEMU.

Se ekzistantan VirtualBox-dosieron (VDI) oni havas, ĝin oni povas konverti al QCOW2 per:

    $ qemu-img convert -f vdi -O qcow2 vm.vdi vm.qcow2

Tamen, se bildon oni ne jam havas, ĝin oni povas krei per:

    $ qemu-img create -f qcow2 vm.qcow2 20G

20GiB-bildon la lasta paŝo kreas, kiu nomiĝas `vm.qcow2`. Tenu en la kalkulo, ke la dosiersufikso
ne fakte gravas—la bildon oni povas nomigi kiel `index.html`, tamen tio ne estus sencema, ĉu ne? 😄


### <a name="grupo"></a>KVM-grupo

La komandoj ĉi-sube postulas, ke grupo nomiĝas `kvm` devas ekzisti kaj oni estas ano de tiu
grupo. Por tion efektivigi, plenumu:

    $ sudo groupadd kvm
    $ sudo usermod -G $(groups | sed 's/ /,/g'),kvm $USER
    $ newgrp kvm

Onin la lasta komando varbas al la KVM-grupo senelsaluti el la seanco.


### <a name="retkonektado"></a>Retkonektado

[Multajn manierojn](http://wiki.qemu-project.org/Documentation/Networking) por retkonektadon agordi
por siaj gastoj QEMU subtenas, tamen por ĉi tiu afiŝo nur je VDE ni uzos.

Kelkajn komandojn oni devas kuri por la retan medion pretigi. Ideale, la komandojn oni volas
konservi en ŝela funkcio aŭ skripto:

    $ sudo vde_switch -tap tap0 -mod 660 -group kvm -daemon
    $ sudo ip addr add 10.0.2.1/24 dev tap0
    $ sudo ip link set dev tap0 up
    $ sudo sysctl -w net.ipv4.ip_forward=1
    $ sudo iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j MASQUERADE

La ĉi-supraj komandoj:

1. La VDE-aparaton kreos.
2. La TCP/IP-opciojn agordos por tiu aparato.
3. La VDE-aparaton ŝaltos.
4. La paketan plusendadon ŝaltos en la gastiga sistemo.
5. La enkursigan agordon agordos.


<a name="plenumo"></a>Plenumo
-----------------------------


### <a name="sxargxu"></a>La bildon ŝarĝi

La komandon `qemu-kvm` oni nun devas alvoki, la komando kiu ĉion lanĉas. La nomo de la komando eble
malsamas kun tiu, kiu instalitas sur la sistemo.

Se operaciumon el praŝarĝebla bildo oni instalas, kutime la ISO-dosiero, plenumu:

    $ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
    -net vde -soundhw all -vga qxl \
    -spice port=9999,addr=127.0.0.1,password=sekretŝlosilo \
    -boot once=d -cdrom installer.iso \
    vm.qcow2

En sekvaj uzadoj:

    $ sudo qemu-kvm -cpu host -m 2G -net nic,model=virtio \
    -net vde -soundhw all -vga qxl \
    -spice port=9999,addr=127.0.0.1,password=sekretŝlosilo \
    vm.qcow2

Tion ni malkomponu:

    -cpu host

La KVM-procezilon uzu, per ĉiom da subtenitaj kapabloj.

    -m 2G

2GiB de gastiga maŝino por la gasto asignu. Adaptu, kiel necese.

    -net nic,model=virtio -net vde

Je virtualan NIC kreu, kaj VDE-retkonektadon ŝaltu.

    -soundhw all

Ĉiomajn aŭdiajn pelilojn ŝaltu.

    -vga qxl

La videan adaptilon por imiti precizigu. Je QXL uzu kiam je SPICE uzi.

    -spice addr=127.0.0.1,port=9999,password=sekretŝlosilo

La opciojn por SPICE precizigu, apartigitaj per komoj.  _addr_ kaj _port_ estas la IP-adreso kaj
TCP-pordo kiujn SPICE aŭskultos. Ideale, aliro al tiu pordo devas esti ĝuste agordita, kaj
sekurigita. _password_ etas la ŝlosilo, kiu esti uzota de la SPICE-kliento, _spicy_, por konekti
al la gasta ekrano poste.

    -boot once=d -cdrom instalilo.iso

Praŝarĝi komence el `instalilo.iso`, tiam por sekvontaj praŝarĝoj, praŝarĝu per la kutima ordo.

La _qemu-kvm_-komandon ĉi-supre kurante, la bildon ŝarĝos, tamen la ekranon oni ne ankoraŭ povas
vidi.


### <a name="ekrano"></a>Konekti al la SPICE-ekrano

Por ke la gastan ekranon oni povu uzi, oni devas konekti al la SPICE-servilo, per la SPICE-kliento:

    $ spicy -h 127.0.0.1 -p 9999 -w sekretŝlosilo

Tenu en la kalkulo, ke la spicy-fenestron fermi ne la QEMU-seancon mortigas. Se la musenigon
la gasta operaciumo kaptas, je <kbd>Shift+F12</kbd> premu, por eskapi.


### <a name="gastareto"></a>La gastan reton agordi

Sekve, la retan agordon de la gasta operaciumo oni devas ĝuste agordi, por ke ĝi povu konekti al
la lokreto, kaj la interreto se aliron al ĝi la gastiga maŝino havas.

IP-adreso:

    10.0.2.2

Implicita kluzo:

    10.0.2.1

DNS-serviloj:

    8.8.8.8
    8.8.4.4


<a name="kurtenoj"></a>La kurtenojn fermi
--------------------------------------------


### <a name="restauxri"></a>La retkonektadon restaŭri

Se la retkonektadon oni volas specife restaŭri, la jenan faru.

```bash
$ sudo iptables -t nat -D POSTROUTING -s 10.0.2.0/24 \
-j MASQUERADE
$ sudo sysctl -w net.ipv4.ip_forward=0
$ sudo ip link set dev tap0 down
$ sudo ip link delete tap0
$ sudo pkill -9 vde_switch
$ sudo rm -f /run/vde.ctl/ctl
```

La ĉi-supraj komandoj:

1. La enkursigan agordon restaŭros.
2. La paketan plusendadon malŝaltos.
3. La VDE-aparaton malŝaltos.
4. La VDE-aparaton forviŝos.
5. La VDE-procezon mortigos.
6. La regajn dosierojn forviŝos.


<a name="cxio"></a>Ĉion kolekti
------------------------------

Jen ĉiom da komandoj el supre, kompiligitaj kiel funkcioj, por ke ilin oni povu kuri komandlinie:

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

Onin mi gvidos:

Komence, la retkonektadon agordu:

    $ kvm-net up

Tiam, la bildon ŝarĝu:

    $ kvm-boot vm.qcow2

Fine, konektu al la ekrano:

    $ kvm-display

Kiam oni finiĝas kun la virtuala maŝino, la spice-ekranon fermu, tiam la KVM-retkonektado
malŝaltu.

    $ kvm-net down


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Miriadojn de mojosaj opcioj kiujn ni ne eĉ diskutis ĉi tie QEMU subtenas, inkluzive statojn konservi
kaj ŝarĝi, ekranaj kaj aŭdiaj kaptoj, kaj plu. Por lerni pli pri ili,
[ĉi tien](http://wiki.qemu-project.org/Main_Page) alklaku.

QEMU kun KVM estas potenca, rapida, kaj fleksebla solvo por tutvirtualigadon fari. Almenaŭ en mia
kazo, la plej konatajn opciojn en la bazaro ĝi superas. Se oni volas kontribui al ĉi tiu projekto,
iru al ĝia [GitHub-paĝo](https://github.com/qemu/qemu).

Mi esperas, ke onin ĉi tiu afiŝo helpis, iel aŭ aliel, lerni pli pri QEMU kaj KVM kaj kiujn ili
povas doni.
