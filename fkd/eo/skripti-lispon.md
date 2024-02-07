Skriptado en Komunlispo
=======================

<div class="center">Esperanto ■ [English](/en/script-lisp/)</div>
<div class="center">Laste ĝisdatigita: la 23-an de Februaro 2022</div>

>La lumo kiu fajras duoble brila, fajras duone longa.<br>
>—D-ro Eldon TYRELL, Blade Runner (1982)

<img src="/bil/lispo-simbolo.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="common-lisp.net emblemo" title="common-lisp.net emblemo"/>


<a name="et"></a>Enhavotabelo
-----------------------------

- [Enkonduko](#enkonduko)
- [Antaŭkondiĉoj](#antauxkondicxoj)
- [Bazaferoj](#bazaferoj)
  + [Dosierindikoj](#dosierindikoj)
  + [Difinoj](#difinoj)
  + [Kunmetado](#kunmetado)
- [Pli](#pli)
- [Avertoj](#avertoj)
- [Finrimarkoj](#finrimarkoj)


<a name="Enkonduko"></a>Enkonduko
---------------------------------

Plenaj tutaj sistemoj kaj bibliotekoj estas ĉiam komfortaj areoj por komunlispaj
uzantoj. Bedaŭrinde, de longe, ne ekzistis definitiva solvo en komunlispon uzi kiel skriptada
lingvo. Skriptada lingvo, en ĉi tiu kunteksto, signifas pri iu, kiu similas anime al komandliniaj
ŝeloj—tio estas, iu kiu estas uzita por sistemkomandojn administri kaj regi sur la apa nivelo. La
signifo ankaŭ etendas al la aŭtomacioj de la rulo de taskoj kiuj aliamaniere faritaj unu post
alia. En ĉi tiu artikolo, mallongan enkondukon pri kiel komunlispon uzi en la skriptada areo mi
priparolos.

Unu el la plej oftaj demandoj kiun mi ricevas kiam mi diras, ke skriptadon mi
volas fari per komunlispo, estas, kiel tion mi eĉ volas fari kaj tio
maleblas. La respondo simplas: plian potencon kaj esprimplenecon mi volas
havi. Maturan kaj nelimigitan lingvon mi volas havi. Lingvon kiu miajn ideojn
povas esprimi en la malplej kiomo de froto mi volas havi.

Skripto estas nur tiel potenca kiel la lingvo kaj iloj povus permesi. Baŝo kaj siaj amikoj,
ekzemple, estas bonegaj por ideojn esprimi, tiel longe kiel komandojn oni maŝinskribas ĉe la komandlinio
mem. La konduton ene skripto ĝi imitas. Funkciojn oni povas difini por procedurojn fari, sed ili nur
estas tiel. Funkcioj en Baŝo ne estas ie proksimaj al la funkcioj en lingvoj kiel komunlispo. Kiel
interaga uzantŝelo, ĝi funkcias bone; escepte tio, ne.

Ekzistas aliaj skriptadaj solvoj en aliaj lingvoj. Haskelo, Pitono, Skimo, kaj
Rubeno, kelkajn ilin nomante, ĝin havas. Tamen estas bona eblo de komunlispo,
kiu estas malfacila por realigi aŭ ne ekzistas en aliaj aliroj: pro la skriptoj
mem estas validaj komunlispaj programoj, la programojn mi povas ŝargi en la REPL
kaj afablajn aferojn mi povas fari kun tio. Neniu venas proksima al la flekso,
kiun komunlispo provizas interagante kun realtempaj kurantaj programoj.

En ĉi tiu mallonga gvidilo, alian belan aĵon pri komunlispa skriptado mi ankaŭ tuŝetas: multvokaj
duumdosieroj. Multvoka duumdosiero estas sola rulebla dosiero kiu povas esti elreferencita per
pluraj nomoj. Ĉiu nomo kongruas al specifa proceduro ene tiu sola duumdosiero. La beleco de ĉi tiu
aliro, estas, ke anstataŭ multajn malsamajn programojn administri, nur unu dosieron oni administras, kaj
la ĝustan proceduron ĝi disdonos kiu uzanto deziras. Ĉi tio similas al kiun Busybox
faras. Komunlispe ĉi tio estas traktita de [cl-launch](https://github.com/fare/cl-launch).


<a name="antkauxkondicxoj"></a>Antaŭkondiĉoj
--------------------------------------------

Skriptado en komunlispo funkcias super la lingvo, tio estas, en la formo de bibliotekoj kiuj la
abstraktadojn disponigas por interagi kun la sistemo kaj la medio. [Utilities for Implementation-
and OS- Portability (UIOP)](https://gitlab.common-lisp.net/asdf/asdf/tree/master/uiop) estas aro de
abstraktadoj kiuj nin permesas por porteblan lispan kodon skribi. UIOP estas enkonstruita en
ASDF3—kiu estas parto de la plejparto de komunlispaj realigoj—do ne ekzistas bezono por ĝin permane
instali. [inferior-shell](https://github.com/fare/inferior-shell) helpas por la procezojn
administri. [cl-scripting](https://github.com/fare/cl-scripting) helpas por pli da rego.

La programo `cl-launch` devas esti instalita ĉe la sistemo. Ĝi estos respondeca por la kreado de la
multvoka duumdosiero mem. Por je `cl-launch` instali:

Per APT:

    $ sudo apt-get install -y cl-launch

Per Nixpkgs:

    $ nix-env -i cl-launch


<a name="bazaferoj">Bazaferoj</a>
---------------------------------


### <a name="dosierindikoj"></a>Dosierindikoj

Komencante, novan projektan dosierujon ni kreu. La projekton ni kunmetu en `$HOME/common-lisp`.

    $ mkdir -p ~/common-lisp/my-scripts

Ĉi tiu dosiero estas unu el la laŭnormaj dosierindikoj kiun ASDF rampigos por `.asd`-dosieroj. Estas
inde por noti, ke ne gravas se `$HOME/common-lisp` estas kutima dosierujo aŭ simbolligilo al iu.


### <a name="difinoj"></a>Difinoj

Tiam la dosieron `my-scripts.asd` ni kreu en tiu dosierujo. Por komenci, la jenan ĝi havos:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Muno VAKELO"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"))
```

Kelke da funkcioj kiujn ni bezonas, estas en ASDF 3.1, pro tio la tutan sistemon ni devas kondiĉigi.
La dependecojn ĉe `cl-scripting` ni deklaras, kiu kelkajn helpilojn provizas; kaj ĉe
`inferior-shell`, kiu la aĵojn kiujn ni bezonas por la ŝelajn procezojn administri provizas.

Sekve, la dosieron `main.lisp` ni kreu en la sama dosierujo. La jenan ĝi havos:

```lisp
(uiop:define-package :my-scripts/main
    (:use #:cl
          #:uiop
          #:cl-scripting
          #:inferior-shell
          #:fare-utils
          #:cl-launch/dispatch)
  (:export #:getuid
           #:symlink
           #:help
           #:main))

(in-package #:my-scripts/main)

(exporting-definitions
  (defun getuid ()
    #+sbcl (sb-posix:getuid)
    #+cmu (unix:unix-getuid)
    #+clisp (posix:uid)
    #+ecl (ext:getuid)
    #+ccl (ccl::getuid)
    #+allegro (excl.osi:getuid)
    #-(or sbcl cmu clisp ecl ccl allegro) (error "no getuid"))

 (defun symlink (src)
   (let ((binarch (resolve-absolute-location `(,(subpathname (user-homedir-pathname) "bin/")) :ensure-directory t)))
     (with-current-directory (binarch)
       (dolist (i (cl-launch/dispatch:all-entry-names))
         (run `(ln -sf ,src ,i)))))
   (success))

 (defun help ()
   (format! t "~A commands: ~{~A~^ ~}~%" (get-name) (all-entry-names))
   (success))

 (defun main (&rest args)
   (format t "main~%")))

(register-commands :my-scripts/main)
```

Ni komencu per je `UIOP:DEFINE-PACKAGE` uzi. Male al `DEFPACKAGE`, la necesan medion kiu estas amika
al UIOP ĉi tio kreas. En la klaŭzo `:USE`, la helpilojn de aliaj bibliotekoj ni uzos. En la korpo de
ĉi tiu dosiero, je `EXPORTING-DEFINITIONS` oni povas vidi. La limojn de tiuj, kiuj iĝos duumdosieroj
aŭ ne, ĉi tiu markilo efektive markas. Ĝi estos uzita de `REGISTER-COMMANDS` poste.

Ĉi tie, kelkajn funkciojn ni difinas: `SYMLINK` respondecas pri la kreado de la simbolligiloj por la
multvoka duumdosiero; kelkajn bazuzajn informojn `HELP` montras; kaj `MAIN` estas la enirejo de nia
skripto. La duumdosiero troveblos en `$HOME/bin/`. Por la procedon pri la kunmetado de la skripto
kaj simbolligiloj plifaciligi, la kunmetadajn instrukciojn ni metos en Makefile. La dosieron
`Makefile` en la aktuala dosierujo kreu, tiam la jenan metu:

```Makefile
NAME=my-scripts
BINARY=$(HOME)/bin/$(NAME)
SCRIPT=$(PWD)/$(NAME)
CL=cl-launch

.PHONY: all $(NAME) clean

all: $(NAME)

$(NAME):
    @$(CL) --output $(NAME) --dump ! --lisp sbcl --quicklisp --system $(NAME) --dispatch-system $(NAME)/main

install: $(NAME)
    @ln -sf $(SCRIPT) $(BINARY)
    @$(SCRIPT) symlink $(NAME)

clean:
    @rm -f $(NAME)
```

En la celo `$(NAME)`, je `cl-launch` ni voku kun la opcioj por la skripton kunmeti. En la celo
`install`, la skripton ni alvoku kun la opcioj `symlink $(NAME)`, por la simbolligilojn de la
multvoka duumdosiero krei. Pro nur tri funkciojn ni difinis ene la korpo de `EXPORTING-DEFINITIONS`,
nur tri simbolligilojn al `my-scripts` ĝi kreos. La eligan dosieron la opcio `‑‑output $(NAME)`
precizigas. La `‑‑dump !` signifas, ke bildon ĝi kreos, por pli rapidan startigon ŝalti. La opcio
`‑‑lisp sbcl` signifas, ke je SBCL ni volas uzi, por ĉi tiu skripto. La opcio `‑‑quicklisp`
signifas, ke je [Quicklisp](https://www.quicklisp.org) ni ŝargas kun la bildo. La sistemon, kiun ni
kreas la opcio `‑‑system $(NAME)` ŝargas. La enirejo de nia programo la opcio
`‑‑dispatch-system $(NAME)/main` precizigas.


### <a name="kunmetado"></a>Kunmetado

Ni nun pretas por la skripton kaj la simbolligilojn krei. Por tion fari, rulu:

    $ mkdir -p ~/bin
    $ make install

La multvokan duumdosieron—`./my-scripts`—ĉi tiu komando kunmetas kun la respondaj simbolligiloj. La dosieruja arbo de `~/bin` devas aspekti jene:

```bash
$ tree ~/bin
/home/vakelo/bin
├── getuid -> my-scripts
├── help -> my-scripts
├── my-scripts -> /home/vakelo/common-lisp/my-scripts/my-scripts
└── symlink -> my-scripts

0 directories, 5 files
```

Por kontroli, ke ĝi efektive funkcias, rulu:

    $ getuid

Sa la uzantnumeron ĝi montras, tiam ni povas daŭrigi.


<a name="pli"></a>Pli
---------------------

Ni supozu, ke la baterian staton de la tekkomputilo oni volas scii de la komandlinio. Tion ni povas
difini per kelkaj funkcioj. Je `my-scripts.asd` ni modifu per la aldonajn deklarojn enhavi:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Muno VAKELO"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"
               "my-scripts/general"))
```

Tiam, la dosieron `general.lisp` ni plenigu per la jena enhavo:

```lisp
(uiop:define-package #:scripts/general
    (:use #:cl
          #:fare-utils
          #:uiop
          #:cl-scripting
          #:inferior-shell
          #:cl-launch/dispatch
          #:optima
          #:optima.ppcre
          #:local-time)
  (:export #:battery
           #:screenshot))

(in-package #:scripts/general)

(defvar *screenshots-dir*
  (subpathname (user-homedir-pathname) "Desktop/"))

(defun battery-status ()
  (let ((base-dir "/sys/class/power_supply/*")
        (exclude-string "/AC/"))
    (with-output (s nil)
      (loop :for dir :in (remove-if #'(lambda (path)
                                        (search exclude-string (native-namestring path)))
                                    (directory* base-dir))
            :for battery = (first (last (pathname-directory dir)))
            :for capacity = (read-file-line (subpathname dir "capacity"))
            :for status = (read-file-line (subpathname dir "status"))
            :do (format s "~A: ~A% (~A)~%" battery capacity status)))))

(exporting-definitions
 (defun battery ()
   (format t "~A" (battery-status))
   (values))

 (defun screenshot (mode)
   (let* ((dir *screenshots-dir*)
          (file (format nil "~A.png" (format-timestring nil (now))))
          (dest (format nil "mv $f ~A" dir))
          (image (format nil "~A/~A" dir file)))
     (flet ((scrot (file dest &rest args)
              (run/i `(scrot ,@args ,file -e ,dest))))
       (match mode
              ((ppcre "(full|f)") (scrot file dest))
              ((ppcre "(region|r)") (scrot file dest '-s))
              (_ (err (format nil "invalid mode ~A~%" mode))))
       (run `("xclip" "-selection" "clipboard" "-t" "image/png" ,image))
       (success)))))

(register-commands :scripts/general)
```

En la difino de `BATTERY`, la liveraĵon de `(BATTERY-STATUS)` ĝi eligas en home amika maniero, tio
estas, sen la duoblaj citiloj. Tiam nenian valoron la funkcio `BATTERY` do liveras. Ĉi tion ni devas
fari tial, ke nur la eligon al la alvoko de `BATTERY-STATUS` ni bezonas.

Aliflanke, enrankopion per *scrot* la funkcio `SCREENSHOT` tenas tiam la absolutdosierindikon de la
bildo ĝi disponebligas el la tondeja zono per *xclip*. La bibliotekojn `local-time` por la data
signovico kaj biblioteko; kaj `optima`, por la ripetiĝa kongruado. Por la komandon `screenshot`
ebligi, la duumdosierojn dependecojn instalu. La jenajn komandojn rulu ĉe APT- kaj Nix-sistemoj,
respektive:

    $ sudo apt-get install -y scrot xclip

    $ nix-env -i scrot xclip

Uzantapojn lanĉi kaj administri facilas. Ni komencu per dependecon aldoni en `my-scripts.asd`:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Lolu VAKELO"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"
               "my-scripts/general"
               "my-scripts/apps"))
```

Tiam je `apps.lisp` ni plenigu:

```lisp
(uiop:define-package #:scripts/apps
    (:use #:cl
          #:fare-utils
          #:uiop
          #:inferior-shell
          #:cl-scripting
          #:cl-launch/dispatch)
  (:export #:chrome
           #:kill-chrome
           #:stop-chrome
           #:continue-chrome))

(in-package #:scripts/apps)

(exporting-definitions
 (defun chrome (&rest args)
   (run/i `(google-chrome-beta ,@args)))

 (defun kill-chrome (&rest args)
   (run `(killall ,@args chromium-browser chromium google-chrome chrome)
        :output :interactive :input :interactive :error-output nil :on-error nil)
   (success))

 (defun stop-chrome ()
   (kill-chrome "-STOP"))

 (defun continue-chrome ()
   (kill-chrome "-CONT")))

(register-commands :scripts/apps)
```

Tiam je *my-scripts* ni rekunmetu:

```bash
$ make install
my-scripts available commands: battery chrome continue-chrome getuid help kill-chrome main screenshot stop-chrome symlink
```

Hura!


<a name="avertoj"></a>Avertoj
-----------------------------

Gravan aferon por teni en la kalkulo, estas, en la difinoj, komunlispajn ŝlosilvortojn oni ne povas uzi kiel la nomo de komando. Do ene `EXPORTING-DEFINITIONS` la jenan oni ne povas havi:

```lisp
(exporting-definitions
  (defun t (&rest args)
    (run/i `(urxvt ,@args)`)))
```

Se tion oni faras kaj la dosieron oni provas kompili, la komunlispa realigo plendos pri nomo kiu
estas jam uzata.


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Onidire ke komunlispo jam velkiĝis al obskuro; ke ĝin oni ne plu uzas; ke ĝi ne plu utilas. Ne, tio
ne pravas. Nur ĉar iu ne plu estas diskutita en plimulta novaĵo, ne signifas, ke ĝi mortas aŭ ĝi ne
plu plaĉas al homo. Komunlispo estas normhava lingvo, kaj garantion programo kiu konformiĝas al la
normo havas—ĝis tia grado ke—ĝi ankoraŭ povas kuri en la estontecon. Por lingvan normon krei estas
monumenta tasko—ĝi postulas, ke malsamaj, eble konfliktaj anaroj devas akordi al unu la
alia. Ekzistas multaj diversaj realigoj de komunlispo, kaj la celojn ĉiu realigo strebas atingi,
kiuj ne necesas kongruaj al la aliaj realigoj. Tio bonas tial, ke spacon ĝi kreas por realigistoj
kaj desegnistoj, pri kiel labori ĉe la bazaj specifoj. Tiel longe kiel ili akordas al la normo,
aferoj verdas.

[baf](https://github.com/ebzzry/baf), Nixpkgs- kaj NixOS-helpilo, estas funkcia ekzemplo de komunlispa
skriptado. [pelo](https://github.com/zhaqenl/pelo/), ping-kovrilo, estas alia ekzemplo, kiu ĉi
tiun facilon uzas. Kelkajn personajn helpilajn [skriptojn](https://github.com/ebzzry/scripts/) kiujn
mi kroĉis al mia [StumpWM-agordo](https://github.com/ebzzry/dotfiles/tree/master/stumpwm) mi skribis. 

La priresponda homo por komunlispon igi ebla kaj akceptebla estas
[François-René RIDEAU](http://fare.tunes.org). Estis
[ĉi tiu blogo](http://fare.livejournal.com/184127.html) kiu min inspiris por la
vivpovecon vidi de komunlispo kiel skriptada lingvo.

_La paĝa rubando supre venis el [common-lisp.net](https://common-lisp.net/)._
