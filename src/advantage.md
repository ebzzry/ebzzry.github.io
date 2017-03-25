My Kinesis Advantage Layout
===========================

<div class="center">October, 26 2015</div>
<div class="center">Updated: March 25, 2017</div>

<img src="images/advantage.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Advantage" />


## Table of contents

* [Why](#why)
* [Before](#before)
* [After](#after)
* [Setup](#setup)
* [Closing remarks](#closing)


## Why <a name="why"></a>

One of the best investments a programmer can have is a good keyboard. What constitutes a good
keyboard, however, can sometimes be a subject of debates. A common item that persists most lists is
that it has be ergonomic. I add to that list an important quality: speed. No matter how ergonomic a
keyboard is, if it falls on the speed category. It has to be comfortable, and speedy.

The [Kinesis Advantage](http://www.kinesis-ergo.com/shop/advantage-for-pc-mac/) is the epitome of
such a criteria. It is ergonomic, and it is fast. If you are already proficient typist, you’ll find
that after the small adjustment period, you’ll type even faster with the Advantage. The default
layout of the keys, however, turns me off. The <kbd>Ctrl</kbd> and <kbd>Alt</kbd> keys are too far
to reach. This is important for users of software like Emacs and Zsh.


## Before <a name="before"></a>
When using Dvorak emulation, the following layout is how the keys are mapped:


### Original Software Dvorak
<a href="images/kadv-dvorak-0.png"><img src="images/kadv-dvorak-0.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Original Software Dvorak" title="Original Software Dvorak"/></a>

Yuck. Using this layout on Emacs or Zsh, is hell: to press <kbd>M-x</kbd>, one would have to press
the <kbd>Alt</kbd> key with the right thumb, then the <kbd>x</kbd> key with the left index
finger. Reaching out for the <kbd>Esc</kbd> keys isn’t a lot of fun, either, because it’s too far.


## After <a name="after"></a>
I remapped some of the keys, to fit my workflow. The new layout is as follows.


### Remapped Software Dvorak
<a href="images/kadv-dvorak-1.png"><img src="images/kadv-dvorak-1.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Remapped Software Dvorak" title="Remapped Software Dvorak"/></a>

I used <kbd>Insert</kbd> in lieu of <kbd>Esc</kbd>, so that I can easily access the `XA_PRIMARY`
selection using <kbd>Shift + Insert</kbd>. The `XA_PRIMARY` selection is where your mouse highlights
go. It also makes it easy to enter Emacs’s `overwrite-mode`. The <kbd>Insert</kbd> key, however, is
buried in the key physically marked with `|`, on the left side. The sequence to access it is listed
at end of this post.

The new location of <kbd>Ctrl</kbd> and <kbd>Alt</kbd> makes it easy for the fingers to reach
them. I swapped the location of <kbd>Up</kbd> and <kbd>Down</kbd> with <kbd>Left</kbd> and
<kbd>Right</kbd>. I wanted to be able to scroll through a webpage without having to use my right
hand with the mouse wheel. <kbd>Page Up</kbd> and <kbd>Page Down</kbd> were also moved to enable
equal load distribution for two hands.

One of my favorites is the new location of the <kbd>[</kbd> and <kbd>]</kbd> keys. I also like the
new location of the <kbd>Esc</kbd> key—this allows me to easily hit the Esc key when using vi, or to
close dialog boxes.


## Setup <a name="setup"></a>
The `+` indicates pressing and holding a key, while pressing another. The `,` indicates a sequence
of keys pressed and released, in order.

First, press the following keys, in order:

| Sequence               | Description                                                  |
| :--------------------- | :----------------------------------------------------------- |
| Progrm + Shift + F10   | Reset settings                                               |
| Progrm + \             | Disable key tones                                            |
| Progrm + -             | Disable key tones for Caps, Scroll, Num Lock keys and Insert |
| Progrm + F12           | Start remapping mode                                         |

At this point, the keyboard waits for key pair combinations. The first key that you’ll press will be
the source; the next key will be the destination.

| Source                      | Destination     |
| :-------------------------- | :-------------- |
| Esc                         | Caps Lock       |
| Left                        | Up              |
| Right                       | Down            |
| Up                          | Left            |
| Down                        | Right           |
| -_                          | End             |
| =+                          | Page Down       |
| Page Up                     | Home            |
| Page Down                   | Page Up         |
| Left Ctrl                   | `~              |
| Left Alt                    | Left backslash  |
| Right Ctrl                  | ]}              |
| Right Alt                   | [{              |
| [{ (slash)                  | Right backslash |
| ]} (equal)                  | Right Alt       |
| `~                          | =+              |
| Right backslash             | -_              |
| Keypad, KP Insert, Keypad   | Esc             |
| Keypad, KP Return, Keypad   | Left Alt        |
| Keypad, u, Keypad (KP Home) | Left Control    |
| Keypad, m, Keypad (KP End)  | Right Control   |

Then, press `Progrm + F12` again, to exit remapping mode.  The `KP Return` key was moved to `Left Alt` so that I can easily use it as a Compose (Multi) key in
X. My [~/.Xmodmap](https://github.com/ebzzry/dotfiles/blob/master/xmodmap/.Xmodmap.kadv.dvorak)
contains the following:

```
keycode 104 = Multi_key
```


## Notes <a name="notes"></a>
If the right <kbd>Ctrl</kbd> key has keycode 21—while mapped via xmodmap to
<kbd>Mode_switch</kbd>—is simultaneously pressed with <kbd>c</kbd> in software Qwerty, or <kbd>j</kbd> in software Dvorak, it
generates the following text for QWERTY and Dvorak, respectively:

```

Copyright (c) 1998-2003 P.I. Engineering, Inc.
```

```

Jrlfpcidy (j) 1998[2003 LvCv >bicb..pcbiw Cbjv
```

At the time of writing, I still don’t know what causes this, nor do I think it makes sense.


## Closing remarks <a name="closing"></a>
The programmability of the Kinesis Advantage is a strong feature; it lets users tailor the keyboard
to their specific needs. That, along with its crazy-ass durability and the award winning ergonomics
makes the Advantage a worthwhile investment. You may check
the [manuals](https://www.kinesis-ergo.com/support/technical-support/manuals-drivers/) or visit
the [homepage](https://www.kinesis-ergo.com/) for more information.

The latest model, [Advantage2](https://www.kinesis-ergo.com/shop/advantage2/) has more features than
the one that I have. The function keys of this model are now also mechanical! So, if you have the
budget, go [get it!](https://www.kinesis-ergo.com/shop/advantage2/)
