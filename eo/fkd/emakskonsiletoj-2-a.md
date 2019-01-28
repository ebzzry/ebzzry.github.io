Emakskonsiletoj 2-a: Seancoj kaj Pakoj
======================================

<div class="center">Esperanto · [English](/en/emacs-tips-2/)</div>
<div class="center">la 20-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 28-an de februaro 2019</div>

Ĉi tiu estas la daŭrigo de la serioj pri emaksaj konsiletoj. En ĉi tiu afiŝo, ni esploras seancan
mastrumadon, pakojn, krommarĝenojn, kaj aliajn malgrandajn agrablajn aferojn.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Desktop](#desktop)
- [Savehist](#savehist)
- [Kunfando](#kunfando)
- [Pakoj](#pakoj)
  + [ELPA](#elpa)
  + [use-package](#use-package)
- [Lininumeroj](#lininumeroj)
- [Tempindikoj](#tempindikoj)
- [Klavoj](#klavoj)
- [Linifinio sen krommarĝeno](#linifinio)
- [Plenigado](#plenigado)
- [Montrilomovado](#montrilo)
- [Gitstato en Dired](#gito)
- [Klavkombinoj](#klavkombinoj)
- [Finrimarkoj](#finrimarkoj)


<a name="desktop"></a>Desktop
-----------------------------

Havenda ilo kiun mi nun uzas estas _Desktop_. Ĝi konservas la staton de la emaksa seanco, por ke en
la okazo de kraŝo, kurenta malfunkcio, aŭ io kiu igas min perdi mian seancon, mi povu reiri al
ĝi. Desktop enkonstruitas kun la plej ĵusaj versioj de emakso. La jena estas la kodaĵo:

```lisp
(require 'desktop)

(desktop-save-mode)

(setq desktop-dirname "~/.emacs.d"
      desktop-base-file-name "desktop"
      desktop-base-lock-name "desktop.lock"
      desktop-restore-frames t
      desktop-restore-reuses-frames t
      desktop-restore-in-current-display t
      desktop-restore-forces-onscreen t)

(defun desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
```


<a name="savehist"></a>Savehist
-------------------------------

Alia grava funkciado kiun mi uzas estas _Savehist_. Ĝi konservas la etbufran historion. Iomete similas
al konservi la komandlinian historion. La jena estas la kodaĵo:

```lisp
(savehist-mode t)

(setq savehist-file "~/.emacs.d/savehist")
```


<a name="kunfando"></a>Kunfando
-------------------------------

Okazis multe da fojo, kiam mi volas permane konservi la staton de tiom da seancan informon kiun mi
povas konservi. Mi volus konservi la bufrojn, etbufran historion, legosignojn, kaj je comint-reĝiman
historion. Por fari tiel, mi havas la jenan:

```lisp
(defun save-defaults ()
  (desktop-save desktop-dirname)
  (savehist-save)
  (bookmark-save))

(defun save-histories ()
  (let ((buf (current-buffer)))
    (save-excursion
      (dolist (b (buffer-list))
        (switch-to-buffer b)
        (save-history)))
    (switch-to-buffer buf)))

(defun save ()
  (interactive)
  (save-desktop)
  (save-defaults)
  (save-histories))
```

Liveras la agrablan:

    M-x save EN


<a name="pakoj"></a>Pakoj
-------------------------

### <a name="elpa"></a>ELPA

ELPA estas la pako-administrila sistemo de emakso. Se vi ne ankoraŭ uzas la paksistemon, uzu ĝin
nun. Ĉiuj, kiujn oni bezonas komenci estas la jena:

```lisp
(require 'package)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(defalias 'pi 'package-install)
(defalias 'pl 'package-list-packages)
(defalias 'pr 'package-refresh-contents)
```

Por listigi ĉiujn haveblajn pakojn, premu:

    M-x pl EN

Se vi konas la nomon de pako, premu:

    M-x pi EN pako EN

Por ĝistadigi vian lokan datumon, premu:

    M-x pr EN


### <a name="use-package"></a>use-package

Ĉi tiu estas vera valorŝtono. Similas al `require`, tamen kun steroidoj. Kiam *require*-igi pakon,
oni havas la elekton por instali tiun pakon, se tiu ne ankoraŭ ekzistas. Ankaŭ donas al la uzanto
la kapablon por agordi tiun pakon, ene unuigita esprimo. Tamen, male `require`, `use-package` ne
alvenas konstruita kun emakso. Oni bezonas instali ĝin per `package-install`:

    M-x pi EN use-package EN

Oni nun povas postuli ĝin je sekvajn uzadojn:

```lisp
(require 'use-package)
```

Por instali `markdown-mode` ekzemple, se eĉ ne jam ekzistas, kaj agordi siajn rilatajn opciojn post
ŝargi ĝin, havu la jenan:

```lisp
(use-package markdown-mode
    :ensure t
    :config
    (progn
      (push '("\\.text\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.markdown\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.md\\'" . markdown-mode) auto-mode-alist)))
```


<a name="lininumeroj"></a>Lininumeroj
-------------------------------------

Mi tre ŝatas havi la lininumerojn montrataj ĉe la maldekstra marĝeno. Donas al mi iom da ideo kiel
granda la dosiero estas, kaj kie ni nune estas. Ŝalti `linum-mode` atingas tion:

```lisp
(setq linum-format "%5d │ ")

(defun my-linum-mode-hook ()
  (linum-mode t))

(add-hook 'find-file-hook 'my-linum-mode-hook)
```


<a name="tempindikoj"></a>Tempindikoj
-------------------------------------

Mi ofte bezonas meti tempindikojn, precipe kiam mi redaktas mian ĉiutagan protokoldosieron. La jena
estas kelke da kodaĵo por helpi onin:

```lisp
(defun format-date (format)
  (let ((system-time-locale "eo.utf8"))
    (insert (format-time-string format))))

(defun insert-date ()
  (interactive)
  (format-date "%A, %B %d %Y"))

(defun insert-date-and-time ()
  (interactive)
  (format-date "%Y-%m-%d %H:%M:%S"))
```

Ŝanĝu la valoron de `system-time-locale` kiel taŭgas.


<a name="klavoj"></a>Klavoj
---------------------------

Kiam la klavkombinoj ne ordigatas, ne estas facile por trovi tiun, kiun klavkombino klavo estas
ligita. Bonŝance, oni havas `bind-key`, kiu estas parto de `use-package`.

Ekzampla uzado de `bind-key` aspektus kiel:

```lisp
(bind-keys
 :map global-map
 ("C-;" . eval-expression)
 ("C-j" . delete-indentation))
```


<a name="linifinio"></a>Linifinio sen krommarĝeno
-------------------------------------------------

Ĉi tiu komando kreas linifinion, kiam movadas la montrilon. Ŝajnigas agmanieron, en kiu, la novlinion
ne krommarĝeniĝas.

```lisp
(defun newline-and-no-indent (&optional arg)
  (interactive "p")
  (open-line arg)
  (next-line arg))
```


<a name="plenigado"></a>Plenigado
---------------------------------

Ĉi tiu kodaĵo ege funkcias kiam labori pri plataj tekstoj. Krommarĝenigas alineon aŭ la aktualan
alinean kontekston. Se ekzistas markilo, tiam la regiono plenigiĝas.

```lisp
(defun fill-region-or-paragraph ()
  (interactive)
  (if (region-active-p)
      (fill-region)
      (fill-paragraph)))
```


<a name="montrilo"></a>Montrilomovado
-------------------------------------

La komando `move-to-window-line-top-bottom`, defaŭlte bindita al <kbd>M-r</kbd> bonegas kiam
oni volas movi la montrilon al la supra, meza, kaj malsupra pozicioj en rilato kun la fenestro
similas al la <kbd>H</kbd>, <kbd>M</kbd>, kaj <kbd>L</kbd> komandoj de Vimo.

Tamen ne estas tre ekonomie kiam specife celi areojn de la ekrano. La komandoj malsupre pozicias
la montrilon, specife al la supra, meza, kaj malsupra pozicioj, respektive.

```lisp
(defun move-to-window-line-top ()
  (interactive)
  (move-to-window-line 0))

(defun move-to-window-line-center ()
  (interactive)
  (move-to-window-line nil))

(defun move-to-window-line-bottom ()
  (interactive)
  (move-to-window-line -1))
```


<a name="gito"></a>Gitstato en Dired
------------------------------------

Ĉi tiu malgranda kodaĵo donas vidajn indikojn de la stato de gitmastrumitaj dosieroj ene Dired-bufro. Premi <kbd>g</kbd> reŝargas la bufron, tiam ĝisdatigas la staton.

```lisp
(use-package dired-k
    :ensure t
    :config
  (progn
    (add-hook 'dired-initial-position-hook 'dired-k)))
```


<a name="klavkombinoj"></a>Klavkombinoj
---------------------------------------

La klavkombinoj por la supraj komandoj listigitas malsupre:

```lisp
(bind-keys
 :map global-map
 ("C-c d"   . insert-date)
 ("C-c C-d" . insert-date-and-time)

 ("S-<return>" . newline-and-no-indent)

 ("M-q" . fill-region-or-paragraph)

 ("C-M-y" . yank-primary)

 ("M-1" . move-to-window-line-top)
 ("M-2" . move-to-window-line-center)
 ("M-3" . move-to-window-line-bottom))

(bind-keys
 :map dired-mode-map
 ("K" . dired-k)
 ("g" . dired-k))
```


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

En ĉi tiu afiŝo, mi montris, ke la malgrandaj alĝustigetoj povas generi grandajn gajnojn. Le resto
de la agordo troveblas [ĉi tie](https://github.com/ebzzry/dotfiles/tree/master/emacs). Se vi havas
emaksan kodumon por havigi, sendu tirpeton!
