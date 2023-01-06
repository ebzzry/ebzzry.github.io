Milda Enkonduko al la Nix-Familio
=================================

<div class="center">Esperanto ◆ [English](/en/nix/)</div>
<div class="center">Laste ĝisdatigita: la 28-an de Marto 2022</div>

>Ne maltrankviliĝu pri tio, kion la aliaj faros. La plej bona maniero por antaŭdiri la estontecon estas por eltrovi ĝin.<br>―Alan KAY

<img src="/bil/wallhaven-751942-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="wallhaven-751942" title="wallhaven-751942"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [NixOS](#nixos)
  + [Instalo](#nixosinstalo)
    * [Ŝalti la maŝinon](#nixossxalti)
    * [Agordi la reton](#nixosreto)
    * [Pretigi la diskojn](#nixosdiskoj)
    * [Instali al disko](#nixosinstali)
  + [Agordaĵo](#nixosagordajxo)
- [Nix](#nix)
  + [Signovicoj](#nixsignovicoj)
  + [Nombroj](#nixnombroj)
  + [Buleaj valoroj](#nixbuleaj)
  + [Listoj](#nixlistoj)
  + [Aroj](#nixaroj)
  + [Dosierindikoj](#nixdosierindikoj)
  + [Funkcioj](#nixfunkcioj)
  + [Let](#nixlet)
  + [With](#nixwith)
  + [Kondiĉesprimoj](#nixkondicxesprimoj)
  + [Dosierenportoj](#nixdosierenportoj)
- [Nixpkgs](#nixpkgs)
  + [Instalo](#nixpkgsinstalo)
  + [Uzado](#nixpkgsuzado)
    * [Gito](#nixpkgsgito)
    * [Kanaloj](#nixpkgskanaloj)
    * [Aliaj komandoj](#nixpkgsaliaj)
  + [Agordaĵo](#nixpkgsagordajxo)
  + [Kontribui](#nixpkgskontribui)
    * [Ĝisdatigi ekzistantan pakon](#nixpkgsgxisdatigi)
    * [Sendi novan pakon](#nixpkgssendi)
  + [Notoj](#nixpkgsnotoj)
- [Medioj](#medioj)
  + [Sistemmedio](#sistemmedio)
  + [Uzantmedio](#uzantmedio)
  + [Programadmedio](#programadmedio)
- [Surmetoj](#surmetoj)
  + [Transpasoj](#surmetojtranspasoj)
  + [Novaj pakoj](#surmetojnovajpakoj)
- [Finrimarkoj](#finrimarkoj)
- [Bonifiko](#bonifiko)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Venas rare ideoj kiuj povas ŝanĝi la metodoj por komputado. Multe da teĥnologio kiujn ni uzas nune
estas nur ripetoj de la malnovaj—niveloj sur niveloj de kosmetikoj kiuj ĉirkaŭkovras la malnovajn
konceptojn. Plenaj produktaj sistemoj baziĝas ĉe ĉi tiu manko de kreemo kaj lerteco. Malnovaj
problemoj ne solviĝas. Pentrante per novaj kolortonoj, ĉi tiuj tielnomataj elpensemaj solvoj nure
ĉirkaŭigas la problemojn anstataŭe, pretendante ke almenaŭ, ili plikolorplenigis ĝin. Ĉi tiu
mensostato difektas progreson en nekalkuleblaj manieroj. Ĉi tio donas la falsan impreson, ke la
solvoj fakte estas faritaj. Ĉi tio kreas Falsan senson de plibonigo.

Antaŭ multaj jaroj [Eelco DOLSTRA](https://nixos.org/~eelco/) skribis siajn influegjan
[paperojn](https://nixos.org/~eelco/pubs/), en kiu, li priskribis la radikalajn manierojn por
disponigi programaron. Tiuj paperoj formis la kernojn de [Nix](https://nixos.org/nix/)—pure funkcia
paka administrila lingvo kiu solvis la malsanon kiu delonge plagis la informadikon—kompatinda paka
administrado. En ĉi tiu artikolo mi parolos pri la Nix-familio, kaj kiel uzi ĝin por la avantaĝo.

Uziĝos la dolarsigno ($) por indiki la ŝelan inviton de la normuzanto indiki, uziĝos la kradsigno
(#) por indki la ŝelan inviton de la ĉefuzanto. Estas fojoj kiam la
[EUID](https://en.wikipedia.org/wiki/User_identifier#Effective_user_ID) de komando estas nulo (0)
pro la uzo de *sudo*.


<a name="nixos">NixOS</a>
-------------------------

Kiom da fojoj, oni havadis difektitan sistemon pro oni ĝistadigis programaron kiun aliaj komponantoj
dependis? Kiom da malfruaj noktoj oni pasis por ripari apon ĉar la nova pako kiun oni instalis
rompigis ĝin? Kiom da fojoj, pro ĉagrenego, oni rezignis pri la riparado de la sistemo kaj simple
decidis por reinstali la sistemon de nulo. Facilas restaŭri datumdosierojn. Restaŭri sistemagordon
de la lasta funkcia stato, bedaŭrinde, estas unudirekta bileto al geheno.

[NixOS](https://nixos.org) (niks-oŭ-es) estas linuksa distribuo kiu solvas ĉi tiajn problemojn per
ekspluati la determinismon de [Nix](https://nixos.org/nix) kaj per uzi unu deklaran agorddosieron
kiu tenas ĉiomajn agordaĵojn kaj alĝustigilojn tenas en unu loko—`/etc/nixos/configuration.nix`. Ĉi
tiu dosiero enhavas informon pri la dosiersistemo, uzantoj, servoj, retagordo, enigaparatoj, kernaj
parametroj, kaj pli . Signifas, ke oni povas preni _configuration.nix_ de iu kaj havi ĝian ekzaktan
sistemagordon! En NixOS oni ne plu bezonas ludi pri la tutsistemo por la agordo kiun oni deziras.
Oni ne plu uzas porokazajn solvojn por specifi deziratan agordan staton. Oni ne plu bezonas
instali aldonan programaron por administri sistemagordon.

NixOS ne konformiĝas al [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard),
malebligante aldonan cerban damaĝon efektive. Tio donas al mi spacon por multe da flekso kaj
eltrovemo. Ĝi ne havas `/usr/` kaj `/opt/`. Tamen, ĝi havas`/bin/` kaj je `/usr/bin/`, kiuj havas
nur `sh` kaj `env` respektive—ambaŭ fakte estas simbolligiloj al la realaj programoj kiuj loĝas ie
en `/nix/store/`. La supra loko por sistemprogramoj—tiuj, kiuj estas instalitaj specife de la
sistemestro—lokiĝas en `/run/current-system/sw/bin/` kaj `/run/current-system/sw/sbin/`.
Uzantinstalitaj programoj, aliflanke, troveblas en siaj respektivaj `~/.nix-profile/bin/`-lokoj. Ĉi
tiuj lokoj ne povas ŝanĝiĝi per kutimaj manieroj; dediĉitaj programoj devas esti uzataj por skribi
al ĉi tiuj arboj.


### <a name="nixosinstalo">Instalo</a>

Instalo de NixOS simplas. Por «nudmetalaj» sistemoj, elŝutu la instalilon el
[nixos.org/nixos/download.html](https://nixos.org/nixos/download.html). Virtualmaŝinaj diskbildoj
ankaŭ haveblas de tiu paĝo. De mia lasta instalo, mi instalis per la jena agordo:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- USB-praŝargo
- Vifia konekto
- [GUID-subdiska tabelo (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)
- [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) super [LVM](https://en.wikipedia.org/wiki/Logical_volume_management)


#### <a name="nixossxalti">Ŝalti la maŝinon </a>

Praŝargu per la USB-poŝmemorilo en UEFI-reĝimo. Ĉe la ensaluta invito, ensalutu kiel `root`.


#### <a name="nixosreto">Agordi la reton</a>

Skanu haveblajn retojn:

    # nmcli d wifi list

Tiam, konektu al la preferata enkursigilo:

    # nmcli d wifi con ENKURSIGILO name NOMO password PASVORTO


#### <a name="nixosdiskoj">Pretigi la diskojn </a>

Kreu la subdiskojn:

    # gdisk /dev/sda
    sda1: EF00 (EFI system), 512 MiB
    sda2: 8E00 (Linux LVM), ceteraj

Strukturu `/dev/sda1`:

    # mkfs.vfat -F 32 /dev/sda1

Kreu la fizikan volumon:

    # pvcreate /dev/sda2

Kreu la voluman grupon:

    # vgcreate vg /dev/sda2

Kreu la logikajn volumojn:

    # lvcreate -L 20G -n swap vg
    # lvcreate -l 100%FREE -n root vg

Ĉifru la radikon:

    # cryptsetup luksFormat /dev/vg/root
    # cryptsetup luksOpen /dev/vg/root root

Strukturu la radikon:

    # mkfs.ext4 -j -L root /dev/mapper/root

Strukturu la permutodosieron:

    # mkswap -L swap /dev/vg/swap

Surmetu la dosiersistemojn:

    # mount /dev/mapper/root /mnt
    # mkdir /mnt/boot
    # mount /dev/sda1 /mnt/boot

Ŝaltu la permutodosieron:

    # swapon /dev/vg/swap


#### <a name="nixosinstali">Instali al disko</a>

Kreu la bazagorddosieron:

    # nixos-generate-config --root /mnt

Redaktu la agorddosieron:

    # nano /mnt/etc/nixos/configuration.nix

Por plifaciligi la procedon, oni povas uzi la malpligrandigitan version de
[mia agorddosiero](https://github.com/ebzzry/dotfiles/blob/main/nixos/configuration.nix). Kaj sekve,
anstataŭigu la valorojn laŭplaĉe. Haveblas ĉiom da agordaj alĝustigiloj [ĉi tie](https://nixos.org/nixos/options.html).

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
    hostName = "ombrelo";
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
    extraUsers.vakelo = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
    defaultUserShell = "/run/current-system/sw/bin/zsh";
  };
}
```

Se oni preterpasis la paŝon `nixos-generate-config` ĉi-supre, kreu la antaŭproduktan dosieron
permane:

    # mkdir -p /mnt/etc/nixos

Oni povas konservi la ĉi-supran dosieron per:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/ZTQcGs

Haveblas pli longa versio per:

    # curl -sSLo /mnt/etc/nixos/configuration.nix https://goo.gl/K4P7l5

Anstataŭigu la UUID-identigilon de la disko per tiu, kiun oni havas. Uzu La komandon `blkid` por
akiri la UUID-identigilojn. Por la valoro de `networking.hostID` uzu la jenan komandon:

    # cksum /etc/machine-id | while read c rest; do printf "%x" $c; done

La ĉi-supra agordo precizigas la jenan, inter aliaj aferoj:

- Krei uzanton `vakelo` kun tuta _sudo_-kapablo;
- Uzi KDE5 kiel la fenestrilo;
- Ŝalti sekurŝelon; kaj
- Specifi la LUKS-parametrojn.

Instalu NixOS al la disko:

    # nixos-install

Tio komando analizas `/etc/nixos/configuration.nix` , asekurante, ke ne estas eraroj. Tiu komando
elŝutos ĉiom da necesaj pakojn por kongrui al la specifo .

Post kiam la instalo finiĝis, repraŝargu la sistemon:

    # reboot


### <a name="nixosagordajxo">Agordaĵo</a>

Instalinte, ĝisdatigi la ekzistantan agordaĵon facilas. Ĉio kion oni devas fari estas redakti la
agorddosieron tiam rekunmetu la sistemon:

    # nano /etc/nixos/configuration.nix
    # nixos-rebuild switch

Se okazis eraro, la sistemo sciigos onin pri tio, anstataŭ pluigi per malĝusta agordo. Post kiam la
sistemo finfaris reŝargi, iru al la konzolo per <kbd>Ctrl+Alt+F1</kbd>, tiam ensalutu kiel `root`,
tiam agordu pasvorton por la uzanto kiun ni specifis en `configuration.nix`:

    # passwd vakelo

Eliru de la ŝelo, tiam iru al la grafika fasado per <kbd>Alt+F7</kbd>, tiam ensalutu kiel `vakelo`.


<a name="nix">Nix</a>
---------------------

La komponanto kiu la fondas koron de NixOS kaj Nixpkgs estas la [Nix](https://nixos.org/nix)-lingvo.
Ĝi estas deklarlingvo kreita por administri pakojn.

Por ke oni facile povu kompreni la lingvon, ni rulu `nix repl`:

    $ nix repl

Sekve, ni rulu ĝin. Oni salutiĝas per la versinombro, kaj la invito de nix-repl. Skribante ĉi tiun
artikolon, la plej ĵusa stabila versinombro estas 2.4:

```nix
Welcome to Nix 2.4. Type :? for help.

nix-repl>
```

Ni elprovu bazajn esprimojn.


### <a name="nixsignovicoj">Signovicoj</a>

Samkiel en aliaj lingvoj, signovicoj taksas al si mem:

```nix
nix-repl> "hundo"
"hundo"
```

Por kunmeti signovicojn, uzu la operacisimbolon `+`:

```nix
nix-repl> "hundo" + "kato"
"hundokato"
```

Alia maniero por deklari signovicojn, estas por uzi du parojn de unuoblaj citiloj. Ne konfuziĝu pri
ĝi kontraste de la duoblaj citiloj:

```nix
nix-repl> ''hundo kato''
"hundo kato"
```

La avantaĝo de uzi `''` anstataŭ `"`, estas ĝi permesas la ĉeeston de `"` ene ĝi:

```nix
nix-repl> ''"hundo" "kato"''
"\"hundo\" \"kato\"\"
```

La valoro kiun ĝi revenas estos ĝuste citita. Ĉi tio utilas poste kiam ni muntos pli komplikajn
esprimojn.

Por elreferenci signovicojn ene signovicoj, uzu la formon `${name}`:

```nix
nix-repl> x = "hundo"

nix-repl> y = "kato"

nix-repl> "${x} ${y}"
"hundo kato"

nix-repl> ''${x} ${y}''
"hundo kato"
```


### <a name="nixnombroj">Nombroj</a>

Bazaj aritmetikaj operacioj en Nix estas inkluzivitaj kun malgranda surprizo:

```nix
nix-repl> 6+2
8

nix-repl> 6-2
4

nix-repl> 6*2
12

nix-repl> 6/2
/home/vakelo/6/2
```

Ho! Tio ne estis, kion ni anticipis. Pro tio ke Nix estas desegnitaj kun dosieroj kaj dosierujoj, ĝi
kreis specialan kazon, ke kiam suprenstreko (/) signo estas ĉirkaŭitaj per nespacetaj signoj, ĝi
interpretas ĝin kiel dosierujindiko, rezultonte al absolutdosierindiko. Por fari dividon efektive,
aldonu almenaŭ unu spaceton antaŭ kaj post la `/` signo:

```nix
nix-repl> 6 / 2
3
```

Parenteze, ne estas glitpunktoj en Nix. Do, se oni provas uzi ilin, oni akiros:

```nix
nix-repl> 1.0
error: syntax error, unexpected INT, expecting ID or OR_KW or DOLLAR_CURLY or '"', at (string):1:3
'"'
```

La funkcio `builtins.div` faras la operacion de `/` esence:

```nix
nix-repl> builtins.div 6 3
2
```

La kontrasto tamen, estas, ke `builtins.div` povas esti aplikita parte:

```nix
nix-repl> (builtins.div 6)
«primop-app»
```

Tiu esprimo revenas fermon de parte aplikita funkco. Ni bezonas alian valoron por tute apliki ĝin:

```nix
nix-repl> (builtins.div 6) 3
2
```

Ni eĉ povas konservi la valoron de tiu parta esprimo :

```nix
nix-repl> d = builtins.div 6
```

La operacisimbolo `=` en Nix estas uzata por bindi valorojn. En ĉi tiu ekzemplo, ĝi estas uzita por
difini partan aplikon. Por uzi tiun funkcion:

```nix
nix-repl> d 3
2
```


### <a name="nixbuleaj">Buleaj valoroj</a>

Vereco kaj malvereco estas reprezentitaj de `true` kaj `false`:

```nix
nix-repl> 1 < 2
true

nix-repl> 1 > 2
false

nix-repl> 1 == 1
true

nix-repl> "hundo" == "hundo"
true

nix-repl> "hundo" > "kato"
false

nix-repl> false || true
true

nix-repl> false && true
false
```


### <a name="nixlistoj">Listoj</a>

Listoj estas heterogenaj tipoj por enteni seriajn valorojn. Eroj estas apartigitaj per spacetoj:

```nix
nix-repl> [ 1 "hundo" true ]
[ 1 "hundo" true ]
```

Por listojn kunmeti:

```nix
nix-repl> [ 1 "hundo" true ] ++ [ false (6 / 2) ]
[ 1 "hundo" true false 3 ]
```

Por eltiri la kopon:

```nix
nix-repl> builtins.head ([ 1 "hundo" true (6 / 2) ] ++ [ false (6 / 2) ])
1
```

Por eltiri la voston:

```nix
nix-repl> builtins.tail ([ 1 "hundo" true (6 / 2) ] ++ [ false (6 / 2) ])
[ "hundo" true 3 false 3 ]
```

Listoj estas indeksitaj komence de
[0 (angle)](https://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD831.html). Por akiri la
1-an eron, uzu la operatoron `builtins.elemAt`:

```nix
nix-repl> builtins.elemAt [ 1 "hundo" true ] 1
"hundo"
```


### <a name="nixaroj">Aroj</a>

Grava datumstrukturo en Nix estas aroj. Ili estas paroj de ŝlosilvorto-valoro apartigitaj per
punktokomoj:

```nix
nix-repl> { a = 0; b = "kato"; c = true; cx = (6 / 2); }
{ a = 0; b = "kato"; c = true; cx = 3; }
```

Tio, kio igas arojn malsamaj konstraste de listoj, estas, ke eltiri valorojn el ili estas faritaj per
nomi referencojn. Por eltiri la valoron de `b`, uzu la operacisimbolon `.`:

```nix
nix-repl> { a = 0; b = "kato"; c = true; cx = (6 / 2); }.b
"kato"
```

kiu estas ekvivalenta al:

```nix
nix-repl> { a = 0; b = "kato"; c = true; cx = (6 / 2); }."b"
"kato"
```

Por elreferenci anon el tiu sama aro, uzu la ŝlosilvorton `rec`:

```nix
nix-repl> rec { a = 0; b = "kato"; c = true; cx = (6 / 2); d = b; }.d
"kato"
```


### <a name="nixdosierindikoj">Dosierindikoj</a>

En Nix ĉiom da dosierindikoj estas tradukitaj al absolutdosierindikoj. Se oni faras referencon al dosiero en
la aktuala dosierujo:

```nix
nix-repl> ./hundo
/home/vakelo/hundo
```

Fariĝas absolutdosierindiko. Ĉi tio estas Bonafero™.

Simile, se oni faras referencon al relativdosierindiko ene absolutdosierindiko, ĝi ankoraŭ
tradukiĝas al absolutdosierindiko.

```nix
nix-repl> /./hundo
/hundo
```

Notu, bedaŭrinde, ke dosierindikoj kiuj staras sole ne plaĉas al Nix:

```nix
nix-repl> /
error: syntax error, unexpected '/', at (string):1:1

nix-repl> ./
error: syntax error, unexpected '.', at (string):1:1
```


### <a name="nixfunkcioj">Funkcioj</a>

Ĉu eĉ ekzistas plezuro se ne estos verboj por uzi kun ĉi tiuj substantivoj? Funkcioj en Nix kunhavas
similecojn al aliaj lingvoj, havante ĝiajn unikajn trajtojn.

Jen la bazformo de funkcio:

```nix
nix-repl> x: x
«lambda»
```

Tiu esprimo kreas sennoman funkcion kiu revenas sian argumenton—la
[identa funkcio (angle)](https://en.wikipedia.org/wiki/Identity_function). La dupunkto post la unua
`x` montras, ke ĝi estas parametro al la funkcio, samkiel en
[lambdokalkulo](/eo/lambdokalkulo/#funkcioj). Aldone, la nomoj ne gravas pro
[alfa-ekvivalenteco](https://eo.wikipedia.org/wiki/Lambda-kalkulo#%CE%B1-konverto):

```nix
nix-repl> hundo-kato-muso: hundo-kato-muso
«lambda»
```

Tiuj funkcioj ne estas tre utilaj tial, ke ili ne estas kaptitaj por aplikado. Se oni volas ĝin,
ekzemple, kun la argumento `"hundo"`, ni bezonas ĉirkaŭkovri ĝin per rondkrampoj:

```nix
nix-repl> (x: x) "hundo"
"hundo"
```

Por aldoni plian amuzon, ni nomu tiun funkcion:

```nix
nix-repl> idento = x: x
```

Bonege! Nun, ni apliku ĝin:

```nix
nix-repl> idento "hundo"
"hundo"
```

Ni kreu funkcion kiu postaldonas `" ve"` al sia enigo, tiam ni apliku ĝin:

```nix
nix-repl> ve = s: s + " ve"

nix-repl> ve "mi"
"mi ve"
```

Por krei funkcion kiu akceptas alian argumenton, ni uzu la jenan formon:

```nix
nix-repl> ve = s: t: s + " ve " + t

nix-repl> ve "mi" "vi"
"mi ve vi"
```

La modelo, estas, ke por aldoni aldonan parametron, uzu la formon `name: `.

Aroj, kiam uzitaj kun funkcioj, ŝaltas pliajn potencajn abstraktadojn. Ni povas doni aron kiel
argumento al funkcio, kiu do uzos la datumon ene tiu aro:

```nix
nix-repl> anaso = { a, b }: x: a + " " + b + x
```

Tiu funkcio havas du parametrojn: `{ a, b }`—parametra specifo por aro kun du eroj, kaj
`x`—kutima parametro. Memoru, ke parametra specifo ne estas veraro, sed nur maniero por kongrui la
argumentojn; ĝi uzas komon kiel apartigilo de valoroj. Ene ĉi tiu funkcio la ni povas kombini
enigojn per la operacisimbolon `+`. Por uzi ĉi tiun funkcion, ni uzu ĝin jene:

```nix
nix-repl> anaso { a = "ve"; b = "mi"; } " anaso"
"ve mi anaso"
```

Kiam funkcio deklaras aron kiel sia parametro, oni devas specifi la ŝlosilvortojn kiam invoki la
funkciojn kiu uzas ilin. Tiukaze, la nomoj de sa ŝlosilvortoj estas `a` kaj `b`:

La difino de `anaso` supre estas semantike simila al:

```nix
nix-repl> anaso = ve: x: ve.a + " " + ve.b + x
```

Ni uzis kutiman, ne-aran parametron ĉi tie por ke ĝi povu referenci al la aro kiel valoro. Rimarku
ĉi tion:

```nix
nix-repl> ve = { a = "hundo"; b = "kato"; }

nix-repl> ve.a
"hundo"
```

Ankaŭ eblas por specifi la implicitajn valorojn. Kiam parametro kun implicita valoro ne estas uzita,
la implicita valoro estos uzita. Simile, en Komunlispo:

```lisp
* (defun birdo (a &optional (b "O.o"))
    (concatenate 'string a b))

* (birdo "o.O ")

"o.O O.o"
* (birdo "o.O " "^_^")

"o.O ^_^"
```

```nix
nix-repl> birdo = { a, b ? "O.o" }: a + b

nix-repl> birdo { a = "oro"; }
"oroO.o"

nix-repl> birdo { a = "oro"; b = "argxento"; }
"oroargxento"
```

Por aldoni plian flekson, Nix subtenas la uzon de pseŭdo-«rest» argumentoj. Ni modifu La funkcion
ĉi-supre:

```nix
nix-repl> birdo = { a, b, ...}: a + b
```

Ĝin ni uzu:

```nix
nix-repl> birdo { a = "ve"; b = "hundo"; }
"vehundo"
```

Estas same. Do kiel ni povas uzi tiun flekson? Ni kreos etikodon por la atribuaro por ke ni
povu referenci al la ‹ekstraj› valoroj:

```nix
nix-repl> birdo = atribuoj@{ a, b, ...}: a + b + atribuoj.c
```

Ni simple uzu ĝin kiel antaŭe, sed kun la uzado de la etikedo:

```nix
nix-repl> birdo { a = "oro"; b = "argxento"; c = "bronzo"; }
"oroargxentobronzo"
```

Mi diris «pseŭda» ĉar la valoro por `c` estis ankoraŭ postulita.

Implicitaj valoroj kaj variabla loknombro povas esti kunmetitaj:

```nix
nix-repl> birdo = atribuoj@{ a, b, c ? "C", ... }: a + b + c + atribuoj.z

nix-repl> birdo { a = "A"; b = "B"; z = "Z"; }
"ABCZ"

nix-repl> birdo { a = "A"; b = "B"; c = "x"; z = "Z"; }
"ABXZ"

```


### <a name="nixlet">Let</a>

La ŝlosilvorto `let` permesas onin por difini variablojn en lokamplekso. Ekzemple, por igi la
identigilojn `x` kaj `y` videblaj nur en lokamplekso:

```nix
nix-repl> let x = "hundo"; y = "kato"; in x + anaso { a = "ne"; b = "vere"; } "efektive" + y
"hundone vereefektivekato"
```

Memoru la lastan `;` antaŭ la `in` ŝlosilvorto kiu iras kun `let`—ĝi markas la komencon de la korpo
de `let`. La konstruo `let` kondutas simile al la ŝlosilvorto `let` troveblas en programlingvoj kiel
Lispo kaj Haskelo.


### <a name="nixwith">With</a>

La ŝlosilvorto `with` permesas onin por demeti arvalorojn en amplekso:

```nix
nix-repl> with { x = "hundo"; y = "kato"; }; anaso { a = y; b = x; } " xyz"
"kato hundo xyz"
```

Kio okazis ĉi tie, estas, ke senvualiĝis la valoroj en tiu aro por disponebligi ilin en la korpo de
`with`.



### <a name="nixkondicxesprimoj">Kondiĉesprimoj</a>

Kondiĉesprimoj estas faritaj per la ŝlosilvorto `if`. Ĝi havas similan formon de plimultaj lingvoj:

```nix
nix-repl> if true then "true" else "false"
"true"
```

Ĝi povas esti nestiĝita:

```nix
nix-repl> if false then "true" else if false then "true" else if false then "true" else "false"
"false"
```

### <a name="nixdosierenportoj">Dosierenportoj</a>

La ideo de enporti dosierojn en Nix-esprimo estas subtile malsama kontraste de aliaj lingvoj.
Enportoj en Nix estas intime rilata al aroj. Supozante, ke ni havas la dosieron `ve.nix` , kiu
enhavas la jenan:

```nix
let
  ve = x: x + "ve";
in {
  ve = ve;
}
```

La `let`-esprimo bindas la saman `ve` al funkcio kiu akceptas unu argumenton. En la korpo de `let`,
ĝi revenas aron kiu havas unu membron kun la nomo `ve`—tiu en la maldekstra parto de `=`. La valoro
de ĉi tiu ano estas la funkcio kiun ni ĵus difinis. La grava koncepto por memorigi, estas, ke
ĉi tiu `let`-esprimo revenas atribuaron .

Ni iru reen al la [REPL (angle)](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
por uzi ĉi tiun dosieron:

```nix
nix-repl> import ./ve.nix
{ ve = «lambda»; }
```

Ni denove vidas la lambdo-terminon. Sajnas, ke la nomo `ve`, ĉi tie, estas funkcio. Nun, kiel ni
povas elreferenci ĉi tiun valoron? Ni uzu la operatoron `.`!

```nix
nix-repl> (import ./ve.nix).ve "hundo"
"hundove"
```

Ni devis uzi rondkrampojn tial, ke ne ekzistas tia dosiero `ve.nix.ve` en la aktuala dosierujo. Se
ni trapasos ĝin, ĝi aperos jene:

```nix
nix-repl> { ve = «lambda»; }.ve "hundo"
```

fariĝos:

```nix
nix-repl> { ve = (x: x + "ve"); }.ve "hundo"
"hundove"
```

La enkondukajn konceptojn de la Nix-lingvo ĉi tiu sekcio resumas. La ceteraj vilaj detaloj troveblas
en la [gvidilo](https://nixos.org/nix/manual/#ch-expression-language).


<a name="nixpkgs">Nixpkgs</a>
-----------------------------

Nixpkgs (niks-pa-kej-ĝes) estas kolekto de pakoj organizitaj kaj administritaj per uzantoj tutmonde.
Pro tio ke la fontkodo estas ĉe [GitHub](https://github.com/nixos/nixpkgs), ĝi eblas ekspluati la
avantaĝon de la potenca kunlaborada sistemo kiun tiu platformo ofertas. La
[kolekto](https://nixos.org/nixos/packages.html) havas grandan vicaron da pakoj, de produktivecaj
apoj al teoremaj pruviloj.

Plejparto de popularaj operaciumoj pakojn traktas bone, ĝis ili ne plu. Tiel longe kiel oni movas en
rektan linion, sole, oni sekuras. Aferoj ŝanĝiĝas kiam aliaj homoj enkondukiĝas en la marŝado. Por
ke la tutgrupo movu en unisono, ĉiuj devas esti konektitaj al unu la alia. Se ano decidas forvojaĝi,
kaj sole marŝi, la tutgrupo kripliĝos. Tamen, se tiu ano decidas kloni ĝin por ke la forvojaĝado
fariĝu sendependa, la originala marŝada grupo fariĝas neŝanĝita.

Ni traktu la kazon de distribuo celita kiel pluruzanta produkta programada medio. Kiam oni instalas
fajrfokson versio 100, la ĉefa duuma dosiero iras al aŭ `/usr/bin/firefox` aŭ
`/usr/local/bin/firefox`. Sekve, ĉiom da uzantoj povas aliri la apon el tiu dosierindiko; feliĉas
Johano, Mario, kaj Petro. Bedaŭrinde, se Johano decidis aktualigi ĝin al versio 200, la sama apo
kiun Mario kaj Petro uzas ankaŭ aktualiĝos! Tio ne estas bonafero se ili preferas la malnovan
version kiu funkcias al ili! Nix permesas onin por havi plurajn versiojn de programaro sen kolizioj
al la aliaj versioj. Johano, Mario, kaj Petro povas havi siajn preferatajn versiojn de fajrfokso sen
konfliktoj al la aliaj versioj. Kiel Nixpkgs faras ĝin? Ĝi faras ĝin per nomi la komponantojn per
iliaj kalkulitaj kontrolsumoj kaj per ne uzi komunan tutmondan lokon.

Ĉiom da uzantoj havas siajn proprajn versiojn de `~/.nix-profile/` kaj ĉiom da enhavo de tiuj
dosierujoj ne havas kutimajn dosierojn. Anstataŭ, ili estas simbolligiloj al la efektivaj dosieroj
troveblas en `/nix/store/`. Ĉi tiu dosierujo, estas kie la programoj kaj siaj dependecoj estas
efektive instalitaj. La nura maniero por skribi al tiu dosierujo estas per la dediĉitaj
Nix-programoj. Ne estas maniero por rekte modifi tiun dosierujon per normaj manieroj. Do, kiam la
uzanto `johano` instalas Vim 8, la programo fariĝas instalita kiel
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329`. La signoj antaŭ la paknomo estas la
kontrolsumo de ĉiom da enigoj kiuj estis uzitaj por konstrui la pakon. La dosiero
`/home/johano/.nix-profile/bin/vim` tiam indikas al simbolligo, en dosiero troveblas en
`/nix/store/` kiu kondukas al la efektiva Vim-duumdosiero en
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329/bin/vim`.


### <a name="nixpkgsinstalo">Instalo</a>

Se oni uzas NixOS, preterpasu ĉi tiun sekcion tial, ke Nixpkgs jam iras kun ĝi. Por instali Nixpkgs
ĉe linukso aŭ makintoŝo, rulu:

    $ curl https://nixos.org/nix/install | bash

Oni invitiĝos al la ensalutilojn por eniri ĉefuzantan aliron per *sudo* tial, ke ĝi instalos la
risurcojn al `/nix/`. Post la instalo, oni petiĝas por aldoni linion de komando al la ŝela
pravaloriza dosiero. Kiam oni generas novajn instancojn de la ŝelo la komandoj specifaj al Nix
fariĝos haveblaj.


### <a name="nixpkgsuzado">Uzado</a>

Estas du manieroj por instali pakojn per Nixpkgs: 1) uzi la gitan kopion, kiu estas la plej ĵusa
versio, ĝisdatigita ĝis la lasta minuto, aŭ 2) uzi kanalojn. La
[gitdeponejo](https://github.com/nixos/nixpkgs) estas ideala por uzantoj kiuj volas uzi la plej novajn versiojn de
pako aŭ por uzantoj kiuj volas eltesti. [Kanaloj](https://nixos.org/channels/), aliflanke,
estas esence kopioj de la gitdeponejo en antaŭa tempo.


#### <a name="nixpkgsgito">Gito</a>

Okazas ofte ĝisdatigoj al la gitdeponejo. Legante ĉi tiun artikolon,
[novaj ŝanĝoj](https://github.com/nixos/nixpkgs/pulls/) estas faritaj al la ĉefarbo. Por uzi la
gitkopion, klonu la [deponejon](https://github.com/nixos/nixpkgs):

    $ git clone https://github.com/nixos/nixpkgs ~/nixpkgs

Tiu komando kreas dosierujon `nixpkgs/` sub la hejmdosierujo. Se la uzanto estas `vakelo`, la klono
de la deponejo troveblas ĉe `/home/vakelo/nixpkgs/` aŭ `/Users/vakelo/nixpkgs/`, se oni uzas linukson aŭ
makintoŝon respektive.

Por instali pakon, ekzemple, *emem*—markdaŭna- al HTML-dosiero konvertilo—per la gitkopio, rulu:

    $ nix-env -f ~/nixpkgs/default.nix -iA emem

Tiu komando elŝutas *emem* kun ĝiajn dependecojn, kaj la programon ĝi disponebligas al
oni. Por certigi, ke emem estas efektive instalita, rulu:

    $ emem --version

Se la ŝelo ne vomiĝas kaj plendas, kaj oni vidas versinombron, do signifas ke oni sukcese instalis
emem.

Por akiri la plej ĵusajn ŝanĝojn el la gitdeponejo, rulu:

    $ cd ~/nixpkgs && git pull origin master


#### <a name="nixpkgskanaloj">Kanaloj</a>

Instali pakojn per kanaloj pli agrablas tial, ke la komandoj por instali pakojn estas pli
oportunaj. La kompromiso, estas, ke la pakoj estas malaktualaj de iom da tagoj. Se oni kontentas pri
tio, do uzi kanalojn anstataŭ la gitkopion.

Kanaloj estas etikeditaj `stable`, `unstable`, aŭ per specifa versinombro, ekzemple, `18.09` aŭ
`21.11`. Por ĉi tiu artikolo, ni uzu `unstable`—ĝi nek estas tiom malaktuala kiel `stable` nek
tiom ĵuŝa kiel la gitkopio. Por aboni al la `unstable`-kanalo, rulu:

    $ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs

Ĉi tio irprenas la kanalon etikedita `nixpkgs-unstable` el nixos.org, tiam instalos ĝin al la
uzantprofilo.

Por esplori la listojn de kanaloj, iru [ĉi tien](https://nixos.org/channels/).

Per la ekzemplo ĉi-supre, instali *emem*, rulu la jenajn komandojn por NixOS kaj aliaj
sistemoj, respektive:

    $ nix-env -iA nixos.emem

    $ nix-env -iA nixpkgs.emem


Por ĝisdatigi la kanalojn, rulu:

    $ nix-channel --update

Tempe, arboj en `/nix/store/` kreskiĝas kaj eble ekzistas dosierindikoj kiuj ne plu estas
referencitaj per ajna pako. Por purigi ĝin, rulu:

    $ nix-collect-garbage


#### <a name="nixpkgsaliaj">Aliaj komandoj</a>

Por malinstali pakon, rulu:

    $ nix-env -e emem

Por listigi ĉiom da instalitaj pakoj, rulu:

    $ nix-env -q --installed

Por listigi ĉiom da instaleblaj pakoj, rulu:

    $ nix-env -q --available


### <a name="nixpkgsagordajxo">Agordaĵo</a>

La dosiero `~/.nixpkgs/config.nix` estas Nix-esprimo, kiu estas legita per la Nix-komandoj. Ene, oni
povas specifi pakajn transpasojn—agordo kiu uzurpas implicitajn agordojn kaj aliajn alĝustigilojn,
inkluzive, sed ne limigataj al, retumilaj kromprogramoj, grafikfasadoaj agordoj, SSL, ktp.

Ni rigardu malpligrandigitan version de mia `config.nix`:

```
{ pkgs }:

{
  packageOverrides = pkgs: {
    emacs = pkgs.emacs.override {
      withGTK2 = false;
      withGTK3 = false;
      withxwidgets = false;
    };
  };

  firefox = {
    jre = true;
    enableGoogleTalkPlugin = true;
  };

  allowUnfree = true;
}
```

Tiu estas funkcio, kiu akceptas atribuon kiel parametro, kaj liveras alian atributaron kiel
liveraĵo. Mia _config.nix_ diras, ke mi ne volas havi GTK por emakso. Por fajrfokso, mi specifas, ke
nur mi volas uzi JRE- kaj je Google Talk-kromprogramoj. Laste, mi specifas, ke programaroj kiuj
ne havas malfermitkodajn permesilojn, aŭ programoj kiu ne havas la liberprogramaran modelon, mi
volas esti kapablaj por instali


### <a name="nixpkgskontribui">Kontribui</a>

La kunlaborada modelo de Nixpkgs restas ĉe gito kaj GitHub. Por kontribui pakon aŭ ĝisdatigi
ekzistantan pakon, forku la [Nixpkgs](https://github.com/nixos/nixpkgs/)-deponejon al la propra
GitHub-konto. Kreu novajn ŝanĝojn en nova branĉo, tiam kreu tirpeton.


#### <a name="nixpkgsgxisdatigi">Ĝisdatigi ekzistantan pakon</a>

Forkinte la deponejon, klonu la propran version de la deponejon:

    $ git clone git@github.com:vakelo/nixpkgs.git ~/nixpkgs

Ĉi tiu komando kreas kopion de la forko en la radiko de la hejmdosierujo. Iru al tiu dosierujo, tiam
la ni esploru la enhavojn :

```bash
$ cd ~/nixpkgs
$ tree -aFL 1
.
├── COPYING
├── default.nix
├── doc/
├── .editorconfig
├── .git/
├── .github/
├── .gitignore
├── lib/
├── maintainers/
├── .mention-bot
├── nixos/
├── pkgs/
├── README.md
├── .travis.yml
├── .version
└── .version-suffix

7 directories, 9 files
```

Sekve, ni trovu pakon kie ĝi loĝas, ekzemple, *GNU Hello*.

    $ grep hello pkgs/top-level/all-packages.nix
      hello = callPackage ../applications/misc/hello { };

Tio diras, ke la pako *hello* troveblas ĉe `../applications/misc/hello`. Rilate al la dosiero
`all-packages.nix`, la dosierindiko estas ĉe `pkgs/applications/misc/hello` aŭ
`~/nixpkgs/pkgs/applications/misc/hello`. Ni iru tien:

    $ cd pkgs/applications/misc/hello
    $ ls
    default.nix

Malfermu la dosieron `default.nix`:

```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "hello-2.10";

  src = fetchurl {
    url = "mirror://gnu/hello/${name}.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };

  doCheck = true;

  meta = {
    description = "A program that produces a familiar, friendly greeting";
    longDescription = ''
      GNU Hello is a program that prints "Hello, world!" when you run it.
      It is fully customizable.
    '';
    homepage = http://www.gnu.org/software/hello/manual/;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.eelco ];
    platforms = stdenv.lib.platforms.all;
  };
}
```

Tio diras al ni, ke la dosiero `default.nix`, estas dosiero kun parametro kiel atribuo kun du eroj.
La funkcio liveras La rezulton de voki `stdenv.mkDerivation` per enigo de atribua valaro . La valoro
por la atribuo `name` estas signovico kun la formato *paknomo-A.B.C*, en kiu, *paknomo* estas la
nomo de la pako kaj *A.B.C.* estas la versinombro. La valoro por la atribuo `src` estas la valoro
liverita per voki la funkcion `fetchurl`, per alia atribuara argumento. La valoro por la atribuo
`url` devas esti aŭ spegula specifo, kiel priskribite en `pkgs/build-support/fetchurl/mirrors.nix`,
aŭ kutima retejadreso. Tiukaze, ni uzis la GNU-spegulon kaj ni interpolis la variablon `name` ene
tiu signovico. La valoro de la atribuo `sha256` estas tiu, kiun ni akiris per ruli `nix-prefetch-url`
kontraŭ la retejadreso. Por akiri la kontrolsumon de `hello-2.10`, rulu:

```bash
$ nix-prefetch-url http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz
downloading ‘http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz’... [622/709 KiB, 64.6 KiB/s]
path is ‘/nix/store/3x7dwzq014bblazs7kq20p9hyzz0qh8g-hello-2.10.tar.gz’
0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i
```

Ĝi kongruas al la SHA256-specifo ĉi-supre.

La atribuo `doCheck` instruas al Nix por ruli la testojn por ĉi tiu pako.

La valoro de la atribuo `meta` estas alia atribuara specifo por aliaj detaloj pri la pako. La
valoroj specifitaj ĉi tie helpas Nix-programojn por klasi la pakon, inter aliaj aferoj. La mallonga
signovico en atribuo `description` priskribas la celon de pako. La atribuo `longDescription` estas
pli longa atribuo, eble plurlinia signovico por priskribi la pakon en pli da detalo. La atribuo
`homepage` estas retejadreso al la retejo de la pako. Oni ne plu bezonas citi ĝin per unuoblaj aŭ
duoblaj citiloj specife—ĝi faras ĝin interne. Oni ankoraŭ devas citi retejadreson se oni uzas
variablan interpolado. La atribuo `platforms` estas grava: ĝi ordas pakon ĝuste—oni ne devas munti
pakon ĉe makintoŝo kiu nur rulas ĉe linukso.

Se aperos nova versio de *GNU Hello*, ekzemple, versio 2.11, modifu la ĝustajn atribuojn. Tamen,
unue, ni kreu apartan branĉon por tio:

    $ git checkout -b hello-2.11

En `default.nix`, ŝanĝu la nomon al `hello-2.11` kaj ankaŭ ĝisdatigu la atribuon `sha256` . Kaj
cetere, se oni estas ĉe NixOS, aldonu la jenan valoron al `/etc/nixos/configuration.nix`:

    nix.useSandbox = true;

Se oni uzas alian linuksan sistemon aŭ oni uzas makintoŝon, aldonu la jenan al `/etc/nix/nix.conf`:

    build-use-sandbox = relaxed

Tiam, muntu la pakon:

    $ cd ~/nixpkgs
    $ nix-build -A hello

Se sukcesis la kunmetaĵo, aperos simbolligilo nomata `result` en la aktuala dosierujo. Ĉi tiu
simbolligilo indikas al dosierindiko en `/nix/store`. Ni rulu la programon:

    $ ./result/bin/hello
    Hello, world!

Bonege. La enmetu ŝanĝojn.

    $ git add -u
    $ git commit -m 'hello: 2.10 -> 2.11'
    $ git push origin hello-2.11

Fine, iru al la GitHub-deponeja [paĝo](https://github.com/nixos/nixpkgs), tiam kreu tirpeton inter
`nixos/nixpkgs:master` kaj `vakelo/nixpkgs:hello-2.11`.


#### <a name="nixpkgssendi">Sendi novan pakon</a>

La paŝoj por sendi novan pakon estas preskaŭ simila al ĝisdatigi novan pakon, krom malmultaj aferoj.

En la komenco, kreu novan branĉon por la pako:

    $ cd ~/nixpkgs
    $ git checkout -b tthsum-1.3.2

Tiam, decidu pri kiu kategorio ĝi devas aparteni:

    $ cd pkgs/applications/misc
    $ mkdir tthsum

Tiam, kreu la dosieron `default.nix`:

```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "tthsum-${version}";
  version = "1.3.2";

  src = fetchurl {
    url = "http://tthsum.devs.nu/pkg/tthsum-${version}.tar.bz2";
    sha256 = "0z6jq8lbg9rasv98kxfs56936dgpgzsg3yc9k52878qfw1l2bp59";
  };

  installPhase = ''
    mkdir -p $out/bin $out/share/man/man1
    cp share/tthsum.1.gz $out/share/man/man1
    cp obj-unix/tthsum $out/bin
  '';

  meta = with stdenv.lib; {
    description = "An md5sum-alike program that works with Tiger/THEX hashes";
    longDescription = ''
      tthsum generates or checks TTH checksums (root of the THEX hash
      tree). The Merkle Hash Tree, invented by Ralph Merkle, is a hash
      construct that exhibits desirable properties for verifying the
      integrity of files and file subranges in an incremental or
      out-of-order fashion. tthsum uses the Tiger hash algorithm for
      both the internal and the leaf nodes.
    '';
    homepage = http://tthsum.devs.nu/;
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.ebzzry ];
    platforms = platforms.unix;
  };
}
```

Oni povas rimarki, ke ni uzas la anglan ene tial, ke ĝi estas la devigita lingvo en la tutprojekto.

Kio novas ĉi tie estas la atribuo `installPhase`. La implicita kunmetada procedoj de la
*tthsum*-pako malsamas al la maniero, en kiu Nix traktas instalojn, do ni devas esti specifa pri
tio. La identigilo `$out` estas pri la fina dosierujo kie la programo loĝos en `/nix/store/`. En la
uzantmedio, haveblos la programo ĉe `~/.nix-profile/bin/tthsum`, kaj en la sistemmedio haveblos la
programo ĉe `/run/current-system/sw/bin/tthsum`.

En ĉi tiu punkto, Nix ne ankoraŭ estas konscia pri *tthsum*. Ni devas deklari ĝin en la supra
nivelo. Por tiel fari, redaktu la dosieron `pkgs/top-level/all-packages.nix`, kaj aldonu la jenan en
la ĝustan kategorion.

```nix
tthsum = callPackage ../applications/misc/tthsum { };
```

Tiam, muntu la pakon kiel priskribite ĉi-supre:

    $ cd ~/nixpkgs
    $ nix-build -A tthsum

Se sukcesis ĉio, enmetu la ŝanĝojn:

    $ git add pkgs/applications/misc/tthsum
    $ git add pkgs/top-level/all-packages.nix
    $ git commit -m "tthsum: init at 1.3.2"
    $ git push origin tthsum-1.3.2

Fine, iru al la GitHub-deponeja [paĝo](https://github.com/nixos/nixpkgs), tiam kreu tirpeton inter
`nixos/nixpkgs:master` kaj `vakelo/nixpkgs:tthsum-1.3.2`.


### <a name="nixpkgsnotoj">Notoj</a>

En ajna punkto dum la instalo de pako, kaj la procezo estas interrompita, la pako ne fariĝos
instalita en duone bakita stato. La plej lasta paŝo de instali pakojn estas atoma. La sekreto,
estas, ke la sistemo kreas simbolligilon de `/nix/store` al `~/.nix-profile/`, la operacio kiu
disponebligas ĝin al uzanto. La kreado de simbolligiloj en linukso kaj makintoŝo estas aŭ sukcesa
aŭ ne.

Ĉe NixOS, la kanalo uzita de la ĉefuzanto estas grava tial, ke ĝi estas tiu, kiun oni uzas kiam
la rekunmeti sistemon per `nixos-rebuild switch` post ŝanĝoj al `/etc/nixos/configuration.nix` estas
faritaj. Por certigi, ke oni uzas la pravan kanalon, listigu ĝin per:

    $ sudo nix-channel --list

Por ŝanĝi la ĉefuzantan kanalon simila al tiu, kiu estis uzita antaŭe:

    $ sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos


<a name="medioj">Medioj</a>
---------------------------

Medio estas maniero de Nix por provizi komponantan izoladon inter la sistemo kaj uzantoj. En NixOS,
ekzistas tri medioj: sistemmedio, uzantmedio, kaj programadmedio.


### <a name="sistemmedio">Sistemmedio</a>

La sistemmedio estas modifita nur per la ĉefuzanto kiu ĝi deklaras la valorojn en
`/etc/nixos/configuration.nix`. Ĝi estas listo, kiu enhavas la pakojn kiu disponebliĝos al ĉiuj
uzantoj de la sistemo. Jen ekzemplo de `/etc/nixos/configuration.nix` kiu uzas la sistemmedion:

```nix
{ config, lib, pkgs, ... }:

{
  ...
  environment.systemPackages = with pkgs; [ zsh vim ];
  ...
}
```

Tiu deklaras, ke la pakoj nomitaj *zsh* kaj *vim* disponeblos por ĉiuj uzantoj de la sistemo. La
duumdosieroj disponeblos kiel `/run/current-system/sw/bin/zsh` kaj `/run/current-system/sw/bin/vim`,
por Ziŝo kaj Vim, respektive.

Parenteze, la sistemmedio ekzistas nur ĉe NixOS .


### <a name="uzantmedio">Uzantmedio</a>

La uzantmedio estas tiu, kiu estas uzita kiam ajn la komando `nix-env` estas uzita. Ekzemple,
instali ziŝon per nix-env:

    $ nix-env -iA nixos.zsh

Ziŝo fariĝos specife disponebla por la uzanto kiu alvokas ĝin. Se `johano` estas la uzanto kiu rulis
tiun komandon, tiam la ziŝa duumdosiero disponebliĝos kiel `/home/johano/.nix-profile/bin/zsh`. Se
la uzanto `mario` ankoraŭ ne instalis ziŝon en sia profilo, tiam ĝi ne disponeblas por si. Se Mario
havas la saman kanalon kiel Johano, kaj ĝi kuris la saman *nix-env*-komandon, tiam Nix ne plu
bezonas elŝuti la ziŝan programan datumon el nulo. Anstataŭe, disponebliĝas por Mario la ziŝa
programa datumo, kiu estis kreita de la procezo de Johano antaŭe. Tamen, se Mario uzas gitkopion aŭ
alian version de kanaloj kontraŭ tiu kiun Johano uzas, kaj la versio de Ziŝo malsamas al tiu kiun
Johano uzas, tiam la alvoko de `nix-env` per Mario elŝutos novan instancon de ziŝo .


### <a name="programadmedio">Programadmedio</a>

La tria medio, la programadmedio, estas kreita per la uzo de nix-shell. nix-shell ebligas la uzanton
por krei sablujmediojn. La medio kreita estas izolita de la sistemo kaj kutimaj uzantmedioj. la
medio kreita ankoraŭ uzos `/nix/store`, sed nek `/run/current-system/sw/` nek `~/.nix-profile/`
estos modifita. Kiun nix-shell disponigas estas medio, kiu estas aparta de la cetero de la sistemo,
permesante la uzanton por krei porokazajn disponigojn sen maltrankvilo pli la modifado de la
sistemstato. Per tio, uzanto gajnas la kapablon por uzi medion por elprovi diversajn disponigojn de
apo aŭ por kontrasti eblojn antaŭ liverado.

Por krei mediojn kiuj estas malkonektitaj al la cetero de la sistemo, ni bezonas havi manieron por
apartigi la dependencojn de apo kaj sia datumo mem, de kutima sistema interveno. nix-shell ebligas
onin por krei maldikajn nivelojn de abstraktado, ekspluante la determinismon kaj risurcan
administradon de Nix mem.

Por ilustri, ni kontrolu, ke [GNU Hello](https://www.gnu.org/software/hello/) ne fakte estas ankoraŭ
instalita:

    $ which hello
    hello not found

Se tio estas la kazo, do bone. Aliokaze, unue forigi la *GNU Hello*-pakon.

Nu, por montri nix-shell, ni rulu GNU Hello en nix-shell, tiam ĝi revenos al la kutima uzantŝelo.

    $ nix-shell --packages hello --pure --run hello
    Hello, world!
    $ which hello
    hello not found

Kion tio faras, estas, ke ĝi elŝutos la duumpakon por GNU Hello, kreante puran ŝelan medion, tiam
progresas por ruli la duumdosieron `hello`, kiu montros la konatan saluton al la ekrano. Se la
`‑‑run` opcio estas forigita, ni faliĝos en ŝelo:

    $ nix-shell --packages hello --pure
    [nix-shell:~]$ hello
    Hello, world!

Tiu ŝelinstanco estas speciala tial, ke ĝi enhavas nur sufiĉan informon por igi la komandon
`hello` disponebla. Ni eĉ povas kontroli la valoron de `$PATH` tie:

```bash
[nix-shell:~]$ echo $PATH | tr ':' '\n'
/nix/store/kc912zn1ry1xilcm901ip7p8s1iqv0f1-hello-2.10/bin
/nix/store/f9q8k36x9jpi8jmdpwifcywzywpxvhrs-patchelf-0.9/bin
/nix/store/xx2bclrflkcvrddvp6bd3wsasqs7vsp1-paxctl-0.9/bin
/nix/store/4d6f8hg5gv20nsbq7b52qzn6bcs4fvlh-coreutils-8.26/bin
/nix/store/f3vl26f3n18khgq1kybnzvwjbm0r9grg-findutils-4.6.0/bin
/nix/store/mvnjpifk06yjffrsd50rpr3jjfrjsqiv-diffutils-3.5/bin
/nix/store/0xwrn1p8fp8h3cynszpgbmhmydbzhns5-gnused-4.4/bin
/nix/store/avmxym1w34sc17nrilsmgrk469l3ml0z-gnugrep-3.0/bin
/nix/store/2vh4wllg66rw61ffdfwp1xm4r2yns44j-gawk-4.1.3/bin
/nix/store/rhjsykhxrzj3ca8da6b4g6v1yx53xpi3-gnutar-1.29/bin
/nix/store/w1vlvxlavmz39by5xpnhva36q2lbi9hf-gzip-1.8/bin
/nix/store/mgvqw07ssjhf1hb96md97rjkfsrmfmp6-bzip2-1.0.6.0.1-bin/bin
/nix/store/69y0laqzizjycwaqivbsp273n0ag3ayi-gnumake-4.2.1/bin
/nix/store/86blj9iqyxwmdgkn3dyrpib1gkbmz91v-bash-4.4-p5/bin
/nix/store/qjklkl51d6qp98n8nncvbv62p01pp6qf-patch-2.7.5/bin
/nix/store/8pcap19p6qwf06ra4iaja3n6k6p2jzwg-xz-5.2.2-bin/bin
```

La eligo malsamos kontraŭ la mia pro la kradvaloroj en la tenejaj dosierindikoj. Ekster la teneja
dosierindiko de *GNU Hello*, la ceteraj estas la minimumaj komponantoj de nix-shell-instanco. Ĉi tiu
sektoraro nomiĝas *stdenv*.

nix-shell serĉas la dosierojn `shell.nix` aŭ `default.nix` , en tiu ordo, ĉe la aktuala dosierujo dum
startigo, por elŝargi la difinojn. Ni kreu ĝin, konservante ĝin kiel `default.nix`:

```nix
{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ hello emem ];
}
```

*.nix*-dosiero estas Nix-esprimo mem. En ĉi tiu ekzemplo, ĝi estas funkcio kiu akceptas unu
argumenton kun implicita valoro. La bizara `<nixpkgs>`-esprimo indikas la valoron de la atribuo
`nixpkgs`, deklarita en la media variablo `NIX_PATH`. Ĉe NixOS, ĝi aspektas jene:

    $ echo $NIX_PATH
    nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels

En la dosierujo kiu estas indikata de la atribuo `nixpkgs`, ĝi estas la dosiero `.git-revision`. Ni kontrolu ĝian
enhavon:

    $ cat /nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs/.git-revision
    1e8c01784a6a121fc94d111f4af7cc88dd932186

Ĉi tio diras al ni la version de Nixpkgs-kanaloj uzata en ĉi tiu profilo.

Iri reen, la deklaro `with pkgs` metas ĉiom da identigiloj en la lokamplekso, igas ilin videblaj.
`stdenv`, kiu estis menciita antaŭe, estas atribuaro kiu inter multaj aferoj, enhavas la identigilon
`mkDerivation`. `mkDerivation`, sinsekve, estas funkcio kiu akceptas unu atribuaran argumenton.
Memorigu, ke la kunigkrampoj post `mkDerivation` specifas unu eron da argumento kiu estas atribuaro;
ĝi ne havas semantikan similecon al la kunigkrampoj de aliaj programlingvoj por limigi la komencon
kaj finon de funkciamplekso. Estas pluraj alĝustigiloj por ĝi, tamen por la celoj de simpleco, nur
ni kontrolos `name` kaj `buildInputs`—la apenaŭaj atribuaj parametroj.

Por nia bagatela ekzemplo, la voloro de `name` povas esti io ajn. La valoro de `buildInputs`, tamen,
estas grava. Ĉi tie, ili estas deklaritaj `hello` kaj `emem`. Estas referencoj al valoroj en la
`nixpkgs`-markilo, kiun ni vidis antaŭe. Se ni ne uzis `with pkgs` , la esprimo estus:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ pkgs.hello pkgs.emem ];
```

Por manĝigi ĉi tiun esprimon al nix-shell, uzante ambaŭ *hello* kaj *emem*, rulu:

    $ nix-shell --pure --run "hello | emem -w"
    <p>Hello, world!</p>

nix-shell donas al ni fortajn abstraktadajn meĥanismojn kiuj estas rigarditaj tre malfacilaj por
fari en aliaj metodoj. Ĝi ekspluatas la determinismajn kvalitojn de Nix, kreante fortan avantaĝon.


<a name="surmetoj">Surmetoj</a>
-------------------------------

Estos tempoj en kiuj oni devas fari ŝanĝojn al la paksistemo, tamen oni ne pretas por iri tutfreneze
kaj fuŝi la gitdeponejon. Ankaŭ estos tempoj en kiuj oni volas havi privatan deponejon, sed oni ne
volas publikiĝi. Surmetoj povas helpi onin por tiu celo.

Kiel la nomo implicas, la surmeto meĥanismo estas maniero por krei abstraktan nivelon super la
ekzistantaj esprimoj. Unu uzo estas samkiel porti benkseĝaron por intervjuo—vi ankoraŭ estas vi
sube, sed draste ŝanĝiĝis via aspekto. Alia uzo estas samkiel anstataŭigi viajn internajn organojn
kibernetike—vi ankoraŭ estas iomete vi, sed draste ŝanĝiĝis pluraj partoj de vi interne.
Alia uzado, kiu estas unu el miaj plej ŝatataj, estas krei novan eston el virtuala nenio.

Surmetaj dosieroj estas viaj konataj Nix-esprimoj kun specifa formato. Ili loĝas ĉe
`~/.config/nixpkgs/overlays/`. Se oni ne havas tiun dosierujon, oni povas krei ĝin per:

    $ mkdir -p ~/.config/nixpkgs/overlays

Mi strukturas miajn surmetajn dosierojn en kiu ĉiu dosiero kongruas al unu pako, kies konduton mi
volas ŝanĝi.


### <a name="surmetojtranspasoj">Transpasoj</a>

Ekzemple, se oni volas certigi ke la dokumentaro por
[Rakido](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/interpreters/racket/default.nix)
estos instalitaj, kreu la dosieron `~/.config/nixpkgs/overlays/racket.nix` per la jena enhavo:

```nix
self: super: {
  racket = super.racket.override {
    disableDocs = false;
  };
}
```

Tiu estas Nix-funkcio kun du argumentoj—`self` kaj `super`. `super` referencas al la esprimoj kiuj
apartenas al la sistemo, dum `self` referencas al la aro de esprimoj kiujn oni difinas. Estas
devige, ke estas nur du argumentoj kaj ili estas `self` kaj `super`.

Sekve, precizigu, ke por la `racket`-atributo, ĝi vokos la funkcion `override` el la fonta tavolo,
donante al ĝi atributan aron kiu enhavas la transpasojn.

Alia ekzemplo estas ke se oni volas ŝalti [NaCl](https://developer.chrome.com/native-client) por
[Chromium](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/browsers/chromium/default.nix),
kreu la dosieron `~/.config/nixpkgs/overlays/chromium.nix` per la jena enhavo:

```nix
self: super: {
  chromium = super.chromium.override {
    enableNaCl = true;
  };
}
```

Kiam oni instalas Racket aŭ Chromium, tiuj agordoj estos legataj kaj efektiviĝos.

    $ nix-env -iA $(nix-channel --list | awk '{print $1}').racket


### <a name="surmetojnovajpakoj">Novaj pakoj</a>

Uzi la surmetan sistemon por krei novajn pakojn estas ideala se oni ne volas doni la pakon al
Nixpkgs, oni volas privatigi ĝin, aŭ oni volas aldoni novan infrastukturon sen trakti la ekstran
komplekson.

Ni supozu, ke ekzistas simpla ŝela programo _moo_ kiu loĝas ĉe <https://github.com/ebzzry/moo>, kaj
oni deziras paki ĝin. Por fari tion, oni skribos du aĵojn:

1. la supran surmetan dosieron en `~/.config/nixpkgs/overlays/`; kaj
2. la Nix-esprimon kiu je _moo_ fakte kreas.

Por #1, kreu la dosieron `~/.config/nixpkgs/overlays/moo.nix` per la jena enhavo:

```
self: super: {
  moo = super.callPackage ./pkgs/moo { };
}
```

Tiam, por #2, kreu la dosierarbon por la esprimo. Memoru, ke ne devigatas la nomo
`pkgs`:

    $ cd ~/.config/nixpkgs/overlays
    $ mkdir -p pkgs/moo

Tiam kreu la dosieron `~/.config/nixpkgs/overlays/pkgs/moo/default.nix` per la jena enhavo:

```nix
{ stdenv, fetchFromGitHub, bash }:

stdenv.mkDerivation rec {
  name = "moo-${version}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ebzzry";
    repo = "moo";
    rev = "abd22b4860f83fe7469e8e40ee50f0db1c7a5f2c";
    sha256 = "0jh0kdc7z8d632gwpvzclx1bbacpsr6brkphbil93vb654mk16ws";
  };

  buildPhase = ''
    substituteInPlace moo --replace "/usr/bin/env bash" "${bash}/bin/bash"
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp moo $out/bin
    chmod +x $out/bin/moo
  '';

  meta = with stdenv.lib; {
    description = "Random helper";
    homepage = https://github.com/ebzzry/moo;
    license = licenses.cc0;
    maintainers = [ maintainers.ebzzry ];
    platforms = platforms.all;
  };
}
```

Per tiuj du dosieroj, oni nun povas instali _moo_ :

    $ nix-env -iA $(nix-channel --list | awk '{print $1}').moo


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Nix provizas potencajn ilojn por administri facile sistemojn kaj programadajn agordojn. Ĝi havas
fleksajn facilojn por krei rendimentajn laborfluojn kaj distrubuajn modelojn. Se mi devas listigi la
plej gravajn eblojn de la Nix-ekosistemo kiuj plaĉas al mi, ili estas la jena:

- determinisma
- reproduktema
- senstata
- deklara
- kohera
- portebla
- fidebla
- pure funkcia

Alia grava ano de la Nix-familio estas [NixOps](https://nixos.org/nixops); ĝi ebligas onin por
disponigi NixOS ĉe «nudmetalaj» sistemoj, virtualaj sistemoj, aŭ la nubo, per la uzo de deklara
aliro kiu estas konata al ni. Ĝi eblas disponigi al *VirtualBox*, *Amazon EC2*,
*Google Compute Engine*, *Microsoft Azure*, *Hetzner*, *Digital Ocean*, kaj *Libvirtd*. Iru al la
[gvidilo](https://nixos.org/nixops/manual/) por vidi pli da detalo.

Fundajn detalojn pri generadoj, derivaĵoj, kaj efektivigadoj estis eliziitaj intence en ĉi tiu
artikolo. Ili povas fariĝi sekcio per si mem, aŭ mi eblas ĝisdatigi ĉi tiun artikolon por aldoni tiujn
temojn. Estas eble, ke mi skribos novan sekcion pri NixOS .

Emaksa ĉefregimo por Nix-dosieroj haveblas de la [ĉefdeponejo](https://github.com/NixOS/nix-mode) de
NixOS. Ĝi ankaŭ haveblas per [MELPA](https://melpa.org/#/nix-mode). Oni povas instali ĝin per:

```
M-x package-install EN nix-mode EN
```

Ekzistas aliaj pakaj administradaj sistemoj kiuj ankaŭ provas solvi ĉi tiun problemareon. Tiuj,
kiujn mi konas estas [AppImage](http://appimage.org/), [Zero Install](http://0install.net/),
[Snapcraft](https://snapcraft.io/), kaj [Flatpak](http://flatpak.org/).

La [Guix System Distribution (GuixSD)](https://www.gnu.org/software/guix/) estas linuksa distribuo
kiu estas bazita sur Nix. Ĝi uzas [Guile](https://www.gnu.org/software/guile/) kiel sia API-lingvo.
La kerna kontrasto inter GuixSD kaj NixOS, estas, ke GuixSD uzas
[GNU Shepherd](https://www.gnu.org/software/shepherd/) anstataŭ systemd; neliberajn pakojn ĝi ne
permesas; kaj ĝi uzas [Linux-libre](https://www.fsfla.org/ikiwiki/selibre/linux-libre/),
malpligrandigita versio de la baza kerno kun ĉiom da komercaj aĵoj forigitaj. Pli da informo pri
iliaj kontrastoj troveblas
[ĉi tie](https://sandervanderburg.blogspot.de/2012/11/on-nix-and-gnu-guix.html).

Ekster GuixSD, ekzistas aliaj projektoj kiujn Nix inspiris. Estas [Habitat](https://habitat.sh),
aplikaĵa aŭtomacia framo; kaj [ied](https://github.com/alexanderGugel/ied), alterna paka
administrilo por Node.js.

La artikoloj de
[Luca BRUNO](https://lethalman.blogspot.com/2014/07/nix-pill-1-why-you-should-give-it-try.html),
[James FISHER](https://jameshfisher.com/2014/09/28/nix-by-example/),
kaj
[Oliver CHARLES](https://web.archive.org/web/20180610095602/https://ocharles.org.uk/blog/posts/2014-02-04-how-i-develop-with-nixos.html),
kune la [NixOS](https://nixos.org/nixos/manual), [Nixpkgs](https://nixos.org/nixpkgs/manual),
kaj [Nix](https://nixos.org/nix/manual) gvidiloj, ege helpis min por kompreni Nix. Apartaj dankoj
iras al [François-René RIDEAU](https://fare.livejournal.com) por enkonduki min al Nix antaŭ multaj jaroj.

La NixOS-fondiĝo estas registrita senprofitcela organizo; la
[oferdonoj](https://nixos.org/nixos/foundation.html) ege helpas en la programado de Nix. Aliĝu al la
[komunumo](https://nixos.org/nixos/community.html) kaj helpu ĝin kreskiĝi!


<a name="bonifiko">Bonifiko</a>
-------------------------------

Jen la [ipsilonkombinatoro](/eo/ipsilono/) en Nix, aplikita al la faktoriala funkcio:

```nix
nix-repl> y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v)))))

nix-repl> b = p: (n: if n == 0 then 1 else (n * (p (n - 1))))

nix-repl> f = y b

nix-repl> f 20
2432902008176640000
```

aŭ, en unu esprimo, per *let*:

```nix
nix-repl> let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v)))));
              b = p: (n: if n == 0 then 1 else (n * (p (n - 1))));
              f = y b;
          in f 20
2432902008176640000
```

Oni povas konduki la ĉefeligujon al nix-repl:

```nix
$ echo 'let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20' | nix-repl
Welcome to Nix version 1.11.8. Type :? for help.

nix-repl> let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20
2432902008176640000

nix-repl>
```

_Dank’ al [Dan SVOBODA](https://github.com/dansvo) pro la korektoj._
