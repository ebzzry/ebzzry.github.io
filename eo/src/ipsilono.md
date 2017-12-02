La Ipsilona Kombinatoro En Ses Paŝoj
====================================

<center>[Esperante](/eo/ipsilono)  [Angle](/en/y)</center>
<center>25a de Novembro 2017</center>
<center>Laste ŝanĝita: 1a de Decembro 2017</center>

>Unue, decidu. Kaj faru ĝin. Estas la nur maniero por atingi ion.<br>
>―Lacus CLYNE, Gundam SEED Destiny

Multe da ni estis instruitaj ke, por difini rikuran proceduron, la rikura alvoko devas uzi la
nomon de la rikuran proceduron. La
[ipsilona kombinatoro (angle)](https://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator), tamen,
permesas onin por presti rikuron, sen referenci la nomatan identigilon.


Enhavotabelo
------------

- [Kio?](#kio)
- [Paŝo 1a: Difinu la bazan proceduron](#baza)
- [Paŝo 2a: Funkcivokarigu la rikuran alvokon](#funkcivokarigi)
- [Paŝo 3a: Apliku la proceduron al si mem](#mem)
- [Paŝo 4a: Abstraktu la enan alvokon](#enan)
- [Paŝo 5a: Izolu la kombinatoron](#izoli)
- [Paŝo 6a: Difinu la kombinatoron](#difini)
- [Finaj rimarkoj](#finaj)


<a name="kio">Kio?</a>
----------------------

La ipsilona kombinatoro estas la fonto de kaj inspiro kaj frustro de multaj homoj. Elvokas sensacion
kiel eŭreka tuj oni pasis la muron, sed ankaŭ faras nin por skrapi niajn kapojn kiam ne faras sencon
por trairi la labirinton. Ĉi tiu artikolo celas porti miajn proprajn metodojn kiel derivi la ipsilonan
kombinatoron. Eble ne estas la plej eleganta maniero, tamen eblas fari  por vi.

En la kodaj ekzemploj en ĉi tiu artikolo, la `>` simbolo montras la invitan simbolon de via skima
realigo.


<a name="baza">Paŝo 1a: Difinu la bazan proceduron</a>
------------------------------------------------------

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

Vi rimarkis, ke mi difinis `foo` per eksplicita `lambda`. Vi vidos postnelonge kial.



<a name="funkcivokarigi">Paŝo 2a: Funkcivokarigu la rikuran alvokon</a>
-----------------------------------------------------------------------

Ni dismembrigu tiun proceduron pli detale, per pli rudimentaj eroj, kaj vi aplikos ĝin, per
funkcivokarigi (angle currying).

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

La plia `lambda` estis bezonata ĉar vi bezonis havi manieron por abstrakti la rikuran
alvokon. Tiaokaze, vi uzis la identigilon `f` por kunligi la rikuran proceduron, kiu estas `foo`,
mem. La stranga `((f f) …)` estas bezonata, tial ke vi devas fari la saman proceduran alvokan
metodon uzata interne: `((foo foo) 100)`.


<a name="mem">Paŝo 3a: Apliku la proceduron al si mem</a>
---------------------------------------------------------

Vi nun estas troprofitonta ĉi tiun kvaliton, por uzi sennomatan aliro—ne per la `foo` identigilo.

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

Konstatu, ke nun, vi ne plu uzos la `foo` nomon por referenci la difinon, krom poste.


<a name="enan">Paŝo 4a: Abstraktu la enan alvokon</a>
------------------------------------------------------

Sekve, vi bezonas movi la `(f f)` parton ekster, por izoli la ĝeneralan (ipsilona kombinatoro), el la
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



<a name="izoli">Paŝo 5a: Izolu la kombinatoron</a>
--------------------------------------------------

Sekve, vi izolos la ipsilonan kombinatoro, el la `foo` proceduro.

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

Vi anstataŭigu la difinon specifa al `foo`, per `x`. Ĉi tio bezonas vin, denove, por krei la enhavatan
`lambda`. Tial ke `x` estas kunligata al la komputata proceduro, vi ne plu bezonas ripeti ĝin.



<a name="difini">Paŝo 6a: Difinu la kombinatoron</a>
----------------------------------------------------

Fine, vi eksplicite kreos apartan proceduran difinon por la ipsilona kombinatoro mem, kaj la `foo`
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


<a name="finaj">Finaj rimarkoj</a>
----------------------------------------

Kiam la kurtaj konceptoj estas komprenata, estos facila por kapti la ŝajne malfacilegajn ideojn. Mi
esperas, ke ĉi tiu artikolo estas utila por fari vin kompreni la ipsilonan kombinatoron, funkcivokarigi,
kaj proceduran aplikon.
