Emakso kaj Paroj
================

<div class="center">[Esperante](#) · [English](/en/emacs-pairs)</div>
<div class="center">la 9-an de Julio 2018</div>
<div class="center">Laste ĝisdatigita: la 6-an de aŭgusto 2018</div>

>La blanka bruo kiu batas ene la blanka mallumo estas la ritmo de la vivo; estas la pulso kiu
>neniam vere foriris la podion.<br>
>―Ergo PROXY, Ergo Proxy

En ĉi tiu artikolo, mi eksklusive parolas pri _smartparens_—pako kiun oni esperis, ke oni jam uzis
antaŭe, supozante ĝin oni ne jam uzis. Se oni estas komencanto pri ĝi, laŭlegu; se ne, ĉi tio eble
estas bona memorigilo.

_smartparens_ estas unu el tiuj pakoj kiu draste plibonigas, kaj ŝanĝas kiel emakson oni
uzas. Similas al kibernetikajn membrojn—onin igas por pli alte salti kaj pli forte pugnobati.

Tenu en la kalkulo, ke la nomo estas iomete malprava tial, ke ne nur rondajn krampojn ĝi
traktas. Ankaŭ iujn ajn kiuj pariĝas ĝi traktas, kaj ilin ĝi traktas stele.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Instalo](#instalo)
- [Agordaĵo](#agordajxo)
- [Uzado](#uzado)
  + [Bazaj](#bazaj)
  + [Navigado](#navigado)
    * [Komencoj kaj finoj](#komencojkajfinoj)
    * [Listojn trairi](#listojntrairi)
    * [Blokaj movadoj](#blokajmovadoj)
    * [Supra niveleca trairado](#supra)
    * [Libermanaj movadoj](#libermanaj)
  + [Manipulado](#manipulado)
    * [Faldado](#faldado)
    * [Malfaldado](#malfaldado)
    * [Glutado kaj vomado](#glutadokajvomado)
    * [Interŝanĝado](#intersxangxado)
    * [Mortigado](#mortigado)
- [Klavoj](#klavoj)
- [Finrimarkoj](#finrimarkoj)


<a name="instalo"></a>Instalo
-----------------------------

Na smartparens instali simplas:

    M-x package-install REV smartparens REV


<a name="agordajxo"></a>Agordaĵo
--------------------------------

Na smartparens oni ŝaltu en la startigo, kaj ĝin oni kroĉu al egaj kroĉiloj:

```lisp
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
```

<a name="uzado"></a>Uzado
-------------------------

Parigitajn karakterojn kiel rondaj krampoj, kurbaj krampoj, kvadrataj krampoj, citiloj, angulaj
krampoj, kaj aliaj koncepteblaj parigeblaj karakteroj mastrumi jam estas ĉiam doloraj. Tiun
problemon aliaj pakoj solvas parte. Bedaŭrinde, kelkajn punktojn ili maltrafas.

En la kodetoj ĉi-sube, la `^` simbolo estos uzita por la
[punkton](https://www.gnu.org/software/emacs/manual/html_node/elisp/Point.html) reprezenti.


### <a name="bazaj"></a>Bazaj

Smartparens-e, kiam parigeblan karakteron oni enigas:

```clojure

(defn foo )
          ^
```

la kongruan paron ankaŭ eniĝas, kaj la punkto estas poziciita ene la paro:

```clojure

(defn foo [])
           ^
```


### <a name="navigado"></a>Navigado

#### <a name="komencojkajfinoj"></a>Komencoj kaj finoj

Sa le jenan esprimon oni havas:

```clojure

(let [x "foo bar baz ... blah"])
                         ^
```

kaj la punkton oni volas movi en la komenco de la signovico:

```clojure

(let [x "foo bar baz ... blah"])
         ^
```

Na `sp-beginning-of-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-a</kbd>.

Male, por la punkton movi al la fino de la esprimo:

```clojure

(let [x "foo bar baz ... blah"])
                             ^
```

Na `sp-end-of-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-e</kbd>.


#### <a name="listojntrairi"></a>Listojn trairi

Se la jenan esprimon oni havas:

```lisp

(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format)))) ^

```

kaj la punkton oni volas movi al `insert`:

```lisp

(defun format-date (format)
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))
     ^
```

Na `sp-down-sexp` plenumu. Ĝin mi bindis al <kbd>C-down</kbd>.

Sa le jenan esprimon oni havas:

```clojure

(str "foo" "bar baz qux")
    ^
```

kaj la punkton oni volas movi post `)`:

```clojure

(str "foo" "bar baz qux")
                         ^
```

Na `sp-up-sexp` plenumu. Ĝin mi bindis al <kbd>C-up</kbd>.

Se la jenan esprimon oni havas:

```clojure

(defn foo [bar] (let [x 0] x))
                ^
```

kaj la punkton oni volas movi al la apuda `]`:

```clojure

(defn foo [bar] (let [x 0] x))
              ^
```

Na `sp-backward-down-sexp` plenumu. Ĝin mi bindis al <kbd>M-down</kbd>.

Sa la jenan esprimon oni havas:

```lisp

(insert (format-time-string format))
                           ^
```

kaj la punkton oni volas movi al `(format`:

```lisp

(insert (format-time-string format))
        ^
```

Na `sp-backward-up-sexp` plenumu. Ĝin mi bindis al <kbd>M-up</kbd>.


#### <a name="blokajmovadoj"></a>Blokaj movadoj

Sa la jenan esprimon oni havas:

```clojure

(:require [clojure.string :as s])
          ^
```

kaj la punkton oni volas movi post `]`:

```clojure

(:require [clojure.string :as s])
                                ^
```

Na `sp-forward-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-f</kbd>.

Male, por ĝin movi reen al `[`:

```clojure

(:require [clojure.string :as s])
          ^
```

Na `sp-backward-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-b</kbd>.


#### <a name="supra"></a>Supra niveleca trairado

Se la jenan esprimon oni havas:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```

kaj la punkton oni volas movi al `[`:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]
  ^)

```

Na `sp-next-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-n</kbd>.

Male, por ĝin movi reen:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```

Na `sp-previous-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-p</kbd>.


#### <a name="libermanaj"></a>Libermanaj movadoj

Se la jenan esprimon oni havas:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
               ^
```

kaj la punkton oni volas movi al `blah`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
      ^
```

Na `sp-backward-symbol` plenumu. Ĝin mi bindis al <kbd>C-S-b</kbd>.

Male, sa la jenan esprimon oni havas:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
            ^
```

kaj la punkton oni volas movi tuj post `(let`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
                  ^
```

Na `sp-forward-symbol` plenumu. Ĝin mi bindis al <kbd>C-S-f</kbd>.

Kion ili faras, estas, ili ĉirkaŭnavigas kvazaŭ ne ekzistas la limiligoj kiel rondaj krampoj,
kvadrataj krampoj, kaj kurbaj krampoj.


### <a name="manipulado"></a>Manipulado

#### <a name="faldado"></a>Faldado

Se la jenan esprimon oni havas:

```javascript

var mods = "vars";
           ^
```

kaj na `"vars"` oni volas esti ĉirkaŭitaj per `[` kaj `]`:

```javascript

var mods = ["vars"];
            ^
```

Na <kbd>C-M-Space</kbd> aŭ <kbd>ESC C-Space</kbd> premu sekvonte de <kbd>[</kbd> la tutan regionon
igas esti ĉirkaŭitaj per kongruaj `[` kaj `]`. Ankaŭ aplikeblas al klavoj kiel `(`, `{`, `"`, `'`,
`*`, `_`, ktp, dependas per la regimo kiun oni uzas.

Alternative, faldadajn funkciojn oni povas difini:

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

La avantaĝon de regionojn ne postuli ĉi tiuj havas por kunoperacii. La unuajn tri funkciojn mi
bindis al <kbd>C-c (</kbd>, <kbd>C-c [</kbd>, kaj <kbd>C-c {</kbd>, respektive. Do, se la jenan
esprimon oni havas:

```clojure

(defn foo args (let [x 0] (inc x)))
          ^
```

kaj na `args` oni volas ĉirkaŭi per `[` kaj `]`:

```clojure

(defn foo [args] (let [x 0] (inc x)))
           ^
```

Na <kbd>C-c [</kbd> premu.

Fojfoje, unu el la paraj paroj oni malatentence forviŝas—ĉi tio rezultas en malekvilibrigita
esprimo. Onin smartparens malpermesas por tion fari. Se na <kbd>Backspace</kbd> oni premas en la
jena esprimo:

```javascript

var mods = ["vars"];
            ^
```

Okazas nenio. Onin smartparens savas el multe da ĝeno, ĉi tie.


#### <a name="malfaldado"></a>Malfaldado

Se la jenan esprimon oni havas:

```clojure

(foo (bar x y z))
     ^
```

kaj la `bar` esprimon oni volas malfaldi, la rondajn krampojn forigante ĉirkaŭ `foo`:

```clojure

foo (bar x y z)
    ^
```

Na `sp-backward-unwrap-sexp` plenumu. Ĝin mi bindis al <kbd>M-[</kbd>.

Male, se la `bar` esprimon oni volas malfaldi, la rondajn krampojn forigante ĉirkaŭ `bar`:

```clojure

(foo bar x y z)
     ^
```

Na `sp-unwrap-sexp` plenumu. Ĝin mi bindis al <kbd>M-]</kbd>.


#### <a name="glutadokajvomado"></a>Glutado kaj vomado

Sa la jenan esprimon oni havas:

```clojure

[foo bar] baz
        ^
```

kaj na `baz` oni volas esti parto de `foo` kaj `bar`:

```clojure

[foo bar baz]
        ^
```

Na `sp-forward-slurp-sexp` plenumu. Ĝin mi bindis al <kbd>C-right</kbd>.

Male, se na `baz` oni volas forigi:

```clojure

[foo bar] baz
        ^
```

Na `sp-forward-barf-sexp` plenumu. Ĝin mi bindis al <kbd>M-right</kbd>.

Se la jenan esprimon oni havas:

```clojure

blah [foo bar]
             ^
```

kaj na `blah` oni volas esti parto de `foo` kaj `bar`:

```clojure

[blah foo bar]
             ^
```

Na `sp-backward-slurp-sexp` plenumu. Ĝin mi bindis al <kbd>C-left</kbd>.

Male, se na `blah` oni volas forigi:

```clojure

blah [foo bar]
             ^
```

Na `sp-backward-barf-sexp` plenumu. Ĝin mi bindis al <kbd>M-left</kbd>.


#### <a name="intersxangxado"></a>Interŝanĝado

Se la jenan esprimon oni havas:

```clojure

"foo" "bar"
      ^
```

kaj na `"foo"` kaj `"bar"` oni volas interŝanĝi:

```clojure

"bar" "foo"
      ^
```

Na `sp-transpose-sexp` plenumu. Ĝin mi bindin al <kbd>C-M-t</kbd>.


#### <a name="mortigado"></a>Mortigado

Se la jenan esprimon oni havas:

```clojure

(let [x "xxx" y "y yy yyy" z 0])
               ^
```

kaj nur na`"y yy yyy"` oni volas mortigi:

```clojure

(let [x "xxx" y z 0])
               ^
```

Na `sp-kill-sexp` plenumu. Ĝin mi bindis al <kbd>C-M-k</kbd>.

Se na `"y yy yyy" z 0` oni volas mortigi:

```clojure

(let [x "xxx" y])
               ^
```

Na `sp-kill-hybrid-sexp` plenumu. Ĝin mi bindis al <kbd>C-k</kbd>.

Se la jenan esprimon oni havas:

```clojure

(:require [clojure.string :as s])
                                ^
```

kaj na `[clojure.string :as s]` oni volas mortigi:

```clojure

(:require )
          ^
```

Na `sp-backward-kill-sexp` plenumu. Ĝin mi bindis al <kbd>M-k</kbd>.


<a name="klavoj"></a>Klavoj
---------------------------

La uzatajn klavkombinojn en ĉi tiu artikolo la jena kodeto resumas. Na `bind-keys` mi uzas por miajn
klavojn oportune mapi. Ĝin mi diskutis en [antaŭa](/eo/emakskonsiletoj-2-a) artikolo.

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


<a name="finrimarkoj"></a>Finrimaroj
------------------------------------

La pletoro de la komandoj en smartparens eble komence senkuraĝigas, tamen la investo per tempo en
ilin lerni, minimumas kontraste al la gajnojn oni povas rikolti.

smartparens estas la elpensintaĵo de [Matus Goljer](https://github.com/Fuco1). Por pli da informo
pri smartparens, [ĉi tien](https://github.com/Fuco1/smartparens) iru. Se ĉi tiun projekton oni
ŝatas, oni povas donaci
[ĉi tie](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CEYP5YVHDRX8C).
