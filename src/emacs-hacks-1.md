Emacs Hacks I
=============

<center>September 9, 2013</center>
<center>Updated: May 13, 2016</center>

In this series of posts, I will be sharing my personal hacks on how
I use Emacs for my day-to-day stuff.


## Table of contents

* [Regions](#regions)
* [Compilation](#compilation)
* [Scheme](#scheme)
* [Server](#server)
* [Buffers](#buffers)
* [Marks](#marks)
* [Key bindings](#keybindings)
* [Closing remarks](#closing)


## Regions <a name="regions"></a>

This command deletes a region if one is active, or deletes the
character underneath the cursor.

```lisp
(defun delete-char-or-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (delete-region (region-beginning)
                     (region-end))
      (if (fboundp 'sp-delete-char)
          (sp-delete-char arg)
          (delete-forward-char arg))))
```


## Compilation <a name="compilation"></a>

I use this command frequently, and I use it from typesetting LaTeX
documents, compiling Scribble documents, compiling code, and just
about anything that I can use make with.

```lisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))
```


### Scheme <a name="scheme"></a>

I want to have a command that explicitly saves the input ring of Geiser:

```lisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

I also have the following, because I want to align the `λ` symbol nicely.

```lisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```


## Server <a name="server"></a>

This snippet ensures that the Emacs server, the one that `emacsclient`
connects to:

```lisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

Alternatively, you may run Emacs in daemon mode from the command-line:

```bash
$ emacs --daemon
```


## Buffers <a name="buffers"></a>

I want a way to kill the current buffer, without being asked what
buffer to kill. I will only get prompted if the current has been
modified.


```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
```


## Marks <a name="marks"></a>

There have been plenty of times in the past when I needed a function
that just marks a line. What I have is below. Executing it multiple
times, marks multiple lines.

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

## Key bindings <a name="keybindings"></a>

The key bindings for the commands above, are listed below:

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

## Closing remarks <a name="closing"></a>

I hope you’ll be able to find use of any of them. The rest of the
configuration can be found at <https://github.com/ebzzry/dotfiles/tree/master/emacs>.
