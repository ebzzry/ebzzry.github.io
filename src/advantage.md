A Better Kinesis Advantage Layout
=================================

<center>October, 26 2015</center>
<center>February 21, 2016</center>

<img src="images/advantage.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Advantage" title="Advantage"/>

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

In this post, we'll use the following legend:

```
ES Escape
TA Tab
CL Caps lock
SL Scroll lock
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

When using Dvorak emulation, the following is how the keys are mapped:

```
Original Software Dvorak

ES F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 PS SL PB
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

Using that layout on Emacs, or shell, is painful to the hands, especially on prolonged periods. To press <kbd>M-x</kbd>, one would have to press the <kbd>Alt</kbd> key with the right thumb, then the <kbd>x</kbd> key with the left index finger. Reaching out for the <kbd>Esc</kbd> keys isn't a lot of fun, either, because the current model of the Advantage have that squishy rubber button in place, which sometimes registers as a double press.

I remapped some of the keys, to fit my workflow. The new layout is as follows. The mapping is initiated by pressing <kbd>Progrm + F12</kbd>. Please check with the manual for other remapping-related information.


```
Remapped Software Dvorak

IN F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 KE CL PB
`~ 1! 2@ 3# 4$ 5%   6^ 7& 8* 9( 0) \|
TA '" ,< .> pP yY   fF gG cC rR lL /?
ES aA oO eE uU iI   dD hH tT nN sS -_
SH ;: qQ jJ kK xX   bB mM wW vV zZ SH
   CT AL UP DN         LE RI AL CT

            [{ PS   =+ ]}
         BS DE PU   HO EN SP
               PD   ED
```

I used <kbd>Insert</kbd> in lieu of <kbd>Esc</kbd>, so that I can
easily access the `XA_PRIMARY` selection using <kbd>Shift +
Insert</kbd>. The `XA_PRIMARY` selection is where your mouse
highlights go. It also makes it easy to enter Emacs'
`overwrite-mode`. The <kbd>Insert</kbd> key, however, is buried in the
key physically marked with `|`, on the left side. The sequence to
access it is listed at end of this post.

The new location of <kbd>Ctrl</kbd> and <kbd>Alt</kbd> makes it easy
for the fingers to reach them. I swapped the location of <kbd>Up</kbd>
and <kbd>Down</kbd> with <kbd>Left</kbd> and <kbd>Right</kbd>. I
wanted to be able to scroll through a webpage without having to use my
right hand with the mouse wheel. The same applies with <kbd>Page
Up</kbd> and <kbd>Page Down</kbd>.

One of my favorites is the new location of the
<kbd>[</kbd> and <kbd>]</kbd> keys. I also like the new location of
the <kbd>Esc</kbd> key -- this allows me to easily hit the Esc key
when using vi, or closing dialog boxes.

The full mapping sequence follows. The `l` and `r` prefixes below
signifies the left and right versions of the keys, respectively. The
`->` is read as "to". For example, `PU -> HO` is read as "Assign
PageUp to Home".

```
Progrm + Shift + F10
Progrm + \
Progrm + -
Progrm + F12

ES -> CL
CL -> SL

LE -> UP
RI -> DN
UP -> LE
DN -> RI

HO -> PU
ED -> PD
PU -> HO
PD -> ED

lCT -> `~
lAL -> \|
rCT -> ]}
rAL -> [{

-_ -> lCT
ES -> lAL
=+ -> rCT
]} -> rAL

`~  -> =+
r\| -> -_
[{  -> l\|

Keypad, Insert, Keypad, ES
Keypad, KP_Enter, Keypad, lAL
```

The `KP_Enter` (KE) key was moved to `Left Alt` (lAL) so that I can
easily use it as a Compose (Multi) key in X. My `~/.Xmodmap` contains
the following:

```
!! KP_Enter
keycode 104 = Multi_key
```
