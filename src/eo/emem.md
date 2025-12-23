---
title: Konverti de Markdaŭno al HTML per emem
keywords: emem, markdown, statika retejo 
image: https://ebzzry.com/images/site/s-migaj-Yui5vfKHuzs-unsplash-1008x250.jpg
---
Konverti de Markdaŭno al HTML per emem
======================================

<div class="center">[English](/en/emem/) ⊻ Esperanto</div>
<div class="center">2022-03-16 16:17:14 +0800</div>

>Oni ne trovos la respondojn kiujn oni serĉas ĝis oni haltas serĉi ekstere kaj komenciĝas serĉi ilin
>el oni mem.<br>
>—JJ, Ergo Proxy

<img src="/images/site/s-migaj-Yui5vfKHuzs-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Instalo](#instalo)
- [Uzado](#uzado)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Mi ĉiam volis manieron por krei HTML-dokumentojn el miaj markdaŭnaj dosieroj. Komence, mi nur volis
havi HTML-dosierojn el miaj tekstaj dosieroj por ke mi povu vidi ilin per la poŝtelefono. Poste, mi
deziris havi manieron por krei tiujn dosierojn por ke mi povu alŝuti ilin al la interreto kaj vidi
ilin per aliaj aparatoj. Jam ekzistas iloj por ja fari tion. Mi provis ilin, tamen mi trovis min mem
ŝanĝi la eligon ofte nur por igi ilin akcepteblaj. Neniuj el ili konformiĝis al mia kriterio: facila
por munti, facila por uzi, kaj realigas decan eligon.

Mi skribis [emem](https://github.com/ebzzry/emem) kiel respondo al tiuj bezonoj. Emem estas
eta ilo kiu ricevas markdaŭnajn dosierojn aŭ el la ĉefenigujo aŭ diska dosiero, tiam liveras HTML-eligon
kiu estas sufiĉe deca, almenaŭ por kutima rigardado.


<a name="instalo">Instalo</a>
-----------------------------

Haveblas emem per [Nix](https://nixos.org/nix/). Se oni ne ankoraŭ havas Nix, oni povas
instali ĝin per:

    $ curl https://nixos.org/nix/install | bash

Tiam, oni nun povas instali emem per:

    $ nix-env -i emem

Se oni ne povas instali Nix, tamen ĝavo estas instalita, oni povas anstataŭ krei porokazan skripton:

```sh
$ mkdir ~/bin
$ curl -sSLo ~/bin/emem.jar https://github.com/ebzzry/emem/releases/download/v0.2.50/emem.jar
$ cat > ~/bin/emem << EOF
#!/usr/bin/env bash
java -jar \$HOME/bin/emem.jar \$@
EOF
$ chmod +x ~/bin/emem
```

Se oni jam finis skribi ĝin, oni povas kontroli la version per:

    $ emem --version

La plej ĵusa versio estas `0.2.50`.


<a name="uzado">Uzado</a>
-------------------------

Ĉe la plej baza nivelo, emem simple ruliĝas kontraŭ markdaŭna dosiero, kaj liveras bazan, tamen plenan
HTML-dosieron kun ĉiom da necesaj risurcoj por ĝusta paĝvido. Aplikante emem al
dosiero nomita `LEGUMIN.md`:

    $ emem LEGUMIN.md

kreas la jenan arbon:

```
static/
  css/
  ico/
  js/
LEGUMIN.html
LEGUMIN.md
```

Male, ruli emem kiel jene:

    $ emem -s LEGUMIN.md

kreas la jenan arbon:

```
LEGUMIN.html
LEGUMIN.md
```

La opcio `-s` forigas la bezonon por krei apartan risurcan dosieron, kaj metas ĉiom da bezonitaj
risurcoj al la eliga dosiero plifaciligante la rigardadon de la eligaj dokumentoj ĉe aparatoj kiel
poŝtelefonoj kaj tabuletoj.

Memoru, ke la dokumentotitolo ene la dosiero, estos uzita kiel la baznomo de la dosiero. Do, de
`LEGUMIN.md`, liveras `<title>LEGUMIN.md</title>` en la HEAD-etikedo. Se oni strukturas la
markdaŭnajn dosierojn, en kiu, la unuaj du linioj aspektas jene:

```
Foo Bar
=======
```

tiam la unua linio funkcias kiel la dokumentotitolo. Por tiel fari, plenu:

    $ emem -F LEGUMIN.md

Tio liveras `<title>Foo Bar</title>`.

Tio agrablas kaj dandas, sed se oni nur volas krei nur rudimentan dokumenton sen ĉiom da ornamaĵoj, uzu la
senornaman reĝimon:

    $ emem -Rp LEGUMIN.md

La opcio `-R` diras al emem por ne krei la risurcajn dosierojn. La opcio `-p` forigas kaj la
CSS-stilojn kaj ĝavoskriptkodon.

Se oni volas ŝanĝi la nomon de la eliga dosiero, uzu la opcion `-o`.

    $ emem -o mia-dosiero.html LEGUMIN.md

Se oni havas markdaŭnajn dosierojn en `~/Desktop/`, oni povas krei HTML-dosireoj el ili en
unu falplonĝo:

    $ emem ~/Desktop

Se oni ne ŝatas la implicitan paĝlarĝecon—40 em—uzu la opcion `-f` por uzi la maksimuman paĝlarĝecon
de la retumilo:

    $ emem -f LEGUMIN.md

Kapablo kiu ege plaĉas al mi, estas kunfandado. Ĉi tio ebligas onin por kombini plurajn dosireojn en
sola eligo. Ekzemple, se oni havas `a.md`, `b.md`, kaj `c.md`, oni povas kunfandi ilin al
`index.html` per la opcio `-m`:

    $ emem -mo index.html a.md b.md c.md

Se oni planas eldoni por la TTT, estas grave, ke oni havas la valorojn de la priskriba kaj ŝlosila
meta-atribuoj. Oni povas fari ĝin per la opcioj `-D` kaj `-K`, respektive:

```sh
$ emem -D 'Retejo pri omaroj kaj kraboj \
-K 'omaroj, kraboj, blogo, ĵurnalo, retejo, maromanĝoj, monstroj' \
LEGUMIN.md
```

Ankaŭ eblas specifu [«Open Graph Protocol»](http://ogp.me/)-valorojn:

```sh
$ emem -D Ve -K 'a, b, c' \
--og-title "Kraboj kaj Omaroj" --og-type article \
--og-url "https://retejo.ie/z.html" --og-image "https://retejo.ie/imagesdo.jpg" \
LEGUMIN.md
```

Se oni volas uzi Guglan «Analytics», specifu la naŭ-ciferan kodon, kun la streketo:

    $ emem -D Ve -K 'a, b -A 12345678-9 LEGUMIN.md

Se la enhavo de la retejo precipe ne estas en la angla, estas bone por specifi la lingvon, por
helpi serĉilojn indeksigi la retejon ĝuste; ankaŭ helpas la programaron, kiel ekranlegiloj, specifi la
lingvon por la parolo. Por fari ĉi tion, uzu la opcion `-l`:

    $ emem -D 'Kie estas ĝi' -K 'kukurboj, hundegoj, afiŝoj' -l eo LEGUMIN.md

Plena listo de la subtenitaj lingvoj de modernaj retumiloj troveblas
[ĉi tie](https://www.w3schools.com/tags/ref_language_codes.asp).

Estas okazoj en kiu mi ne volas rompi la redaktadan iteracion laborante kun la enigaj dosieroj, kaj
mi volas, ke la HTML-dosieroj nur kreiĝos kiam ajn novaj ŝanĝoj al la fontaj markdaŭnaj dosieroj
realiĝas. Tiuokaze, mi alvokas la senpaŭzan reĝimon per la opcio `-c`:

    $ emem -c LEGUMIN.md

La aliaj opcioj povas esti kombinitaj per la opcio `-c` por plifajnigi la eligon. Ekzemple, por
munti senornaman eligon en senpaŭza reĝimo:

    $ emem -Rpc LEGUMIN.md

emem kontrolas la ŝanĝojn en `LEGUMIN.md` po 200 ms . Se ŝanĝo estis eltrovita, ĝi rekunmetas la
dosieron `LEGUMIN.html`. La tempolimo inter kontroloj povas esti ŝanĝita per la opcio `-t`. Por specifi unu
minutan tempolimon:

    $ emem -Rpc -t 1000 LEGUMIN.md

Kutime mi rulas emem jene:

    $ emem -Fis dosiero.md

Fine, por vidi ĉiom da subtenitaj opcioj de emem, rulu:

    $ emem --help


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Por ĉi tiu tuta [blogo](https://ebzzry.com), mi povis atingi 90+ poentaron de
[Google PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/),
«Mobile-Friendly»-pritakson de
[Google Mobile-Friendly Test](https://search.google.com/test/mobile-friendly), kaj ekonomian rangon
de B de [Pingdom](https://tools.pingdom.com/). Se oni povas regi la TTT-servilajn parametrojn, oni
eĉ povas atingi ekonomian rangon de A, kiam oni ekspluatas kaj specifas retumilan kaŝmemoron, kaj
specifas la `Vary: Accept-Encoding`-ĉapon. Mi uzas [GitHub Pages](https://pages.github.com), do
estas malsama sperto al mi.

Mi feliĉas pri la eligo kiun emem liveras. emem estas sufiĉe rapida kaj mi povas etendi ĝin facile.
Mi eĉ uzas ĝin por miaj propraj kaj postenaj dokumentadoj. Mi ankaŭ uzas ĝin per emakso por krei
TTT-versiojn de markdaŭnaj bufroj per
[shell-command](https://www.gnu.org/software/emacs/manual/html_node/elisp/Synchronous-Processes.html)
kaj [emacs-w3m](https://www.emacswiki.org/emacs/emacs-w3m). Por vidi emem en efektiva uzado, iru [ĉi tien](https://github.com/ebzzry/ebzzry.github.io/blob/main/makefile).

Se oni konas iom da Kloĵuro, forku [ĝin](https://github.com/ebzzry/emem/) kaj kodumu!
