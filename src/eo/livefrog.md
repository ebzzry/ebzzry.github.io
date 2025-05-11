---
title: Migri de LiveJournal al Frog
keywords: livefrog, livejournal, frog, disqus, blogo, migri, migrado 
image: https://ebzzry.com/images/site/stephanie-leblanc-xrE6WwccyU-unsplash-1008x250.jpg
---
Migri de LiveJournal al Frog
============================

<div class="center">[English](/en/livefrog/) ∅ Esperanto</div>
<div class="center">mer feb 7 20:15:42 2018 +0800</div>

>Mi ne scias kien mi iras, sed mi estas sur mia vojo.<br>
>—Carl SAGAN

<img src="/images/site/stephanie-leblanc-xrE6WwccyU-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="stephanie-leblanc-xrE6Wwccy_U-unsplash" title="stephanie-leblanc-xrE6Wwccy_U-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Instalo](#instalo)
- [Bazaferoj](#bazaferoj)
- [Komentoj](#komentoj)
- [Ĝisdatigo](#gxisdatigo)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Estas tempoj kiam oni volas havi plian regon de la enhavo. Estas ankaŭ tempoj kiam ni ne volas
alian platformon por dikti kio eniras aŭ eliras. Aferoj kiel cenzurado kaj politikoj, facile
povas rampi al bloga platformo. Mi spertis specificajn kazojn, en kiu, mi bezonis konverti
LiveJournal-afiŝojn por alia platformo. Estas iloj kiuj faras tion, tamen, mi trovis nenion, ĝis
nun, kiu tradukas al [Frog](https://github.com/greghendershott/frog/)-dosieroj. Ĉi tio estas mia
malforta provo por atingi tiun celon.

Livefrog estas utilaĵo, verkita per [Rakido](http://racket-lang.org), kiu estas uzata por migrigi
LiveJournal-afiŝojn al Frog—blogada platformo, ankaŭ verkita per Rakido. Ĝi uzas la dosierojn
kreitaj de aŭ [ljdump](http://hewgill.com/ljdump/) aŭ
[ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="instalo">Instalo</a>
-----------------------------

Esti kapable por ruli la programojn, unue oni devas instali Rakidon:

Per Nixpkgs:

    $ nix-env -i racket

Per APT:

    $ sudo apt-get install -y racket

Sekve, ni instalu livefrog, kiu haveblas per [Planet2](https://pkg.racket-lang.org).

    $ raco pkg install livefrog

Se ne funkcias tio, oni facile povas instali livefrog per elŝuti ĝiajn dependecojn rekte el
GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

La vostaj suprenstrekoj gravas, diri al `raco`, ke oni instalos el lokaj dosierujoj. La sistemo
elŝutos la fontojn el la interreto sen ili.


<a name="bazaferoj">Bazaferoj</a>
---------------------------------

Por krei markdaŭnan dosieron de la dosiero `entry.xml`

    $ raco livefrog -m entry.xml

Bedaŭrinde, tio fariĝos ĝena se oni administros pli ol cent enskribojn. Por aŭtomate kolekti la
dosierojn—kreitaj de ljdump aŭ ljmigrate—kaj konverti ilin al markdaŭno:

    $ raco livefrog -am

Memoru, tamen, ke ljdump kaj limigrate malsamopinias kiel la arboj por la datenaj aroj
estas kreitaj.

Ljdump havas la jenan arban strukturon, en kiu, `username` estas la LiveJournal-uzantnomo:

```sh
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

```sh
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

Kreinte la markdaŭnaj- kaj Frog-fontajn dosierojnkreinte, oni nun povas kopii ilin al la Frog-fonta
dosierujo, indikata ĉe `_src/posts/`.


<a name="komentoj">Komentoj</a>
-------------------------------

Frog uzas [Disqus](https://disqus.com) implicite por trakti la komentojn. Por importi komentojn al
tiu platformo, oni devas generi XML-dosieron, kiu devas konformiĝi al la reglamentoj de Disqus
por importi komentojn.

Por krei tiel dosieron, nomata kiel `comments.xml`, kun `foo.bar.com` kiel la radika retejo:

    $ raco livefrog -s foo.bar.com -c comments.xml

Ĉi tiu uziĝos per <https://import.disqus.com>.


<a name="gxisdatigo">Ĝisdatigo</a>
----------------------------------

Se oni instalis livefrog per Planet2, oni povas ĝisdatigi ĝin per ruli:

    $ raco pkg update livefrog

Tamen, se oni uzis la lastan metodon, oni povas ĝisdatigi ĝin per elŝuti la ĝisdatigojn, malinstali je
livefrog, kaj denove instali ĝin:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Por redukti maŝinskribadon, oni povas krei alinomon de `raco livefrog` ĉe la ŝelo.

Por sh- kaj sh-ecaj ŝeloj—sh, ash, DASH; mksh; Baŝo; kaj Ziŝo; respektive:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.profile

    $ echo 'alias livefrog="raco livefrog"' >> ~/.mkshrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.zshenv

Por csh- kaj csh-ecaj ŝeloj—csh, Tcsh, respektive:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

La fontoj troveblas, kun la aldonaj informoj, [ĉi tie](https://github.com/ebzzry/livefrog). Se vi konas
Rakidon, forku ĝin!
