Emacs and Pairs
======================================================================

<center>2015-08-15 21:48:41</center>

In this post, I'll exclusively talk about Smartparens. If there are
packages that significantly improves, and changes how one uses Emacs,
this is one of them. Take note though, that the name is a misnomer, as
it not only handles parentheses. It handles just about anything that
pairs, and it performs those functions stellarly.


## Installation

Installing Smartparens is straightforward:

```
M-x package-install RET smartparens RET
```


## Configuration

Let's enable Smartparens on startup, and hook it with some major
hooks:

```lisp
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
```

## Usage

Managing paired characters like parentheses, braces, brackets,
quotation marks, angle brackets, and other conceivable pair-able
characters has always been a pain. Paredit, solves that problem
partially, but it still misses some key points. In the code samples
below, the `^` symbol represents point:

### Basics

In Smartparens, when you input a pair-able character:

```clojure

(defn foo )
          ^
```

the matching pair gets inserted, too, and point is positioned inside
the pair:

```clojure

(defn foo [])
           ^
```


### Navigation

If you have the expression:

```clojure

(let [x "foo bar baz ... blah"])
                         ^
```

and you want to move point to the start of the string:

```clojure

(let [x "foo bar baz ... blah"])
         ^
```

Execute `sp-beginning-of-sexp`. I bound it to <kbd>C-M-a</kbd>.

Conversely, to move point to the end of the expression:

```clojure

(let [x "foo bar baz ... blah"])
                             ^
```

Execute `sp-end-of-sexp`. I bound it to <kbd>C-M-e</kbd>:

If you have the expression:

```lisp

(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format)))) ^

```

and you want to move point to `insert`:

```lisp

(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))
     ^
```

Execute `sp-down-sexp`. I bound it to <kbd>C-down</kbd>.

If you have the expression:

```clojure

(str "foo" "bar baz qux")
    ^
```

and you want to move point just past `)`:

```clojure

(str "foo" "bar baz qux")
                         ^
```

Execute `sp-up-sexp`. I bound it to <kbd>C-up</kbd>.

If you have the expression:

```clojure

(defn foo
  [bar]
  (let [x 0]
  ^ x))

```

and you want to move point after `bar`:

```clojure

(defn foo
  [bar]
  (let^[x 0]
    x))

```

Execute `sp-backward-down-sexp`. I bound it to <kbd>M-down</kbd>.

If you have the expression:

```lisp

(insert (format-time-string format))
                           ^
```

and you want to move point to `(format`:

```lisp

(insert (format-time-string format))
        ^
```

Execute `sp-backward-up-sexp`. I bound it to <kbd>M-up</kbd>.

If you have the expression:

```clojure

(:require [clojure.string :as s])
          ^
```

and you want to move just past `]`:

```clojure

(:require [clojure.string :as s])
                                ^
```

Execute `sp-forward-sexp`. I bound it to <kbd>C-M-f</kbd>

Conversely, to move it just before `[`:

```clojure

(:require [clojure.string :as s])
          ^
```

Execute `sp-backward-sexp`. I bound it to <kbd>C-M-b</kbd>.

If you have the expression:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```

and you want to move point to `[foo]`:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]
  ^)

```

Execute `sp-next-sexp`. I bound it to <kbd>C-M-n</kbd>.

Conversely, to move it back:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```
Execute `sp-previous-sexp`. I bound it to <kbd>C-M-p</kbd>.

If you have the expression:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
               ^
```

and you want to move point to `blah`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
      ^
```

Execute, `sp-backward-symbol`. I bound it to <kbd>C-S-b</kbd>.

Conversely, if you have the expression:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
            ^
```

and you want to move point just after `(let`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
                  ^
```

Execute `sp-forward-symbol`. I bound it to <kbd>C-S-f</kbd>.

What they do is that they navigate around expressions as if
delimiters, like parens, brackets, and braces do not exist.


### Manipulation

If you have the expression:

```javascript

var mods = "vars";
           ^
```

and you want `"vars"` to be surrounded by `[`, and `]`:

```javascript

var mods = ["vars"];
            ^
