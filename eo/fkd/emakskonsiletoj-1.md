Emaksaj Konsiletoj kaj Ruzetoj: Regionoj kaj Indikiloj
======================================================

<center>[Esperante](#)  [English](/en/emacs-tips-1)</center>
<center>la 12-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 12-an de Februaro 2018</center>

Mi ankoraŭ bezonas trovi pli bonan redaktilon ol Emakso. Kion faras Emakson antaŭiĝi estas sia
agorda lingvo—Emaksa Lispo. Emakso uzas ĝin al punkto, en kiu, plejmulto de la funkciado de si mem,
estas realigitaj per Emakslispo.


Enhavotabelo
------------

- [Regionoj](#regionoj)
- [Kompilado](#kompilado)
- [Skimo](#skimo)
- [Servilo](#servilo)
- [Bufroj](#bufroj)
- [Indikiloj](#indikiloj)
- [Klavkombinoj](#klavkombinoj)
- [Finaj rimarkoj](#finaj)


<a name="regionoj"></a>Regionoj
-------------------------------

La jena komando forviŝas regionon se unu aktivas aŭ forviŝas la signon sub la tajpmontrilo.

```lisp
(defun delete-char-or-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (delete-region (region-beginning)
                     (region-end))
      (if (fboundp delete-char)
          (delete-char arg)
          (delete-forward-char arg))))
```


<a name="kompilado"></a>Kompilado
---------------------------------

Mi ofte uzas la jenan komandon kaj mi uzas ĝin de komposti LaTeX-ajn dokumentojn, kompili
Scribble-ajn dokumentojn, kompili kodon, kaj por preskaŭ io ajn, kiun mi povas uzi ĝin.

```lisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))
```


<a name="skimo"></a>Skimo
-------------------------

Mi volas havi komandon kiu eksplicite konservas la enigan historion de Geiser:

```lisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

Kaj mi ankaŭ havas la jenan, tial ke, mi plaĉe volas ĝisrandigi la `λ`-an simbolon.

```lisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```


<a name="servilo"></a>Servilo
-----------------------------

La jena kodaĵo certigas, ke la Emaksa servilo, la tiu, kiun `emacsclient` konektas al, kuras:

```lisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

Alternative, vi povas kuri Emakson en demonreĝimo el la komandlinio:

```bash
$ emacs --daemon
```


<a name="bufroj"></a>Bufroj
---------------------------

Mi volas havi manieron por mortigi la nunan bufron, sen esti demandita kiun bufro por mortigi. Mi
nur invitiĝos se la nuna bufro ŝanĝitis.

```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
```


<a name="indikiloj"></a>Indikiloj
---------------------------------

Estis multe da fojo en la estinteco kiam mi bezonis funkcion kiu nur markas linion. Kiun mi havas
estas la jena. Ruli ĝin multfoje markas plurajn liniojn.

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


<a name="klavkombinoj"></a>Klavkombinoj
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


<a name="finaj"></a>Finaj rimarkoj
----------------------------------

Mi esperas, ke vi povos esti kapabla por trovi uzojn de kelkaj de ili. La ceteraj agordoj troveblas
[ĉi tie](https://github.com/ebzzry/dotfiles/tree/master/emacs).
