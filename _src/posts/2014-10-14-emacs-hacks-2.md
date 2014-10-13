    Title: Emacs: Hacks 2
    Date: 2014-10-14T17:41:20
    Tags: DRAFT

_Replace this with your post text. Add one or more comma-separated
Tags above. The special tag `DRAFT` will prevent the post from being
published._

<!-- more -->

M-s h ...

```
(defun find-files (pathnames)
  (let* ((paths (split-string pathnames))
         (len (length paths))
         (files (rest paths)))
    (when (= len 0)
      (switch-to-scratch-buffer))
    (when (> len 0)
      (find-file (first paths)))
    (when (> len 1)
      (dolist (file files)
        (split-window-right-other-window)
        (find-file file))
      (balance-windows))))
```

```
(defun kill-buffer! (buffer)
  (let ((query-functions kill-buffer-query-functions))
    (save-current-buffer
      (when (get-buffer buffer)
        (switch-to-buffer buffer)
        (setq kill-buffer-query-functions
              (remq 'process-kill-buffer-query-function
                    kill-buffer-query-functions))
        (let ((buffer-modified-p nil))
          (kill-buffer (current-buffer))
          (setq kill-buffer-query-functions query-functions))))))
```

```
(defun kill-buffer! (buffer)
  (let ((query-functions kill-buffer-query-functions))
    (save-current-buffer
      (when (get-buffer buffer)
        (switch-to-buffer buffer)
        (setq kill-buffer-query-functions
              (remq 'process-kill-buffer-query-function
                    kill-buffer-query-functions))
        (let ((buffer-modified-p nil))
          (kill-buffer (current-buffer))
          (setq kill-buffer-query-functions query-functions))))))
```

```
(defmacro when-package (package &rest rest)
  (let* ((package-string (prin1-to-string package))
         (path (package-path
                (cc "/" package-string
                    "/" package-string
                    ".el"))))
    `(when (file-exists-p ,path)
       (require ',package)
       ,@rest)))
```

```
(defun my-dired-mode-hook ()
  (define-key dired-mode-map "\C-xw" 'wdired-change-to-wdired-mode))

(add-hook 'dired-mode-hook 'my-dired-mode-hook)
```

```
(defun ocaml-save-history ()
  (interactive)
  (let ((buffer-name "*ocaml-toplevel*"))
    (save-current-buffer
      (when (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
        (tuareg-repl-write-input-ring)
        (message "Wrote %s" (tuareg-repl-history-file))))))
```