```

Press <kbd>C-M-Space</kbd> followed by <kbd>[</kbd>, the
whole region becomes surrounded by matching `[`, and `]`.
It also applies to keys like `(`, `{`, `"`, `'`, `*`, `_`, etc,
depending on the mode that you're using.

Sometimes, we inadvertently delete one of the pair characters — this
results in an unbalanced expression. Smartparens prevents us from
doing that. If you hit <kbd>Backspace</kbd> in this expression:

```javascript

var mods = ["vars"];
            ^
```

Nothing will happen. Smartparens saves us a lot of trouble, here.

If you have the expression:

```clojure

[foo bar] baz
        ^
```

and you want `baz` to be part of `foo` and `bar`:

```clojure

[foo bar baz]
        ^
```

Execute `sp-forward-slurp-sexp`. I bound it to <kbd>C-right</kbd>.

Conversely, if you want to remove `baz`:

```clojure

[foo bar] baz
        ^
```

Execute `sp-forward-barf-sexp`. I bound it to <kbd>M-right</kbd>.

If you have the expression:

```clojure

blah [foo bar]
             ^
```

and you want `blah` to be part of `foo` and `bar`:

```clojure

[blah foo bar]
             ^
```

Execute `sp-backward-slurp-sexp`. I bound it to <kbd>C-left</kbd>.

Conversely, if you want to remove `blah`:

```clojure

blah [foo bar]
             ^
```

Execute `sp-backward-barf-sexp`. I bound it to <kbd>M-left</kbd>.

If you have the expression:

```clojure

"foo" "bar"
      ^
```

and you want `"foo"` and `"bar"` to switch places:

```clojure

"bar" "foo"
      ^
```

Execute `sp-transpose-sexp`. I bound it to <kbd>C-M-t</kbd>.

If you have the expression:

```clojure

(let [x "xxx" y "y yy yyy" z 0])
               ^
```

and you want to kill just `"y yy yyy"`:

```clojure

(let [x "xxx" y z 0])
               ^
```

Execute `sp-kill-sexp`. I bound it to <kbd>C-M-k</kbd>.

If you want to kill `"y yy yyy" z 0`:

```clojure

(let [x "xxx" y])
               ^
```

Execute `sp-kill-hybrid-sexp`. I bound it to <kbd>C-k</kbd>.

If you have the expression:

```clojure

(:require [clojure.string :as s])
                                ^
```

and you want to kill `[clojure.string :as s]`:

```clojure

(:require )
          ^
```

Execute `sp-backward-kill-sexp`. I bound it to <kbd>M-k</kbd>

If you have the expression:

```clojure

(foo (bar x y z))
     ^
```

and you want to unwrap the `bar` expression, removing the parentheses
around `foo`:

```clojure

foo (bar x y z)
    ^
```

Execute `sp-backward-unwrap-sexp`. I bound it to <kbd>M-[</kbd>

Conversely, if you want to unwrap the `bar` expression, removing the
parentheses around `bar`:

```clojure

(foo bar x y z)
     ^
```

Execute `sp-unwrap-sexp`. I bound it to <kbd>M-]</kbd>.


## Keys

The following snippet summarizes the key bindings used in this article.

```lisp
(bind-keys
 :map smartparens-mode-map
 ("C-M-a" . sp-beginning-of-sexp)
 ("C-M-e" . sp-end-of-sexp)

 ("C-<down>" . sp-down-sexp)
 ("C-<up>"   . sp-up-sexp)
 ("M-<down>" . sp-backward-down-sexp)
 ("M-<up>"   . sp-backward-up-sexp)

 ("C-M-f" . sp-forward-sexp)
 ("C-M-b" . sp-backward-sexp)

 ("C-M-n" . sp-next-sexp)
 ("C-M-p" . sp-previous-sexp)

 ("C-S-f" . sp-forward-symbol)
 ("C-S-b" . sp-backward-symbol)

 ("C-<right>" . sp-forward-slurp-sexp)
 ("M-<right>" . sp-forward-barf-sexp)
 ("C-<left>"  . sp-backward-slurp-sexp)
 ("M-<left>"  . sp-backward-barf-sexp)

 ("C-M-t" . sp-transpose-sexp)
 ("C-M-k" . sp-kill-sexp)
 ("C-k"   . sp-kill-hybrid-sexp)
 ("M-k"   . sp-backward-kill-sexp)
 ("C-M-w" . sp-copy-sexp)

 ("C-M-d" . delete-sexp)

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

The plethora of commands in Smartparens may be daunting at first, but
the investement in time in learning them, will be minimal compared to
benefits that you will reap. For more information on Smartparens, you
go to <http://foo.bar>.
