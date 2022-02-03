Migri de LiveJournal al Frog
============================

<div class="center">Esperanto ▪ [English](/en/livefrog/)</div>
<div class="center">la 7-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 3-an de Februaro 2022</div>

>Mi ne scias kien mi iras, sed mi estas sur mia vojo.<br>
>―Carl SAGAN

Estas tempoj kiam volas havi oni plian regon sur la enhavo. Estas ankaŭ tempoj kiam ne volas oni
alian platformon por dikti tion, kio eniras aŭ eliras. Aferoj kiel cenzurado kaj politikoj, facile
povas rampi al bloga platformo. Spertis mi specificajn kazojn, en kiu, bezonis mi konverti
LiveJournal-afiŝojn por alia platformo. Estas iloj kiuj faras ĉi tion, tamen, trovis mi nenion, ĝis
nun, kiu tradukas al [Frog](https://github.com/greghendershott/frog/)-dosieroj. Ĉi tio estas mia
malforta provo por atingi tiun celon.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Bazaj aferoj](#bazaj)
- [Komentoj](#komentoj)
- [Ĝisdatigo](#gxisdatigo)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo">Superrigardo</a>
---------------------------------------

Livefrog estas utilaĵo, verkita per [Rakido](http://racket-lang.org), kiu estas uzata por migrigi
LiveJournal-afiŝojn al Frog—blogada platformo ankaŭ verkita per Rakido. Uzas ĝi la dosierojn
kreitaj de aŭ [ljdump](http://hewgill.com/ljdump/) aŭ
[ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="instalo">Instalo</a>
-----------------------------

Esti kapable por plenumi la programojn, unue devas instali oni Rakidon:

Per Nixpkgs:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

Sekve, instalu ni je livefrog, kiu haveblas per [Planet2](https://pkg.racket-lang.org).

    $ raco pkg install livefrog

Se ne funkcias tio, facile povas instali oni je livefrog per elŝuti ĝiajn dependecojn rekte el
GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

Gravas la vostaj suprenstrekoj, diri al `raco`, ke instalas oni el lokaj dosierujoj. Elŝutos la
sistemo la fontojn el la interreto sen ili.


<a name="bazaj">Bazaj aferoj</a>
--------------------------------

Por krei Markdown-an dosieron de la dosiero `entry.xml`

    $ raco livefrog -m entry.xml

Bedaŭrinde, ĝene fariĝos tio se administros oni pli ol cent enskribojn. Por aŭtomate kolekti la
dosierojn (kreitaj de ljdump aŭ ljmigrate) kaj konverti ilin al Markdown:

    $ raco livefrog -am

Memoru, tamen, ke ljdump kaj limigrate malsamopinias kiel la arboj por la datumaj aroj
estas kreitaj.

Havas ljdump la jenan arban strukturon, en kiu, `username` estas la LiveJournal-uzantnomo:

```bash
ljdump/
  build
  ChangeLog
  convertdump.py
  username/
    L-1
    L-2
    C-2
    L-3
    ...
  ljdump.config
  ljdump.config.sample
  ljdump-gui.py
  ljdump.py*
  README.txt
  TODO
```

ljmigrate, aliflanke, uzas malsimilan formaton:

```bash
ljmigrate/
  LICENSE.text
  ljmigrate.cfg
  ljmigrate.cfg.sample
  ljmigrate.py*
  README.md
  README_windows.txt
  TODO
  www.livejournal.com/
    username/
      entry00001/
        entry.xml
      entry00002/
        entry.xml
        comment.xml
      html/
      metadata/
      userpics/
```

Kreinte la Markdown- kaj Frog-fontajn dosierojnkreinte, nun povas oni kopii ilin al la Frog-fonta
dosierujo, indikata ĉe `_src/posts/`.


<a name="komentoj"></a>Komentoj
-------------------------------

Uzas Frog je [Disqus](https://disqus.com) implicite por trakti la komentojn. Por importi komentojn al
ĉi tiu platformo, devas generi oni XML-dosieron, kiu devas konformiĝi al la reglamentoj de Disqus
por importi komentojn.

Por krei tiel dosieron, nomata kiel `comments.xml`, kun `foo.bar.com` kiel la radika retejo:

    $ raco livefrog -s foo.bar.com -c comments.xml

Ĉi tiu uziĝos per <https://import.disqus.com>.


<a name="gxisdatigo"></a>Ĝisdatigo
----------------------------------

Se instalis oni je livefrog per Planet2, povas ĝisdatigi oni ĝin per plenumi:

    $ raco pkg update livefrog

Tamen, se uzis oni la lastan metodon, povas ĝisdatigi oni ĝin per elŝuti la ĝisdatigojn, malinstali je
livefrog, kaj denove instali ĝin:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Por redukti maŝinskribadon, povas krei oni alinomon de `raco livefrog` ĉe la ŝelo.

Por sh- kaj sh-ecaj ŝeloj—sh, ash, DASH; mksh; Baŝo; kaj Ziŝo; respektive:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.profile

    $ echo 'alias livefrog="raco livefrog"' >> ~/.mkshrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.zshenv

Por csh- kaj csh-ecaj ŝeloj—csh, Tcsh, respektive:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

Troveblas la fontoj, kun la aldonaj informoj, [ĉi tie](https://github.com/ebzzry/livefrog). Se konas
vi Rakidon, forku ĝin!
