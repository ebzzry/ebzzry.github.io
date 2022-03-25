Milda Enkonduko al la Nix-Familio
=================================

<div class="center">Esperanto ■ [English](/en/nix/)</div>
<div class="center">Laste ĝisdatigita: la 22-an de Februaro 2022</div>

>Ne maltrankviliĝu pri tio, kion la aliaj faros. La plej bona maniero por antaŭdiri la estontecon
>estas por eltrovi ĝin.<br>―Alan KAY

<img src="/bil/wallhaven-751942-1008x250.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="wallhaven-751942" title="wallhaven-751942"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
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
    * [Ekzistantan pakon ĝisdatigi](#nixpkgsgxisdatigi)
    * [Novan pakon sendi](#nixpkgssendi)
  + [Notoj](#nixpkgsnotoj)
- [Medioj](#medioj)
  + [Sistemmedio](#sistemmedio)
  + [Uzantmedio](#uzantmedio)
  + [Disvolvmedio](#disvolvmedio)
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

[NixOS](https://nixos.org) (niks-oh-es) estas linuksa distribuo kiu solvas ĉi tiajn problemojn per
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


#### <a name="nixossxalti">La maŝinon ŝalti</a>

Praŝargu per la USB-poŝmemorilo en UEFI-reĝimo. Ĉe la ensaluta invito, ensalutu kiel `root`.


#### <a name="nixosreto">La reton agordi</a>

Skanu haveblajn retojn:

    # nmcli d wifi list

Tiam, konektu al la preferata enkursigilo:

    # nmcli d wifi con ENKURSIGILO name NOMO password PASVORTO


#### <a name="nixosdiskoj">La diskojn pretigi</a>

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

Ĉi tiu esprimo revenas fermon de parte aplikita funkco. Ni bezonas alian valoron por tute apliki ĝin:

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

Ĉi tiu esprimo kreas sennoman funkcion kiu revenas sian argumenton—la
[identa funkcio (angle)](https://en.wikipedia.org/wiki/Identity_function). La dupunkto post la unua
`x` montras, ke ĝi estas parametro al la funkcio, samkiel en
[lambdokalkulo](/eo/lambdokalkulo/#funkcioj). Aldone, la nomoj ne gravas pro
[alfa-ekvivalenteco](https://eo.wikipedia.org/wiki/Lambda-kalkulo#%CE%B1-konverto):

```nix
nix-repl> hundo-kato-muso: hundo-kato-muso
«lambda»
```

Ĉi tiuj funkcioj ne estas tre utilaj tial, ke ili ne estas kaptitaj por aplikado. Se oni volas ĝin,
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

Ĉi tiu funkcio havas du parametrojn: `{ a, b }`—parametra specifo por aro kun du eroj, kaj
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

Kondiĉesprimoj estas faritaj per la `if` ŝlosilvorto. Ĝi havas similan formon de plimultaj lingvoj:

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

La ideo de dosierojn enporti en Nix-esprimo estas subtile malsame al aliaj lingvoj. Enportoj en Nix
intime rilatas al aroj. Supozante, ke la dosieron `ve.nix` ni havas, kiu la jenan enhavas:

```nix
let
  ve = x: x + "ve";
in {
  ve = ve;
}
```

La saman `ve` la let-esprimo bindas al funkcio kiu unu argumenton akceptas. En la korpo de `let`,
aron ĝi revenas kiu unu membron kun la nomo `ve` havas—tiu en la maldekstra parto de la `=`. La
valoro de ĉi tiu ano estas la funkcio kiun ni ĵus difinis. La grava koncepto por memorigi, estas, ke
atribuaron ĉi tiu let-esprimo revenas.

Ni reen iru al la [REPL (angle)](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
por ĉi tiun dosieron uzi:

```nix
nix-repl> import ./ve.nix
{ ve = «lambda»; }
```

La lambdo-terminon ni denove vidas. Sajnas, ke la `ve` nomo ĉi tie estas funkcio. Nun, kiel ĉi tiun
valoron ni povas elreferenci? La operatoron `.` ni uzu!

```nix
nix-repl> (import ./ve.nix).ve "hundo"
"hundove"
```

Rondkrampojn ni devis uzi tial, ke ne ekzistas tia dosiero `ve.nix.ve` en la aktuala dosierujo. Se ĝin
ni trapasos, ĝi aperos jene:

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

Nixpkgs (niks-pa-kej-ĝes) estas kolekto de pakoj organizitaj kaj administritaj per uzantoj
tutmonde. Pro tio ke la fontkodo estas en [GitHub](https://github.com/nixos/nixpkgs), la avantaĝon
de la potenca kunlaborada sistemo kiun tiu platformo ofertas ĝi eblas ekspluati. Grandan vicaron da
pakoj la [kolekto](https://nixos.org/nixos/packages.html) havas, de produktivecaj apoj al teoremaj
pruviloj.

Pakojn plejparto de popularaj operaciumoj traktas bone, ĝis ili ne plu. Tiel longe kiel oni movas en
rektan linion, sole, oni sekuras. Aferoj ŝanĝiĝas, kiam aliaj homoj enkondukiĝas en la marŝo. Por ke
la tutgrupo movu en unisono, ĉiuj devas esti konektita al unu la alia. Se ano decidas forvojaĝi, kaj
sole marŝi, la tutgrupo kripliĝos. Tamen, se ĝin tiu ano decidas kloni por ke la forvojaĝado fariĝu
sendependa, la originala marŝada grupo fariĝas nemodifita.

La kazon de distribuo celita kiel pluruzanta produkta disvolva medio ni traktu. Kiam fajrfokson
versio 100 oni instalas, la ĉefa duuma dosiero iras al aŭ `/usr/bin/firefox` aŭ
`/usr/local/bin/firefox`. Sekve, la apon el tiu dosierindiko ĉiomajn uzantojn povas aliri; Johano,
Mario, kaj Petro feliĉas. Bedaŭrinde, se ĝin Johano decidis aktualigi al versio 200, la sama apo
kiun Mario kaj Petro uzas ankaŭ aktualiĝis! Tio ne estas bonaĵo se la malnovan version kiu funkcias
al ili ili preferas! Onin Nix permesas por plurajn versiojn de programaro havi sen kolizioj al la
aliaj versioj. Siajn preferatajn versiojn de fajrfokso Johano, Mario, kaj Petro povas havi sen
konfliktoj kun la aliaj versioj. Kiel ĝin Nixpkgs faras? Ĝin ĝi faras per la komponantojn nomi per
iliaj kalkulitaj kontrolsumoj kaj per komunan tutmondan lokon ne uzi.

Siajn proprajn versiojn de `~/.nix-profile` ĉiom da uzantoj havas kaj kutimajn dosierojn ĉiom da
enhavo de tiuj dosierujoj ne havas. Anstataŭ, ili estas simbolligiloj al la efektivaj dosieroj
troveblas en `/nix/store/`. Ĉi tiu dosierujo, estas kie la programoj kaj siaj dependecoj estas
efektive instalitaj. La nur maniero por skribi al tiu dosierujo estas per la dediĉitaj
Nix-programoj. Ne estas maniero por tiun dosierujon rekte modifi per normaj manieroj. Do, kiam je
Vim 8 la uzanto `johano` instalas, la programo fariĝas instalita kiel
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329`. La signoj antaŭ la paknomo estas la
kontrolsumo de ĉiom da enigoj kiuj estis uzitaj por la pakon konstrui. La dosiero
`/home/johano/.nix-profile/bin/vim` tiam montras al simbolligo, en dosiero troveblas en
`/nix/store/` kiu kondukas al la efektiva Vim-duumdosiero en
`/nix/store/w4cr4j13lqzry2b8830819vdz3sdypfa-vim-8.0.0329/bin/vim`.


### <a name="nixpkgsinstalo">Instalo</a>

Se je NixOS oni uzas ĉi tiun sekcion preterpasu tial, ke Nixpkgs iras kun ĝi. Por je Nixpkgs instali
ĉe linukso aŭ makintoŝo, rulu:

    $ curl https://nixos.org/nix/install | bash

Oni invitiĝos al la ensalutilojn por ĉefuzantan aliron eniri per *sudo* tial, ke la risurcojn ĝi
instalos al `/nix/`. Post la instalo, oni petiĝas por linion de komando al la ŝela pravaloriza
dosiero aldoni. Kiam novajn aperaĵojn de la ŝelo oni generas la komandoj specifaj al Nix fariĝos
haveblaj.


### <a name="nixpkgsuzado">Uzado</a>

Estas du manieroj por pakojn instali per Nixpkgs; la gita kopio, kiu estas la plej ĵusa versio,
ĝisdatigita ĝis la lasta minuto, aŭ per kanalojn uzi. La
[gitdeponejo](https://github.com/nixos/nixpkgs) idealas por uzantoj kiuj la plej novajn versiojn de
pako volas uzi, aŭ por uzantoj kiuj volas eltesti. [Kanaloj](https://nixos.org/channels/) aliflanke,
estas esence kopioj de la gitdeponejo en antaŭ tempo.


#### <a name="nixpkgsgito">Gito</a>

Okazas ofte ĝisdatigoj al la gitdeponejo—ĉi tiun artikolon legante,
[novaj ŝanĝoj](https://github.com/nixos/nixpkgs/pulls/) estas faritaj al la ĉefarbo. Por la
gitkopion uzi, la [deponejon](https://github.com/nixos/nixpkgs) klonu:

    $ git clone https://github.com/nixos/nixpkgs ~/nixpkgs

`nixpkgs/` dosierujo ĉi tiu komando kreas sub la hejmdosierujo. Se la uzanto estas `vakelo`, la klono
de la deponejo troveblas ĉe `/home/vakelo/nixpkgs/` aŭ `/Users/vakelo/nixpkgs/`, se linukson aŭ
makintoŝon oni uzas respektive.

Por pakon instali, ekzemple, *emem*—markdaŭna- al HTML-dosiero konvertilo—per la gitkopio, rulu:

    $ nix-env -f ~/nixpkgs/default.nix -iA emem

Je *emem* ĉi tiu komando elŝutas kun ĝiajn dependecojn, kaj la programon ĝi disponebligas al
oni. Por certigi, ke emem estas efektive instalita, rulu:

    $ emem --version

Se la ŝelo ne vomiĝas kaj plendas, ke tio, kion oni volas trovi ne ekzistas, kaj versinombron oni
vidas, do signifas ke je emem oni sukcese instalis.

Por la plej ĵusajn ŝanĝojn akiri el la gitdeponejo, rulu:

    $ cd ~/nixpkgs && git pull origin master


#### <a name="nixpkgskanaloj">Kanaloj</a>

Pakojn instali per kanaloj pli agrablas tial, ke la komandoj por pakojn instali estas pli
oportunaj. La kompromiso, estas, ke la pakoj estas malaktualaj de iom da tagoj. Se oni bonas pri
tio, tiam kanalojn uzi anstataŭ la gitkopion.

Kanaloj estas etikeditaj `stable`, `unstable`, aŭ per specifa versinombro,
ekzemple, `18.09` aŭ `21.11`. Por ĉi tiu artikolo, je `unstable` ni uzu—ĝi nek
estas tiel malaktuala kiel `stable` nek tiel ĵuŝa kiel la gitkopio. Por aboni al
la `unstable`-kanalo, rulu:

    $ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs

La kanalon etikedita `nixpkgs-unstable` ĉi tio irprenas el nixos.org, tiam instolas al la
uzantprofilo.

Por la listojn de kanaloj esplori, [ĉi tien](https://nixos.org/channels/) iru.

Per la ekzemplo ĉi-supre, je *emem* instali, la jenajn komandojn rulu por NixOS kaj aliaj
sistemoj, respektive:

    $ nix-env -iA nixos.emem

    $ nix-env -iA nixpkgs.emem


Por la kanalojn ĝisdatigi, rulu:

    $ nix-channel --update

Tempe, arboj en `/nix/store/` kreskiĝas kaj eble ekzistas dosierindikoj kiuj ne plu estas
referencitaj per ajna pako. Por ĝin purigi, rulu:

    $ nix-collect-garbage


#### <a name="nixpkgsaliaj">Aliaj komandoj</a>

Por pakon malinstali, rulu:

    $ nix-env -e emem

Por ĉiomajn instalitajn pakojn listigi, rulu:

    $ nix-env -q --installed

Por ĉiomajn haveblajn pakojn listigi, rulu:

    $ nix-env -q --available


### <a name="nixpkgsagordajxo">Agordaĵo</a>

La dosiero `~/.nixpkgs/config.nix` estas Nix-esprimo, kiu estas legita per la Nix-komandoj. Ene,
pakajn transpasojn oni povas specifi—agordo kiu implicitajn agordojn uzurpas, kaj aliajn
alĝustigilojn, inkluzive, sed ne limigataj al, retumilaj kromprogramoj, grafikfasadoaj agordoj, SSL,
ktp.

Malpligrandigitan version de mia `config.nix` ni rigardu:

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

Ĉi tio estas funkcio, kiu atribuon akceptas kiel parametro, tiam alian atributaron liveras kiel
liveraĵo. Mia _config.nix_ diras, ke je GTK mi ne volas havi por emakso. Por fajrfokso, mi
specifis, ke nur je JRE- kaj je Google Talk-kromprogramoj mi volas uzi. Laste, mi precizigas, ke
programaroj kiuj malfermitkodajn permesilojn ne havas, aŭ programoj kiu la liberprogramaran modelon
ne havas, mi volas esti kapabla por instali


### <a name="nixpkgskontribui">Kontribui</a>

La kunlaborada modelo de Nixpkgs restas ĉe gito kaj GitHub. Por pakon kontributi aŭ ekzistantan
pakon ĝisdatigi, la [Nixpkgs](https://github.com/nixos/nixpkgs/)-deponejon forku al la propra
GitHub-konto. Novajn ŝanĝojn kreu en nova branĉo, tiam tirpeton kreu.


#### <a name="nixpkgsgxisdatigi">Ekzistantan pakon ĝisdatigi</a>

La deponejon forkinte, la propran version de la deponejon klonu:

    $ git clone git@github.com:vakelo/nixpkgs.git ~/nixpkgs

Kopion de la forko ĉi tiu komando kreas en la radiko de la hejmdosierujo. Iru al tiu dosierujo, tiam
la enhavojn ni esploru:

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

Sekve, pakon ni trovu kie ĝi loĝas, ekzemple, *GNU Hello*.

    $ grep hello pkgs/top-level/all-packages.nix
      hello = callPackage ../applications/misc/hello { };

Diras, ke la pako *hello* troveblas sub `../applications/misc/hello`. Rilate al la dosiero
`all-packages.nix`, la dosierindiko estas ĉe `pkgs/applications/misc/hello` aŭ
`~/nixpkgs/pkgs/applications/misc/hello`. Tien ni iru:

    $ cd pkgs/applications/misc/hello
    $ ls
    default.nix

La dosieron `default.nix` malfermu:

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

Ĉi tio diras al ni, ke la dosiero `default.nix`, estas dosiero kun parametro kiel atribuo kun du
eroj. La rezulton de je `stdenv.mkDerivation` voki per enigo de atribua valaro la funkcio
liveras. La valoro por la atribuo `name` estas signovico kun la formato *paknomo-A.B.C*, en kiu,
*paknomo* estas la nomo de la pako kaj *A.B.C.* estas la versinombro. La valoro por la `src` atribuo
estas la valoro liverita per la funkcion `fetchurl` voki, per alia atribuara argumento. La valoro
por la atribuo `url` devas esti aŭ spegula specifo, kiel priskribite en
`pkgs/build-support/fetchurl/mirrors.nix`, aŭ kutima retejadreso. Tiukaze, la GNU-spegulon ni uzis
kaj la variablon `name` ni interpolis ene tiu signovico. La valoro de la atribuo `sha256` estas tiu, kiun ni akiris per je `nix-prefetch-url` ruli kontraŭ la retejadreso. Por la kontrolsumon akiri
de `hello-2.10`, rulu:

```bash
$ nix-prefetch-url http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz
downloading ‘http://ftpmirror.gnu.org/hello/hello-2.10.tar.gz’... [622/709 KiB, 64.6 KiB/s]
path is ‘/nix/store/3x7dwzq014bblazs7kq20p9hyzz0qh8g-hello-2.10.tar.gz’
0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i
```

Ĝi kongruas al la SHA256-specifo ĉi-supre.

La atribuo `doCheck` instruas al Nix la testojn ruli por ĉi tiu pako.

La valoro de la atribuo `meta` estas alia atribuara specifo por aliaj detaloj pri la
pako. Nix-programojn la valoroj precizigitaj ĉi tie helpas por la pakon klasi, inter aliaj
aferoj. La celon de pako la mallonga signovico en atribuo `description` priskribas. La atribuo
`longDescription` estas pli longa atribuo, eble plurlinia signovico por la pakon priskribi en pli da
detalo. La atribuo `homepage` estas retejadreso al la retejo de la pako. Ĝin oni ne plu bezonas citi
per unuoblaj aŭ duoblaj citiloj specife—ĝin ĝi faras interne. Retejadreson oni ankoraŭ devas citi se
variablan interpolado oni uzas. La atribuo `platforms` estas grava: pakon ĝi ordas ĝuste—pakon ĉe
makintoŝo oni ne devas munti kiu nur kuras ĉe linukso.

Se aperos nova versio de *GNU Hello*, ekzemple, versio 2.11, la ĝustajn atribuojn modifu. Sed unue,
apartan branĉon ni kreu por tio:

    $ git checkout -b hello-2.11

En `default.nix`, la nomon ŝanĝu al `hello-2.11` kaj la atribuon `sha256` ankaŭ ĝisdatigu. Kaj
cetere, se oni estas nur NixOS, la jenan valoron aldonu al `/etc/nixos/configuration.nix`:

    nix.useSandbox = true;

Se alian linuksan sistemon oni uzas, aŭ makintoŝon oni uzas, la jenan aldonu al `/etc/nix/nix.conf`:

    build-use-sandbox = relaxed

Tiam, la pakon muntu:

    $ cd ~/nixpkgs
    $ nix-build -A hello

Se la kunmetaĵo sukcesis, aperos simbolligilo nomata `result` en la aktuala dosierujo. Ĉi tiu
simbolligilo montras al dosierindiko en `/nix/store`. La programon ni rulu:

    $ ./result/bin/hello
    Hello, world!

Bonege. La ŝanĝojn enmetu.

    $ git add -u
    $ git commit -m 'hello: 2.10 -> 2.11'
    $ git push origin hello-2.11

Fine, iru al la GitHub-deponeja [paĝo](https://github.com/nixos/nixpkgs), tiam tirpeton inter
`nixos/nixpkgs:master` kaj `vakelo/nixpkgs:hello-2.11` kreu.


#### <a name="nixpkgssendi">Novan pakon sendi</a>

La paŝoj por novan pakon sendi estas preskaŭ simila de novan ĝisdatigi, krom malmultaj aferoj.

En la komenco, novan branĉon kreu por la pako:

    $ cd ~/nixpkgs
    $ git checkout -b tthsum-1.3.2

Tiam, decidu pri kiu kategorio ĝi devas aparteni:

    $ cd pkgs/applications/misc
    $ mkdir tthsum

Tiam, la dosieron `default.nix` kreu:

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

Oni povas rimarki, ke la anglan ni uzas ene tial, ke ĝi estas la devigita lingvo en la tutprojekto.

Kio novas ĉi tie estas la atribuo `installPhase`. La implicita kunmetada procedoj de la *tthsum*-pako
malsamas al la maniero, en kiu instalojn Nix traktas, do ni devas esti specifa pri tio. La `$out`
identigilo signifas pri la fina dosierujo kie la programo loĝos en `/nix/store/`. En la uzantmedio,
la programo haveblos ĉe `~/.nix-profile/bin/tthsum`, kaj en la sistemmedio la programo haveblos ĉe
`/run/current-system/sw/bin/tthsum`.

En ĉi tiu punkto, Nix ne ankoraŭ estas konscia pri *tthsum*. Ĝin ni devas deklari en la supra
nivelo. Por tiel fari, la dosieron `pkgs/top-level/all-packages.nix` redaktu, kaj la jenan aldonu en
la ĝusta kategorio.

```nix
tthsum = callPackage ../applications/misc/tthsum { };
```

Tiam, la pakon muntu kiel priskribite ĉi-supre:

    $ cd ~/nixpkgs
    $ nix-build -A tthsum

Se ĉio sukcesis, la ŝanĝojn enmetu:

    $ git add pkgs/applications/misc/tthsum
    $ git add pkgs/top-level/all-packages.nix
    $ git commit -m "tthsum: init at 1.3.2"
    $ git push origin tthsum-1.3.2

Fine, iru al la GitHub-deponeja [paĝo](https://github.com/nixos/nixpkgs), tiam tirpeton inter
`nixos/nixpkgs:master` kaj `vakelo/nixpkgs:tthsum-1.3.2` kreu.


### <a name="nixpkgsnotoj">Notoj</a>

En ajna punkto dum la instalo de pako, la procezo estas interrompita, la pako ne estos instalita en
duone bakita stato. La plej lasta paŝo de pakojn instali estas atoma. La sekreto, estas,
simbolligilon de `/nix/store` al `~/.nix-profile/`, la operacio kiu ĝin disponebligas al uzanto la
sistemo kreas. La kreado de simbolligiloj en linukso kaj makintoŝo estas aŭ sukcesa aŭ ne.

Ĉe NixOS, la kanalo uzita de la ĉefuzanto estas grava tial, ke ĝi estas tiu, kiun oni uzas kiam
la sistemon rekunmeti per `nixos-rebuild switch` post ŝanĝoj al `/etc/nixos/configuration.nix` estas
faritaj. Por certigi, ke la pravan kanalon oni uzas, ĝin listigu per:

    $ sudo nix-channel --list

Por la ĉefuzantan kanalon ŝanĝi simila al tiu, kiu estis uzita antaŭe:

    $ sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos


<a name="medioj">Medioj</a>
---------------------------

Medio estas maniero de Nix por komponantan izoladon provizi inter la sistemo kaj uzantoj. En NixOS,
ekzistas tri medioj: sistemmedio, uzantmedio, kaj disvolvmedio.


### <a name="sistemmedio">Sistemmedio</a>

La sistemmedio estas modifita nur per la ĉefuzanto kiu ĝian valoron ĝi deklaras en
`/etc/nixos/configuration.nix`. Ĝi estas listo, kiu la pakojn kiu disponebliĝos al ĉiuj uzantoj de
la sistemo enhavas. Jen ekzemplo de `/etc/nixos/configuration.nix` kiu la sistemmedion uzas:

```nix
{ config, lib, pkgs, ... }:

{
  ...
  environment.systemPackages = with pkgs; [ zsh vim ];
  ...
}
```

Ĉi tio deklaras, ke la pakoj nomitaj *zsh* kaj *vim* disponeblos por ĉiuj uzantoj de la sistemo. La
duumdosieroj disponeblos kiel `/run/current-system/sw/bin/zsh` kaj `/run/current-system/sw/bin/vim`,
por Ziŝo kaj Vim, respektive.

Parenteze, nur ekzistas ĉe NixOS la sistemmedio.


### <a name="uzantmedio">Uzantmedio</a>

La uzantmedio estas tiu, kiu estas uzita kiam ajn la komando `nix-env` estas uzita. Ekzemple,
ziŝon instalante per nix-env:

    $ nix-env -iA nixos.zsh

Ziŝo fariĝos specife disponebla por la uzanto kiu ĝin alvokas. Se `johano` estas la uzanto kiu tiun
komandon rulis, tiam la ziŝa duumdosiero disponebliĝos kiel
`/home/johano/.nix-profile/bin/zsh`. Se ziŝon la uzanto `mario` ankoraŭ ne instalis en sia profilo,
tiam ĝi ne disponeblas por ĝi. Se la saman kanalon kiel Johano, Mario havas, kaj la saman
*nix-env*-komandon ĝi kuris, tiam la ziŝan programan datumon Nix ne plu bezonas elŝuti el
nulo. Anstataŭe, la ziŝan programan datumon, kiu estis kreita de la procezo de Johano antaŭe,
disponebligas por Mario. Tamen, se gitkopion aŭ alian version de kanaloj kontraŭ tiu kiun Johano
uzas, Mario uzas, tiam novan aperaĵon de ziŝo la alvoko de `nix-env` per Mario elŝutos.


### <a name="disvolvmedio">Disvolvmedio</a>

La tria medio, la dislovmedio, estas kreita per la uzo de nix-shell. La uzanton nix-shell
permesas por sablujmediojn krei. La medio kreita estas izolita de la sistemo kaj kutimaj
uzantmedioj. Je `/nix/store` la medio kreita ankoraŭ uzos, sed nek `/run/current-system/sw/` nek
`~/.nix-profile/` estos modifita. Kiun nix-shell disponigas estas medio, kiu estas aparta de la
resto de la sistemo, la uzanton permesante por porokazajn disponigojn krei sen zorgoj pli la
modifado de la sistemstato. Per tio, la kapablon por medion uzi uzanto gajnas por diversajn
disponigojn de apo elprovi aŭ por eblojn kontrasti antaŭ liverado.

Por mediojn krei kiuj estas malkonektitaj al la resto de la sistemo, manieron por la dependencojn de
apo kaj sia datumo mem apartigi, de kutima sistema interveno ni bezonas havi. Onin la nix-shell
permesas por maldikajn nivelojn de abstraktado krei, la determinismon kaj risurcan administradon de
Nix mem ekspluatante.

Por ilustri, ni kontrolu, ke [GNU Hello](https://www.gnu.org/software/hello/) ne fakte estas ankoraŭ
instalita:

    $ which hello
    hello not found

Se tio estas la kazo, bone. Aliokaze, la *GNU Hello*-pakon unue forigi.

Nu, por je nix-shell montri, je GNU Hello ni rulu en nix-shell, tiam ĝi revenos al la kutima
uzantŝelo.

    $ nix-shell --packages hello --pure --run hello
    Hello, world!
    $ which hello
    hello not found

Kion ĉi tio faras, estas, ke la duumpakon por GNU Hello ĝi elŝutos, puran ŝelan medion kreante, tiam
progresas por la duumdosieron `hello` ruli, kiu la konatan saluton montros al la ekrano. Se la
`‑‑run` opcio estas forigita, ni faliĝos en ŝelo:

    $ nix-shell --packages hello --pure
    [nix-shell:~]$ hello
    Hello, world!

Ĉi tiu ŝelaperaĵo estas speciala tial, ke nur sufiĉan informon ĝi enhavas nur por la komandon
`hello` igi disponebla. La valoron de `$PATH` ni eĉ povas kontroli ĉi tie:

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
dosierindiko de *GNU Hello*, la ceteraj estas la minimumaj komponantoj de nix-shell-aperaĵo. Ĉi tiu
sektoraro nomiĝas *stdenv*.

La dosierojn `shell.nix` aŭ `default.nix` nix-shell serĉas, en tiu ordo, en la aktuala dosierujo dum
startigo, por la difinojn elŝargi. Ĝin ni kreu, ĝin konservante kiel `default.nix`:

```nix
{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ hello emem ];
}
```

*.nix*-dosiero estas Nix-esprimo. En ĉi tiu ekzemplo, ĝi estas funkcio kiu unu argumenton akceptas
kun implicita valoro. La bizara `<nixpkgs>` montras al la valoro de la atribuo `nixpkgs` deklarita en
la `NIX_PATH` media variablo. Ĉe NixOS, ĝi aspektas jene:

    $ echo $NIX_PATH
    nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels

En la dosierujo kiu estas montrata de la atribuo `nixpkgs`, estas `.git-revision` dosiero. Ĝian
enhavon ni kontrolu:

    $ cat /nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs/.git-revision
    1e8c01784a6a121fc94d111f4af7cc88dd932186

Ĉi tio diras al ni la versio de Nixpkgs kanalojn uzanta en ĉi tiu profilo.

Iri reen, ĉiomajn identigilojn en la lokamplekso la deklaro `with pkgs` metas, ilin igas
videblaj. `stdenv`, kiu estis menciita antaŭe, estas atribuaro kiu inter multaj aferoj, la
identigilon `mkDerivation` enhavas. `mkDerivation`, sinsekve, estas funkcio kiu unu atribuaran
argumenton akceptas. Onin mi memorigas, ke unu eron de argumento kiu estas atribuaro la kunigkrampoj
post `mkDerivation` precizigas; semantikan similecon al la kunigkrampoj de aliaj programlingvoj por
la komencon kaj finon de funkciamplekso limigi ĝi ne havas. Estas pluraj alĝustigiloj por ĝi, tamen
por la celoj de simpleco, nur je `name` kaj je `buildInputs` ni kontrolos—la apenaŭaj atribuaj
parametroj.

Por nia bagatela ekzemplo, la voloro de `name` povas esti io ajn. La valoro de `buildInputs`, tamen,
estas grava. Ĉi tie, ili estas deklaritaj `hello` kaj `emem`. Estas referencoj al valoroj en la
`nixpkgs` markilo, kiun ni vidis antaŭe. Se je `with pkgs` ni ne uzis, la esprimo estus:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ pkgs.hello pkgs.emem ];
```

Por ĉi tiun esprimon manĝigi al nix-shell, ambaŭ je *hello* kaj *emem* uzante, rulu:

    $ nix-shell --pure --run "hello | emem -w"
    <p>Hello, world!</p>

Fortajn abstraktadajn meĥanismojn nix-shell donas al ni kiuj estas rigarditaj tre malfacilaj por
fari en aliaj aliroj. La determinismajn kvalitojn de Nix ĝi ekspluatas, fortan avantaĝon kreante.


<a name="surmetoj">Surmetoj</a>
-------------------------------

Estos tempoj en kiuj ŝanĝojn al la paksistemo oni devas fari, tamen ne pretas oni por iri tutfreneze
kaj la gitdeponejon fuŝi. Ankaŭ estos tempoj en kiuj privatan deponejon oni volas havi, sed oni ne
volas publikiĝi. Onin surmetoj povas helpi pri tio.

Kiel la nomo implicas, la surmeto meĥanismo estas maniero por abstraktan nivelon krei super la
ekzistantaj esprimoj. Unu uzo estas samkiel benkseĝaron porti por intervjuo—vi ankoraŭ estas vi
sube, sed draste ŝanĝiĝis via aspekto. Alia uzo samkiel viajn internajn organojn anstataŭigi per la
kibernetikajn—vi ankoraŭ estas iomete vi, sed draste ŝanĝiĝis pluraj partoj de vi interne. Alia uzado, kiu estas unu el miaj plej ŝatataj, estas novan eston krei el virtuala nenio.

Surmetaj dosieroj estas viaj konataj Nix-esprimoj, per specifa formato. Ili loĝas en
`~/.config/nixpkgs/overlays/`. Se tiun dosierujon oni ne havas, ĝin oni povas krei per:

    $ mkdir -p ~/.config/nixpkgs/overlays

Miajn surmetajn dosierojn mi strukturas en kiu ĉiu dosiero kongruas al unu pako, kies konduton mi
volas ŝanĝi.


### <a name="surmetojtranspasoj">Transpasoj</a>

Ekzemple, se oni volas certigi ke la dokumentaro por
[Rakido](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/interpreters/racket/default.nix)
estos instalitaj, la dosieron `~/.config/nixpkgs/overlays/racket.nix` kreu per la jena enhavo:

```nix
self: super: {
  racket = super.racket.override {
    disableDocs = false;
  };
}
```

Ĝi estas Nix-funkcio kun du argumentoj—`self` kaj `super`. `super` referencas al la esprimoj kiuj apartenas al la sistemo, dum `self` referencas al la aro de esprimoj kiujn oni difinas. Estas devige, ke estas nur du argumentoj kaj ili estas `self` kaj `super`.

Sekve, precizigu, ke por la `racket`-atributo, la `override`-funkcion ĝi vokos el la fonta tavolo,
donante al ĝi atributan aron kiu la transpasojn enhavas.

Alia ekzemplo estas ke se je [NaCl](https://developer.chrome.com/native-client) por
[Chromium](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/browsers/chromium/default.nix)
oni volas ŝalti, la dosieron `~/.config/nixpkgs/overlays/chromium.nix` kreu per la jena enhavo:

```nix
self: super: {
  chromium = super.chromium.override {
    enableNaCl = true;
  };
}
```

Kiam je Racket aŭ je Chromium oni instalas, tiuj agordoj estos legataj kaj efektiviĝos.

    $ nix-env -iA $(nix-channel --list | awk '{print $1}').racket


### <a name="surmetojnovajpakoj">Novaj pakoj</a>

La surmetan sistemon uzi por novajn pakojn krei estas ideala se la pakon oni ne volas doni al
Nixpkgs, ĝin oni volos esti privata, aŭ novan infrastukturon oni volas aldoni sen la ekstran
komplekson trakti.

Ni supozu, ke je [kapo](https://github.com/ebzzry/kapo)—Vagrant-helpilon—oni volas
pakigi. Por tion fari, du aĵojn oni skribos:

1. la supran surmetan dosieron en `~/.config/nixpkgs/overlays/`; kaj
2. la Nix-esprimo kiu je _kapo_ fakte kreas.

Por #1, la dosieron `~/.config/nixpkgs/overlays/kapo.nix` kreu per la jena enhavo:

```
self: super: {
  kapo = super.callPackage ./pkgs/kapo { };
}
```

Tiam, por #2, la dosierarbon kreu por la esprimo. Memoru, ke ne devigatas la nomo
`pkgs`:

    $ cd ~/.config/nixpkgs/overlays
    $ mkdir -p pkgs/kapo

Tiam la dosieron `~/.config/nixpkgs/overlays/pkgs/kapo/default.nix` keru per la jena enhavo:

```nix
{ stdenv, fetchFromGitHub, bash }:

stdenv.mkDerivation rec {
  name = "kapo-${version}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ebzzry";
    repo = "kapo";
    rev = "abd22b4860f83fe7469e8e40ee50f0db1c7a5f2c";
    sha256 = "0jh0kdc7z8d632gwpvzclx1bbacpsr6brkphbil93vb654mk16ws";
  };

  buildPhase = ''
    substituteInPlace kapo --replace "/usr/bin/env bash" "${bash}/bin/bash"
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp kapo $out/bin
    chmod +x $out/bin/kapo
  '';

  meta = with stdenv.lib; {
    description = "Vagrant helper";
    homepage = https://github.com/ebzzry/kapo;
    license = licenses.cc0;
    maintainers = [ maintainers.ebzzry ];
    platforms = platforms.all;
  };
}
```

Per tiuj du dosieroj, je _kapo_ oni nun povas instali:

    $ nix-env -iA $(nix-channel --list | awk '{print $1}').kapo


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Potencajn ilojn por sistemojn kaj disvolvajn agordojn administri facile Nix provizas. Fleksajn
facilojn por rendimentajn laborfluojn kaj distrubuajn modelojn krei ĝi havas. Se la plej gravajn
eblojn de la Nix-ekosistemo kiuj plaĉas al mi, mi devas listigi, ili estas:

- determinisme
- reprodukteme
- senstate
- deklare
- kohere
- porteble
- fideble
- pure funkcie
- transakciajn ĝisdatigojn havas

Alia grava ano de la Nix-familio estas [NixOps](https://nixos.org/nixops); onin permesas por je
NixOS disponigi ĉe «nudmetalaj» sistemoj, virtualaj sistemoj, aŭ la nubo, per la uzo de deklara
aliro kiu estas konata al ni. Ĝi eblas disponigi al *VirtualBox*, *Amazon EC2*,
*Google Compute Engine*, *Microsoft Azure*, *Hetzner*, *Digital Ocean*, kaj *Libvirtd*. Iru al la
[gvidilo](https://nixos.org/nixops/manual/) por vidi pli da detalo.

Fundajn detalojn pri generadoj, derivaĵoj, kaj efektivigadoj estis eliziadoj intence, en ĉi tiu
artikolo. Ili povas fariĝi sekcio per si mem, aŭ ĉi tiun artikolon mi eblas ĝisdatigi por tiujn
temojn aldoni. Novan sekcion pri NixOS mi eblas skribi.

Emaksa ĉefregimo por Nix-dosieroj haveblas de la [ĉefdeponejo](https://github.com/NixOS/nix-mode) de
NixOS. Ĝi ankaŭ haveblas per [MELPA](https://melpa.org/#/nix-mode). Ĝin oni povas instali per:

```
M-x package-install EN nix-mode EN
```

Ekzistas aliaj pakaj administradaj sistemoj kiuj ĉi tiun problemareon ankaŭ provas solvi. Tiuj,
kiujn mi konas estas [AppImage](http://appimage.org/), [Zero Install](http://0install.net/),
[Snapcraft](https://snapcraft.io/), kaj [Flatpak](http://flatpak.org/).

La [Guix System Distribution (GuixSD)](https://www.gnu.org/software/guix/) estas linuksa distribuo
kiu baziĝas ĉe Nix. Je [Guile](https://www.gnu.org/software/guile/) ĝi uzas kiel sia
API-lingvo. La kerna kontrasto inter GuixSD kaj NixOS, estas, je
[GNU Shepherd](https://www.gnu.org/software/shepherd/) tiu uzas anstataŭ systemd; neliberajn
pakojn ĝi ne permesas; kaj je [Linux-libre](https://www.fsfla.org/ikiwiki/selibre/linux-libre/),
malpligrandigita versio de la baza kerno kun ĉiom da komercaj aĵoj forigitaj, ĝi uzas. Pli da
informo pri iliaj kontrastoj troveblas
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
kaj [Nix](https://nixos.org/nix/manual) gvidiloj, min ege helpis por je Nix kompreni. Apartaj dankoj
iras al [François-René RIDEAU](https://fare.livejournal.com) por min enkonduki al Nix antaŭ multaj jaroj.

La NixOS-fondiĝo estas registrita senprofitcela organizo; la
[oferdonoj](https://nixos.org/nixos/foundation.html) ege helpas en la disvolvo de Nix. Aliĝu al la
[komunumo](https://nixos.org/nixos/community.html) kaj ĝin helpigu kreski!


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

La ĉefeligujon oni povas konduki al nix-repl:

```nix
$ echo 'let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20' | nix-repl
Welcome to Nix version 1.11.8. Type :? for help.

nix-repl> let y = x: ((f: (x (v: ((f f) v)))) (f: (x (v: ((f f) v))))); b = p: (n: if n == 0 then 1 else (n * (p (n - 1)))); f = y b; in f 20
2432902008176640000

nix-repl>
```

_Dank’ al [Dan SVOBODA](https://github.com/dansvo) pro la korektoj._
