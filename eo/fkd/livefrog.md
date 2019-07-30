Migri de LiveJournal al Frog
============================

<div class="center">Esperanto ▪ [English](/en/livefrog/)</div>
<div class="center">la 7-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 8-an de Marto 2019</div>

>Mi ne scias kien mi iras, sed mi estas sur mia vojo.<br>
>―Carl SAGAN

Estas tempoj kiam oni volas havi pli da rego sur la enhavo. Estas ankaŭ tempoj kiam oni ne volas
alian platformon por dikti tion, kion eniras aŭ eliras. Aferoj kiel cenzurado kaj politikoj, facile
povas rampi al blogan platformon. Mi spertis specificajn kazojn, en kiu, mi bezonis konverti
LiveJournal-afiŝojn al alia platformo. Estas iloj kiuj faras ĉi tion, tamen, mi trovis
nenion, ĝis nun, kiu tradukas al [Frog](https://github.com/greghendershott/frog/) dosieroj. Ĉi tio
estas mia malforta provo por atingi tiun celon.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Bazaj aferoj](#bazaj)
- [Komentoj](#komentoj)
- [Ĝisdatigo](#gxisdatigo)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Livefrog estas utilaĵo, verkita per [Rakido](http://racket-lang.org), kiu uzatas migri
LiveJournal-afiŝojn al Frog, blogada platformo ankaŭ verkita per Rakido. Uzas la dosierojn,
kreitaj de aŭ [ljdump](http://hewgill.com/ljdump/) aŭ
[ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="instalo"></a>Instalo
-----------------------------

Esti kapable por kuri la programojn, oni unue devas instali Rakidon:

Per Nixpkgs:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

Sekve, ni instalu je livefrog—haveblas per [Planet2](https://pkg.racket-lang.org).

    $ raco pkg install livefrog

Se tio ne funkcias, oni facile povas instali je livefrog per elŝuti ĝiajn dependecojn rekte de
GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

La vostaj suprenstrekoj gravas diri al `raco`, ke oni instalas el lokaj dosierujoj. Elŝutos
la fontojn de la interreto sen tio.


<a name="bazaj"></a>Bazaj aferoj
--------------------------------

Por krei Markdown-an dosieron de la dosiero `entry.xml`

    $ raco livefrog -m entry.xml

Tio, bedaŭrinde, ĝene fariĝos se oni administros pli ol cent enskribojn. Por aŭtomate kolekti la
dosierojn, kreitaj de ljdump aŭ ljmigrate, kaj konverti ilin al Markdown:

    $ raco livefrog -am

Memoru, tamen, ke ljdump kaj limigrate malsamopinias kiel la arboj por la datumaj aroj
kreitas.

ljdump havas la jenan arban strukturon, en kiu, `username` estas via LiveJournal-uzantnomo:

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

La Markdown- kaj Frog-fontajn dosierojn kreinte, oni nun povas kopii ilin al via Frog-fonta
dosierujo, indikata ĉe `_src/posts/`.


<a name="komentoj"></a>Komentoj
-------------------------------

Frog, defaŭlte, uzas [Disqus](https://disqus.com) por trakti la komentojn. Por importi komentojn al
ĉi tiu platformo, oni devas generi XML-dosieron, kiu devas konformiĝi al la reglamentoj de Disqus
por importi komentojn.

Por krei tiel dosieron, nomata kiel `comments.xml`, kun `foo.bar.com` kiel la radika retejo:

    $ raco livefrog -s foo.bar.com -c comments.xml

Ĉi tiu uzatos per <https://import.disqus.com>.


<a name="gxisdatigo"></a>Ĝisdatigo
----------------------------------

Se oni instalis je livefrog per Planet2, oni povas ĝisdatigi ĝin per kuri:

    $ raco pkg update livefrog

Tamen, se oni uzis la postan metodon, oni povas ĝisdatigi ĝin per elŝuti la ĝisdatigojn, malinstali je
livefrog, kaj denove instali ĝin:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Por redukti maŝinskribadon, oni povas krei alinomon de `raco livefrog` en via ŝelo.

Por sh- kaj sh-ecaj ŝeloj—sh, ash, DASH; mksh; Baŝo; kaj Ziŝo; respektive:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.profile

    $ echo 'alias livefrog="raco livefrog"' >> ~/.mkshrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.zshenv

Por csh- kaj csh-ecaj ŝeloj—csh, Tcsh, respektive:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

La fontoj, kun la aldonaj informoj, troveblas [ĉi tie](https://github.com/ebzzry/livefrog). Se vi
konas Rakidon, forku ĝin!
