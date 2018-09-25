Emacs Hacks II
==============

<div class="center">June 12, 2015</div>
<div class="center">Updated: March 31, 2017</div>

This is second part of my Emacs tips series. The contents of this post are written in no particular
order. It explores session management, packages, managing indents, and other things.


Table of contents
-----------------

- [Desktop](#desktop)
- [Savehist](#savehist)
- [Consolidation](#consolidation)
- [Packages](#packages)
  + [ELPA](#elpa)
  + [use-package](#use-package)
- [Line numbers](#linenumbers)
- [Timestamps](#timestamps)
- [Keys](#keys)
- [Newline sans indent](#newline)
- [Filling](#filling)
- [Yanking](#yanking)
- [Cursor movement](#cursormovement)
- [Git status in dired](#gitdired)
- [Key bindings](#keybindings)
- [Closing remarks](#closing)


Desktop <a name="desktop"></a>
------------------------------

An indispensable tool that I use now is desktop. It saves the state of my Emacs session, so that in
the event of crash, power outage, or anything that will make me lose my session, I can back to it.
Desktop comes built-in with the recent versions of GNU Emacs. Here's my snippet:

```lisp
(require 'desktop)

(desktop-save-mode)

(setq desktop-dirname "~/.emacs.d"
      desktop-base-file-name "desktop"
      desktop-base-lock-name "desktop.lock"
      desktop-restore-frames t
      desktop-restore-reuses-frames t
      desktop-restore-in-current-display t
      desktop-restore-forces-onscreen t)

(defun desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
```


Savehist <a name="savehist"></a>
--------------------------------

Another important functionality that I use is savehist. It saves the minibuffer history. It’s
roughly similar to saving the command line history. Here’s my snippet

```lisp
(savehist-mode t)

(setq savehist-file "~/.emacs.d/savehist")
```


Consolidation <a name="consolidation"></a>
------------------------------------------

No, that is not the name of a library. However, there were a lot of times, when I want to manually
save the state of as much session information that I could save. I’d want to save the buffers,
minibuffer history, bookmarks, and comint mode histories. To do that, I have the following:

```lisp
(defun save-defaults ()
  (desktop-save desktop-dirname)
  (savehist-save)
  (bookmark-save))

(defun save-histories ()
  (let ((buf (current-buffer)))
    (save-excursion
      (dolist (b (buffer-list))
        (switch-to-buffer b)
        (save-history)))
    (switch-to-buffer buf)))

(defun save ()
  (interactive)
  (save-desktop)
  (save-defaults)
  (save-histories))
```

This gives you a nice:

```
M-x save RET
```


Packages <a name="packages"></a>
--------------------------------

### ELPA <a name="elpa"></a>

If you aren’t using the package system yet, use it now. All you need to get started is the
following:

```lisp
(require 'package)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(defalias 'pi 'package-install)
(defalias 'pl 'package-list-packages)
```

To list all the available packages, hit:

```
M-x pl RET
```

If you know the name of package, hit:

```
M-x pi RET package RET
```


### use-package <a name="use-package"></a>

This one is a real gem. It’s like `require`, but on steroids. When “requiring” a package, you have
the option to specify to install that package, if it does not exist, yet. It also enables you to
configure that package, in a unified expression. But unlike `require`, `use-package` does not come
built-in with Emacs. You need to install it via `package-install`:

```
M-x pi RET use-package RET
```

You can then require it, on subsequent uses:

```lisp
(require 'use-package)
```

To install `markdown-mode`, even if it doesn’t exist yet, and configure its related options, after
loading it, have:

```lisp
(use-package markdown-mode
    :ensure t
    :config
    (progn
      (push '("\\.text\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.markdown\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.md\\'" . markdown-mode) auto-mode-alist)))
```


Line numbers <a name="linenumbers"></a>
---------------------------------------

I really like to have the line numbers displayed at the left margin. It gives me a rough idea how
big the file is, and where am I currently. Turning on `linum-mode` achieves it:

```lisp
(setq linum-format "%4d")

(defun my-linum-mode-hook ()
  (linum-mode t))

(add-hook 'find-file-hook 'my-linum-mode-hook)
```


Timestamps <a name="timestamps"></a>
------------------------------------

I frequently find the need to insert timestamps, especially when I'm editing my daily log file. Here
are some snippets to help you with it:

```lisp
(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))

(defun insert-date ()
  (interactive)
  (format-date "%A, %B %d %Y"))

(defun insert-date-and-time ()
  (interactive)
  (format-date "%Y-%m-%d %H:%M:%S"))
```

The code above sets the correct value for `system-time-locale`, and binds keys for
`insert-date/long` and `insert-date/short`.


Keys <a name="keys"></a>
------------------------

When your key bindings are not organized, it’s not easy to find what key did you bind to
what. Fortunately, you have `bind-key`, which comes as part of `use-package`.

An example would look like:

```lisp
(bind-keys
 :map global-map
 ("C-;" . eval-expression)
 ("C-j" . delete-indentation))
```


Newline sans indent <a name="newline"></a>
------------------------------------------

This command creates a newline, then moves the cursor. It simulates a behavior wherein the new line
doesn’t indent.

```lisp
(defun newline-and-no-indent (&optional arg)
  (interactive "p")
  (open-line arg)
  (next-line arg))
```


Filling <a name="filling"></a>
------------------------------

This snippet works great when working when working with plain text. It indent a paragraph, or the
current paragraph context. If there is a mark, the region becomes filled.

```lisp
(defun fill-region-or-paragraph ()
  (interactive)
  (if (region-active-p)
      (fill-region)
      (fill-paragraph)))
```


Yanking <a name="yanking"></a>
------------------------------

Emacs, by default, pastes (yanks) from the secondary, or clipboard selection. This command yanks
from the primary selection — mouse highlights.

```lisp
(defun yank-primary ()
  (interactive)
  (insert-for-yank (x-get-selection 'PRIMARY)))
```


Cursor movement <a name="cursormovement"></a>
---------------------------------------------

The command `move-to-window-line-top-bottom`, bound by default to <kbd>M-r</kbd> is great when you
want to move the cursor from the center, top, and bottom position, relative to the window, similar
to Vim’s <kbd>H</kbd>, <kbd>M</kbd>, and <kbd>L</kbd> commands. However, it’s not very efficient
when specifically targetting areas of the screen. The commands below position point, specifically to
the top, center, and bottom window positions, respectively.

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


Git status in dired <a name="gitdired"></a>
-------------------------------------------

This small snippet gives visual indications of the status of git-managed files in a Dired
buffer. Pressing <kbd>g</kbd> reloads the buffer, then updates the status.

```lisp
(use-package dired-k
    :ensure t
    :config
  (progn
    (add-hook 'dired-initial-position-hook 'dired-k)))
```


Key bindings <a name="keybindings"></a>
---------------------------------------

The key bindings for the commands above, are listed below:

```lisp
(bind-keys
 :map global-map
 ("C-c d"   . insert-date)
 ("C-c C-d" . insert-date-and-time)

 ("S-<return>" . newline-and-no-indent)

 ("M-q" . fill-region-or-paragraph)

 ("C-M-y" . yank-primary)

 ("M-1" . move-to-window-line-top)
 ("M-2" . move-to-window-line-center)
 ("M-3" . move-to-window-line-bottom))

(bind-keys
 :map dired-mode-map
 ("K" . dired-k)
 ("g" . dired-k))
```


Closing remarks  <a name="closing"></a>
---------------------------------------

In this post, I demonstrated that small tweaks can generate huge benefits. The rest of the
configuration can be found [here](https://github.com/ebzzry/dotfiles/tree/master/emacs). If you have
an Emacs hack to share, send a pull request!
