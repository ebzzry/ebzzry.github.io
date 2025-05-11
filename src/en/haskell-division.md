---
title: Division in Haskell
keywords: haskell, division
image: https://ebzzry.com/images/site/josh-withers-VyOUw5byHlc-unsplash-1008x250.jpg
---
Division in Haskell
===================

<div class="center">English ∅ [Esperanto](/eo/haskeldivido/)</div>
<div class="center">Wed Mar 8 12:51:14 2017 +0800</div>

>But every decision for something is a decision against something else.<br>
>—H. G. Tannhaus, Dark (2017)

<img src="/images/site/josh-withers-VyOUw5byHlc-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="david-becker-crs2vlkSe98-unsplash-1008x250.jpg" title="david-becker-crs2vlkSe98-unsplash-1008x250.jpg"/>

While learning about division in Haskell, I realized that the concept is not as trivial as I
initially wanted it to be. There are subtle differences between the functions that can easily trip
someone who’s not aware of them. `quot` performs integer division that rounds towards zero. `div` is
like `quot`, but it rounds below zero—negative infinity. `rem` returns the remainder of a
division. `mod`, on the other hand, performs modular arithmetic.

In the GHCi interaction below, `quotRem` returns a tuple of the application of `quot` and `rem` to its
arguments, while `divMod` returns a tuple of the application `div` and `mod` to its arguments.

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

Giving special attention to negative numbers, here are some observations about it:

- `quotRem` and `divMod` behave the same, if all the arguments are positive.

- `quot` returns `0`, if the dividend is less than the divisor.

- `rem` follows the sign of the dividend.

- `rem` returns the dividend, if the dividend is less than the divisor.

- `div` rounds off the divisor to the negative infinity, if either the dividend
  or divisor is negative.

- `mod` follows the sign of the divisor.

- `div` returns `0`, if the dividend is less than the divisor, and both
  arguments are positive.

- `mod` returns the dividend, if the dividend is less than the divisor, and both
  arguments are positive.

- `div` returns `-1` if the dividend is negative, and its absolute value is less
  than the divisor.

- `quot` and `div` returns `0` if the dividend is `0`, and the divisor is not
  zero.

- `mod` returns the difference of the absolute values of the dividend and the
  divisor, following the sign of the divisor, if either the dividend or the
  divisor is negative, and if the absolute of the dividend is less than the
  absolute value of the divisor.

- If either the dividend or divisor of `mod` is a negative, and that the
  absolute value of the dividend is larger than the abvolute value of the
  divisor, `mod` returns a value such that when this value is added to the
  result of the `div` of the dividend and divisor, multiplied by the divisor, it
  returns the dividend of `mod`. That is:
```haskell
x == (x `mod` y) + (x `div` y) * y
```
So if `x = (-13)` and `y = 5`, then
```haskell
(-13) == ((-13) `mod` 5) + ((-13) `div` 5) * 5
```
evaluates to `True`.
