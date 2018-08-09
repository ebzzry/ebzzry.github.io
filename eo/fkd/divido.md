Divido en Haskelo
=================

<div class="center">[Esperante](#) · [English](/en/division)</div>
<div class="center">la 5-an de aŭgusto 2018</div>
<div class="center">Laste ĝisdatigita: la 8-an de aŭgusto 2018</div>

Kiam lerni pri divido en Haskelo, mi konsciis, ke la koncepto ne estas kiel bagatela tiel ĝin mi
komence volis. Ekzistas subtilaj kontrastoj inter la funkcioj kiu iun povas facile faligi ki ne
estas konscias de ili. Entjeran dividon kiu rondigas al nulo `quot` faras. `div` similas al `quot`,
tamen ĝi rondigas sub nulo—negativa senfineco. La reston de divido `rem` liveras. `mod`, aliflanke,
modulan aritmetikon faras.

En la «GHCi»-a interago ĉi-supre, la opon de la apliko de `quot` kaj `rem` al iliaj argumentoj
`quotRem` liveras, dum la opon de la apliko de `div` kaj `mod` al iliaj argumentoj `divMod` liveras.

```
Prelude> quotRem 13 5
(2,3)
Prelude> quotRem (-13) 5
(-2,-3)
Prelude> quotRem 13 (-5)
(-2,3)
Prelude> quotRem 5 13
(0,5)
Prelude> quotRem (-5) 13
(0,-5)
Prelude> quotRem 5 (-13)
(0,5)
Prelude> divMod 13 5
(2,3)
Prelude> divMod (-13) 5
(-3,2)
Prelude> divMod 13 (-5)
(-3,-2)
Prelude> divMod 5 13
(0,5)
Prelude> divMod (-5) 13
(-1,8)
Prelude> divMod 5 (-13)
(-1,-8)
```

Apartan atenton al negativaj nombroj donante, jen kelkaj rimarkoj pri ĝi:

- `quotRem` kaj `divMod` kondutas same se ĉiom da argumentoj pozitivas.

- `quot` liveras `0`, se la dividato estas malpli ol la dividanto.

- `rem` sekvas la signon de la dividato.

- `rem` liveras la dividato, se la dividato estas malpli ol la dividanto.

- `div` rondigas la dividanton al negative senfineco, se aŭ la dividato aŭ la dividanto negativas.

- `mod` sekvas la signon de la dividanto.

- `div` liveras `0`, se la dividato estas malpli ol la dividanto, kaj ambaŭ argumentoj estas
  pozitivaj.

- `mod` liveras la dividaton, se la dividato estas malpli ol la dividanto, kaj ambaŭ argumentoj estas
  pozitivaj.

- `div` liveras `-1` se la dividato negativas, kaj ĝia absoluta valoro estas malpli ol la
  dividanto.

- `quot` kaj `div` liveras `0` se la dividato estas `0`, kaj la dividanto ne estas nulo.

- `mod` liveras la diferencon de la absolutaj valoroj de la dividanto kaj la dividato, sekvante la
  signon de la dividanto, se aŭ la dividanto aŭ la dividato negativas.
