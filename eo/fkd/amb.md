Milda Enkonduko al Nedeterminismo en Skimo
==========================================

<div class="center">la 24-an de februaro 2019</div>
<div class="center">Laste ĝisdatigita: la 7-an de marto 2019</div>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [La aktuala daŭrigo](#aktualadaŭrigo)
  + [Ekzemploj](#aktualadaŭrigoekzemploj)
- [La call/cc-operatoro](#callcc)
  + [Kaptado](#callcckaptado)
  + [Aplikado](#callccaplikado)
  + [Eskapado](#callcceskapado)
  + [Ekzemploj](#callccekzemploj)
- [La amb-operatoro](#amb)
  + [Difino](#ambdifino)
  + [Malkonstruado](#ambmalkonstruado)
  + [Taksado](#ambtaksado)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

[Nedeterminisma](http://vortaro.net/#nedeterminisma) programado estas tekniko en kiu la fluo de la
algoritmo ne linearas kaj ekzistas pluraj daŭrigoj. La konduto povas ŝanĝiĝi per la samaj
enigoj. Ekzistas multaj metodoj por tion fari. En ĉi tiu artikolo la metodo kiun mi uzos estas
retroiĝado.

Kaj cetere, la programlingvon [skimo](https://eo.wikipedia.org/wiki/Scheme) mi uzos por tion
atingi. En skimo, oni permesatas por facile iri al antaŭa tempo de komputo kaj reen facile.

Mi ankaŭ diskutos pri la postulaj temoj por ke nedeterminismo en skimo oni pli facile komprenu.


<a name="aktualadaŭrigo">La aktuala daŭrigo</a>
-----------------------------------------------

En skimo, la aktuala daŭrigo aŭ la restanta komputo estas la restanta laboro por la ceteron de la
komputo taksi.

En la esprimo

```scheme
0
```

la aktuala daŭrigo—la restanta komputo—estas

```scheme
(lambda (v) v)
```

kaj la restanta operacio estas

```scheme
((lambda (v) v) 0)
```

kiu liveras je

```scheme
0
```

Tio estas la rezulto tial, ke la restanta komputo en tiu nivelo—la plej supra nivelo—estas la identa
funkcio.

Tenu en la kalkulo, ke la nomo de la argumento de la lambdo ne gravas. Ĝi povas esti `v`, `x`, aŭ
`hundo-kato-muso`:

```scheme
((lambda (hundo-kato-muso) hundo-kato-muso) 0)
```

### <a name="aktualadaŭrigoekzemploj">Ekzemploj</a>

En la esprimo

```scheme
(* 1 2)
```

la restanta komputo por `2`—la dua argumento de `+`—estas

```scheme
(lambda (v) (* 1 v))
```

kaj la restanta operacio estas

```scheme
((lambda (v) (* 1 v)) 2)
```

kiu, en tiu nivelo de komputo liveras

```scheme
2
```

konsekvece, la restanta komputo estas

```scheme
(lambda (v) v)
```

kaj la restanta operacio estas

```scheme
((lambda (v) v) 2)
```

kiu fine liveras ĉe la plej supra nivelo

```scheme
2
```

En la esprimo

```scheme
(+ (* 1 2) 3)
```

la fluo de la komputo estas

```scheme
   (* 1 2)
(+         3)
```

Unue `(* 1 2)` taksiĝos tiam la rezulto fariĝas la unua argumento por `(+   3)`. En tiu vaka spaco,
la restanta komputo estas

```scheme
(lambda (v) (+ v 3))
```

la restanta komputo operacio estas

```scheme
((lambda (v) (+ v 3)) (* 1 2))
```


<a name="callcc">La call/cc-operatoro</a>
-----------------------------------------

En skimo, la aktualan daŭrigon—la restantan komputon—oni povas kapti kiel variablo. Tion oni povas
fari per la operatoro [call/cc](https://scheme.com/tspl4/further.html#./further:h3). Ĝi estas
operatoro, kiu nur unu argumenton ekskluzive akceptas—[lambdon](http://localhost:8000/eo/lambdokalkulo/)—sennoman funcion, kun unu argumento:

```scheme
(call/cc (lambda (k) k))
```

Se je `call/cc` oni ne havas, ĝin difinu per:

```scheme
(define call/cc call-with-current-continuation)
```

En la angla, `call/cc` estas la alinomo de `call-with-current-continuation`. Tiun nomon oni ankaŭ
povas trakti kiel *voku funkcion per la restanta komputo*. La funkcio, kiun ĝi vokas estas la
lambdo. Kaj cetere, la aktualan daŭrigon—la restantan komputon—`call/cc` pasas al tiu sennoma
funkcio.

En tiu lambdo,

```scheme
(lambda (k) k)
```

`k` estas funkcio mem kiu unu argumenton akceptas. Do, en

```scheme
(call/cc (lambda (k) k))
```

la aktualan daŭrigon—simple la funkcion—`call/cc` liveras sen ajna argumento. Tamen, en

```scheme
(call/cc (lambda (k) (k 0)))
```

`call/cc` simple liveras je `0` tial, ke en tiu nivelo—la plej supra nivelo—`k` estas:

```scheme
(lambda (v) v)
```

—la identa funkcio. Pro tio, la voko:

```scheme
(call/cc (lambda (k) (k 0)))
```

ekvivalentas al:

```scheme
((lambda (v) v) 0)
```

### <a name="callcckaptado">Kaptado</a>

Reirante al la antaŭa ekzemplo

```scheme
(+ (* 1 2) 3)
```

la aktualan daŭrigon de `(* 1 2)` oni povas kapti per `call/cc`:

```scheme
(+ (call/cc (lambda (k) (* 1 2))) 3)
```

Tamen, oni povas rimarki ke la funckion `k` oni ne aplikis al io ajn. La esprimon `(* 1 2)` oni
taksos, kaj la rezulton oni donos al `(+ _ 3)`. Alidire, tiu esprimo ekvivalentas al:

```scheme
(+ (* 1 2) 3)
```

### <a name="callccaplikado">Aplikado</a>

La saman ekzemplon uzante, ĉi tie la funkcion `k` oni apliku.

```scheme
(+ (call/cc (lambda (k) (k (* 1 2)))) 3)
```

Ene la voko de `call/cc`:

```scheme
            (lambda (k) (k (* 1 2)))
```
la variablo `k` estas la aktuala daŭrigo—la restanta komputo. Kio estas la restanta komputo? Jen:

```scheme
(+                                    3)
```

—la adicio al 3. Por ke tiun komputon reprezentu kiel funkcio, ĝi fariĝos:

```scheme
(lambda (v) (+ v 3))
```

En kie `(+ _ 3)` estos reprezentata per ĉi tiu lambdo.

Do, la rolo de `call/cc` estas por lambdon voki, kiun la restanta komputo akceptas. Ĉi tie, la
restanta komputo nomiĝas `k`. Pro tio, la konsekveco de:

```scheme
(+ (call/cc (lambda (k) (k (* 1 2)))) 3)
```

ekvivalentas al

```scheme
((lambda (v) (+ v 3)) (* 1 2))
```

### <a name="callcceskapado">Eskapado</a>

En

```scheme
(define z #f)
(+ (call/cc (lambda (k) (set! z k) (* 1 2))) 3)
```

normale la rezulto estos

```scheme
5
```

tamen pro tio, ke la aktualan daŭrigon—`k`—ni konservis en `z`. Al tiu loko oni povas reiri per:

```scheme
(z 1)
```

kiu liveras je

```scheme
4
```

—alian valoron. Tiu meĥanismo donas al oni la kapablon por la komputon eskapi.

Pro tio, ke la aktuala daŭrigo estas:

```scheme
(lambda (v) (+ v 3))
```

la voko

```scheme
(z 1)
```
ekvivalentas al

```scheme
((lambda (v) (+ v 3)) 1)
```

anstataŭ

```scheme
((lambda (v) (+ v 3)) (* 1 2))
```

### <a name="callccekzemploj">Ekzemploj</a>

En

```scheme
(let ((x (call/cc (lambda (k) k)))) (x (lambda (o) "saluton")))
```

la voko

```scheme
(x (lambda (o) "saluton"))
```

fariĝas

```scheme
((call/cc (lambda (k) k)) (lambda (o) "saluton"))
```

tie, la restanta komputo estas

```scheme
(lambda (o) "saluton")
```

kiu iras al la variablo `k` en la korpo de `call/cc`. Kiel antaŭe, je `k` oni apliku al `(lambda (o) "saluton")` ene alia lambdo:

```scheme
((lambda (v) (v (lambda (o) "saluton"))) (lambda (o) "saluton"))
```

kiu liveras je

```scheme
"saluton"
```

En

```scheme
(((call/cc (lambda (k) k)) (lambda (x) x)) "saluton")
```

la kerno estas

```scheme
((call/cc (lambda (k) k)) (lambda (x) x))
```

Ene la korpo de `call/cc`, la restanta komputo estas

```scheme
(lambda (x) x)
```

kiu iras al la variablo `k` en la korpo de `call/cc`. Kiel antaŭe denove, ĝin oni apliku al la lambdo

```scheme
((lambda (v) (v (lambda (x) x))) (lambda (x) x))
```

kiu liveras je

```scheme
#<procedure x>
```

Tio signifas, ke ĉi tiun funkcion oni nun povas apliki al la cetera argumento:

```scheme
(((lambda (v) (v (lambda (x) x))) (lambda (x) x)) "saluton")
```

kiu liveras je

```scheme
"saluton"
```


<a name="amb">La amb-operatoro</a>
----------------------------------

La fama amb-operatoro estas uzata en skimo por nedeterminisman programadon realigi per
retroiĝado. Per tiu meĥanismo, la komputo povas iri al antaŭa stato; valorojn porti; ŝtatojn ŝanĝi;
komputon eskapi; ktp.

En ĉi tiu artikolo la amb-operatoron oni uzos por la retroiĝadan meĥanismon ebligi.


### <a name="ambdifino">Difino</a>

La difino kiun oni uzos estas de [shido.info](http://www.shido.info/lisp/scheme_amb_e.html). Ĝi estas
makroo por certigi, ke la argumentoj ne taksiĝos. Kaj cetere, listojn ĝi interne uzas.

```scheme
(define call/cc call-with-current-continuation) ;  1
                                                ;  2
(define f #f)                                   ;  3
                                                ;  4
(define-syntax amb                              ;  5
  (syntax-rules ()                              ;  6
    ((_) (f))                                   ;  7
    ((_ a) a)                                   ;  8
    ((_ a b ...)                                ;  9
     (let ((s f))                               ; 10
       (call/cc                                 ; 11
        (lambda (k)                             ; 12
          (set! f (lambda ()                    ; 13
                    (set! f s)                  ; 14
                    (k (amb b ...))))           ; 15
          (k a)))))))                           ; 16
                                                ; 17
(define (cxu? x y)                              ; 18
  (if (equal? x y)                              ; 19
      (list x y)                                ; 20
      (amb)))                                   ; 21
                                                ; 22
(call/cc                                        ; 23
 (lambda (k)                                    ; 24
   (set! f (lambda ()                           ; 25
             (k 'neniuj-elektoj)))))            ; 26
```

Ĉi tiuj difinoj funkcias per [MIT-skimo](https://www.gnu.org/software/mit-scheme/),
[Guile](https://www.gnu.org/software/guile/), [Scheme48](http://s48.org/),
[Scsh](https://scsh.net/), [chibi-scheme](http://synthcode.com/wiki/chibi-scheme),
[Gerbil](https://cons.io/), [Chez-skimo](https://www.scheme.com/), [Chicken](http://call-cc.org/),
[Bigloo](https://www-sop.inria.fr/indes/fp/Bigloo/),
[Gauche](https://practical-scheme.net/gauche/memo.html), kaj [Rakido](https://racket-lang.org/).

La enkonstruitan operatoron `choice`—kiu funkcias kiel `amb`—[FramerD](http://www.framerd.org/)
havas. Se la nomon `amb` oni preferas, ĝin oni povas bindi per:

```scheme
(define amb choice)
```


### <a name="ambmalkonstruado">Malkonstruado</a>

En ĉi tiu sekcio, la difinon de la amb-operatoro kaj aliaj funkcioj oni malkonstruu. La funkcio
`cxu?` teknike ne estas parto de la difino, tamen ĝin oni uzos por la funkciadon de `amb`
montru.

En linio 1-a `call/cc` bindiĝas al `call-with-current-continuation` precipe por realigoj kiuj tiun
funkcion ne havas. En linio 3-a `f` bindiĝas al implicita valoro. En linioj 5-a ĝis 16-a estas la korpo
do `amb`. En linioj 18-a ĝis 21-a estas ekzempla funckio. Se `x` kaj `y` egalas, liston ĝi liveras; se
ne, `amb` vokiĝos. En linioj 23-a ĝis 26-a, `call/cc` vokiĝas, en kiu la vera komenca valoro de `f`
pravaloriziĝas per lambdo kiu je `'neniuj-elektoj` simple liveras.

Oni reiru al la korpo de `amb` en linioj 5-a ĝis 16-a. En linio 7-a, se `amb` vokiĝas kiel:

```scheme
(amb)
```

la funkcio `f` vokiĝos, per kio ajn `f` povos fari.

En linio 8-a, se `amb` vokiĝas kiel:

```scheme
(amb "hundo")
```

la argumento `"hundo"` simple liveriĝas.

Tamen, per pli ol unu argumentoj, la konduto de `amb` ŝanĝiĝos. Unue, en linio 10-a, la aktuala
valoro de `f` bindiĝas al `s`, sekve en linio 11-a, `call/cc` vokiĝas, la aktualan daŭrigon kaptante
al `k`.

Ene la korpo de la lambdo, novan valoron la tutmonda variablo `f` havos—alian lambdon—kiu ne estas
taksota ĝis ĝi estas specife taksata. En tiu korpo, la valoron de `s` antaŭe `f` havos, tiam `k`
vokiĝos per la valoro `b ...`, kiu estas la ceteraj argumentoj por `amb`.

Kaj laste, la `k` funkcio—la sekva komputo—aplikiĝos al la valoro `a`.


### <a name="ambtaksado">Taksado</a>

Je `cxu?` uzante, la paŝojn en la uzado de `amb` oni rigardos. Se la jenan esprimon oni
havas:

```scheme
(cxu? (amb "hundo" "kato" 9) (amb "muso" 9))
```

Jen la pli simpligitaj taksadaj paŝoj:

1. `(amb "hundo" "kato" 9)` taksiĝos;

2. Pro tio, ke pli ol unu argumento estas pasitaj al `amb` oni iru al linio 9-a;

3. La aktualan valoron de `f` de la plej supra nivelo:
```scheme
(lambda () (k 'neniuj-elektoj))
```
la loka variablo `s` havos;

4. La lambdo en linio 12-a vokiĝos kun la sekva komputo al `k`;

5. En linio 13-a novan valoron `f` havos. La valoro estos lambdo;

6. Kiam la lambdo vokiĝos, la valoron de `s`—kiu estas la lambdo de paŝo 3-a—`k` denove havos;

7. `k` aplikiĝos al `a`, en kiu, `(k a)` estas:
```scheme
((lambda (v) (cxu? v (amb "muso" 9))) "hundo")
```
kiu konsekvece fariĝas
```scheme
((lambda (v) ((lambda (w) (cxu? v w)) "hundo")) "muso")
```
pro la voko `(amb "muso" 9)`;

8. Pro tio, ke `"hundo"` ne egalas al `"muso"` la `amb` funkcio vokiĝos, kiel:
```scheme
(amb)
```

9. Pro tio, ke argumenton `(amb)` ne havas, la esprimo en linio 7-a okazos;
```scheme
(f)
```
en kiu la valoro estas la lambdo en la linioj 13-a ĝis 15-a. La valoro de `f` denove fariĝas:
```scheme
(lambda () (k 'neniuj-elektoj))
```

10. Tiam, en linio 15-a, `k` vokiĝos kiel `(k "kato" 9)`.

11. La paŝoj ripetiĝos, je `cxu?` vokante. En kie, la paŝoj aspektos kiel:
```scheme
(cxu? "hundo" "muso")
(cxu? "hundo" 9)
(cxu? "kato" "muso")
(cxu? "kato" 9)
(cxu? 9 "muso")
(cxu? 9 9)
```

12. Pro tio, ke `9` egalas al `9`, la esprimo
```scheme
(list 9 9)
```
taksiĝos en la korpo de `cxu?` kiu finfine liveras je
```
'(9 9)
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

En ĉi tiu artikolo, oni rimarkis, ke per `call/cc` nedeterminismon per retroiĝado oni povis atingi
facile per `amb` kaj bazaj skimaj funkcioj. Tamen, estas aliaj pli kompleksaj kaj pli bonaj metodoj
por ĉi tion atingi. La tipo de daŭrigoj, kiun oni traktis estis la
[kutima daŭrigo (angle)](https://en.wikipedia.org/wiki/Continuation) kontraste al
[limigita daŭrigo (angle)](https://en.wikipedia.org/wiki/Delimited_continuation). Mi ankaŭ devas
mencii, ke `call/cc` eble
[ne estas bona konstruo](http://okmij.org/ftp/continuations/against-callcc.html) por la celon de ĉi
tiu artikolo atingi.

Mi esperas, ke iel, bonan ion oni lernis el ĉi tiu afiŝo!