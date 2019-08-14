Konverti de Markdown al HTML per emem
=====================================

<div class="center">Esperanto ▪ [English](/en/emem/)</div>
<div class="center">la 5-an de Aŭgusto 2018</div>
<div class="center">Laste ĝisdatigita: la 14-an de Aŭgusto 2019</div>

>Oni ne trovos la respondojn kiujn oni serĉas ĝis oni haltas serĉi ekster kaj komenciĝas serĉi ilin
>el oni mem.<br>
>―Memory GATEKEEPER, Ergo Proxy

Manieron por HTML-dokumentojn krei el miaj Markdown-dosieroj mi ĉiam volis. Komence,
HTML-dosierojn el miaj tekstaj dosieroj mi nur volis havi por ke ilin mi povu vidi per mia
poŝtelefono. Poste, manieron por tiujn dosierojn krei por ke ilin mi povu alŝuti al la interreto
kaj ilin vidi sur aliaj aparatoj. Jam ekzistas iloj por ja tion fari. Ilin mi provis, tamen min mem
mi trovis la eligon ŝanĝi ofte nur por ilin igas akcepteblaj. Neniuj da ili konformiĝis al mia
kriterio: facile por munti, facile por uzi, kaj decan eligon realigas.

Na [emem](https://github.com/ebzzry/emem) mi skribis kiel respondo al tiuj bezonoj. Emem estas
malgranda ilo kiu Markdown-dosierojn ricevas aŭ el la ĉefenigujo aŭ diska dosiero, tiam HTML-eligon
liveras kiu sufiĉe decas, almenaŭ por kutima rigardado.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Instalo](#instalo)
- [Uzado](#uzado)
- [Finrimarkoj](#finrimarkoj)


<a name="instalo"></a>Instalo
-----------------------------

Emem haveblas per [Nix](https://nixos.org/nix/). Se na Nix oni ne ankoraŭ havas, ĝin oni povas
instali per:

    $ curl https://nixos.org/nix/install | bash

Tiam, na emem oni nun povas instali per:

    $ nix-env -i emem

Se na Nix oni ne povas instali, tamen ĝavo instalitas, porokazan skripton oni povas anstataŭ
krei:

```bash
$ mkdir ~/bin
$ curl -sSLo ~/bin/emem.jar https://github.com/ebzzry/emem/releases/download/v0.2.50/emem.jar
$ cat > ~/bin/emem << EOF
#!/usr/bin/env bash
java -jar \$HOME/bin/emem.jar \$@
EOF
$ chmod +x ~/bin/emem
```

Se ĝin oni jam finis krei, la version oni povas kontroli per:

    $ emem --version

La plej ĵusa versio estas `0.2.50`.


<a name="uzado"></a>Uzado
-------------------------

Ĉe la plej baza nivelo, na emem simple kuras kontraŭ Markdown-dosiero, bazan, tamen plenan
HTML-dosieron kun ĉiom da necesaj risurcoj por ĝusta paĝa montrado liveras. Na emem aplikante al
dosiero nomita `MINLEGU.md`:

    $ emem MINLEGU.md

la jenan arbon kreas:

```
static/
  css/
  ico/
  js/
MINLEGU.html
MINLEGU.md
```

Male, na emem kuri kiel jene:

    $ emem -s MINLEGU.md

la jenan arbon kreas:

```
MINLEGU.html
MINLEGU.md
```

La bezonon por apartan risurcan dosieron krei la `-s` opcio forigas, kaj ĉiom da bezonitaj risurcoj
metas al la eliga dosiero igas al ĝi facila kaj helpema por la eligajn dokumentojn rigardi sur
aparatoj kiel poŝtelefonoj kaj tabuletoj.

Tenu en la kalkulo, ke la dokumentotitolo ene la dosiero estos uzita kiel la baznomo de la
dosiero. Do, de `MINLEGU.md`, na `<title>MINLEGU.md</title>` liveras en la HEAD-etikedo. Se la
Markdown-dosierojn oni strukturas tia, ke la unuaj du linioj aspektas kiel:

```
Foo Bar
=======
```

tiam la unua linio funkcias kiel la dokumentotitolo. Por tiel fari, plenumu:

    $ emem -F MINLEGU.md

na `<title>Foo Bar</title>` liveronte.

Tio agrablas kaj dandas, sed nur rudimentan dokumenton oni nur volas krei sen ĉiom da ornamaĵoj, la
senornaman reĝimon uzu:

    $ emem -Rp MINLEGU.md

La `-R` opcio instruas al emem la risurcajn dosierojn ne krei, kaj la CSS-stilojn kaj
ĝavoskripton la `-p` opcio forigas.

Se la nomon de la eliga dosiero oni volas ŝanĝi, la `-o` opcion uzu.

    $ emem -o mia-dosiero.html MINLEGU.md

Se Markdown-dosierojn oni havas en `~/Desktop/`, ilin ĉiujn oni povas konverti al HTML-dosireoj en
unu falplonĝo:

    $ emem ~/Desktop

Se la defaŭltan larĝecon oni ne ŝatas—40 em—uzu na `-f` por la disponan retumilan paĝan ekranan
larĝecon uzi:

    $ emem -f MINLEGU.md

Kapablo kiu ege plaĉas al mi, estas kunfandado. Onin ĉi tio permesas por plurajn dosireojn kombini
en sola eligo. Ekzemple, se oni havas na `a.md`, `b.md`, kaj `c.md`, ilin oni povas kunfandi al
`index.html` per `-m`:

    $ emem -mo index.html a.md b.md c.md

Se oni planas eldoni por la TTT, estas grave, ke la valorojn de la priskriba kaj ŝlosila
meta-atribuoj oni disponigas. Ĝin oni povas fari per la `-D` kaj `-K` opcioj, respektive:

```bash
$ emem -D 'Retejo pri omaroj kaj kraboj \
-K 'omaroj, kraboj, blogo, ĵurnalo, retejo, maromanĝoj, monstroj' \
MINLEGU.md
```

Ankaŭ eblas por [«Open Graph Protocol»](http://ogp.me/)-valorojn precizigi:

```bash
$ emem -D Ve -K 'a, b, c' \
--og-title "Kraboj kaj Omaroj" --og-type article \
--og-url "https://retejo.ie/z.html" --og-image "https://retejo.ie/bildo.png" \
MINLEGU.md
```

Se la Guglan «Analytics» oni volas uzi, la naŭ-ciferan kodon precizigu, kun la streketon:

    $ emem -D Ve -K 'a, b -A 12345678-9 MINLEGU.md

Se la enhavo de la retejo precipe ne estas en la Angla, estas bone por la lingvon precizigi, por
serĉilojn helpi la retejon indeksigi ĝuste; la programaron ankaŭ helpas, kiel ekranlegiloj la
lingvon precizigi por la parolo. Por ĉi tion fari, la `-l` opcion uzu:

    $ emem -D 'Kie estas ĝi' -K 'kukurboj, hundegoj, afiŝoj' -l eo MINLEGU.md

Plena listo de la subtenitaj lingvoj de modernaj retumiloj troveblas
[ĉi tie](https://www.w3schools.com/tags/ref_language_codes.asp).

Estas okazoj en kiu la redaktadan iteracion mi ne volas rompi laborante kun la enigaj dosieroj,
kaj nur la HTML-dosieroj mi volas esti kreitaj kiam ajn novaj ŝanĝoj al la fontaj Markdown-dosieroj realiĝas. Tiuokaze, la senpaŭzan reĝimon per la `-c` opcio mi alvokas:

    $ emem -c MINLEGU.md

La aliaj opcioj povas esti kombinitaj kun la `-c` opcio por la eligon plifajnigi. Ekzemple, por
senornaman eligon munti en senpaŭza reĝimo:

    $ emem -Rpc MINLEGU.md

Ŝanĝojn al `MINLEGU.md` emem kontrolas po 200 ms. Se ŝanĝo estis eltrovita, la `MINLEGU.html` dosieron
ĝi rekunmetas. La tempolimo inter kontroloj povas esti ŝanĝita per la `-t` opcio. Por unu minutan
tempolimon precizigi:

    $ emem -Rpc -t 1000 MINLEGU.md

Kutime na emem mi kuras jene:

    $ emem -Fis dosiero.md

Por ĉiom da subtenitaj opcioj vidi:

    $ emem --help


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Por ĉi tiu tuta [blogo](https://ebzzry.io), 90+ poentaron mi povis atingi el
[Google PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/), «Mobile-Friendly» pritakso el
[Google Mobile-Friendly Test](https://search.google.com/test/mobile-friendly), kaj ekonomia rango
de B el [Pingdom](https://tools.pingdom.com/). Se la TTT-servilajn parametrojn oni povas regi,
ekonomian rangon de A oni eĉ povas atingi, kiam retumilan kaŝmemoron oni ekspluatas kaj la
`Vary: Accept-Encoding`-ĉapon precizigas. Na [GitHub Pages](https://pages.github.com) mi uzas, do estas
malsama rakonto de mi.

Mi feliĉas pri la eligo kiun emem liveras. Sufiĉe rapidas kaj ĝin mi povas etendi facile. Ĝin mi eĉ
uzas por miaj propraj kaj postenaj dokumentadoj. Ĝin mi ankaŭ uzas per emakso por TTT-versiojn de
Markdown-bufroj krei per
[shell-command](https://www.gnu.org/software/emacs/manual/html_node/elisp/Synchronous-Processes.html)
kaj [emacs-w3m](https://www.emacswiki.org/emacs/emacs-w3m). Por na emem vidi en efektiva uzado,
[ĉi tien](https://github.com/ebzzry/ebzzry.github.io/blob/master/makefile) iru.

Se iom da Kloĵuron oni konas, [ĝin forku](https://github.com/ebzzry/emem/) kaj forkodumu!
