La Ipsilonkombinatoro en Ses Paŝoj
==================================

<div class="center">Esperanto ▪ [English](/en/y/)</div>
<div class="center">la 25-an de Novembro 2017</div>
<div class="center">Laste ĝisdatigita: la 1-an de Februaro 2022</div>

>Unue, decidu. Kaj faru ĝin. Estas la nur maniero por atingi ion.<br>
>―Lacus Cʟʏɴᴇ, Gundam SEED Destiny

Multe da ni estis instruitaj ke, por difini rikuran proceduron, devas uzi la rikura alvoko la nomon
de la rikura proceduro. Tamen, ebligas la
[ipsilonkombinatoro](https://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator) (angla
artikolo) onin por presti rikuron, senreferenci la nomatan identigilon.


<a name="et">Enhavotabelo</a>
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
kiel surprizego kiam pasis oni la muron, sed ankaŭ igas nin skrapi niajn kapojn kiam ne senchavas
trairi la labirinton. Celas porti ĉi tiu artikolo miajn proprajn metodojn kiel derivi la ipsilonan
kombinatoron. Eble ne estas la plej eleganta maniero, tamen eblas funkcii por iu.

En la kodaj ekzemploj en ĉi tiu artikolo, montras la simbolo `>` la invitsimbolon de la skima
realigo.


<a name="baza">Paŝo 1-a: Difinu la bazan proceduron</a>
-------------------------------------------------------

Komencu ni per difini proceduron nomata `foo` kiu komputas la sumadon de pozitiva entjero, malsupren
al nulo. En la sekvanta kodaĵo, okazas la rikura alvoko kiam `foo` estas aplikata en la `else`-a
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

Rimarkis oni, ke difinis mi je `foo` per eksplicita `lambda`-esprimo. Vidos oni postnelonge kial.


<a name="funkcivokarigi">Paŝo 2-a: Funkcivokarigu la rikuran alvokon</a>
------------------------------------------------------------------------

Dismembrigu ni tiun proceduron pli detale per pli rudimentaj eroj, kaj aplikos oni ĝin per
funkcivokarigado (angle [currying](https://en.wikipedia.org/wiki/Currying)).

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

La plia `lambda`-esprimo estis bezonata ĉar bezonis havi oni manieron por abstrakti la rikuran
alvokon. Tiaokaze, uzis oni la identigilon `f` por kunligi la rikuran proceduron, kiu estas `foo`
mem. La stranga `((f f) …)`-esprimo estas bezonata tial, ke devas fari oni la saman proceduran
alvokan metodon uzata interne: `((foo foo) 100)`.


<a name="mem">Paŝo 3-a: Apliku la proceduron al si mem</a>
----------------------------------------------------------

Nun eluzas oni ĉi tiun kvaliton por uzi sennomatan aliron—ne per la identigilo `foo`.

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

Konstatiĝu, ke nun, ne plu uzos oni la nomon `foo` por referenci la difinon, krom poste.


<a name="enan">Paŝo 4-a: Abstraktu la enan alvokon</a>
------------------------------------------------------

Sekve, devas movi oni la parton `(f f)` eksteren por izoli la ĝeneralan (ipsilonkombinatoro), el la
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

Dum la aplikaĵo de alvoko, la identigilo `p` estos kunligata al `(lambda (v) ((f f) v))` kaj la
identigilo `v` estos kunligata al `(- n 1)`.



<a name="izoli">Paŝo 5-a: Izolu la kombinatoron</a>
---------------------------------------------------

Sekve, izolos oni la ipsilonan kombinatoron, el la `foo` proceduro.

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

Anstataŭigu oni la difinon specifa al `foo`, per `x`. Igas ĉi tio onin denove, por krei la enhavatan
`lambda`-esprimo tial, ke `x` estas kunligata al la komputata proceduro, ne plu devas ripeti oni
ĝin.



<a name="difini">Paŝo 6-a: Difinu la kombinatoron</a>
-----------------------------------------------------

Fine, kreos eksplicite oni apartan proceduran difinon por la ipsilonkombinatoro mem kaj la
proceduro `foo`.

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

Kiam la kernaj konceptoj estas komprenataj, estos facile por kapti la ŝajne malfacilegajn
konceptojn. Esperas mi, ke ĉi tiu artikolo estas utila por igi onin kompreni la ipsilonan
kombinatoron, funkcivokarigadon, kaj proceduran aplikon.

_Dank’ al [Raymund Mᴀʀᴛɪɴᴇᴢ](https://zhaqenl.github.io) pro la korektoj._
