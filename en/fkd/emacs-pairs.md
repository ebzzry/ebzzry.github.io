Emacs and Pairs
===============

<div class="center">August 15, 2015</div>
<div class="center">Last updated: March 31, 2017</div>

>The white noise that beats within the white darkness is the rhythm of life; it is that pulse which
>never truly left the stage.<br>
>―Ergo Proxy, Ergo Proxy

In this article, I’ll exclusively talk about _smartparens_—a package that you wish you should have
used, earlier, presuming you don’t use it yet. If you’re new to it, read along; if not, this may be
a good refresher.

_smartparens_ is one of those packages that drastically improves, and changes how one uses
Emacs. It’s like having cybernetic limbs—it makes you jump higher and punch harder.

Take note, though, that the name is a misnomer, as it not only handles parentheses. It handles just
about anything that pairs, and it performs those functions stellarly.


Table of contents
-----------------

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
  + [Basics](#basics)
  + [Navigation](#navigation)
    * [Starts and ends](#startsandends)
    * [Traversing lists](#traversinglists)
    * [Block movements](#blockmovements)
    * [Top-level-ish traversal](#toplevel)
    * [Free-form movements](#freeform)
  + [Manipulation](#manipulation)
    * [Wrapping](#wrapping)
    * [Unwrapping](#unwrapping)
    * [Slurp and barf](#slurpandbarf)
    * [Swapping](#swapping)
    * [Killing](#killing)
- [Keys](#keys)
- [Closing remarks](#closing)


<a name="installation"></a> Installation
----------------------------------------

Installing smartparens is straightforward:

```
M-x package-install RET smartparens RET
```


<a name="configuration"></a> Configuration
------------------------------------------

Let’s enable smartparens on startup, and hook it with some major hooks:

```lisp
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
```


<a name="usage"></a> Usage
--------------------------

Managing paired characters like parentheses, braces, brackets, quotation marks, angle brackets, and
other conceivable pair-able characters has always been a pain. Other packages solve that problem
partially. However, they it still miss several points.

In the code snippets below, the `^` symbol will be used to represent point:


### <a name="basics"></a> Basics

In smartparens, when you input a pair-able character:

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


### <a name="navigation"></a> Navigation


#### <a name="startsandends"></a> Starts and ends

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

Execute `sp-end-of-sexp`. I bound it to <kbd>C-M-e</kbd>.


#### <a name="traversinglists"></a> Traversing lists

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

and you want to move point after `)`:

```clojure

(str "foo" "bar baz qux")
                         ^
```

Execute `sp-up-sexp`. I bound it to <kbd>C-up</kbd>.

If you have the expression:

```clojure

(defn foo [bar] (let [x 0] x))
                ^
```

and you want to move point to the preceeding `]`:

```clojure

(defn foo [bar] (let [x 0] x))
              ^
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


#### <a name="blockmovements"></a> Block movements

If you have the expression:

```clojure

(:require [clojure.string :as s])
          ^
```

and you want to move point after `]`:

```clojure

(:require [clojure.string :as s])
                                ^
```

Execute `sp-forward-sexp`. I bound it to <kbd>C-M-f</kbd>

Conversely, to move it back to `[`:

```clojure

(:require [clojure.string :as s])
          ^
```

Execute `sp-backward-sexp`. I bound it to <kbd>C-M-b</kbd>.


#### <a name="toplevel"></a> Top-level-ish traversal

If you have the expression:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```

and you want to move point to `[`:

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


#### <a name="freeform"></a> Free-form movements

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

What they do is that they navigate around expressions as if delimiters, like parens, brackets, and
braces do not exist.


### <a name="manipulation"></a> Manipulation

#### <a name="wrapping"></a> Wrapping

If you have the expression:

```javascript

var mods = "vars";
           ^
```

and you want `"vars"` to be surrounded by `[` and `]`:

```javascript

var mods = ["vars"];
            ^
```

Pressing <kbd>C-M-Space</kbd> or <kbd>ESC C-Space</kbd> followed by <kbd>[</kbd> will make the
whole region become surrounded by matching `[` and `]`.  It also applies to keys like `(`,
`{`, `"`, `'`, `*`, `_`, etc, depending on the mode that you’re using.

Alternatively, you may define wrapping functions:

```lisp
(defmacro def-pairs (pairs)
  `(progn
     ,@(loop for (key . val) in pairs
          collect
            `(defun ,(read (concat
                            "wrap-with-"
                            (prin1-to-string key)
                            "s"))
                 (&optional arg)
               (interactive "p")
               (sp-wrap-with-pair ,val)))))

(def-pairs ((paren . "(")
            (bracket . "[")
            (brace . "{")
            (single-quote . "'")
            (double-quote . "\"")
            (back-quote . "`")))
```

These have the advantage of not requiring a region to operate on. I bound the first three functions to
<kbd>C-c (</kbd>, <kbd>C-c [</kbd>, and <kbd>C-c {</kbd>, respectively. So, if you have the
expression:

```clojure

(defn foo args (let [x 0] (inc x)))
          ^
```

and you want to surround `args` with `[` and `]`:

```clojure

(defn foo [args] (let [x 0] (inc x)))
           ^
```

Press <kbd>C-c [</kbd>.

Sometimes, we inadvertently delete one of the pair characters—this results in an unbalanced
expression. smartparens prevents us from doing that. If you hit <kbd>Backspace</kbd> in this
expression:

```javascript

var mods = ["vars"];
            ^
```

Nothing will happen. smartparens saves us a lot of trouble, here.


#### <a name="unwrapping"></a> Unwrapping

If you have the expression:

```clojure

(foo (bar x y z))
     ^
```

and you want to unwrap the `bar` expression, removing the parentheses around `foo`:

```clojure

foo (bar x y z)
    ^
```

Execute `sp-backward-unwrap-sexp`. I bound it to <kbd>M-[</kbd>

Conversely, if you want to unwrap the `bar` expression, removing the parentheses around `bar`:

```clojure

(foo bar x y z)
     ^
```

Execute `sp-unwrap-sexp`. I bound it to <kbd>M-]</kbd>.


#### <a name="slurpandbarf"></a> Slurp and barf

If you have the expression:

```clojure

[foo bar] baz
        ^
```

and you want `baz` to become part of `foo` and `bar`:

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

and you want `blah` to become part of `foo` and `bar`:

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


#### <a name="swapping"></a> Swapping

If you have the expression:

```clojure

"foo" "bar"
      ^
```

and you want `"foo"` and `"bar"` to trade places:

```clojure

"bar" "foo"
      ^
```

Execute `sp-transpose-sexp`. I bound it to <kbd>C-M-t</kbd>.


#### <a name="killing"></a> Killing

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


<a name="keys"></a> Keys
------------------------

The following snippet summarizes the key bindings used in this article. I use `bind-keys` to
conveniently map my keys. I discussed about it, in an [earlier](/en/emacs-tips-2) article.

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

 ("C-c ("  . wrap-with-parens)
 ("C-c ["  . wrap-with-brackets)
 ("C-c {"  . wrap-with-braces)
 ("C-c '"  . wrap-with-single-quotes)
 ("C-c \"" . wrap-with-double-quotes)
 ("C-c _"  . wrap-with-underscores)
 ("C-c `"  . wrap-with-back-quotes))
```


<a name="closing"></a> Closing remarks
--------------------------------------

The plethora of commands in smartparens may be daunting at first, but the investement in time in
learning them, will be minimal compared to benefits that you will reap.

smartparens is the brainchild of [Matus Goljer](mailto:matus.goljer@gmail.com). For more information
on smartparens, go to [here](https://github.com/Fuco1/smartparens). If you like this project, you
may
donate [here](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CEYP5YVHDRX8C).
