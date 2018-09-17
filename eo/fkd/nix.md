Milda Enkonduko al la Nix-Familio
=================================

<div class="center">[Esperante](#) · [English](/en/nix)</div>
<div class="center">la 5-an de aŭgusto 2018</div>
<div class="center">Laste ĝisdatigita: la 17-an de septembro 2018</div>

>Ne maltrankviliĝu pri tio, kion la aliaj faros. La plej bona maniero por la estontecon antaŭdiri
>estas per tion eltrovi.<br>
>―Alan KAY

Venas rare ideoj kiuj la manieron por komputado ŝanĝas. Multe da teĥnologio kiujn ni uzas nune nur
estas ripetoj de la malnovaj—niveloj sur niveloj de kosmetikoj kiuj la malnovajn konceptojn
ĉirkaŭkovras. Tutaj produktaj sistemoj estas bazitaj sur ĉi tiu manko de kreemo kaj
lerteco. Malnovaj problemoj ne solvitas. Pentrante per novaj kolortonoj, la problemojn ĉi tiuj
tielnomataj elpensemaj solvoj nure ĉirkaŭigas anstataŭe, pretendante ke almenaŭ, ĝin ili
plikolorplenigis. Progreson ĉi tiu mensostato difektas en nekalkuleblaj manieroj. La falsan
impreson, ke la solvoj fakte estas faritaj ĉi tio donas. Falsan senson de plibonigoj ĉi tio kreas.

Antaŭ multaj jaroj siajn semajn [paperojn](https://nixos.org/~eelco/pubs/)
[Eelco Dolstra](https://nixos.org/~eelco/) skribis, kiu la radikalajn manierojn por programaron disponigi
priskribis. La kernojn de [Nix](https://nixos.org/nix/), pure funkcia paka mastrumila lingvo kiu la
malsanon solvis kiu la komputikon plagis delonge plagis—kompatinda paka mastrumado. En ĉi tiu
artikolo mi parolos pri la Nix-familio, kaj kiel ilin uzi por la avantaĝo.

La dolarsigno ($) uzitos por la ŝelan inviton de normala uzanto indiki, dum la kradsigno (#) uzitos
por la ŝelan inviton de la ĉefuzanto indiki. Estas fojoj kiam la
[EUID](https://en.wikipedia.org/wiki/User_identifier#Effective_user_ID) de komando estos nulo (0)
pro la uzado de *sudo*.


Enhavotabelo
------------

- [NixOS](#nixos)
  + [Instalo](#nixosinstalo)
    * [La maŝinon ŝalti](#nixossxalti)
    * [La reton agordi](#nixosreto)
    * [La diskojn pretigi](#nixosdiskoj)
    * [Instali al disko](#nixosinstali)
  + [Agordaĵo](#nixosagordajxo)
- [Nix](#nix)
  + [Signovicoj](#nixsignovicoj)
  + [Nombroj](#nixnombroj)
  + [Buleaj](#nixbuleaj)
  + [Listoj](#nixlistoj)
  + [Aroj](#nixaroj)
  + [Dosierindikoj](#nixdosierindikoj)
  + [Funkcioj](#nixfunkcioj)
  + [Let](#nixlet)
  + [With](#nixwith)
  + [Kondiĉesprimoj](#nixkondicxesprimoj)
  + [Enportoj](#nixenportoj)
- [Nixpkgs](#nixpkgs)
  + [Instalo](#nixpkgsinstalo)
  + [Uzado](#nixpkguzado)
    * [Gito](#nixpkgsgit)
    * [Kanaloj](#nixpkgskanaloj)
    * [Aliaj komandoj](#nixpkgsaliaj)
  + [Agordaĵo](#nixpkgsagordajxo)
  + [Kontribuado](#nixpkgskontribuado)
    * [Ekzistantan pakon ĝisdatigi](#nixpkgsgxistadigi)
    * [Novan pakon sendi](#nixpkgssendi)
  + [Notoj](#nixpkgsnotoj)
- [Medioj](#medioj)
  + [Sistemmedio](#sistemmedio)
  + [Uzantmedio](#uzantmedio)
  + [Disvolvmedio](#disvolvmedio)
- [Finrimarkoj](#finrimarkoj)
- [Bonifiko](#bonifiko)


<a name="nixos"></a>NixOS
-------------------------

Kiom da fojo difektan sistemon oni havadis pro programaron oni ĝistadigis kiun aliaj komponantoj
dependis? Kiom da malfrunoktaj restoj oni pasis por apon oni bezonis funkciigi pro ĝin la nova pako
kiun oni instalis rompigis? Kiom da fojo, pro ĉagrenego, oni rezignis en la riparado de la sistemo
kaj simple decidis por la sistemon reinstali el nulo. Datumdosierojn restaŭri facilas; sistemagordon
de la lasta funkcia stato restaŭri, bedaŭrinde, estas unudirekta bileto al infero.

[NixOS](https://nixos.org) estas linuksa distributo kiu ĉi tiajn problemojn solvas per la
determinismon de [Nix](https://nixos.org/nix) ekspluati kaj per unu deklara agorda dosiero uzi kiu
ĉiom da agordaĵoj kaj alĝustigiloj tenas en unu loko—`/etc/nixos/configuration.nix`. Informon pri la
dosiersistemo, uzantoj, servoj, retagordo, enigaparatoj, kernaj parametroj, kaj pli ĉi tiu dosiero
enhavas. Signifas, ke je `configuration.nix` de iu oni povas preni kaj sian ekzaktan sistemagordon
havu! En NixOS oni ne plu bezonas ludadi pri la tutsistemo por la agordo kiun oni
deziras. Porokazajn solvojn oni ne plu uzas por deziratan agordan staton precizigi. Aldonan
programaron oni ne plu bezonas instali por sistemagordon mastrumi.

NixOs ne konformiĝas al [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), aldonan
cerban damaĝon efektive malebligas. Spacon por multe da fleksebleco kaj eltrovemo donas. Je `/usr/`
kaj `/opt/` ĝi ne havas. Tamen, je `/bin/` kaj `/usr/bin/` ĝi havas, kiu nur je `sh` kaj `env` havas
respektive—ambaŭ fakte estas simbolligiloj al la realaj programoj kiu loĝas ie en `/nix/store/`. La
supra loko por sistemprogramoj—la tiuj, kiuj estas instalitaj specife de la sistemestro—estas
lokitaj en `/run/current-system/sw/bin/` kaj `/run/current-system/sw/sbin/`. Uzantinstalitaj
programoj, aliflanke, troveblas en siaj respektivaj `~/.nix-profile/bin/`-lokoj. Ĉi tiuj lokoj ne
povas ŝanĝiĝi per kutimaj manieroj; dediĉitaj programoj devas esti uzataj por skribi al ĉi tiuj
arboj.


### <a name="nixosinstalo"></a>Instalo

Simplas instalo de NixOS. Por “nudmetalaj” sistemoj, instalilon de [nixos.org/nixos/download.html](https://nixos.org/nixos/download.html) elŝutu. Virtualmaŝinaj diskbildoj ankaŭ haveblas de tiu paĝo. En mia lasta instalo, mi instalis per la jena agordo:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- USB-praŝarĝo
- Vifia konekto
- [GUID-subdiska tabelo (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)
- [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) super [LVM](https://en.wikipedia.org/wiki/Logical_volume_management)


#### <a name="nixossxalti"></a>La maŝinon ŝalti

Praŝarĝu per la USB-poŝmemorilo en UEFI-reĝimo. Sur la ensaluta invito, ensalutu kiel `root`.


#### <a name="nixosreto"></a>La reton agordi

Haveblajn retojn skanu

    # nmcli d wifi list

Tiam, konektu al la preferata enkursigilo

    # nmcli d wifi con PLDT name hejmo password sekreto


#### <a name="nixosdiskoj"></a>La diskojn pretigi

La subdiskojn kreu

    # gdisk /dev/sda
    sda1: EF00 (EFI system), 512 MiB
    sda2: 8E00 (Linux LVM), ceteraj

Je `/dev/sda1` strukturu

    # mkfs.vfat -F32 /dev/sda1

La fizikan volumon kreu

    # pvcreate /dev/sda2

La voluman grupon kreu

    # vgcreate vg /dev/sda2

La logikajn volumojn kreu

    # lvcreate -L 20G -n swap vg
    # lvcreate -l 100%FREE -n root vg

La radikon ĉifru

    # cryptsetup luksFormat /dev/vg/root
    # cryptsetup luksOpen /dev/vg/root root

La radikon strukturu

    # mkfs.ext4 -j -L root /dev/mapper/root

La permutodosieron strukturu

    # mkswap -L swap /dev/vg/swap

La dosiersistemojn surmetu

    # mount /dev/mapper/root /mnt
    # mkdir /mnt/boot
    # mount /dev/sda1 /mnt/boot

La permutodosieron ŝaltu

    # swapon /dev/vg/swap


#### <a name="nixosinstali"></a>Instali al disko

La bazagorddosieron kreu

    # nixos-generate-config --root /mnt

La agorddosieron redaktu

    # nano /mnt/etc/nixos/configuration.nix

Por la procedon plifaciligi, malpligrandigitan version de
[mia agorddosiero](https://github.com/ebzzry/dotfiles/blob/master/nixos/configuration.nix) oni povas uzi, kaj sekve. La valorojn anstataŭigu laŭ oni preferas. Ĉiom da agordaj alĝustigiloj haveblas
[ĉi tie](https://nixos.org/nixos/options.html).

```nix
{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    initrd.luks.devices = [
      {
        device = "/dev/vg/root";
        name = "root";
        preLVM = false;
      }
    ];

    cleanTmpDir = true;
  };

  fileSystems = [
    {
      device = "/dev/disk/by-uuid/6106-6BF8";
      fsType = "vfat";
      mountPoint = "/boot";
    }

    {
      device = "/dev/mapper/root";
      fsType = "ext4";
      mountPoint = "/";
    }
  ];

  swapDevices = [
    {
      device = "/dev/vg/swap";
    }
  ];

  networking = {
    hostName = "mehfoo";
    hostId = "7B1548AE";
    enableIPv6 = true;
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ zsh ];
  };

  time.timeZone = "Asia/Manila";

  security.sudo = {
    enable = true;
    configFile = ''
      Defaults env_reset
      root ALL = (ALL:ALL) ALL
      %wheel ALL = (ALL) SETENV: NOPASSWD: ALL
    '';
  };

  services = {
    xserver = {
      autorun = true;
      defaultDepth = 24;
      enable = true;
      displayManager.kdm.enable = true;
      desktopManager.kde5.enable = true;
      videoDrivers = [ "intel" ];
    };
  };

  users = {
    extraUsers.ogag = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
    defaultUserShell = "/run/current-system/sw/bin/zsh";
  };
}
```

Se la `nixos-generate-config` paŝon ĉi-supre oni preterpasis, la antaŭproduktan dosieron kreu mane:

    # mkdir -p /mnt/etc/nixos

La ĉi-supran dosieron oni povas konservi per:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/ZTQcGs

Pli longa versio haveblas per:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/K4P7l5

La UUID-identigilon de la disko anstataŭigu per la tiu, kiun oni havas. La komandon `blkid` uzu por
la UUID-identigilojn akiru. Por la valoro de `networking.hostID` la jenan komandon uzu:

    # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done

La jenan la ĉi-supra agordo precizigas, inter aliaj aferoj:

- Uzanton `ogag` kreas kun tuta sudo-aliro.
- Je KDE5 uzas kiel la fenestrilo.
- Sekurŝelon ŝaltas.
- La LUKS-parametrojn precizigas.

Je NixOS instalu al la disko:

    # nixos-install

Je `/etc/nixos/configuration.nix` ĉi tiu komando analizas, asekurante, ke ne estas eraroj. Ĉiom da
necesaj pakoj por kongrui al la specifo ĉi tiu komando elŝutos.

Post kiam la instalo finiĝis, la sistemon repraŝarĝu.

    # reboot
