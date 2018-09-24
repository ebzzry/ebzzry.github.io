Emakskonsiletoj 3-a: Enmeti kaj Forviŝi
=======================================

<div class="center">[Esperanto](#) · [English](/en/emacs-tips-3)</div>
<div class="center">la 24-an de septembro 2018</div>
<div class="center">Laste ĝisdatigita: la 24-an de septembro 2018</div>

Jen la daŭrigado de mia serio pri emaksaj konsiletoj. En ĉi tiu artikolo, ni esploru pri signovicaj
enmetadoj, kaj linia forviŝado, markado, kaj algluado.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Enmetado](#enmetado)
- [Forviŝado](#forvisxado)
- [Markado](#markado)
- [Algluado](#algluado)
- [Klavoj](#klavoj)
- [Finrimarkoj](#finrimarkoj)


<a name="enmetado"></a>Enmetado
-------------------------------

Mi laboras kun multe da Markdown-dosieroj kaj manieron por signojn kaj signovicojn enmeti facile mi
volas havi.

Por kodon enmeti per maldekstraj kornoj:

```lisp
(defun insert-backticks (&optional arg)
  "Insert three backticks for code blocks"
  (interactive)
  (insert "``````")
  (backward-char 3))
```

Ĝin mi bindis al <kbd>M-g `</kbd>.

Por movi al specifa kolumno:

```lisp
(defun go-to-column (column)
  "Move to a column inserting spaces as necessary"
  (interactive "nColumn: ")
  (move-to-column column t))
```

Ĝin mi bindis al <kbd>M-g .</kbd>.

Por signovicojn enmeti ĝis la lastan kolumnon de la antaŭa linio:

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

La enmetadon de `=` kaj `-` plifaciligos kiam je H1 kaj H2 ĉapojn krei.

Ilin mi bindis al <kbd>M-g =</kbd> kaj <kbd>M-g -</kbd>, respektive.

Se la jenan linion oni havas, en kiu, `^` estas la punkto:

```
Hundo Kato Muso

^
```

Kiam je <kbd>M-g =</kbd> oni premas, ĝi fariĝos:

```
Hundo Kato Muso
===============
              ^
```

Male, je la jenan mi havas:

```
Hundo Kato Muso
===============


Sekcio 1-a

^
```


Kiam je <kbd>M-g -</kbd> oni premas, ĝi fariĝos:

```
Hundo Kato Muso
===============


Sekcio 1-a
----------
         ^
```


<a name="forvisxado"></a>Forviŝado
----------------------------------

Oportunajn funkciojn mi volas havi por la linion de punkto al komenco kaj fino forviŝi:

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

Ilin mi bindis al <kbd>C-c ^</kbd> kaj <kbd>C-c $</kbd>, respektive:

Se la jenan mi havas:

```
Retejo pri komputiko, hominklinaĵoj, kaj hazardaĵoj.
                      ^
```

Tiam, je <kbd>C-c ^</kbd> oni premas, ĝi fariĝos:

```
hominklinaĵoj, kaj hazardaĵoj.
^
```

Male, se je <kbd>C-c $</kbd> oni premas, ĝi fariĝos:

```
Retejo pri komputiko,
                      ^
```

<a name="markado"></a>Markado
-----------------------------

Estas pluraj fojoj kiam regionon de punkto al komenco kaj fino mi hovas krei. Pro tio, la jenan mi
havas:

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

Ilin mi bindis al <kbd>C-c C-a</kbd> kaj <kbd>C-c C-e</kbd>, respektive.



<a name="algluado"></a>Algluado
-------------------------------

Mi volas esti kapabla por alglui de la tondejo al emakso, precipe se mi estas en la
terminalsimulilo.

Unue, je xclip ni bezonas instali:

Per Nix:

    nix-env -i xclip

Per APT:

    sudo apt-get install -y xclip

Tiam, la jenan ni aldonu al emaksa startiga dosiero:

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

La ĉefzono estas la tiu, kiu ŝaltiĝas kiam musajn markojn oni faras, dum la tondejzono estas la tiu,
kiu estas uzita kiam la komandon _Kopii_ el apo oni alvokas, aŭ kiam je <kbd>Ctrl+c</kbd> oni
premas.


<a name="klavoj"></a>Klavoj
---------------------------

Jen la rilata kodeto por ĉiom da komandoj diskutitaj en ĉi tiu artikolo. Se j `bind-key` oni ne
ankoraŭ havas, ĝin oni povas instali per:

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


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Mian vivon ĉi tiuj funkcioj kaj klavkombinoj plifaciligas precipe kiam mi laboras kun emacsclient
sur la terminalsimulilo pro kelkaj klavaj stiraj kodoj ne estas ricevitaj bone per la
terminalsimulilo mem. Eksteraj ilojn ekspluatante, unuforman konduton tra platformoj mi povas akiri.

Kiel ĉiam, la fontkodo troveblas [ĉi tie](https://github.com/ebzzry/dotfiles/tree/master/emacs). Se
konsileton oni volas doni, la tirpeton sendu al mi!
