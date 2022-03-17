Emaksaj Konsiletoj 1-a: Regionoj kaj Markoj
===========================================

<div class="center">Esperanto ■ [English](/en/emacs-tips-1/)</div>
<div class="center">Laste ĝisdatigita: la 17-an de Marto 2022</div>

>La voĉon ne pligrandigu; la argumenton plibonigu.<br>
>―Desmond TUTU

<img src="/bil/robert-keane-rlbG0pnQOU-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="robert-keane-rlbG0pnQOU-unsplash" title="robert-keane-rlbG0pnQOU-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Introduction](#introduction)
- [Regionoj](#regionoj)
- [Kompilo](#kompilo)
- [Skimo](#skimo)
- [Servilo](#servilo)
- [Bufroj](#bufroj)
- [Markoj](#markoj)
- [Klavkombinoj](#klavkombinoj)
- [Finrimarkoj](#finrimarkoj)


<a name="introduction">Introduction</a>
---------------------------------------

Mi ankoraŭ bezonas trovi pli bonan redaktilon ol [emakso](https://www.gnu.org/software/emacs/). Tio,
kio igas emakson elstara, estas ĝia agorda lingvo—emakslispo. Emakso uzas ĝin al punkto, en kiu,
plejparto de la funkciado de ĝi mem, realiĝas per emakslispo. En ĉi tiuj serioj, mi priparolos la
aferojn, kiujn mi malkovris fari la uzadon de emakso pli agrabla persone.


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

Ofte mi uzas la jenan komandon kaj mi uzas ĝin kiam komposti LaTex-dokumentojn, kompili
Scribble-dokumentojn, kompili kodon, kaj por preskaŭ io ajn, al kiu mi povas uzi ĝin.

```lisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))
```


<a name="skimo">Skimo</a>
-------------------------

Mi volas havi komandon kiu eksplicite konservas la enigan historion de Geiser:

```lisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

Kaj mi ankaŭ havas la jenan tial, ke mi volas ĝisrandigi plaĉe la `λ`-simbolon.

```lisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```


<a name="servilo">Servilo</a>
-----------------------------

La jena certigas kodaĵo, ke la emaksa servilo—tiu, kiu `emacsclient` konektas al—plenumiĝos:

```lisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

Alterne, oni povas plenumi emakson en demonreĝimo ĉe la komandlinio:

```bash
$ emacs --daemon
```


<a name="bufroj">Bufroj</a>
---------------------------

Mi volas havi manieron por mortigi la aktualan bufron sen demandita kiun bufron por mortigi. Mi nur
invitiĝos se la aktuala bufro ŝanĝiĝis:

```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
```


<a name="markoj">Markoj</a>
---------------------------

Estis multe da fojoj en la estinteco kiam mi bezonis funkcion kiu markas nur linion. Kiun mi havas
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

Mi esperas, ke oni povos esti kapabla trovi uzojn el kelke da aferoj ĉi-supre. La ceteraj agordoj
troveblas [ĉi tie](https://github.com/ebzzry/dotfiles/tree/master/emacs).
