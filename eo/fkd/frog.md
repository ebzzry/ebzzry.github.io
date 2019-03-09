Blogi per Frog
==============

<div class="center">Esperanto · [English](/en/frog/)</div>
<div class="center">la 16-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 9-an de marto 2019</div>

>Unu persono kun ardo pli bonas ol kvardek personoj nure interesataj.<br>
>―E.M. FORSTER

Kiam eldoni blogan enhavon al la TTT, la plejmulto da homoj kondifus antaŭkreitajn servojn, kiuj
faras la grandparton de la laboro. Tamen, estas okazoj kiam oni volas havi pli da rego sur ĝiaj
aĵoj. Bona ekzemplo de tio, estas la limigoj, kiujn provizantoj efikigas. Alia afero estas la ĉeesto
de reklamoj aŭ la uzado de [parte senpagaj](https://en.wikipedia.org/wiki/Freemium) servoj—komence
liberaj servoj, tiam mono bezonatas por aldonaj servoj.

Eble oni disputas, ke ĉiuj, kiujn ĝi bezonas estas platformo por blogi, kaj ĝi ne bezonas la plian
flekson. Estas bonfarte por iuj. Tamen multe da homo volas liberiĝi el la katenoj. Mi ne volas
vidi reklamojn sur mia retejo. Mi ne volas surprizajn cenzuradojn. Mi volas liberon. Do, se oni
estas kiel mi, daŭru legi.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Unua uzo](#unua)
- [Krei novafiŝojn](#novaj)
- [Tajloradoj](#tajloradoj)
  - [.frogrc](#.frogrc)
  - [page-template.html](#page-template.html)
  - [post-template.html](#post-template.html)
  - [bootstrap.css](#bootstrap.css)
- [Miksaĵo](#miksajxo)
- [Komentoj](#komentoj)
- [Eldono](#eldono)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Kiam mi trovadis ilojn por krei ĉi tiun blogon, mi malkontentiĝis pri la plejmulto de la famaj
opcioj. Iuj tro malfacilas por agordi; iuj malhavas kapablojn. Mi frustriĝis pro ĉiu fino
de la spektro devigas min por uzi ion, kiu tro mezkvalitas en almenaŭ unu kritika
aspekto. Bonŝance, mi trovis je [Frog](https://github.com/greghendershott/frog) pro propono en
[#racket](https://kiwiirc.com/client/irc.freenode.net/#racket).

Frog en laikoterminoj, estas retejokreilo, kiu estas tiel facila uzi, agordi, kaj tajlori. Kio
ajn oni skribas aperos sur ĝi kiel oni anticipas. Nek estas bizaraj kondiĉoj de uzado, nek
arbitraj limigoj, nek trudoj—tre proksimas al tuta rego, en la pinto de la fingropintoj.

Frog operacias ie en la mezo de jena spektro:

    Krudenhavo → Frog → HTML

En kiu, krudenhavo estas aŭ Markdown, Scribble, aŭ HTML-fontdosieroj, aŭ kombinado de ĉio. Frog
konsumas tiujn enigdosierojn, kiam ĝi eligas agrablajn HTML-dosierojn, kiuj oni povas alŝuti al
sia TTT-servilo. Ĉu facilas? Ne, pli facilas ol sonas.


<a name="instalo"></a>Instalo
-----------------------------

En la jenaj sekcioj, ni supozas, ke la uzantnomo estas `vakelo`, kaj la hejmdosiero estas
`/home/vakelo/`.

Por instali je Frog, oni bezonas instali Rakidon unue. Plej verŝajne, la pako-administrilo jam
havas ĝin.


Per Nixpkgs:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

En la malbonŝanca okazo ke ne instaleblas per la pako-administrilo, iru al
[racket-lang.org/download/](https://racket-lang.org/download/), tiam faru la instrukciojn el tie:

Tiam, oni bezonas instali je Frog:

    $ raco pkg install frog

Poste, oni akiros la `raco frog`-komandon. Ni montru ĝiajn helpajn opciojn:

    $ raco frog -h


<a name="unua"></a>Unua uzo
---------------------------

Dolĉe. Nu, nun oni havas je Frog instalita, ni daŭru ruli. Por krei la unuan Frog-disponigitan
retejon, oni kreos la projektan dosierujon unue:

    $ mkdir blogo
    $ cd blogo

Tiam, bruligu la sparkilon pravalorizi la retan deponejon:

    $ raco frog --init

Tiam, oni vidos mesaĝon diri ke la retejo jam pretas. Ni agu laŭ la proponita komando:

    $ raco frog -bp

Kion la komando faras, estas, ĝi muntas la HTML-dosierojn el la specimenaj dosieroj, kreitaj
per la `‑‑init`-ŝaltilo, tiam ĝi lanĉas lokan retservilon, kiu defaŭlte servas la retejadreson
[http://localhost:3000](http://localhost:3000).

Frog malfermas novan retumilan langeton aŭ fenestron, montranta tiun retejadreson. La paĝo kiun
oni vidos, enhavas la defaŭltan retejan araĝon. Kiam oni konsentas al tiu, ni iru al la
komandlinio kaj ni mortigu tiun procezon per premi <kbd>C-c</kbd>.


<a name="novaj"></a>Krei novafiŝojn
-----------------------------------

Krei novan afiŝon el nulo estas alia facila tasko:

    $ raco frog -n "Nova Bloga Afisxo"

Ĉi tiu kreas Markdown-dosieron, kiu relativas al la aktuala dosierujo, per la
formato `_src/posts/YYYY-MM-DD-afisxa-titolo.md`. Per la supra komando, la absoluta dosierindiko estus
simila al:

    /home/vakelo/blogo/_src/posts/2014-02-21-nova-bloga-afisxo.md

Ni redaktu tiun dosieron, kaj vidu kiel ĝi aspektas:

    $ emacs _src/posts/2014-02-21-nova-bloga-afisxo.md

```
    Title: Nova Bloga Afiŝo
    Date: 2014-02-21T18:53:42
    Tags: DRAFT

_Ĉi tion anstataŭigu per la afiŝa teksto. Unu aŭ pli perkome disigitajn etikedojn aldonu ĉi-supre. La
afiŝon por esti eldonita la speciala etikedo `DRAFT` malebligas._

<!-- more -->
```

Tenu en la kalkulo, ke ĉi tiu dosiero, kreitas por oni per la komando `raco frog -n ...`.  La
unuaj tri linioj enhavas la metadatumojn pri la afiŝo. Ili estas la afiŝotitolo, estigdato, kaj
etikedoj, respektive. La dato estis elektita el la `-n`-ŝaltilo, kiu proklamitas antaŭe. La
`Tags`-kampoj, enhavas diskomajn listojn de vortoj, kiuj Frog poste priidentigus la afiŝon. Kiam
la usklecodistinga etikedo `DRAFT` uzatas, la dosiero estos pretersalita dum la kunmetfazo.

Kvar spacetoj devas esti prefiksitaj antaŭ tiuj tri linioj, sekvita de malplena linio. La resto
estos la efektiva artikola enhavo, en la Markdown-formato. Kiam linio per si mem enhavas nur la
tekston `<!‑‑ more ‑‑>`, tiu linio estos anstataŭigita per hiperligilo en la fina HTML-formo, kiu
estos montranta al la resto de la artikolo. Signifas, ĉiuj teksto, post la `<!‑‑ more ‑‑>` linio
ne aperos en la bloga indekso, sed aperos en la ligilo por la tutafiŝo.

Ni supozu, ke oni ŝanĝas tiun dosieron por aspekti kiel io la jena:

```
    Title: Nova Bloga Afiŝo
    Date: 2014-02-21T18:53:42
    Tags: arto, historio

Se ia aŭtoritata centra institucio trovos, ke tiu aŭ alia vorto aŭ regulo en nia lingvo estas tro
neoportuna, ĝi ne devos forigi aŭ ŝanĝi la diritan formon, sed ĝi povos proponi formon novan, kiun
ĝi rekomendos uzadi paralele kun la formo malnova. Kun la tempo la formo nova iom post iom elpuŝos
la formon malnovan, kiu fariĝos arĥaismo, kiel ni tion ĉi vidas en ĉiu natura lingvo. Sed,
prezentante parton de la fundamento, tiuj ĉi arĥaismoj neniam estos elĵetitaj, sed ĉiam estos
presataj en ĉiuj lernolibroj kaj vortaroj samtempe kun la formoj novaj, kaj tiamaniere ni havos la
certecon, ke eĉ ĉe la plej granda perfektiĝado la unueco de Esperanto neniam estos rompata kaj neniu
verko Esperanta eĉ el la plej frua tempo iam perdos sian valoron kaj kompreneblecon por la estontaj
generacioj.

<!-- more -->

Eĉoŝanĝo ĉiuĵaŭde
```

Tiam, denove plenumu la jenan komandon:

    $ raco frog -bp

Nun oni havas du afiŝojn, kiel montrata en la indekso. Por forigi la aŭtomate kreitan komencan
afiŝon, kiu kreitas per la komando `raco frog ‑‑init`, antaŭe, plenumu:

    $ rm -f _src/posts/2012-01-01-a-2012-blog-post.md

Tiam, rekunmetu la dosierojn:

    $ raco frog -bp


<a name="tajloradoj"></a>Tajloradoj
---------------------------------

Ĉi-foje eble oni jam tre volas tajlori la retejon. Jes, tio estas, kion oni faros en ĉi tiu sekcio.

Ĉe la baznivelo, estas tri dosieroj kiujn oni ŝanĝos por fari la komencajn ŝanĝojn:

- `.frogrc`
- `_src/page-template.html`
- `_src/post-template.html`
- `css/bootstrap.css`
- `css/bootstrap.min.css`

Ni pli proksimu esploru ĉiun de la dosieroj de la listo.


### <a name=".frogrc"></a>.frogrc

Ĉi tiu dosiero estas kie supraj tajloroj kreitas. Malfermu la dosieron `.frogrc`, troveblas en la
aktuala dosierujo:

    $ emacs .frogrc

Oni rimarkos, ke estas pli ol dekduo parametroj kiuj ŝanĝeblas. Tamen por nun, oni okupiĝas nur pri
tri parametroj:

- `scheme/host`
- `title`
- `author`

`scheme/host` devas enhavi la (sub)domajno al tiu, kiu oni eldonos sian verkon poste. `title` estas
la nomo de la blogo. `author` estas la nomo de verkanto.


### <a name="page-template.html"></a>page-template.html

Ĉi tiu dosiero enhavas la komunan enhavon tra ĉiuj specoj de paĝoj, ĉu ili estas blogaj aŭ ne-blogaj
afiŝoj. Malfermu la dosieron `_src/page-template.html`, troveblas en la aktuala dosierujo:

    $ emacs _src/page-template.html

Oni vidos eĉ pli grandan dosieron, kontraste kun .frogrc. Ĉi tiu apartas HTML-dosiero, kiu enhavas
Rakidan kaj Frog-specifajn kodojn. Estos uzata kiel bazo por ĉiuj paĝoj. Ekzistas multe da
parametroj ĉi tie, tamen oni ŝanĝos nur iujn, kiuj estas plej utilaj por ĝi ĉi-momente. Por fari ĝin
pli facile, mi simple listigos la erojn por serĉi kaj anstataŭigi:

- `The Unknown Blogger`
- `My Blog Brand`
- `Welcome`
- `Your legal notice here`

Devas memklare kiujn oni devas ŝanĝi ilin.


### <a name="post-template.html"></a>post-template.html

Similas al `page-template.html`, tamen ĉi tiu dosiero enhavas aĵojn, kiuj nur aperas en la blogaj
afiŝoj. Eble, ĉi tiu estas la plej facila dosiero por. Ni malfermu ĝin.

    $ emacs _src/post-template.html

Intertempe, oni bezonas ŝanĝi nur la tekston `shortname`. Estas la identigilo kiu ligilas la
komentajn sekciojn de la blogaj afiŝoj al Disqus-konto. Pli da informo pri ĉi tiu estos diskutita
en la sekcio _Komentoj_.


### <a name="bootstrap.css"></a>bootstrap.css kaj bootstrap.min.css

Ĉi tiuj du dosieroj respondecas por tiu, kiu komune nomitas, haŭtoj—regas la aspekton de
la retejo. Por ŝanĝi ĉi tiujn dosierojn, ni iru al <https://bootswatch.com/>, tiam elektu haŭton,
kiun oni ŝatas.

Ni supozu, ke oni elŝutis la *Cerulean* haŭton. Klaku la falmenuon por tiu haŭto. Elektu kaj elŝutu
kaj `bootstrap.min.css` kaj `bootstrap.css`. Poste, kopiu ilin al la CSS-dosierujo `css/`.

    $ cp ~/Downloads/bootstrap.*.css css/


<a name="miksajxo"></a>Miksaĵo
------------------------------

Kiam oni kreis novan afiŝon antaŭe, oni uzis la komandon:

    $ raco frog -n "Nova Bloga Afisxo"

Tiu komando kreas Markdown-fontdosieron. Frog, tamen, havas alian reĝimon—Scribble. Ĉi tiu
reĝimo permesas onin por uzi Scribble-dosieron anstataŭe. Por krei tiun, oni uzos la jenan
komandon:

    $ raco frog -N "Nova Bloga Afisxo"

Per la supra komando, la absoluta dosierindiko aspektos kiel:

    /home/vakelo/blogo/_src/posts/2014-02-21-nova-bloga-afisxo.scrbl

Denove, ni redaktu tiun dosieron por vidi kiel ĝi aspektas ene:

    $ emacs _src/posts/2014-02-21-nova-bloga-afisxo.scrbl

```
##lang scribble/manual

Title: Nova Bloga Afiŝo
Date: 2014-02-21T18:53:42
Tags: DRAFT

Ĉi tion anstataŭigu per la afiŝa teksto. Unu aŭ pli perkome disigitajn etikedojn aldonu ĉi-supre. La
afiŝon por esti eldonita la speciala etikedo `DRAFT` malebligas.

<!-- more -->
```

Ni povas vidi, ke la Markdown- kaj Scribble-dosieroj plejparte similas, krom la aldono de
la lingva precizigilo, `#lang scribble/manual`, kaj la manko de la prefiksaj spacetoj por la
metadatumaj kampoj.


<a name="komentoj"></a>Komentoj
-------------------------------

Frog uzas je [Disqus](https://disqus.com) por trakti siajn komentojn. Por uzi ĝin, kreu konton ĉe
[https://disqus.com/profile/signup/](https://disqus.com/profile/signup/?next=http%3A//disqus.com/).

Kiam oni jam havas sian konton, iru al <https://disqus.com/admin/create/>  por krei retejon, kiu
havos alinomon nomitan *shortname*. La *shortname* estas tiu, kiun oni enregistros per Disqus por
unike identigi sian retejon.

Do, se oni ekzemple elektas `foobar` kiel la mallonga nomo por la retejo, oni povas aliri
<http://foobar.disqus.com> por mastrumi la komentojn por tiu retejo. La mallonga nomo menciita ĉi
tie, estas tiu, kiujn oni uzos en la dosiero `_src/post-template.html`, kiel priskribita supre.

Por importi komentojn de ekzistanta blogo al Disqus, iru al <https://import.disqus.com>.


<a name="eldono"></a>Eldono
---------------------------

Por eldoni la verkon, alŝuti la enhavojn de la dosierujo kiun Frog mastrumas al la defora
servilo. En ĉi tiu gvidilo, estas la dosierujo `/home/vakelo/blogo`. Se la aktuala dosierujo estas
`blog/`, kaj oni volas sendi la dosierojn per rsync, la komando aspektus kiel:

    $ rsync -avz ./ deforservilo:public_html

Anstataŭigu `public_html` per la ĝusta defora dosierujo.

Tamen, se oni ne havas deforan gastigkomputilo kaj vi uzas je [Git](https://git-scm.com), oni povas
uzi la liberan gastigservon de [GitHub Pages](https://pages.github.com). Se oni ne havas GitHub-konton, oni povas iri al [GitHub](https://github.com) por krei tiun. Por uzi je GitHub Pages, kreu
deponejon nomiĝas `UZANTNOMO.github.io`. Se la uzantnomo estas `vakelo`, la deponejo kiun oni
bezonas krei devas nomita `vakelo.github.io`.

Por eldoni la verkon al GitHub Pages, oni unue devas aldoni la deforan deponejon:

    $ git remote add origin git@github.com:vakelo/vakelo.github.io.git

Tiam puŝu la enmetojn:

    $ git push origin master

Por vidi la retejon, iru al `vakelo.github.io`.


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Frog vivkapablas kaj utila retejokreilo. Estas facile por uzi; agordeblegas, flekseblas, kaj
jes, malfermita kodo. Donas regon reen la verkisto. Bona ekzemplo de blogo funkciigita de Frog
troveblas ĉe [https://ngnghm.github.io/](https://ngnghm.github.io/).

Frog kreitas de [Greg HENDERSHOTT](http://www.greghendershott.com/). Se oni volas lerni pli
da projekto, iru [ĉi tien](https://github.com/greghendershott/frog).

🐸—Kva!
