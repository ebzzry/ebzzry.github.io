#lang scribble/manual

Title: The Y Combinator in Six Easy Steps
Date: 2013-05-09T12:43:11
Tags: racket, programming

A lot of us have been taught that to be able to define a recursive procedure,
the recursive invocation must "use" the name of the recursive procedure. The
@hyperlink["http://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator"
"Y combinator"], however, lets us perform recursion, without referring to the
named identifier.

The Y combinator has been both a source of inspiration and frustration
for many. It evokes a eureka-like sensation once you get past the
wall, but it also renders us scratching our heads when it just doesn't
make sense to traverse the labyrinth. This post aims to bring my own
approach on how to derive the Y combinator. It may not be the most
elegant way, but it may work for you.

<!-- more -->

In the code examples in this post, the @code{>} symbol denotes the prompt
symbol for your Scheme implementation.

Let's start by defining a procedure named @code{sum0} that computes the
@hyperlink["http://en.wikipedia.org/wiki/Summation" "summation"] of a positive
integer, down to zero. In the following snippet, the recursive call happens
when @code{sum0} is applied in the else part of the condition.

@codeblock{
> (define sum0
    (lambda (n)
      (if (zero? n)
          0
          (+ n (sum0 (- n 1))))))
> (sum0 100)
5050
}

You have have observed that I have defined @code{sum0} using an explicit
@code{lambda}. You'll see shortly, why.

Let's break that procedure futher, into more elementary components,
and we'll apply it, using
@hyperlink["https://en.wikipedia.org/wiki/Currying" "currying"].

@codeblock{
> (define sum0
    (lambda (f)
      (lambda (n)
        (if (zero? n)
            0
            (+ n ((f f) (- n 1)))))))
> ((sum0 sum0) 100)
5050
}

The extra @code{lambda} was needed because we needed to have a way to
"anonymize" the recursive procedure. In this case, we used the
identifier @code{f} to bind to the recursive procedure, which is @code{sum0},
itself. The weird-looking @code{((f f) ...)} is needed, because we have to
perform the same procedure invocation method used initially: @code{((sum0 sum0) 100)}.

We're now going to exploit that property, to use a "nameless"
approach, that is, without using the @code{sum0} name.

@codeblock{
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
}

Take note, that at this point, we're no longer using the @code{sum0} name,
to refer the the definition, except for later.

Next, we need to move the @code{(f f)} part outside, to isolate the general
(Y combinator), from the specific (@code{sum0}) code.

@codeblock{
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
}

During the procedure application, the identifier @code{p} will be bound to
@code{(lambda (v) ((f f) v))}, and the identifier @code{v} will be bound to @code{(-
n 1)}.

Finally, we're going to isolate the Y combinator, from the @code{sum0}
procedure.

@codeblock{
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
}

We replace the @code{sum0}-specific definition with @code{x}. This requires us
again, to create an enveloping @code{lambda}. Since @code{x} is bound to the
computing procedure, we no longer need to repeat it.

Optionally, we can explicitly create separate procedure definitions for
the Y combinator itself, and the @code{sum0} procedure.

@codeblock{
> (define y
    (lambda (x)
      ((lambda (f)
         (x (lambda (v) ((f f) v))))
       (lambda (f)
         (x (lambda (v) ((f f) v)))))))
> (define %sum0
    (lambda (p)
      (lambda (n)
        (if (zero? n)
            0
            (+ n (p (- n 1)))))))
> (define sum0 (y %sum0))
> (sum0 100)
5050
}

I hope this post has been useful in making you understand the
Y combinator, currying, and procedure application. Please post your
comments and suggestions, below. <-:

