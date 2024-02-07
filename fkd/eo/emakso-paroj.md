Emakso kaj Paroj
================

<div class="center">Esperanto ■ [English](/en/emacs-pairs/)</div>
<div class="center">Laste ĝisdatigita: la 7-an de Marto 2021</div>

>La blanka bruo kiu batas ene la blanka mallumo estas la ritmo de la vivo; estas la pulso kiu
>neniam vere foriris la podion.<br>
>—Ergo PROXY, Ergo Proxy

<img src="/bil/wallhaven-578010-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="wallhaven-578010" title="wallhaven-578010"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Instalo](#instalo)
- [Agordaĵo](#agordajxo)
- [Uzado](#uzado)
  + [Bazaferoj](#bazaferoj)
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


<a name="enkonduko">Enkonduko</a>
---------------------------------

En ĉi tiu artikolo, mi eksklusive parolas pri _smartparens_—tiu pako, kiun oni esperis, ke oni jam
uzis antaŭe, supozante oni ne jam uzis ĝin . Se oni estas komencanto pri ĝi, laŭlegu; se ne, ĉi tio
eble estas bona memorigilo.

_smartparens_ estas unu el tiuj pakoj kiu draste plibonigas, kaj ŝanĝas kiel oni uzas emakson .
Similas al kibernetikaj membroj—igas onin por pli alte salti kaj pli forte pugnobati.

Memoru, ke la nomo malpravas tial, ke ne nur rondajn krampojn ĝi
traktas. Ĝi ankaŭ traktas iujn ajn kiuj pariĝas, kaj ĝi traktas ilin stele.


<a name="instalo">Instalo</a>
-----------------------------

Instali smartparens estas facila:

    M-x package-install EN smartparens EN


<a name="agordajxo">Agordaĵo</a>
--------------------------------

Sekve, oni ŝaltu smartparens en la startigo, kaj oni kroĉu ĝin al egaj kroĉiloj:

```lisp
(use-package smartparens-config
  :ensure smartparens
  :config (progn (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
```

<a name="uzado">Uzado</a>
-------------------------

Administri parigitajn signojn kiel rondaj krampoj, kurbaj krampoj, kvadrataj krampoj, citiloj,
angulaj krampoj, kaj aliaj koncepteblaj parigeblaj signoj jam ĉiam doloras sin. Aliaj pakoj solvas tiun
problemon parte. Bedaŭrinde, mankas al ili kelkaj punktoj.

En la kodetoj ĉi-sube, la ĉapelo (^) simbolo estos uzita por reprezenti la
[punkton](https://www.gnu.org/software/emacs/manual/html_node/elisp/Point.html).


### <a name="bazaferoj">Bazaferoj</a>

Per smartparens, kiam oni enigas parigeblajn signojn:

```clojure

(defn foo )
          ^
```

ankaŭ eniĝas la kongrua paro, kaj la punkto estas poziciita ene la paro:

```clojure

(defn foo [])
           ^
```


### <a name="navigado">Navigado</a>

#### <a name="komencojkajfinoj">Komencoj kaj finoj</a>

Sa oni havas le jenan esprimon:

```clojure

(let [x "foo bar baz ... blah"])
                         ^
```

kaj oni volas movi la punkton al la komenco de la signovico:

```clojure

(let [x "foo bar baz ... blah"])
         ^
```

Rulu `sp-beginning-of-sexp`. Mi bindis ĝin al <kbd>C-M-a</kbd>.

Male, por movi la punkton al la fino de la esprimo:

```clojure

(let [x "foo bar baz ... blah"])
                             ^
```

Rulu `sp-end-of-sexp`. Mi bindis ĝin al <kbd>C-M-e</kbd>.


#### <a name="listojntrairi">Listojn trairi</a>

Se oni havas la jenan esprimon:

```lisp

(defun format-date (format)
  "La daton enmetu laŭ specio FORMAT kun specifa lokaĵaro."
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format)))) ^

```

kaj oni volas movi la punkton al `insert`:

```lisp

(defun format-date (format)
  "La daton enmetu laŭ specio FORMAT kun specifa lokaĵaro."
  (let ((system-time-locale "en_US.UTF-8"))
    (insert (format-time-string format))))
     ^
```

Rulu `sp-down-sexp`. Mi bindis ĝin al <kbd>C-down</kbd>.

Sa oni havas la jenan esprimon:

```clojure

(str "foo" "bar baz qux")
    ^
```

kaj oni volas movi la punkton post `)`:

```clojure

(str "foo" "bar baz qux")
                         ^
```

Rulu `sp-up-sexp`. Mi bindis ĝin al <kbd>C-up</kbd>.

Se oni havas la jenan esprimon:

```clojure

(defn foo [bar] (let [x 0] x))
                ^
```

kaj oni volas movi la punkton al la apuda `]`:

```clojure

(defn foo [bar] (let [x 0] x))
              ^
```

Rulu `sp-backward-down-sexp`. Mi bindis ĝin al <kbd>M-down</kbd>.

Sa oni havas la jenan esprimon:

```lisp

(insert (format-time-string format))
                           ^
```

kaj la punkton oni volas movi al `(format`:

```lisp

(insert (format-time-string format))
        ^
```

Rulu `sp-backward-up-sexp`. Mi bindis ĝin al <kbd>M-up</kbd>.


#### <a name="blokajmovadoj">Blokaj movadoj</a>

Sa oni havas la jenan esprimon:

```clojure

(:require [clojure.string :as s])
          ^
```

kaj la punkton oni volas movi post `]`:

```clojure

(:require [clojure.string :as s])
                                ^
```

Rulu `sp-forward-sexp`. Mi bindis ĝin al <kbd>C-M-f</kbd>.

Male, por movi ĝin reen al `[`:

```clojure

(:require [clojure.string :as s])
          ^
```

Rulu `sp-backward-sexp`. Mi bindis ĝin al <kbd>C-M-b</kbd>.


#### <a name="supra">Supra niveleca trairado</a>

Se oni havas la jenan esprimon:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]                 ^
  )

```

kaj oni volas movi la punkton  al `[`:

```clojure

(defn blah
  "Returns blah of foo."
  [foo]
  ^)

```

Rulu `sp-next-sexp` . Mi bindis ĝin al <kbd>C-M-n</kbd>.

Male, por movi ĝin reen:

```clojure

(defn blah
    "Returns blah of foo."
  [foo]                 ^
  )

```

Rulu `sp-previous-sexp`. Mi bindis ĝin al <kbd>C-M-p</kbd>.


#### <a name="libermanaj">Libermanaj movadoj</a>

Se oni havas la jenan esprimon:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
               ^
```

kaj oni volas movi la punkton  al `blah`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
      ^
```

Rulu `sp-backward-symbol`. Mi bindis ĝin al <kbd>C-S-b</kbd>.

Male, se oni havas la jenan esprimon:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
            ^
```

kaj oni volas movi la punkton tuj post `(let`:

```clojure

(defn blah [] (let [x 0 y 1] (+ x 1)))
                  ^
```

Rulu `sp-forward-symbol`. Mi bindis ĝin al <kbd>C-S-f</kbd>.

Kion ili faras, estas ke, ili ĉirkaŭnavigas kvazaŭ ne ekzistas la limiligoj kiel rondaj krampoj,
kvadrataj krampoj, kaj kurbaj krampoj.


### <a name="manipulado">Manipulado</a>

#### <a name="faldado">Faldado</a>

Se oni havas la jenan esprimon:

```javascript

var mods = "vars";
           ^
```

kaj oni volas ĉirkaŭi `"vars"` per `[` kaj `]`:

```javascript

var mods = ["vars"];
            ^
```

Preminte <kbd>C-M-Space</kbd> kaj <kbd>[</kbd> la tuta regiono fariĝas ĉirkaŭitaj per kongruaj `[`
kaj `]`. Tio ankaŭ estas aplikeblaj al klavoj kiel `(`, `{`, `"`, `'`, `*`, `_`, ktp, dependas per
la regimo kiun oni uzas.

Oni povas difini faldadajn funkciojn alterne:

```lisp
(defmacro def-pairs (pairs)
  "Funkciojn por parigado difinu. PAIRS estas asocialisto de (NAME . STRING) conses, en kiu, NAME estas la nomo de la funkcio kiu estos kreita kaj STRING estas sole signa signovico kiu la komencan signon markas.

La alvoko

  (def-pairs ((paren . \"(\")
              (bracket . \"[\"))

difinas la funkciojn WRAP-WITH-PAREN kaj WRAP-WITH-BRACKET, respektive."
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

Ĉi tiuj havas la avantaĝon de ne postuli regionojn por esti operaciotaj. Mi bindis la unuajn tri
funkciojn al <kbd>C-c (</kbd>, <kbd>C-c [</kbd>, kaj <kbd>C-c {</kbd>, respektive. Do, se oni havas la jenan
esprimon:

```clojure

(defn foo args (let [x 0] (inc x)))
          ^
```

kaj oni volas ĉirkaŭi `args` per `[` kaj `]`:

```clojure

(defn foo [args] (let [x 0] (inc x)))
           ^
```

Premu <kbd>C-c [</kbd>.

Fojfoje, oni malatentence forviŝas unu el la paraj paroj—ĉi tio rezultas al malekvilibrigita
esprimo. Smartparens malpermesas onin por fari tion. Se oni premas<kbd>Backspace</kbd> en la jena
esprimo:

```javascript

var mods = ["vars"];
            ^
```

Nenio okazas. smartparens savas onin el multe da ĝeno, ĉi tie.


#### <a name="malfaldado">Malfaldado</a>

Se oni havas la jenan esprimon:

```clojure

(foo (bar x y z))
     ^
```

kaj oni volas malfaldi la `bar` esprimon, forigante la rondajn krampojn ĉirkaŭ `foo`:

```clojure

foo (bar x y z)
    ^
```

Rulu `sp-backward-unwrap-sexp`. Mi bindis ĝin al <kbd>M-[</kbd>.

Male, se oni volas malfaldi la esprimon `bar`, forigante la rondajn krampojn ĉirkaŭ `bar`:

```clojure

(foo bar x y z)
     ^
```

Rulu `sp-unwrap-sexp`. Mi bindis ĝin al <kbd>M-]</kbd>.


#### <a name="glutadokajvomado">Glutado kaj vomado</a>

Sa oni havas la jenan esprimon:

```clojure

[foo bar] baz
        ^
```

kaj oni volas igi `baz` parto de `foo` kaj `bar`:

```clojure

[foo bar baz]
        ^
```

Rulu `sp-forward-slurp-sexp`. Mi bindis ĝin al <kbd>C-right</kbd>.

Male, se oni volas forigi `baz`:

```clojure

[foo bar] baz
        ^
```

Rulu `sp-forward-barf-sexp`. Mi bindis ĝin al <kbd>M-right</kbd>.

Se oni havas la jenan esprimon:

```clojure

blah [foo bar]
             ^
```

kaj oni volas igi `blah` parto de `foo` kaj `bar`:

```clojure

[blah foo bar]
             ^
```

Rulu `sp-backward-slurp-sexp`. Mi bindis ĝin al <kbd>C-left</kbd>.

Male, se oni volas forigi `blah`:

```clojure

blah [foo bar]
             ^
```

Rulu `sp-backward-barf-sexp`. Mi bindis ĝin al <kbd>M-left</kbd>.


#### <a name="intersxangxado">Interŝanĝado</a>

Se oni havas la jenan esprimon:

```clojure

"foo" "bar"
      ^
```

kaj oni volas interŝanĝi `"foo"` kaj `"bar"`:

```clojure

"bar" "foo"
      ^
```

Rulu `sp-transpose-sexp`. Mi bindis ĝin al <kbd>C-M-t</kbd>.


#### <a name="mortigado">Mortigado</a>

Se oni havas la jenan esprimon:

```clojure

(let [x "xxx" y "y yy yyy" z 0])
               ^
```

kaj oni volas mortigi nur `"y yy yyy"`:

```clojure

(let [x "xxx" y z 0])
               ^
```

Rulu `sp-kill-sexp`. Mi bindis ĝin al <kbd>C-M-k</kbd>.

Se oni volas mortigi `"y yy yyy" z 0`:

```clojure

(let [x "xxx" y])
               ^
```

Rulu `sp-kill-hybrid-sexp`. Mi bindis ĝin al <kbd>C-k</kbd>.

Se oni havas la jenan esprimon:

```clojure

(:require [clojure.string :as s])
                                ^
```

kaj oni volas mortigi `[clojure.string :as s]`:

```clojure

(:require )
          ^
```

Rulu `sp-backward-kill-sexp`. Mi bindis ĝin al <kbd>M-k</kbd>.


<a name="klavoj">Klavoj</a>
---------------------------

La jena kodeto resumas la uzatajn klavkombinojn en ĉi tiu artikolo. Mi uzas `bind-keys` por mapi
miajn klavojn oportune. Mi pridiskutis ĝin en [antaŭa](/eo/emakskonsiletoj-2-a) artikolo.

```lisp
(defmacro def-pairs (pairs)
  "Funkciojn por parigado difinu. PAIRS estas asocialisto de (NAME . STRING) conses, en kiu, NAME estas la nomo de la funkcio kiu estos kreita kaj STRING estas sole signa signovico kiu la komencan signon markas.

La alvoko

  (def-pairs ((paren . \"(\")
              (bracket . \"[\"))

difinas la funkciojn WRAP-WITH-PAREN kaj WRAP-WITH-BRACKET, respektive."
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


<a name="finrimarkoj">Finrimaroj</a>
------------------------------------

La pletoro de la komandoj en smartparens eble povas senkuraĝigas en la komenco, tamen la investo per
tempo en lerni ilin, estas minimuma kontraste al la gajnojn oni povas rikolti.

smartparens estas la elpensintaĵo de [Matus GOLJER](https://github.com/Fuco1). Por vidi pli da
informo pri smartparens, iru [ĉi tien](https://github.com/Fuco1/smartparens). Se oni ŝatas ĉi tiun
projekton, oni povas donaci
[ĉi tie](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CEYP5YVHDRX8C).
