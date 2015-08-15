Emacs and Hacks (Part I)
======================================================================

<center>2013-09-10 13:23:34</center>

In this series of posts, I will be sharing my personal hacks on how
I use Emacs for my day-to-day stuff. Most, if not all of the code
contained in these posts are excerpts from the respective
configuration files that I use.


## Regions

```lisp
(defun delete-forward-char-or-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (delete-region (region-beginning)
                     (region-end))
      (delete-forward-char arg)))

(define-key global-map [deletechar] 'delete-forward-char-or-region)
(define-key global-map [del] 'delete-forward-char-or-region)
```

This command deletes a region if one is active, or deletes the
character underneath the cursor. I have this bound to <kbd>Del</kbd>.


## Compilation

```lisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))

(define-key global-map [(control ?x) ?c] 'compile-file)
```

I use this command frequently, and I use it from typesetting LaTeX
documents, compiling Scribble documents, compiling code, and just
about anything that I can use make with.


### Scheme

```lisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

This comes in very handy for me, because sometimes I lose the REPL
buffer before the input ring has been saved. 

```lisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1)
  (define-key scheme-mode-map [(control ?c) tab] 'completion-at-point))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```

I also have the above, since I want to align the `λ` symbol nicely.


## Server

```lisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

This snippet runs the server instance, when it is not running, yet.


## Buffers

```lisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(define-key global-map [(control ?x) (control ?k)] 'kill-current-buffer)
```

A lot of us have this, but this is my simple, unconvoluted version


## Marks

```lisp
(defun mark-line (&optional arg)
  (interactive "p")
  (if (not mark-active)
      (progn
        (beginning-of-line)
        (push-mark)
        (setq mark-active t)))
  (forward-line arg))

(define-key global-map [(shift ? )] 'mark-line)

(define-key global-map [(control ?z)] 'mark-line)
```

There have been plenty of times in the past when I needed this
function, and I would have to press a long series of keystrokes just
to get it down. The above is what I have, instead.


## Conclusion

I hope you'll be able to find use of any of them. The rest of the
configuration can be found at <https://github.com/ebzzry/dotemacs>.
