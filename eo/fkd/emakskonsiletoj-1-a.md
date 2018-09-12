Emakskonsiletoj 1-a: Regionoj kaj Markoj
========================================

<div class="center">[Esperante](#) · [English](/en/emacs-tips-1)</div>
<div class="center">la 12-an de februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 12-an de septembro 2018</div>

Mi ankoraŭ bezonas trovi pli bonan redaktilon ol [Emakso](https://www.gnu.org/software/emacs/). Kio
faras Emakson elstari, estas sia agorda lingvo—Emaksa Lispo. Emakso uzas ĝin al punkto, en kiu,
plejmulto de la funkciado de si mem, realigitas per Emakslispo. En ĉi tiuj serioj, mi priparolos
la aferojn, kiujn mi malkovris fari la uzadon de Emakso pli agrabla.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Regionoj](#regionoj)
- [Kompilo](#kompilo)
- [Skimo](#skimo)
- [Servilo](#servilo)
- [Bufroj](#bufroj)
- [Markoj](#markoj)
- [Klavkombinoj](#klavkombinoj)
- [Finrimarkoj](#finrimarkoj)


<a name="regionoj"></a>Regionoj
-------------------------------

La jena komando forviŝas regionon se unu aktivas aŭ forviŝas la signon sub la tajpmontrilo.

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


<a name="kompilo"></a>Kompilo
-----------------------------

Mi ofte uzas la jenan komandon kaj mi uzas ĝin de komposti LaTeX-dokumentojn, kompili
Scribble-dokumentojn, kompili kodon, kaj por preskaŭ io ajn, kiun mi povas uzi ĝin.

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

Alterne, oni povas kuri Emakson en demonreĝimo el la komandlinio:

```bash
$ emacs --daemon
```


<a name="bufroj"></a>Bufroj
---------------------------

Mi volas havi manieron por mortigi la nunan bufron, sen esti demandita kiun bufro por mortigi. Mi
nur invitiĝos se la nuna bufro ŝanĝiĝis.

```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
```


<a name="markoj"></a>Markoj
---------------------------

Estis multe da fojo en la estinteco kiam mi bezonis funkcion kiu markas nur linion. Kiun mi havas
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


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Mi esperas, ke oni povos esti kapabla trovi uzojn de kelkaj de ili. La ceteraj agordoj troveblas
[ĉi tie](https://github.com/ebzzry/dotfiles/tree/master/emacs).

_Dank’ al [Raymund Martinez](https://zhaqenl.github.io) pro la korektoj._
