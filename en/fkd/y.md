The Y Combinator in Six Steps
=============================

<div class="center">[Esperanto](/eo/ipsilono/) · English</div>
<div class="center">May 9, 2013</div>
<div class="center">Last updated: December 1, 2017</div>

>First, decide. And then do it. It’s the only way to achieve anything.<br>
>―Lacus Clyne, Gundam SEED Destiny

A lot of us have been taught that to be able to define a recursive procedure, the recursive
invocation must “use” the name of the recursive
procedure. The [Y combinator](https://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator) ,
however, lets you perform recursion, without referring to the named identifier.


Table of contents
-----------------

- [Y?](#y)
- [Step 1: Define the base procedure](#base)
- [Step 2: Curry the recursive call](#curry)
- [Step 3: Apply procedure to itself](#self)
- [Step 4: Abstract inner recursive call](#abstractinner)
- [Step 5: Isolate the combinator](#isolate)
- [Step 6: Define the combinator](#define)
- [Closing remarks](#closing)


<a name="y"></a> Y?
-----------------------

The Y combinator has been both a source of inspiration and frustration for many. It evokes a
eureka-like sensation once you get past the wall, but it also renders us scratching our heads when
it just doesn’t make sense to traverse the labyrinth. This post aims to bring my own approach on how
to derive the Y combinator. It may not be the most elegant way, but it may work for you.

In the code examples in this post, the `>` symbol denotes the prompt symbol for your Scheme
implementation.


<a name="base"></a> Step 1: Define the base procedure
-----------------------------------------------------

Let’s start by defining a procedure named `foo` that computes the summation of a positive integer,
down to zero. In the following snippet, the recursive call happens when `foo` is applied in the else
part of the condition.

```scheme
> (define foo
    (lambda (n)
      (if (zero? n)
          0
          (+ n (foo (- n 1))))))
> (foo 100)
5050
```

You have observed that I have defined `foo` using an explicit `lambda`. You’ll see shortly,
why.



<a name="curry"></a> Step 2: Curry the recursive call
-----------------------------------------------------

Let’s break that procedure further, into more elementary components, and you’ll apply it,
using [currying](https://en.wikipedia.org/wiki/Currying).

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

The extra `lambda` was needed because you needed to have a way to abstract the recursive
procedure. In this case, you used the identifier `f` to bind to the recursive procedure, which is
`foo`, itself. The weird-looking `((f f) …)` is needed, because you have to perform the same
procedure invocation method used initially: `((foo foo) 100)`.


<a name="self"></a> Step 3: Apply procedure to itself
-----------------------------------------------------

You’re now going to exploit that property, to use a “nameless” approach—not using the `foo`
identifier.

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

Take note, that at this point, you’re no longer using the `foo` name,
to refer the definition, except for later.


<a name="abstractinner"></a> Step 4: Abstract inner recursive call
------------------------------------------------------------------

Next, you need to move the `(f f)` part outside, to isolate the general (Y combinator), from the
specific (`foo`) code.

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

During the procedure application, the identifier `p` will be bound to `(lambda (v) ((f f) v))`, and
the identifier `v` will be bound to `(- n 1)`.


<a name="isolate"></a> Step 5: Isolate the combinator
-----------------------------------------------------

Next, you’re going to isolate the Y combinator, from the `foo` procedure.

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

You replace the `foo`-specific definition with `x`. This requires you, again, to create an enveloping
`lambda`. Since `x` is bound to the computing procedure, you no longer need to repeat it.


<a name="define"></a> Step 6: Define the combinator
---------------------------------------------------

Finally, you will explicitly create a separate procedure definition for the Y combinator itself, and
the `foo` procedure.

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


<a name="closing"></a> Closing remarks
--------------------------------------

When the key concepts are understood, it becomes easy to grasp the seemingly daunting ideas. I hope
this post has been useful in making you understand the Y combinator, currying, and procedure
application.
