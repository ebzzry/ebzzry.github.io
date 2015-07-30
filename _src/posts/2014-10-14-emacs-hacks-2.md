    Title: Emacs & Hacks (part 2)
    Date: 2015-06-12T06:30:00
    Tags: emacs, programming

This is second part of my Emacs tips series. The contents of this post
are written in no particular order. It explores session management,
packages, and other neat things.

<!-- more -->

# Session Management

## Desktop
An indispensable tool that I use now is desktop. It saves the state of
my Emacs session, so that in the event of crash, power outage, or
anything that will make me lose my session, I can back to it. Desktop
comes built-in with the recent versions of GNU Emacs. Here's my
snippet:

```elisp
(require 'desktop)
(desktop-save-mode)

(setq desktop-dirname "~/.emacs.d"
      desktop-base-file-name "desktop"
      desktop-base-lock-name "desktop.lock"
      desktop-restore-frames t
      desktop-restore-reuses-frames t
      desktop-restore-in-current-display t
      desktop-restore-forces-onscreen t)

(defun my-desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)
```

## Savehist
Another important functionality that I use is savehist. It saves the
minibuffer history. It's roughly similar to saving the command line
history. Here's my snippet

```elisp
(savehist-mode t)
(setq savehist-file "~/.emacs.d/savehist")
```

## Consolidation
No, that is not the name of the library. There are a lot of times,
when I want to manually save the state of as much session information
that I could save. I'd want to save the buffers, minibuffer history,
bookmarks, and comint mode histories. To do that, I have the
following:

```elisp
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
  (save-defaults)
  (save-histories))
```

# Packages

## ELPA
If you aren't using the package system yet, use it now. All you need
to get started is the following:

```elisp
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defalias 'pi 'package-install)
(defalias 'pl 'package-list-packages)
```

To list all the available packages, just hit `M-x pl`. If you know the
name of package, hit `M-x pi RET package RET`.

## use-package
This one is a real gem. It's like `require`, but on steroids. When
"requiring" a package, you have the option to specify to install that
package, if it does not exist, yet. It also enables you to configure
that package, in a unified expression. But unlike `require`,
`use-package` does not come built-in with Emacs. We need to install it
via `package-install`:

```elisp
M-x package-install RET use-package RET
```

We can then require it, on subsequent uses:

```elisp
(require 'use-package)
```

To install `markdown-mode`, even if it doesn't exist yet,
and configure its related options, after loading it, have:

```elisp
(use-package markdown-mode
    :ensure t
    :config
    (progn
      (push '("\\.text\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.markdown\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.md\\'" . markdown-mode) auto-mode-alist)))
```

# General

## Line Numbers
I really like to have the line numbers displayed at the left
margin. It gives me a rough idea how big the file is, and where am I
currently. Turn on `linum-mode` achieves this:

```elisp
(setq linum-format "%4d")
(defun my-linum-mode-hook ()
  (linum-mode t))
(add-hook 'find-file-hook 'my-linum-mode-hook)
```

## Timestamps
I frequently find the need to insert timestamps, especially when I'm
editing my daily log file. Here are some snippets to help with it:

```elisp
(defun insert-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))

(defun insert-date/long ()
  (interactive)
  (insert-date "%A, %B %d %Y"))

(defun insert-date/short ()
  (interactive)
  (insert-date "%Y-%m-%d"))

```

Set the correct value for `system-time-locale`, and bind keys for
`insert-date/long` and `insert-date/short`.

## Keys
The last, but definitely not the least, is key bindings
management. When your key bindings are not organized, it's not easy to
find what key did you bind to what. Fortunately, we have `bind-key`,
which comes as part of `use-package`.

A sample would look like the following:

```elisp
(bind-keys
 :map global-map
 ("C-;" . eval-expression)
 ("C-j" . delete-indentation)
 ("M-j" . delete-indentation-1)
 ("C-z" . mark-line)
 ("C-r" . isearch-backward)
 ("C-s" . isearch-forward)
 ("C-M-r" . isearch-backward-regexp)
 ("C-M-s" . isearch-forward-regexp))

(bind-keys
 :map emacs-lisp-mode-map
 ("M-." . find-function)
 ("C-x C-r" . eval-region)
 (";" . sp-comment))

(bind-keys
 :map dired-mode-map
 ("C-x w" . wdired-change-to-wdired-mode))
```

# Conclusion

Like last time, the rest of the configuration can be found at
[github.com/ebzzry/dotemacs](http://github.com/ebzzry/dotemacs).

If you an Emacs hack to share, let me know in the comments
below. Ciao!
