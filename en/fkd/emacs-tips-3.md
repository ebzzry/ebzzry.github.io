Emacs Tips and Tricks 3: Insert and Delete
==========================================

<div class="center">[Esperanto](/eo/emakskonsiletoj-3-a/) · English</div>
<div class="center">April 1, 2017</div>
<div class="center">Last updated: September 24, 2017</div>

This is the continuation of my series on Emacs tips and tricks. In this article, we explore string
insertion, and line deletion, marking, and yanking.


Table of contents
-----------------

- [Insertion](#insertion)
- [Deletion](#deletion)
- [Marking](#marking)
- [Yanking](#yanking)
- [Keys](#keys)
- [Closing remarks](#closing)


<a name="insertion"></a> Insertion
----------------------------------

I work with a lot of Markdown files and I want a way to easily insert characters and strings.

To insert a code section using backticks:

```lisp
(defun insert-backticks (&optional arg)
  "Insert three backticks for code blocks"
  (interactive)
  (insert "``````")
  (backward-char 3))
```

I bound it to <kbd>M-g `</kbd>.

To move to a specific column:

```lisp
(defun go-to-column (column)
  "Move to a column inserting spaces as necessary"
  (interactive "nColumn: ")
  (move-to-column column t))
```

I bound it to <kbd>M-g .</kbd>.

To insert a string until the last column of the previous line:

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

This function, together with the following interactive functions:


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

Will make insertion of `=` and `-` easier when creating H1 and H2 headings.

I bound them to <kbd>M-g =</kbd> and <kbd>M-g -</kbd>, respectively.

If you have the following line, where `^` is point:

```
Foo Bar Baz

^
```

When I press <kbd>M-g =</kbd>, it will become:

```
Foo Bar Baz
===========
           ^
```

Conversely, if I have:

```
Foo Bar Baz
===========


Section I

^
```

 When I press <kbd>M-g -</kbd>, it will become:

```
Foo Bar Baz
===========


Section I
---------
         ^
```


<a name="deletion"></a> Deletion
--------------------------------

I want convenient functions to delete from point to start and end:

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

I bound them to <kbd>C-c ^</kbd> and <kbd>C-c $</kbd>, respectively.

If I have:

```
A journal about computing, human predilections, and random krakaboom.
                           ^
```

Then, I press <kbd>C-c ^</kbd>, it will become:

```
human predilections, and random krakaboom.
^
```

Conversely, if I press <kbd>C-c $</kbd>, it will become:

```
A journal about computing, 
                           ^
```


<a name="marking"></a> Marking
------------------------------

There are many times when I want to make a region from point to start and end. For that, I have the
following:

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

I bound them <kbd>C-c C-a</kbd> and <kbd>C-c C-e</kbd>, respectively.


<a name="yanking"></a> Yanking
------------------------------

I want to be able to yank from the clipboard to Emacs, especially when I’m on the terminal.

First, we need to install xclip:

Nixpkgs:

    nix-env -i xclip

APT:

    sudo apt-get install -y xclip

Then, we add in the Emacs Lisp code:

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

The primary selection is the one activated when doing mouse highlights, while the clipboard
selection is the one used when you invoke the _Copy_ command from an application, or when
<kbd>Ctrl+c</kbd> is pressed.


<a name="keys"></a> Keys
------------------------

Here’s the relevant snippet for all the commands discussed in this article. If you don’t have
`bind-key` yet, you may install it with:

    M-x package-install RET bind-key RET

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


<a name="closing"></a> Closing remarks
--------------------------------------

These functions and key bindings make it significantly convenient for me when working with
emacsclient on the terminal, due to the fact that some keyboard control codes are not received by
the terminal emulator itself. By leveraging on external tools, I get a consistent behavior across
platforms.

As always, the source is available [here](https://github.com/ebzzry/dotfiles/tree/master/emacs). If
you have a tip to share, send in your pull request!
