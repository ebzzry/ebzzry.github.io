Divido en Haskelo
=================

<div class="center">Esperanto ◆ [English](/en/haskell-division/)</div>
<div class="center">Laste ĝisdatigita: la 22-an de Majo 2019</div>

Lernante pri divido en Haskelo, mi konsciis, ke la koncepto ne estas tiel bagatele kiel ĝin mi
komence volis. Estas subtilaj kontrastoj inter la funkcioj kiuj oni povas facile faligi kiu ne
estas konscias de ili. Entjeran dividon kiu rondigas al nulo `quot` faras. `div` similas al `quot`,
tamen ĝi rondigas sub nulo—negativa senfineco. La reston de divido `rem` liveras. `mod`, aliflanke,
modulan aritmetikon faras.

En la «GHCi»-interago ĉi-supre, la opon de la apliko de `quot` kaj `rem` al iliaj argumentoj
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

- `mod` liveras la diferencon de la absolutaj valoroj de la dividato kaj la
  dividanto, sekvante la signon de la dividanto, se aŭ la dividato aŭ la
  dividanto negativas, kaj se la absoluta valoro de la dividato estas malpli ol
  la absoluta valoro de la dividanto.

- Se aŭ la dividato aŭ la dividanto de `mod` negativas, kaj la absoluta valoro
  de la dividato estas pli ol la absoluta valoro de la dividanto, `mod` liveras
  valoron tiel, ke kiam ĉi tiu valoro estas adiciita al la rezulto de la `div`
  de la dividato kaj la dividanto, multiplikite per la dividanto, ĝi liveras la
  dividaton de `mod`. Tio estas:
```haskell
x == (x `mod` y) + (x `div` y) * y
```
Do, se `x = (-13)` kaj `y = 5`, tiam
```haskell
(-13) == ((-13) `mod` 5) + ((-13) `div` 5) * 5
```
taksas al `True`.
