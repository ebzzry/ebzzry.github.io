Migri de LiveJournal al Frog
============================

<center>[Esperante](#)  [English](/en/frog)</center>
<center>la 7-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 8-an de Februaro 2018</center>

>Mi ne scias kien mi iras, sed mi estas sur mia vojo.<br>
>―Carl SAGAN

Estas tempoj kiam oni volas havi pli da rego sur via enhavo. Estas ankaŭ tempoj kiam oni ne volas
alian platformon por dikti kion eniras aŭ eliras. Aferoj kiel cenzurado kaj politikoj, povas facile
rampi al blogan platformon. Mi spertis specificajn kazojn, en kiu, mi bezonis konverti
LiveJournal-ajn afiŝojn al alia platformo. Ekzistas iloj kiuj faras ĉi tion, tamen, mi trovis
nenion, ĝis nun, kiu tradukas al [Frog](https://github.com/greghendershott/frog/) dosieroj. Ĉi tio
estas mia malforta provo por atingi tiun celon.

Enhavotabelo
------------

- [Superrigardo](#superrigardo)
- [Instalado](#instalado)
- [Uzado](#uzado)
  + [Bazaj](#bazaj)
  + [Komentoj](#komentoj)
- [Ĝisdatigado](#ĝisdatigado)
- [Miksaĵo](#miksaĵo)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

livefrog estas utilaĵo, verkita per [Rakido](http://racket-lang.org), kiu estas uzata por migri
LiveJournal-ajn afiŝojn al Frog, blogada platformo ankaŭ verkita per Rakido. Uzas la dosierojn, kreitaj de aŭ [ljdump](http://hewgill.com/ljdump/) aŭ [ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="instalado"></a>Instalado
---------------------------------

Esti kapable por kuri la programojn, oni unue devas instali Rakidon:

Per Nix:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

Sekve, ni instalu livefrog-on—haveblas per [Planet2](https://pkg.racket-lang.org).

    $ raco pkg install livefrog

Se tio ne funkcias, vi facile povas instali livefrog-on per elŝuti ĝiajn dependecojn rekte de
GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

La vostaj suprenstrekoj gravas, por diri al `raco`, ke vi instalas de lokaj dosierujoj. Sen tiu, elŝutas
la fontojn de la interreto.


<a name="uzado"></a>Uzado
-------------------------

Ĉi tiu sekcio enhavas instrukciojn por krei konvenajn dosierojn por la uzado per Frog.


### <a name="bazaj"></a>Bazaj

Por krei Markdown-an dosieron de la dosiero `entry.xml`

    $ raco livefrog -m entry.xml

Tio, bedaŭrinde, fariĝos ĝene se vi administros pli ol cent enskriboj. Por aŭtomate kolekti la dosierojn, kreita de ljdump aŭ ljmigrate, kaj konverti ilin al Markdown:

    $ raco livefrog -am

Memoru, tamen, ke ljdump kaj limigrate malsamopinias kiel la arboj for la datumaj aroj estas kreitaj. ljdump havas la jenan arban strukturon, en kiu, `username` estas via LiveJournal-a uzantnomo:

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

Post krei la Markdown-ajn Frog-ajn fontajn dosierojn, vi nun povas kopii ilin al via Frog-a fonta dosierujo, indikata ĉe `_src/posts/`.


### <a name="komentoj"></a>Komentoj

Frog, defaŭlte, uzas [Disqus](https://disqus.com) por trakti la komentojn. Por importi komentojn al
ĉi tiu platformo, vi devas generi XML-an dosieron, kiu devas konformiĝi al la reglamentoj de Disqus
por importi komentoj.

Por krei tiel dosieron, nomata kiel `comments.xml` kun `foo.bar.com` kiel la radika retejo:

    $ raco livefrog -s foo.bar.com -c comments.xml

Ĉi tiu estos uzata per <https://import.disqus.com>.


<a name="ĝisdatigado"></a>Ĝisdatigado
-------------------------------------

Se vi instalis livefrog per Planet2, vi povas ĝisdatigi ĝin per kuri:

    $ raco pkg update livefrog

Tamen, se vi uzis la posta metodo, vi povas ĝisdatigi ĝin per elŝuti la ĝisdatojn, malinstali
livefrog, kaj denove instali ĝin:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="miksaĵo"></a>Miksaĵo
-----------------------------

Por redukti tajpadon, vi povas krei alinomon de `raco livefrog` en via ŝelo.

Per Sh-ecaj ŝeloj—Bash, Zsh, Ash, Ksh, Sh:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

Per Csh-ecaj ŝeloj—Csh, Tcsh:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

Anstataŭigu `.bashrc` kaj `.cshrc`, per la taŭga pravaloriza dosiero por via ŝelo.

La fontoj, kun la aldonaj informoj, troveblas [ĉi tie](https://github.com/ebzzry/livefrog). Se vi
konas Rakidon, forku ĝin!
