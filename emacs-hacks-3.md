Emacs and Hacks (Part III)
======================================================================

<center>2015-08-15 21:48:41</center>

This is second part of my Emacs tips series. It explores managing
indents, fills, and cursor movements. It also talks about pasting,
git-in-dired, and most importantly a better way to handle paired
characters like parentheses, braces, brackets, and just about anything
that has pairs.


## Newline Sans Indent

```lisp
(defun newline-and-no-indent (&optional arg)
  (interactive "p")
  (open-line arg)
  (next-line arg))
```

The command above creates a newline, then moves the cursor. It
simulates a behavior wherein the new line doesn't indent.


## Fills

```lisp
(defun fill-region-or-paragraph ()
  (interactive)
  (if (region-active-p)
      (fill-region)
      (fill-paragraph)))
```

The snippet above works great when working when working with plain
text. It indent a paragraph, or the current paragraph context. If
there is a mark, the region becomes filled.


## Pasting

```lisp
(defun yank-primary ()
  (interactive)
  (insert-for-yank (x-get-selection 'PRIMARY)))
```

Emacs, by default pastes (yanks) from the secondary, or clipboard
selection. The command above yanks from the primary selection — mouse
highlights.


## Cursor Movement

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

The command `move-to-window-line-top-bottom`, bound by default to
<kbd>M-r</kbd> is great when we want to move the cursor from the
center, top, and bottom position, relative to the window, similar to
Vim's <kbd>H</kbd>, <kbd>M</kbd>, and <kbd>L</kbd> commands. However,
it's not very efficient when specifically targetting areas of the
screen. The commands above position point, specifically to the top,
center, and bottom window positions, respectively.

## Git Status in Dired

```lisp
(use-package dired-k
    :ensure t
    :config
  (progn
    (define-key dired-mode-map (kbd "K") 'dired-k)
    (define-key dired-mode-map (kbd "g") 'dired-k)
    (add-hook 'dired-initial-position-hook 'dired-k)))
```

The small snippet above gives visual indications of the status of
git-managed files in a Dired buffer. Pressing <kbd>g</kbd> reloads the
buffer, and updates the status.


## Pairs

```lisp
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)
(add-hook 'prog-mode-hook 'highlight-thing-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
```

Managing paired characters like parentheses, braces, brackets,
quotation marks, angle brackets, and other conceivable pair-able
characters has always been a pain. Paredit, solves that problem
partially, but it still misses some key points.

In Smartparens, just like with Paredit, when you input a pair-able
character, the matching pair gets inserted too, and the point is
positioned inside the pair. Also, when you mark an expression, for
example, by pressing <kbd>C-M-Space</kbd> followed by
<kbd>[</kbd>, the whole region becomes surrounded by matching `[` and `]`.

It is also very frequent that we inadvertently delete any of the pair
characters — this results in an unbalanced expression. Smartparens
prevents us from doing that, saving us a lot of trouble.


## Keys

The relevant key bindings for the commands above, are listed below:

```lisp
(bind-keys
 :map global-map
 ("S-<return>" . newline-and-no-indent)

 ("M-q" . fill-region-or-paragraph)

 ("C-M-y" . yank-primary)

 ("M-1" . move-to-window-line-top)
 ("M-2" . move-to-window-line-center)
 ("M-3" . move-to-window-line-bottom))

(bind-keys
 :map smartparens-mode-map
 ("C-M-f" . sp-forward-sexp)
 ("C-M-b" . sp-backward-sexp)

 ("C-M-n" . sp-next-sexp)
 ("C-M-p" . sp-previous-sexp)

 ("C-M-a" . sp-beginning-of-sexp)
 ("C-M-e" . sp-end-of-sexp)

 ("C-<down>" . sp-down-sexp)
 ("C-<up>"   . sp-up-sexp)
 ("M-<down>" . sp-backward-down-sexp)
 ("M-<up>"   . sp-backward-up-sexp)

 ("C-S-f" . sp-forward-symbol)
 ("C-S-b" . sp-backward-symbol)

 ("C-M-t" . sp-transpose-sexp)
 ("C-M-k" . sp-kill-sexp)
 ("M-k"   . sp-backward-kill-sexp)
 ("C-M-w" . sp-copy-sexp)

 ("C-M-d" . delete-sexp)

 ("C-<right>" . sp-forward-slurp-sexp)
 ("M-<right>" . sp-forward-barf-sexp)
 ("C-<left>"  . sp-backward-slurp-sexp)
 ("M-<left>"  . sp-backward-barf-sexp)

 ("M-<backspace>" . backward-kill-word)
 ("C-<backspace>" . sp-backward-kill-word)
 ([remap sp-backward-kill-word] . backward-kill-word)

 ("M-[" . sp-backward-unwrap-sexp)
 ("M-]" . sp-unwrap-sexp)

 ("C-x C-t" . sp-transpose-hybrid-sexp)

 ("C-(" . wrap-with-parens)
 ("M-(" . wrap-with-brackets)
 ("C-{" . wrap-with-braces))
```


## Conclusion

In this post, we've demonstrated that small changes can reap huge
benefits. For more information on Smartparens, you may go to
<http://foo.bar>.
