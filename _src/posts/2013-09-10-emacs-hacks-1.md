    Title: Emacs & Hacks (part 1)
    Date: 2013-09-10T13:23:34
    Tags: emacs, programming

In this series of posts, I will be sharing my personal hacks on how
I use Emacs for my day-to-day stuff. Most, if not all of the code
contained in these posts are excerpts from the respective
configuration files that I use.

<!-- more -->

```elisp
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
character underneath the cursor. I have this bound to the DEL key.

```elisp
(defun compile-file ()
  (interactive)
  (compile "make -k"))

(define-key global-map [(control ?x) ?c] 'compile-file)
```

I use this command frequently, and I use it from typesetting LaTeX
documents, compiling Scribble documents, compiling code, and just
about anything that I can use Make with.

```elisp
(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

This comes in very handy for me, because sometimes I lose the REPL
buffer before the input ring has been saved. When I need to run I
execute `M-x geiser-save`.

```elisp
(defun my-scheme-mode-hook ()
  (put 'λ 'scheme-indent-function 1)
  (define-key scheme-mode-map [(control ?c) tab] 'completion-at-point))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
```

I also have the above, since I want to align the `λ` symbol nicely.

```elisp
(require 'tramp)
(add-to-list 'tramp-remote-path "/var/run/current-system/sw/bin")
```

The above snippet is applicable only to users of NixOS, since the
filesystem tree is deviantly different from "regular" nixen.

```elisp
(defun other-window-1 (&optional arg)
  (interactive "p")
  (other-window (- arg)))

(define-key global-map [(control left)] 'other-window-1)
(define-key global-map [(control right)] 'other-window)
```

One of my favorites, and I may be biased because I'm using a
[Kinesis Advantage keyboard](http://www.kinesis-ergo.com/advantage.htm),
wherein the arrow keys are very easy to reach, but nevertheless, YMMV.

```elisp
(defun find-two-files (orientation directory file1 file2)
  (let ((file-path1 (file-truename file1))
        (file-path2 (file-truename file2)))
    (delete-other-windows)

    (case orientation
      (vertical (progn (split-window-right)
                       (find-file file-path1)
                       (other-window 1)
                       (find-file file-path2)))
      (horizontal (progn (split-window)
                         (find-file file-path1)
                         (other-window 1)
                         (find-file file-path2)))

      (other-window 1))))

(defun find-two-files-vertically (directory file1 file2)
  (find-two-files 'vertical directory file1 file2))

(defun find-two-files-horizontally (directory file1 file2)
  (find-two-files 'horizontal directory file1 file2))
```

```shell
ev () { emacsclient -nw --eval "(find-two-files-vertically \"$(pwd)\" \"$1\" \"$2\")" }
eh () { emacsclient -nw --eval "(find-two-files-horizontally \"$(pwd)\" \"$1\" \"$2\")" }
```

The two snippets above, for Elisp and Zsh (or your shell),
respectively, load two files into an Emacs buffer, oriented
horizontally, and vertically, respectively.

So, to load `~/test1.txt` and `~/test2.txt` in Emacs, split windows,
horizontally, run:

```
$ ev ~/test1.txt ~/test2.txt
```

```elisp
(require 'server)

(unless (server-running-p)
  (server-start))
```

This snippet runs the server instance, when it is not
running, yet:

```elisp
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(define-key global-map [(control ?x) (control ?k)] 'kill-current-buffer)
```

A lot of us have this, but this is my simple, unconvoluted version

```elisp
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

# Conclusion

The rest of the configuration can be found at
[github.com/ebzzry/dotemacs](http://github.com/ebzzry/dotemacs).

Well, that is it for now. Ciao!
