Retpoŝton Agordi per Emakso
===========================

<div class="center">Esperanto · [English](/en/emacs-mail/)</div>
<div class="center">la 14-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 28-an de januaro 2019</div>

>Nur tial ke ne fariĝis, ne signifas, ke ne fareblas. Nur tial ke fareblas, ne
>signifas, ke devus.<br>
>―Barry GLASFORD

Nunatempe kontroli retpoŝton postulas onin por iri al la retejo de sia provizanto, aŭ uzi
poŝkomputilapon. Tamen, estas kazoj kiam oni volas havi pli da rego sur siaj mesaĝoj, precipe kiam
la kapablo kiun si volas, ne haveblas en la plimultaj opcioj.

Emakso disponigas pletorajn manierojn (Gnus, Wanderlust, VM, ktp.) de sendi kaj ricevi la retpoŝton. En ĉi
tiu afiŝo, mi parolos pri [getmail](http://pyropus.ca/software/getmail/),
[mu](http://www.djcbsoftware.nl/code/mu/), kaj [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html),
kaj kiel agordi ilin ĝuste. En ĉi tiu lernilo, mi supozas, ke oni akiras siajn mesaĝojn
[Gmail-e](https://gmail.com) per ĝia IMAP-interfacio.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Elŝuti mesaĝojn](#elsxuti)
  + [Instalo](#elsxutiinstalo)
  + [Agordo](#elsxutiagordo)
  + [Plenumo](#elsxutiplenumo)
- [Legi mesaĝojn](#legi)
  + [Instalo](#legiinstalo)
  + [Agordo](#legiagordo)
  + [Plenumo](#legiplenumo)
- [Ĉifrado](#cxifrado)
- [Finrimarkoj](#finrimarkoj)


<a name="elsxuti"></a>Elŝuti mesaĝojn
-------------------------------------

Oni bezonas havi manieron por elŝuti siajn retpoŝtojn, el sia retpoŝtservilo. Facile uzebla
programo, kiu faras tion al si, estas [getmail](http://pyropus.ca/software/getmail/).


### <a name="elsxutiinstalo"></a>Instalo

Plejofte, getmail jam haveblas sur la sistemo per la pako-administrilo:

Per Nixpkgs:

    $ nix-env -i getmail

Per APT:

    $ sudo apt-get install getmail4

Tamen, se onia sistemo ne disponigas manieron por facile instali je getmail, oni povas iri al ĝia
[hejmpaĝo](http://pyropus.ca/software/getmail/), tiam elŝutu la tar-arĥivon.


### <a name="elsxutiagordo"></a>Agordo

Sekve, oni bezonas fari sorĉon, por ke getmail sciu kiel elŝuti siajn aĵojn. Kreu la dosieron
`~/.getmail/getmailrc`. Krom tio, oni bezonas krei kaj precizigi kien la mesaĝojn iras:

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

Anstataŭigu __UZANTNOMO__ per onia Gmail-uzantnomo, tiam anstataŭigu __PASVORTO__, per onia
Gmail-pasvorto. Tamen, se oni uzas [dufazan aŭtentigon](https://www.google.com/landing/2step/), uzu
[apspecifan](https://accounts.google.com/IssuedAuthSubTokens) pasvorton por la pasvorta kampo. Notu,
ke `~/Maildir` estas la defaŭlta dosierujo, kiun la retpoŝta transmeta ilo uzos konservi datumon.


### <a name="elsxutiplenumo"></a>Plenumo

Por kontroli, ke oni jam povas elŝuti siajn mesaĝojn, kurigu je getmail:

    $ getmail

Se funkcias kaj montras ion kiel la jena, tiam oni prave agordis je getmail:

```bash
getmail version 4.43.0
Copyright (C) 1998-2012 Charles Cazabon.  Licensed under the GNU GPL version 2.
SimpleIMAPSSLRetriever:foobar@gmail.com@imap.gmail.com:993:
...
```


<a name="legi"></a>Legi mesaĝojn
--------------------------------

Nun ke oni povas elŝuti siajn mesaĝojn, oni bezonas havi manieron por legi ilin. Ĉi tie estas kie mu
kaj la aldonita kliento, kiu funkcias Emakse, _mu_ envenas:

### <a name="legiinstalo"></a>Instalo

Same kiel getmail supre, plej verŝajne, mu povas esti instalita per la pako-administrilo de onia
sistemo:

Per Nixpkgs:

    $ nix-env -i mu

Per APT:

    $ sudo apt-get install maildir-utils

Kaj cetere, oni bezonas elŝuti je mu4e. Venas kun la fontkodo de mu. Elŝutu ĝin per kuri:

    $ mkdir ~/.emacs.d
    $ cd ~/.emacs.d
    $ git clone git@github.com:djcb/mu.git

Ĉi tiu komando kreas `mu/`-dosierujon en la aktuala dosierujo, kiu estas la defaŭlta dosierindiko,
en kiu, Emakso trovas pravalorizajn dosierojn. Notu, ke la supra gita komando, fakte elŝutas la
fontkodon de mu, kaj oni fakte povas uzi ĝin por instali je mu. Tamen, tial ke oni jam havas sian
pako-administrilon, si malatentos tion. Kaj la dosierindiko, en kiu, la `mu/mu4e/`-subdosierujo
ekzistas de la pako-administrila instalo, malsimilas inter sistemoj. Do, intertempe, oni
interesitas nur pri la `mu/mu4e/`-subdosierujo.


### <a name="legiagordo"></a>Agordo

Oni nun bezonas fari tiun mu4e-dosierujon alirebla al Emakso. Por fari tiel, oni bezonas redakti
aŭ `~/.emacs.d/init.el` aŭ `~/.emacs`:

    $ emacs ~/.emacs.d/init.el

Tiam, aldonu la jenan:

```lisp
(setq load-path (append load-path '("~/.emacs.d/mu/mu4e")))
(require 'mu4e)
```

Kaj cetere oni bezonas enmeti kelkajn informojn pri onii, por ke Emakso ne ĝenatas demandu onin pri
tiuj detaloj poste:

```lisp
(setq user-full-name "Foo B. Baz"
      user-mail-address "foo@bar.baz")
```

Por fari onian vivon pli facile, agordu kelkajn variablojn:

```lisp
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 300
      mu4e-attachment-dir "~/Downloads")
```


### <a name="legiplenumo"></a>Plenumo

Oni povas reŝargi Emakson, por ke tiuj agordoj povu efektiviĝi, aŭ alternative, ovi povas marki
tiujn liniojn per <kbd>C-Space</kbd>, tiam premu:

    M-x eval-region EN

Ĉi-loke oni povas uzi je mu4e, per premi:

    M-x mu4e EN

Oni vidos ĉarman menuon, en kiu, oni povas premi fulmoklavojn por iri kien oni povas iri. Por verki
mesaĝon, premu <kbd>C</kbd>, tiam plenigu la kampojn, tiam premu <kbd>C-c C-c</kbd> por sendi la
mesaĝon. La ceteraj komandoj devus esti mem-klarigaj, tamen se oni povas lerni pli da informo, oni
povas legi la [agrablan manlibron](http://www.djcbsoftware.nl/code/mu/mu4e/index.html).


<a name="cxifrado"></a>Ĉifrado
-----------------------------

Malnepre oni eble volas aldoni kelkajn alĝustigetojn, por ke la ĉifrado kaj
malĉifrado de mesaĝoj estu pli facilaj. Fakte ĉi tio estas unu el la ĉefkialoj
kial mi uzas je mu4e—estis montrite al mi ke malgraŭ uzi retumilajn kromprogrojn
kiel [FireGPG](http://getfiregpg.org/s/home), la onidire privataj mesaĝoj kiujn
mi verkis, estis aŭtomate konservitaj en la _Drafts_ dosierujo. Subkomprenigas,
ke la malĉifrita mesaĝo, estis ankoraŭ konservita ie. Kraĉotusas.

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

Por sendi sendi ĉifritan mesaĝon, premu <kbd>C</kbd> el la ĉefmenuo de mu4e, plenumigi la kutimajn
kampojn kiel `To:`, kaj `Subject:`, tiam sur la mesaĝokorpo, premu:

    M-x ec REv

ĉi tiu komando, etikedos la eliranta poŝto kiel subskribita kaj ĉifrita. Por sendi ĝin, premu
<kbd>C-c C-c</kbd>. Ĉi tiu komando sekve invitos onin por enigi sian pasfrazon. Ankaŭ demandos onin
por plenumigi kelkajn informojn pri la elira retpoŝtservilo (SMTP). La SMTP-servilo de Gmail
estas `smtp.gmail.com`, tiam uzu `UZANTNOMO@gmail.com` kiam invitita por la uzantnomo. Uzu onian
kutiman pasvorton, kiam invitita, aŭ enigu onian apspecifan pasvortos, kiel priskribita antaŭe. Ĉi
tiu informo konservitas al `~/.authinfo`, kaj estos uzata por postaj mesaĝoj.

Por malĉifri mesaĝon, malfermu la mesaĝon, tiam premu:

    M-x dc RET

Ĉi tiu komando invitos onin por eniri sian pasfrazon. Post tio, oni invititos ĉu si volas
anstataŭigi la enhavon de la bufro. Diru jes al ĉi tio.

Ĉi tiuj alproksimiĝoj ne malfuŝeblas tial, ke almenaŭ ekzistas du truoj gapas, kiujn oni devas
konscii pri:

1. emaksaj sekurkopioj, kaj
2. mu4e-malnetoj

Pri la antaŭa, kiam oni uzas la sekurkopia facilo de Emakso, aŭ pakaĵo kiel
[backup-dir](https://www.emacswiki.org/emacs/BackupDirectory), mesaĝoj kiujn si verkas, supozeble
antaŭ si ĉifras ilin, estos havi malĉifritajn kopiojn sur la loka disko. Pri la lasta, la sama
principo aplikatas. Do, estu atenta de ĉi tiuj situacioj, kaj alĝustigetu la agordon kiel necese.


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Tenu en la kalkulo, ke mi laŭcele evitis eltiregis multe da detalo, ĉar devus konfuzi la celon de ĉi
tiu artikolo por fari la aferojn simplaj. Tamen, se oni volas lerni pli, oni ĉiam povas iri al la [getmail-](http://pyropus.ca/software/getmail/documentation.html)
kaj [mu4e-](http://www.djcbsoftware.nl/code/mu/mu4e/index.html)dokumentadoj, por plenumigi la
mankajn informojn kiun oni eble havi.
