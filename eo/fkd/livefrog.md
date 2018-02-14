Migri de LiveJournal al Frog
============================

<center>[Esperante](#)  [English](/en/frog)</center>
<center>la 7-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 11-an de Februaro 2018</center>

>Mi ne scias kien mi iras, sed mi estas sur mia vojo.<br>
>―Carl SAGAN

Estas tempoj kiam oni volas havi pli da rego sur la enhavo. Estas ankaŭ tempoj kiam oni ne volas
alian platformon por dikti tion, kion eniras aŭ eliras. Aferoj kiel cenzurado kaj politikoj, facile
povas rampi al blogan platformon. Mi spertis specificajn kazojn, en kiu, mi bezonis konverti
LiveJournal-ajn afiŝojn al alia platformo. Ekzistas iloj kiuj faras ĉi tion, tamen, mi trovis
nenion, ĝis nun, kiu tradukas al [Frog](https://github.com/greghendershott/frog/) dosieroj. Ĉi tio
estas mia malforta provo por atingi tiun celon.

Enhavotabelo
------------

- [Superrigardo](#superrigardo)
- [Instalo](#instalo)
- [Bazaj aferoj](#bazaj)
- [Komentoj](#komentoj)
- [Ĝisdatigo](#ĝisdatigo)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Livefrog estas utilaĵo, verkita per [Rakido](http://racket-lang.org), kiu uzatas migri
LiveJournal-ajn afiŝojn al Frog, blogada platformo ankaŭ verkita per Rakido. Uzas la dosierojn,
kreitaj de aŭ [ljdump](http://hewgill.com/ljdump/) aŭ
[ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="instalo"></a>Instalo
-----------------------------

Esti kapable por kuri la programojn, oni unue devas instali Rakidon:

Per Nix:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

Sekve, ni instalu livefrog-on—haveblas per [Planet2](https://pkg.racket-lang.org).

    $ raco pkg install livefrog

Se tio ne funkcias, oni facile povas instali livefrog-on per elŝuti ĝiajn dependecojn rekte de
GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

La vostaj suprenstrekoj gravas por diri al `raco`, ke oni instalas el lokaj dosierujoj. Elŝutos
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

ljdump havas la jenan arban strukturon, en kiu, `username` estas via LiveJournal-a uzantnomo:

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

Post krei la Markdown-ajn Frog-ajn fontajn dosierojn, oni nun povas kopii ilin al via Frog-a fonta
dosierujo, indikata ĉe `_src/posts/`.


<a name="komentoj"></a>Komentoj
-------------------------------

Frog, defaŭlte, uzas [Disqus](https://disqus.com) por trakti la komentojn. Por importi komentojn al
ĉi tiu platformo, oni devas generi XML-an dosieron, kiu devas konformiĝi al la reglamentoj de Disqus
por importi komentojn.

Por krei tiel dosieron, nomata kiel `comments.xml`, kun `foo.bar.com` kiel la radika retejo:

    $ raco livefrog -s foo.bar.com -c comments.xml

Ĉi tiu uzatos per <https://import.disqus.com>.


<a name="ĝisdatigo"></a>Ĝisdatigo
---------------------------------

Se oni instalis livefrog-on per Planet2, oni povas ĝisdatigi ĝin per kuri:

    $ raco pkg update livefrog

Tamen, se oni uzis la postan metodon, oni povas ĝisdatigi ĝin per elŝuti la ĝisdatigojn, malinstali
livefrog-on, kaj denove instali ĝin:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Por redukti tajpadon, oni povas krei alinomon de `raco livefrog` en via ŝelo.

Per Sh-ecaj ŝeloj—Bash, Zsh, Ash, Ksh, Sh:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

Per Csh-ecaj ŝeloj—Csh, Tcsh:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

Anstataŭigu `.bashrc` kaj `.cshrc`, laŭ la taŭgaj pravalorizaj dosieroj por via ŝelo.

La fontoj, kun la aldonaj informoj, troveblas [ĉi tie](https://github.com/ebzzry/livefrog). Se vi
konas Rakidon, forku ĝin!
