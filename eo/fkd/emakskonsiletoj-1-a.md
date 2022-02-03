Emaksaj Konsiletoj 1-a: Regionoj kaj Markoj
===========================================

<div class="center">Esperanto ▪ [English](/en/emacs-tips-1/)</div>
<div class="center">la 12-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 3-an de Februaro 2022</div>

Ankoraŭ bezonas trovi mi pli bonan redaktilon ol [emakso](https://www.gnu.org/software/emacs/). Tio,
kio igas emakson elstara, estas ĝia agorda lingvo—emakslispo. Uzas emakso ĝin al punkto, en kiu,
plejparto de la funkciado de ĝi mem, realiĝas per emakslispo. En ĉi tiuj serioj, priparolos mi la
aferojn, kiujn malkovris fari mi la uzadon de emakso pli agrabla persone.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Regionoj](#regionoj)
- [Kompilo](#kompilo)
- [Skimo](#skimo)
- [Servilo](#servilo)
- [Bufroj](#bufroj)
- [Markoj](#markoj)
- [Klavkombinoj](#klavkombinoj)
- [Finrimarkoj](#finrimarkoj)


<a name="regionoj">Regionoj</a>
-------------------------------

La jena komando forviŝas regionon se unu aktivas aŭ forviŝas la signon sub la kursoro.

```lisp
(defun delete-char-or-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (delete-region (region-beginning)
                     (region-end))
      (if (fboundp 'delete-char)
          (delete-char arg)
          (delete-forward-char arg))))
```


<a name="kompilo">Kompilo</a>
-----------------------------

Ofte uzas mi la jenan komandon kaj uzas mi ĝin kiam komposti LaTex-dokumentojn, kompili
Scribble-dokumentojn, kompili kodon, kaj por preskaŭ io ajn, al kiun povas uzi mi ĝin.

```lisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))
```


<a name="skimo">Skimo</a>
-------------------------

Volas havi mi komandon kiu eksplicite konservas la enigan historion de Geiser:

```lisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

Kaj ankaŭ havas mi la jenan tial, ke volas ĝisrandigi plaĉe mi la `λ`-simbolon.

```lisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```


<a name="servilo">Servilo</a>
-----------------------------

Certigas la jena kodaĵo, ke la emaksa servilo, tiu, kiun `emacsclient` konektas al, kuros:

```lisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

Alterne, povas plenumi oni emakson en demonreĝimo ĉe la komandlinio:

```bash
$ emacs --daemon
```


<a name="bufroj">Bufroj</a>
---------------------------

Volas havi mi manieron por mortigi la aktualan bufron sen esti demandita kiun bufro por mortigi. Nur
invitiĝos mi se ŝanĝiĝis la aktuala bufro.

```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
```


<a name="markoj">Markoj</a>
---------------------------

Estis multe da fojoj en la estinteco kiam bezonis funkcion mi kiu markas nur linion. Kiun havas mi
estas la jena. Plenumi ĝin multfoje markas plurajn liniojn.

```lisp
(defun mark-line (&optional arg)
  (interactive "p")
  (if (not mark-active)
      (progn
        (beginning-of-line)
        (push-mark)
        (setq mark-active t)))
  (forward-line arg))
```


<a name="klavkombinoj">Klavkombinoj</a>
---------------------------------------

La klavkombinoj por la supraj komandoj, estas la jenaj:

```lisp
(bind-keys
 :map global-map
 ("<delete>" . delete-char-or-region)
 ("C-x C-k" . kill-current-buffer)
 ("C-x c" . compile-file)
 ("M-z" . mark-line))

(bind-keys
 :map scheme-mode-map
 ("C-c <tab>" . completion-at-point))
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Esperas mi, ke oni povos esti kapabla trovi uzojn el kelke da ili. Troveblas la ceteraj agordoj [ĉi
tie](https://github.com/ebzzry/dotfiles/tree/master/emacs).

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
