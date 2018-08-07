La Ipsilonkombinatoro en Ses Paŝoj
==================================

<div class="center">[Esperante](#) · [English](/en/y)</div>
<div class="center">la 25-an de Novembro 2017</div>
<div class="center">Laste ĝisdatigita: la 20-an de marto 2018</div>

>Unue, decidu. Kaj faru ĝin. Estas la nur maniero por atingi ion.<br>
>―Lacus CLYNE, Gundam SEED Destiny

Multe da ni estis instruitaj ke, por difini rikuran proceduron, la rikura alvoko devas uzi la
nomon de la rikuran proceduron. La
[ipsilonkombinatoro (angle)](https://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator), tamen,
permesas onin por presti rikuron, sen referenci la nomatan identigilon.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Kio?](#kio)
- [Paŝo 1-a: Difinu la bazan proceduron](#baza)
- [Paŝo 2-a: Funkcivokarigu la rikuran alvokon](#funkcivokarigi)
- [Paŝo 3-a: Apliku la proceduron al si mem](#mem)
- [Paŝo 4-a: Abstraktu la enan alvokon](#enan)
- [Paŝo 5-a: Izolu la kombinatoron](#izoli)
- [Paŝo 6-a: Difinu la kombinatoron](#difini)
- [Finrimarkoj](#finrimarkoj)


<a name="kio">Kio?</a>
----------------------

La ipsilonkombinatoro estas la fonto de kaj inspiro kaj frustro de multaj homoj. Elvokas sensacion
kiel eŭreka tuj oni pasis la muron, sed ankaŭ igas nin skrapi niajn kapojn kiam ne faras sencon
por trairi la labirinton. Ĉi tiu artikolo celas porti miajn proprajn metodojn kiel derivi la ipsilonan
kombinatoron. Eble ne estas la plej eleganta maniero, tamen eblas funkcii por oni.

En la kodaj ekzemploj en ĉi tiu artikolo, la `>` simbolo montras la invitan simbolon de via skima
realigo.


<a name="baza">Paŝo 1-a: Difinu la bazan proceduron</a>
-------------------------------------------------------

Ni komencu per difini proceduron nomata `foo` kiu komputas la sumadon de pozitiva entjero, malsupren
al nul. En la sekvanta kodaĵo, la rikura alvoko okazas kiam `foo` estas aplikata en la `else`-a
parto de la kondiĉo.

```scheme
> (define foo
    (lambda (n)
      (if (zero? n)
          0
          (+ n (foo (- n 1))))))
> (foo 100)
5050
```

Oni rimarkis, ke mi difinis `foo` per eksplicita `lambda`. Oni vidos postnelonge kial.



<a name="funkcivokarigi">Paŝo 2-a: Funkcivokarigu la rikuran alvokon</a>
------------------------------------------------------------------------

Ni dismembrigu tiun proceduron pli detale, per pli rudimentaj eroj, kaj oni aplikos ĝin, per
funkcivokarigi (angle [currying](https://en.wikipedia.org/wiki/Currying)).

```scheme
> (define foo
    (lambda (f)
      (lambda (n)
        (if (zero? n)
            0
            (+ n ((f f) (- n 1)))))))
> ((foo foo) 100)
5050
```

La plia `lambda` estis bezonata ĉar oni bezonis havi manieron por abstrakti la rikuran
alvokon. Tiaokaze, oni uzis la identigilon `f` por kunligi la rikuran proceduron, kiu estas `foo`,
mem. La stranga `((f f) …)` estas bezonata, tial ke oni devas fari la saman proceduran alvokan
metodon uzata interne: `((foo foo) 100)`.


<a name="mem">Paŝo 3-a: Apliku la proceduron al si mem</a>
----------------------------------------------------------

Oni nun eluzas ĉi tiun kvaliton, por uzi sennomatan aliron—ne per la `foo` identigilo.

```scheme
> (((lambda (f)
      (lambda (n)
        (if (zero? n)
            0
            (+ n ((f f) (- n 1))))))
    (lambda (f)
      (lambda (n)
        (if (zero? n)
            0
            (+ n ((f f) (- n 1)))))))
   100)
5050
```

Konstatiĝu, ke nun, oni ne plu uzos la `foo` nomon por referenci la difinon, krom poste.


<a name="enan">Paŝo 4-a: Abstraktu la enan alvokon</a>
------------------------------------------------------

Sekve, oni bezonas movi la `(f f)` parton ekster, por izoli la ĝeneralan (ipsilonkombinatoro), el la
specifa (`foo`) kodo.

```scheme
> (((lambda (f)
      ((lambda (p)
         (lambda (n)
           (if (zero? n)
               0
               (+ n (p (- n 1))))))
       (lambda (v) ((f f) v))))
    (lambda (f)
      ((lambda (p)
         (lambda (n)
           (if (zero? n)
               0
               (+ n (p (- n 1))))))
       (lambda (v) ((f f) v)))))
   100)
5050
```

Dum la aplikaĵo de alvoko, la identigilo `p` estos kunligata al `(lambda (v) ((f f) v))`, kaj la
identigilo `v` estos kunligata al `(- n 1)`.



<a name="izoli">Paŝo 5-a: Izolu la kombinatoron</a>
---------------------------------------------------

Sekve, oni izolos la ipsilonan kombinatoron, el la `foo` proceduro.

```scheme
> (((lambda (x)
      ((lambda (f)
         (x (lambda (v) ((f f) v))))
       (lambda (f)
         (x (lambda (v) ((f f) v))))))
    (lambda (p)
      (lambda (n)
        (if (zero? n)
            0
            (+ n (p (- n 1)))))))
   100)
5050
```

Oni anstataŭigu la difinon specifa al `foo`, per `x`. Ĉi tio bezonas onin, denove, por krei la enhavatan
`lambda`. Tial ke `x` estas kunligata al la komputata proceduro, oni ne plu bezonas ripeti ĝin.



<a name="difini">Paŝo 6-a: Difinu la kombinatoron</a>
-----------------------------------------------------

Fine, oni eksplicite kreos apartan proceduran difinon por la ipsilonkombinatoro mem, kaj la `foo`
proceduro.

```scheme
> (define y
    (lambda (x)
      ((lambda (f)
         (x (lambda (v) ((f f) v))))
       (lambda (f)
         (x (lambda (v) ((f f) v)))))))
> (define foo
    (lambda (p)
      (lambda (n)
        (if (zero? n)
            0
            (+ n (p (- n 1)))))))
> (define f (y foo))
> (f 100)
5050
```


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Kiam la kernaj konceptoj estas komprenataj, estos facile por kapti la ŝajne malfacilegajn ideojn. Mi
esperas, ke ĉi tiu artikolo estas utila fari onin kompreni la ipsilonan kombinatoron,
funkcivokarigon, kaj proceduran aplikon.

_Dank’ al [Raymund Martinez](https://zhaqenl.github.io) pro la korektoj._
