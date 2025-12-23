---
title: Agordi Retpoŝton per Emakso
keywords: emakso, retpoŝto, retposxto, agordo, agordaĵo, agordajxo 
image: https://ebzzry.com/images/site/zak-7wBFsHWQDlk-unsplash-1008x250.jpg
---
Agordi Retpoŝton per Emakso
===========================

<div class="center">[English](/en/emacs-mail/) ⊻ Esperanto</div>
<div class="center">2022-02-02 22:22:42 +0800</div>

>Nur pro tio, ke ne fariĝis io, ne signifas, ke ne fareblas ĝi. Nur pro tio, ke fareblas io, ne signifas, ke farendas ĝi.<br>
>—Barry GLASFORD

<img src="/images/site/zak-7wBFsHWQDlk-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Elŝuti mesaĝojn](#elsxuti)
  + [Instalo](#elsxutiinstalo)
  + [Agordo](#elsxutiagordo)
  + [Rulo](#elsxutirulo)
- [Legi mesaĝojn](#legi)
  + [Instalo](#legiinstalo)
  + [Agordo](#legiagordo)
  + [Rulo](#legirulo)
- [Ĉifrado](#cxifrado)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Nunatempe kontroli retpoŝton postulas onin por iri al la retejo de sia provizanto aŭ uzi
poŝkomputilapon. Tamen, estas kazoj kiam oni volas havi pli da rego de ĝiaj mesaĝoj, precipe kiam
la kapablo kiun oni volas, ne haveblas en la plimultaj opcioj.

Emakso disponigas multaj manierojn (Gnus, Wanderlust, VM, ktp.) de sendi kaj ricevi retpoŝtonj. En
ĉi tiu afiŝo, mi parolos pri [getmail](http://pyropus.ca/software/getmail/),
[mu](http://www.djcbsoftware.nl/code/mu/), kaj [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html),
kaj kiel agordi ilin ĝuste. En ĉi tiu lernilo, mi supozas, ke oni akiras siajn mesaĝojn per
[Gmail](https://gmail.com) kaj ĝia IMAP-interfacio.


<a name="elsxuti">Elŝuti mesaĝojn</a>
-------------------------------------

Oni bezonas havi manieron por elŝuti la retpoŝtojn el retpoŝtservilo. Facile uzebla
programo, kiu faras tion, estas [getmail](http://pyropus.ca/software/getmail/).


### <a name="elsxutiinstalo">Instalo</a>

Plejofte, getmail jam haveblas ĉe la sistemo per la pako-administrilo:

Per Nixpkgs:

    $ nix-env -i getmail

Per APT:

    $ sudo apt-get install getmail4

Tamen, se la sistemo ne disponigas manieron por facile instali getmail, oni povas iri al ĝia
[hejmpaĝo](http://pyropus.ca/software/getmail/), tiam elŝuti la tar-arĥivon.


### <a name="elsxutiagordo">Agordo</a>

Sekve, oni bezonas fari sorĉadon, por ke getmail sciu kiel elŝuti la aĵojn. Kreu la dosieron
`~/.getmail/getmailrc`. Krom tio, oni bezonas krei kaj precizigi kien la mesaĝoj iros:

    $ mkdir ~/Maildir
    $ mkdir ~/.getmail
    $ emacs ~/.getmail/getmailrc

Tiam, metu la jenan:

```
[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
username = UZANTNOMO@gmail.com
password = PASVORTO

[destination]
type = Maildir
path = ~/Maildir/

[options]
verbose = 2
message_log = ~/.getmail/gmail.log
read_all = false
delivered_to = false
received = false
```

Anstataŭigu __UZANTNOMO__ per la Gmail-uzantnomo, tiam anstataŭigu __PASVORTO__, per la
Gmail-pasvorto. Tamen, se oni uzas [dufazan aŭtentigon](https://www.google.com/landing/2step/), uzu
[apspecifan](https://accounts.google.com/IssuedAuthSubTokens) pasvorton por la pasvorta kampo. Notu,
ke `~/Maildir` estas la implicita dosierujo, kiun la retpoŝta transmeta ilo uzos por konservi datumon.


### <a name="elsxutirulo">Rulo</a>

Por kontroli, ĉu oni jam povas elŝuti la mesaĝojn, rulu getmail:

    $ getmail

Se funkcias kaj montras ion kiel la jena, oni prave agordis getmail:

```sh
getmail version 4.43.0
Copyright (C) 1998-2012 Charles Cazabon.  Licensed under the GNU GPL version 2.
SimpleIMAPSSLRetriever:foobar@gmail.com@imap.gmail.com:993:
...
```


<a name="legi">Legi mesaĝojn</a>
--------------------------------

Nun ke oni povas elŝuti la mesaĝojn, oni bezonas havi manieron por legi ilin. Ĉi tie estas kie mu
kaj la aldonita kliento, kiu funkcias Emakse, _mu_ envenas:

### <a name="legiinstalo">Instalo</a>

Same kiel getmail supre, plej verŝajne, mu povas esti instalita per la pako-administrilo de la
sistemo:

Per Nixpkgs:

    $ nix-env -i mu

Per APT:

    $ sudo apt-get install maildir-utils

Kaj cetere, oni bezonas elŝuti mu4e. Ĉi tiu venas kun la fontkodo de mu. Elŝutu ĝin per kuri:

    $ mkdir ~/.emacs.d
    $ cd ~/.emacs.d
    $ git clone git@github.com:djcb/mu.git

Ĉi tiu komando kreas `mu/`-dosierujon en la aktuala dosierujo, kiu estas la implicita dosierindiko,
en kiu, Emakso trovos pravalorizajn dosierojn. Notu, ke la supra gita komando, fakte elŝutas la
fontkodon de mu, kaj oni fakte povas uzi ĝin por instali mu. Tamen, ĉar oni jam havas sian
pako-administrilon, ĝi malatentos tion. Kaj la dosierindiko, en kiu, la `mu/mu4e/`-subdosierujo
ekzistas de la pako-administrila instalo, malsimilas inter sistemoj. Do, intertempe, oni
interesiĝas nur pri la `mu/mu4e/`-subdosierujo.


### <a name="legiagordo">Agordo</a>

Oni nun bezonas igi tiun mu4e-dosierujon, alirebla al Emakso. Por fari tiel, oni bezonas redakti
aŭ `~/.emacs.d/init.el` aŭ `~/.emacs`:

    $ emacs ~/.emacs.d/init.el

Tiam, aldonu la jenan:

```lisp
(setq load-path (append load-path '("~/.emacs.d/mu/mu4e")))
(require 'mu4e)
```

Kaj cetere oni bezonas enmeti kelkajn informojn pri oni, por ke Emakso ne ĝeniĝus demandi onin pri
tiuj detaloj poste:

```lisp
(setq user-full-name "Foo B. Baz"
      user-mail-address "foo@bar.baz")
```

Por plifaciligi la aferojn, agordu kelkajn variablojn:

```lisp
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 300
      mu4e-attachment-dir "~/Downloads")
```


### <a name="legirulo">Rulo</a>

Oni povas reŝargi Emakson, por ke tiuj agordoj povu efektiviĝi, aŭ alternative, ovi povas marki
tiujn liniojn per <kbd>C-Space</kbd>, tiam premu:

    M-x eval-region EN

Ĉi-loke oni povas uzi mu4e, per premi:

    M-x mu4e EN

Oni vidos ĉarman menuon, en kiu, oni povas premi fulmoklavojn por iri kien oni povas iri. Por verki
mesaĝon, premu <kbd>C</kbd>, tiam plenigu la kampojn, tiam premu <kbd>C-c C-c</kbd> por sendi la
mesaĝon. La ceteraj komandoj devus esti mem-klarigaj, tamen se oni povas lerni pli da informo, oni
povas legi la [agrablan manlibron](http://www.djcbsoftware.nl/code/mu/mu4e/index.html).


<a name="cxifrado">Ĉifrado</a>
-----------------------------

Malnepre oni eble volas aldoni kelkajn alĝustigetojn, por ke la ĉifrado kaj malĉifrado de mesaĝoj
estu pli facilaj. Fakte ĉi tio estas unu el la ĉefkialoj kial mi uzas mu4e—estis montrite al mi
ke malgraŭ ke uzi retumilajn kromprogrojn kiel [FireGPG](http://getfiregpg.org/s/home), la onidire
privataj mesaĝoj kiujn mi verkis, estis aŭtomate konservitaj en la _Drafts_ dosierujo.
Subkomprenigas, ke la malĉifrita mesaĝo, estis ankoraŭ konservita ie. Kraĉotusas.

Por uzi ĉi tiujn ĉifradajn utilaĵojn, redaktu la Emaksan pravalorizan dosieron:

    $ emacs ~/.emacs.d/init.el

Tiam, aldonu la jenan:

```lisp
(require 'mml2015)
(require 'epa-file)

(defun encrypt-message (&optional arg)
  (interactive "p")
  (mml-secure-message-encrypt-pgp))

(defun decrypt-message (&optional arg)
  (interactive "p")
  (epa-decrypt-armor-in-region (point-min) (point-max)))

(defalias 'ec 'encrypt-message)
(defalias 'dc 'decrypt-message)
```

Marku tiujn liniojn, tiam premu:

    M-x eval-region EN

Por ke la agordoj tuj efektiviĝu.

Por sendi sendi ĉifritan mesaĝon, premu <kbd>C</kbd> el la ĉefmenuo de mu4e, ruli la kutimajn
kampojn kiel `To:`, kaj `Subject:`, tiam en la mesaĝokorpo, premu:

    M-x ec EN

ĉi tiu komando, etikedos la elirantan poŝton kiel subskribita kaj ĉifrita. Por sendi ĝin, premu
<kbd>C-c C-c</kbd>. Ĉi tiu komando sekve invitos onin por enigi la pasfrazon. Oni ankaŭ demandos por
ruli kelkajn informojn pri la elira retpoŝtservilo (SMTP). La SMTP-servilo de Gmail estas
`smtp.gmail.com`, tiam uzu `UZANTNOMO@gmail.com` kiam invitita por la uzantnomo. Uzu la kutiman
pasvorton, kiam invitiĝis, aŭ enigu onian apspecifan pasvortos, kiel priskribite antaŭe. Ĉi tiu
informo konserviĝas al `~/.authinfo`, kaj estos uzata por postaj mesaĝoj.

Por malĉifri mesaĝon, malfermu la mesaĝon, tiam premu:

    M-x dc EN

Ĉi tiu komando invitos onin por eniri la pasfrazon. Post tio, oni invitiĝos ĉu ĝi volas anstataŭigi
la enhavon de la bufro. Diru jes ĉi tie.

Ĉi tiuj alproksimiĝoj ne malfuŝeblas tial, ke almenaŭ ekzistas du gapantaj truoj, kiujn oni devas
konscii pri:

1. emaksaj sekurkopioj, kaj
2. mu4e-malnetoj

Pri la antaŭa, kiam oni uzas la sekurkopian facilon de Emakso, aŭ pakaĵon kiel
[backup-dir](https://www.emacswiki.org/emacs/BackupDirectory), mesaĝojn kiujn ĝi verkas, supozeble
antaŭ ĝi ĉifras ilin, estos havi malĉifritajn kopiojn ĉe la loka disko. Pri la lasta, la sama
principo aplikatas. Do, estu atente en ĉi tiuj situacioj, kaj alĝustigetu la agordon necese.


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Memoru, ke mi laŭcele evitis multe da detalo, ĉar forigu la celon de ĉi tiu artikolo por
igi la aferojn simplajn. Tamen, se oni volas lerni pli, oni ĉiam povas iri al la
[getmail-](http://pyropus.ca/software/getmail/documentation.html) kaj
[mu4e-](http://www.djcbsoftware.nl/code/mu/mu4e/index.html)dokumentadoj, por ruli la mankajn
informojn kiun oni eble havi.
