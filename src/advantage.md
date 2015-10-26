A Better Kinesis Advantage Layout
======================================================================

<center>Monday, October 26 2015</center>

One of the best investments a programmer can have is a good
keyboard. What constitutes a good keyboard, however, can sometimes be
a subject of debates. A common item that persists most lists is that
it has be ergonomic. I add to that list an important quality:
speed. No matter how ergonomic a keyboard is, if it falls on the speed
category. It has to be comfortable, and speedy.

The
[Kinesis Advantage](http://www.kinesis-ergo.com/shop/advantage-for-pc-mac/)
is the epitome of such a criteria. It is ergonomic, and it is fast. If
you are already proficient typist, you'll find that after the small
adjustment period, you'll type even faster with the Advantage. The
default layout of the keys, however, turns me off. The <kbd>Ctrl</kbd>
and <kbd>Alt</kbd> keys are too far to reach. This is important for
users of software like Emacs, and shells like Zsh and Bash.

By default, the Advantage is set to QWERTY (US). I use Dvorak, so I
would have something like

```
setxkbmap dvorak
```

somewhere in my config. After that, the layout would look like the
following:

```
Legend

ES Escape
TA Tab
CL Caps Lock
SH Shift
CT Ctrl
AL Alt
BS Backspace
DE Delete
HO Home
ED End
PU Page Up
PD Page Down
EN Enter
SP Space
```

```
Original Software Dvorak

ES
]} 1! 2@ 3# 4$ 5%   6^ 7& 8* 9( 0) [{
TA '" ,< .> pP yY   fF gG cC rR lL \|
CL aA oO eE uU iI   dD hH tT nN sS -_
SH ;: qQ jJ kK xX   bB mM wW vV zZ SH
   `~ <> LE RI         UP DO /? =+

            CT AL   AL CT
         BS DE HO   PU EN SP
               ED   PD
```

Horrible.

Using that layout on Emacs, or shell, is painful to the hands, especially on prolonged periods. To press <kbd>M-x</kbd>, one would have to press the <kbd>Alt</kbd> key with the right thumb, then the <kbd>x</kbd> key with the left index finger. Reaching out for the <kbd>Escape</kbd> keys isn't a lot of fun, either, because the current model of the Advantage have that squishy rubber button in place, which sometimes registers as a double press. (The new Advantage 2 fixed this by using mechanical keys for the topmost row).

I remapped some of the keys, to fit my workflow. The new layout is as follows. The mapping is initiated by pressing <kbd>Progrm + F12</kbd>. Please check with the manual for other remapping-related information.


```
Remapped Software Dvorak

IN
`~ 1! 2@ 3# 4$ 5%   6^ 7& 8* 9( 0) \|
TA '" ,< .> pP yY   fF gG cC rR lL /?
CL aA oO eE uU iI   dD hH tT nN sS -_
SH ;: qQ jJ kK xX   bB mM wW vV zZ SH
   CT AL UP DN         LE RI AL CT

            [{ ES   =+ ]}
         BS DE PU   HO EN SP
               PD   ED
```

I used <kbd>Insert</kbd> in lieu of <kbd>Escape</kbd>, so that I can
easily access the `XA_PRIMARY` selection using <kbd>Shift +
Insert</kbd>. The `XA_PRIMARY` selection is where your mouse
highlights go. It also makes it easy to enter Emacs'
`overwrite-mode`. The <kbd>Insert</kbd> key, however, is buried in the
key physically marked with `|`, on the left side. To access it inside
remapping mode, press:

```
Keypad, Insert, Keypad, Esc
```

The new location of <kbd>Ctrl</kbd> and <kbd>Alt</kbd> makes it easy
for the fingers to reach them. I swapped the location of <kbd>Up</kbd>
and <kbd>Down</kbd> with <kbd>Left</kbd> and <kbd>Right</kbd>. I
wanted to be able to scroll through a webpage without having to use my
right hand with the mouse wheel. The sample applies with <kbd>Page
Up</kbd> and <kbd>Page Down</kbd>.

One of my favorites is the new location of the
<kbd>[</kbd> and <kbd>]</kbd> keys. They are used, a lot, in the major
languages used today.
