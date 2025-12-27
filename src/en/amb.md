---
title: A Gentle Introduction to Non-determinism in Scheme
keywords: non-determinism, scheme, lisp, current continuation, continuation, call/cc, amb, choice, choose 
image: https://ebzzry.com/images/site/john-towner-JgOeRuGD_Y4-unsplash-2000x1125.jpg
---
A Gentle Introduction to Non-determinism in Scheme
==================================================

<div class="center">English ⊻ [Esperanto](/eo/amb/)</div>
<div class="center">2019-03-08</div>

>Some of the most crucial steps in mental growth are based not simply on acquiring new skills, but
>on acquiring new administrative ways to use what one already knows.<br>
>—Marvin Minsky

<img src="/images/site/john-towner-JgOeRuGD_Y4-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [The current continuation](#cc)
  + [Examples](#ccexamples)
- [The call/cc operator](#callcc)
  + [Capturing](#callcccapturing)
  + [Application](#callccapplication)
  + [Escaping](#callccescaping)
  + [Examples](#callccexamples)
- [The amb operator](#amb)
  + [Definition](#ambdefinition)
  + [Deconstruction](#ambdeconstruction)
  + [Evaluation](#ambevaluation)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

Nondeterministic programming is a technique wherein the flow of an algorithm is not linear, and
there exists multiple possible continuations. The behavior of a computation can also change with the
same inputs. There are several methods to achieve nondeterminism. In this article the method that
I’ll use is backtracking.

Additionally, I’ll use [Scheme](https://goo.gl/zAHR9A) to do it. In Scheme, you are permitted to go
back in an early computation and back, later, with ease.

I will also discuss the prerequisite topics to make nondeterminism in Scheme easier to understand.

In this article, I’ll be using the symbol `λ` for `lambda`. If you can’t type that symbol, you may use `lambda`, instead.


<a name="cc">The current continuation</a>
-----------------------------------------

In Scheme, the current continuation or the remaining computation is the remaining work to evaluate
the rest of the computation.

In the expression

```scheme
0
```

the current continuation—the remaining computation—is

```scheme
(λ (v) v)
```

and the remaining operation is

```scheme
((λ (v) v) 0)
```

which returns

```scheme
0
```

That is the result because the remaining computation on that level—the top-level—is the identity
function.

Bear in mind, that the name of the argument of the lambda is not important. It can be `v`, `x`, or
`dog-cat-mouse`:

```scheme
((λ (dog-cat-mouse) dog-cat-mouse) 0)
```


### <a name="ccexamples">Examples</a>

In the expression

```scheme
(* 1 2)
```

the remaining computation for `2`—the second argument of `*`—is

```scheme
(λ (v) (* 1 v))
```

and the remaining operation is

```scheme
((λ (v) (* 1 v)) 2)
```

which, in that level of computation returns

```scheme
2
```

Consequently, the remaining computation is

```scheme
(λ (v) v)
```

and the remaining operation is

```scheme
((λ (v) v) 2)
```

which finally returns, at the top-level:

```scheme
2
```

In the expression

```scheme
(+ (* 1 2) 3)
```

the flow of the computation is

```scheme
   (* 1 2)
(+         3)
```

Firstly, `(* 1 2)` will be evaluated then the result becomes the first argument for `(+   3)`. In
that empty space, the remaining computation is

```scheme
(λ (v) (+ v 3))
```

and the remaining operation is

```scheme
((λ (v) (+ v 3)) (* 1 2))
```


<a name="callcc">The call/cc operator</a>
-----------------------------------------


In Scheme, you can capture the current continuation—the next computation—as a variable. You can do
that with [call/cc](https://scheme.com/tspl4/further.html#./further:h3). It is an operator which
accepts only one argument exclusively—a [lambda](/en/lambda-calculus/)—an anonymous function, with
one argument:

```scheme
(call/cc (λ (k) k))
```

If you don’t have `call/cc` define it with:

```scheme
(define call/cc call-with-current-continuation)
```

The phrase _call with current continuation_ can also be treated as _call with next computation_. The
function that it calls is the lambda. Additionally, `call/cc` passes the current continuation—the
next computation—to that anonymous function.

In this lambda:

```scheme
(λ (k) k)
```

`k` is a function itself which accepts one argument. So, in

```scheme
(call/cc (λ (k) k))
```

`call/cc` returns the current continuation—simply the function. However, in

```scheme
(call/cc (λ (k) (k 0)))
```

`call/cc` simply returns `0` because in that level—the top-level—`k` is

```scheme
(λ (v) v)
```

—the identity function. Because of that, the function

```scheme
(call/cc (λ (k) (k 0)))
```

is functionally equivalent to

```scheme
((λ (v) v) 0)
```


### <a name="callcccapturing">Capturing</a>

Going back to the earlier example:

```scheme
(+ (* 1 2) 3)
```

you can capture the current continuation of `(* 1 2)`  with `call/cc`:

```scheme
(+ (call/cc (λ (k) (* 1 2))) 3)
```

However, you may notice that you did not apply the function `k` to anything. The expression
`(* 1 2)` is evaluated, then the result goes to `(+ _ 3)`. In other words, that expression is
functionally equivalent to:

```scheme
(+ (* 1 2) 3)
```


### <a name="callccapplication">Application</a>

Using the same example, let’s apply the function `k`:

```scheme
(+ (call/cc (λ (k) (k (* 1 2)))) 3)
```

Inside the call of `call/cc`:

```scheme
            (λ (k) (k (* 1 2)))
```

the variable `k` is the current continuation—the remaining computation. What is the remaining
computation? This:

```scheme
(+                               3)
```

the addition to `3`. In order to represent that computation as function, it becomes:

```scheme
(λ (v) (+ v 3))
```

Wherein `(+ _ 3)` is going to be represented by this lambda.

So, the role of `call/cc` is to call a lambda, which accepts the remaining computation. Here, the
remaining computation is called `k`. Because of that, the consequence of:

```scheme
(+ (call/cc (λ (k) (k (* 1 2)))) 3)
```

is functionally equivalent to

```scheme
((λ (v) (+ v 3)) (* 1 2))
```


### <a name="callccescaping">Escaping</a>

In

```scheme
(define z #f)
(+ (call/cc (λ (k) (set! z k) (* 1 2))) 3)
```

normally the result is

```scheme
5
```

however, because we saved the current continuation—`k`—in `z`, we can return to that saved location
with:

```scheme
(z 1)
```

which returns

```scheme
4
```

—another value. That mechanisms gives us the capability to escape computations, whether with a new
value, an old value, or nothing.

For the reason that the current continuation is:

```scheme
(λ (v) (+ v 3))
```

the call

```scheme
(z 1)
```

is functionally equivalent to

```scheme
((λ (v) (+ v 3)) 1)
```

instead of

```scheme
((λ (v) (+ v 3)) (* 1 2))
```


### <a name="callccexamples">Examples</a>

In

```scheme
(let ((x (call/cc (λ (k) k)))) (x (λ (o) "hi")))
```

the call

```scheme
(x (λ (o) "hi"))
```

becomes

```scheme
((call/cc (λ (k) k)) (λ (o) "hi"))
```

there, the remaining computation is

```scheme
(λ (o) "hi")
```

which goes to the variable `k` in the body of `call/cc`. Like earlier, we apply `k` to
`(λ (o) "hi")` inside another lambda:

```scheme
((λ (v) (v (λ (o) "hi"))) (λ (o) "hi"))
```

which returns

```scheme
"hi"
```

In

```scheme
(((call/cc (λ (k) k)) (λ (x) x)) "hi")
```

the key is

```scheme
((call/cc (λ (k) k)) (λ (x) x))
```

In the body of `call/cc`, the remaining computation is

```scheme
(λ (x) x)
```

which goes to the variable `k` in the body of `call/cc`. Like earlier again, we apply it to the
lambda:

```scheme
((λ (v) (v (λ (x) x))) (λ (x) x))
```

which returns

```scheme
#<procedure x>
```

It means, that you can now apply this function to the remaining argument:

```scheme
(((λ (v) (v (λ (x) x))) (λ (x) x)) "hi")
```

which returns

```scheme
"hi"
```


<a name="amb">The amb operator</a>
----------------------------------

One of the uses of the famous amb operator in Scheme is to implement non-deterministic programming
by means of backtracking. With that mechanism, the computation can go to an earlier state; carry
computations; change change; escape computations; and more.

In this article we’re going to use the amb operator to enable the backtracking mechanism.


### <a name="ambdefinition">Definition</a>

The definition that we’ll use is the one by shido.info/lisp. It is a macro to
ensure that the arguments are not evaluated. Additionally, it uses lists
internally.

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
        (λ (k)                                  ; 12
          (set! f (λ ()                         ; 13
                    (set! f s)                  ; 14
                    (k (amb b ...))))           ; 15
          (k a)))))))                           ; 16
                                                ; 17
(define (really? x y)                           ; 18
  (if (equal? x y)                              ; 19
      (list x y)                                ; 20
      (amb)))                                   ; 21
                                                ; 22
(call/cc                                        ; 23
 (λ (k)                                         ; 24
   (set! f (λ ()                                ; 25
             (k 'no-choices)))))                ; 26
```

These definitions work on [MIT/GNU Scheme](https://www.gnu.org/software/mit-scheme/),
[Guile](https://www.gnu.org/software/guile/), [Scheme48](http://s48.org/),
[Scsh](https://scsh.net/), [chibi-scheme](http://synthcode.com/wiki/chibi-scheme),
[Gerbil](https://cons.io/), [Chez Scheme](https://www.scheme.com/), [Chicken](http://call-cc.org/),
[Bigloo](https://www-sop.inria.fr/indes/fp/Bigloo/),
[Gauche](https://practical-scheme.net/gauche/memo.html), and [Racket](https://racket-lang.org/).


### <a name="ambdeconstruction">Deconstruction</a>

In this section, we are going to deconstruct the definitions of the amb operator and other
functions. The function `really?` technically is not part of the definition, however, we’ll
use it to demonstrate the functionality of `amb`.

Here are superficial steps of the definitions:

1. In line 1 `call/cc` is bound to `call-with-current-continuation` mainly for implementations which
   doesn’t have that definition.

2. In line 3 `f` is bound to a default value.

3. In lines 5 to 16 is the body of `amb`.

4. In lines 18 to 21 is an example function: if `x` and `y` are equal, it returns a list; if not,
   `amb` is called.

5. In lines 23 to 26, `call/cc` is called, in which the true initial value of `f` is initialized
   with a lambda which returns `'no-choices`.

6. Let’s go back to the body of `amb` in lines 5 to 16. In line 7, if `amb` is called as such:
```scheme
(amb)
```
the function `f` is called, with whatever that `f` can do.

7. In line 8, if `amb` is called as such:
```scheme
(amb "dog")
```
the argument `"dog"` is simply returned.

8. However, with more than one arguments, the behavior of `amb` changes. Firstly, in line 10, the
   current value of `f` is bound to `s`, next in line 11, `call/cc` is called, capturing the current
   continuation to `k`.

9. Inside the body of the lambda, the global variable `f` will have a new value—another lambda—which
   will not be evaluated until it is explicitly requested. In that body, `f` will have the earlier
   value of `s`, then `k` will be called with the value `b ...`, which are the remaining arguments
   for `amb`.

10. Lastly, the `k` function—the remaining computation—will be applied to the value `a`.


### <a name="ambevaluation">Evaluation</a>

Using `really?` we will watch the evaluation steps in the use of `amb`. If we have the
following expression,

```scheme
(really? (amb "dog" "cat" 9) (amb "mouse" 9))
```

here are the simplified evaluation steps:

1. `(amb "dog" "cat" 9)` will be evaluated;

2. For the reason that more than one argument is passed to `amb` let’s go to line 9;

3. The local variable `s` will have the current value of `f` in the top-level:
```scheme
(λ () (k 'no-choices))
```
4. The lambda in line 12 will be called with the remaining computation to `k`;

5. In line 13 `f` will have a new value. The value will be a lambda;

6. When the lambda is called, `k` again will have the value of `s`, which is the lambda in step 3.

7. `k` will be applied to `a`, wherein, `(k a)` is:
```scheme
((λ (v) (really? v (amb "mouse" 9))) "dog")
```
which consequently becomes
```scheme
((λ (v) ((λ (w) (really? v w)) "dog")) "mouse")
```
because of the call `(amb "mouse" 9)`;

8. Because `"dog"` is not equal to `"mouse"` the `amb` operator will be called like:
```scheme
(amb)
```

9. Because `(amb)` doesn’t have arguments, the expression in line 7 happens;
```scheme
(f)
```
wherein the value of `k` is the lambda in lines 13 to 15. The value of `f` again becomes:
```scheme
(λ () (k 'no-choices))
```

10. Then, in line 15 `k` will be called like `(k "cat" 9)`.

11. The steps will be repeated, calling `really?` many times. The steps will look like:
```scheme
(really? "dog" "mouse")
(really? "dog" 9)
(really? "cat" "mouse")
(really? "cat" 9)
(really? 9 "mouse")
(really? 9 9)
```

12. Because `9` is equal to `9`, the expression
```scheme
(list 9 9)
```
will be evaluated in the body of `really?` which finally returns
```
'(9 9)
```


<a name="closing">Closing remarks</a>
-------------------------------------

In this article, we noticed that with `call/cc` we have easily achieved non-determinism through
backtracking with `amb` and basic Scheme functions. However, there are more elaborate and better
methods of achieving this.

The type of continuations that we dealt with is the
[non-delimited continuation](https://en.wikipedia.org/wiki/Continuation) in contrast with a
[delimited continuation](https://en.wikipedia.org/wiki/Delimited_continuation). I must also mention,
that there’s an [argument](http://okmij.org/ftp/continuations/against-callcc.html) against the use
of `call/cc`.

Anyway, I hope that you learned something good from this post.
