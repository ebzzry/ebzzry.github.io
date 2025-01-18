Emaksaj Konsiletoj 3-a: Enmeti kaj Forviŝi
==========================================

<div class="center">[English](/en/emacs-tips-3/) • Esperanto</div>
<div class="center">Laste ĝisdatigita: la 29-an de marto 2022</div>

>Ju pli oni ŝvitas en paco, des malpli oni sangas en milito.<br>—Norman SCHWARZKOPF

<img src="/images/site/jr-korpa-E2i7HftbrI-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="jr-korpa-E2i7HftbrI-unsplash" title="jr-korpa-E2i7HftbrI-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Enmetado](#enmetado)
- [Forviŝado](#forvisxado)
- [Markado](#markado)
- [Algluado](#algluado)
- [Klavoj](#klavoj)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Jen la daŭrigo de la serio pri emaksaj konsiletoj. En ĉi tiu artikolo, ni esploros pri signovica
enmetado, linia forviŝado, markado, kaj algluado.


<a name="enmetado">Enmetado</a>
-------------------------------

Mi laboras kun multe da markdaŭnaj dosieroj kaj mi volas havi manieron por enmeti facile signojn kaj
signovicojn .

Por enmeti kodon kun maldekstraj kornoj:

```lisp
(defun insert-backticks (&optional arg)
  "Insert three backticks for code blocks"
  (interactive)
  (insert "``````")
  (backward-char 3))
```

Mi ĝin bindis al <kbd>M-g `</kbd>.

Por movi al specifa kolumno:

```lisp
(defun go-to-column (column)
  "Move to a column inserting spaces as necessary"
  (interactive "nColumn: ")
  (move-to-column column t))
```

Mi ĝin bindis al <kbd>M-g .</kbd>.

Por enmeti signovicojn ĝis la lastan kolumnon de la antaŭa linio:

```lisp
(defun insert-until-last (string)
  "Insert string until column"
  (let* ((end (save-excursion
                 (previous-line)
                 (end-of-line)
                 (current-column)))
         (count (if (not (zerop (current-column)))
                    (- end (current-column))
                  end)))
    (dotimes (c count)
      (insert string))))
```

Ĉi tiu funkcio, kun la sekvaj interagaj funkcioj:

```lisp
(defun insert-equals (&optional arg)
  "Insert equals until the same column number as last line"
  (interactive)
  (insert-until-last "="))

(defun insert-hyphens (&optional arg)
  "Insert hyphens until the same column number as last line"
  (interactive)
  (insert-until-last "-"))
```

La enmetado de `=` kaj `-` plifaciligos kiam krei H1- kaj H2-ĉapojn .

Mi bindis ilin al <kbd>M-g =</kbd> kaj <kbd>M-g -</kbd>, respektive.

Se oni havas la jenan linion, en kiu, `^` estas la punkto:

```
Hundo Kato Muso

^
```

Kiam oni premas <kbd>M-g =</kbd>, ĝi fariĝos:

```
Hundo Kato Muso
===============
              ^
```

Male, mi havas la jenan:

```
Hundo Kato Muso
===============


Sekcio 1-a

^
```


Kiam oni premas <kbd>M-g -</kbd>, ĝi fariĝos:

```
Hundo Kato Muso
===============


Sekcio 1-a
----------
         ^
```


<a name="forvisxado">Forviŝado</a>
----------------------------------

Mi volas havi oportunajn funkciojn por forviŝi la linion de punkto al komenco kaj fino:

```lisp
(defun delete-to-bol (&optional arg)
  "Delete to beginning of line"
  (interactive "p")
  (delete-region (point) (save-excursion (beginning-of-line) (point))))

(defun delete-to-eol (&optional arg)
  "Delete to end of line"
  (interactive "p")
  (delete-region (point) (save-excursion (end-of-line) (point))))
```

Mi bindis ilin al <kbd>C-c ^</kbd> kaj <kbd>C-c $</kbd>, respektive:

Se mi havas la jenan:

```
Retejo pri informadiko, hominklinaĵoj, kaj hazardaĵoj.
                        ^
```

Tiam, oni premas <kbd>C-c ^</kbd>, ĝi fariĝos:

```
hominklinaĵoj, kaj hazardaĵoj.
^
```

Male, se oni premas <kbd>C-c $</kbd>, ĝi fariĝos:

```
Retejo pri informadiko,
                        ^
```

<a name="markado">Markado</a>
-----------------------------

Estas pluraj fojoj kiam mi hovas krei regionon de punkto al komenco kaj fino. Pro tio, mi havas la jenan:

```lisp
(defun mark-to-bol (&optional arg)
  "Create a region from point to beginning of line"
  (interactive "p")
  (mark-thing 'point 'beginning-of-line))

(defun mark-to-eol (&optional arg)
  "Create a region from point to end of line"
  (interactive "p")
  (mark-thing 'point 'end-of-line))
```

Mi bindis ilin al <kbd>C-c C-a</kbd> kaj <kbd>C-c C-e</kbd>, respektive.



<a name="algluado">Algluado</a>
-------------------------------

Mi volas esti kapabla por alglui de la tondejo al emakso, precipe se mi estas en la
terminalsimulilo.

Unue, ni devas instali xclip:

Per Nixpkgs:

    nix-env -i xclip

Per APT:

    sudo apt-get install -y xclip

Tiam, ni aldonu la jenan al emaksa startiga dosiero:

```lisp
(defun yank-primary (&optional arg)
  "Yank the primary selection"
  (interactive)
  (insert (shell-command-to-string "xclip -selection primary -o")))

(defun yank-clipboard (&optional arg)
  "Yank the clipboard selection"
  (interactive)
  (insert (shell-command-to-string "xclip -selection clipboard -o")))
```

La ĉefzono estas tiu, kiu ŝaltiĝas kiam oni faras musajn markojn, dum la tondejzono estas tiu, kiu
estas uzita kiam oni alvokas la komandon _Kopii_ el grafika apo, aŭ kiam oni premas
<kbd>Ctrl+c</kbd>.


<a name="klavoj">Klavoj</a>
---------------------------

Jen la rilata kodeto por ĉiom da komandoj diskutitaj en ĉi tiu artikolo. Se oni ne ankoraŭ havas
`bind-key`, oni povas instali ĝin per:

    M-x package-install EN bind-key EN

```
(bind-keys
 :global-map
 ("C-c ^" . delete-to-bol)
 ("C-c $" . delete-to-eol)

 ("C-c ," . mark-to-bol)
 ("C-c ." . mark-to-eol)

 ("C-x y" . yank-clipboard)
 ("C-x C-y" . yank-primary)

 ("M-g SPC" . go-to-column)
 ("M-g `" . insert-backticks)
 ("M-g =" . insert-equals)
 ("M-g -" . insert-hyphens))
 ```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Ĉi tiuj funkcioj kaj klavkombinoj plifaciligas mian vivon precipe kiam mi laboras kun emacsclient ĉe
la terminalsimulilo pro kelkaj klavaj stiraj kodoj ne estas ricevitaj bone per la terminalsimulilo
mem. Ekspluatante eksterajn ilojn, mi povas akiri unuforman konduton tra platformoj.

Kiel ĉiam, troveblas la fontkodo [ĉi tie](https://github.com/ebzzry/dotfiles/tree/main/emacs). Se
oni volas doni konsileton, sendu la tirpeton al mi!
