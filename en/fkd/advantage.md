My Kinesis Advantage Layout
===========================

<div class="center">[Esperante](/eo/avantagxo) · [English](#)</div>
<div class="center">October 26, 2015</div>
<div class="center">Last updated: July 13, 2018</div>

>Pain is inevitable. Suffering is optional.<br>
>―M. Kathleen Casey

<img src="/bil/avantagxo.jpg" style="display: block; width: 100%; margin-left: auto;
margin-right: auto;" alt="Kinesis Advantage" title="Kinesis Advantage"/>


<a name="toc"></a>Table of contents
-----------------------------------

- [Overview](#overview)
- [Before](#before)
- [After](#after)
- [Setup](#setup)
- [Closing remarks](#closing)


<a name="overview"></a>Overview
-------------------------------

One of the best investments a programmer can have is a good keyboard. What constitutes a good
keyboard, however, can sometimes be a subject of debates. A common item that persists most lists is
that it has be ergonomic. I add to that list an important quality: speed. No matter how ergonomic a
keyboard is, if it fails on the speed category. It has to be comfortable, and speedy.

The [Kinesis Advantage](https://www.kinesis-ergo.com/wp-content/uploads/2015/01/kinesis_advantage_user_manual.pdf) is the epitome of
such a criteria. It is ergonomic, and it is fast. If you are already proficient typist, you’ll find
that after the small adjustment period, you’ll type even faster with the Advantage.

However, the default layout of the keys, however, doesn’t suit me. The <kbd>Ctrl</kbd> and
<kbd>Alt</kbd> keys are too far to reach. This is important for users of software like Emacs and
Zsh.


<a name="before"></a>Before
---------------------------

There exists a Dvorak mode which is already built-in in the keyboard. You can activate the dvorak
mode without using any software by pressing <kbd>Pogrm + Shift + F5</kbd>. You can go back to the
QWERTY mode by pressing the same key combination.  When using Dvorak emulation, the following layout
is how the keys are mapped:

<a href="/bil/avantagxo-dvorako-0.png"><img src="/bil/avantagxo-dvorako-0.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Original Software Dvorak" title="Original Software Dvorak"/></a>
<div class="center">Figure 1-1: Original software Dvorak</div>

No. Using this layout on Emacs or Zsh, is hell: to press <kbd>M-x</kbd> in Emacs, one would have to
press the <kbd>Alt</kbd> key with the right thumb, then the <kbd>x</kbd> key with the left index
finger. Reaching out for the <kbd>Esc</kbd> keys isn’t a lot of fun, either, because it’s too far.


<a name="after"></a>After
-------------------------

Because of that, I remapped some of the keys. The new layout is as follows.

<a href="/bil/avantagxo-dvorako-1.png"><img src="/bil/avantagxo-dvorako-1.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="Remapped Software Dvorak" title="Remapped Software Dvorak"/></a>
<div class="center">Figure 1-2: Remapped software Dvorak</div>

The new location of <kbd>Ctrl</kbd> and <kbd>Alt</kbd> makes it easy for the fingers. I swapped the
location of <kbd>🡅</kbd> and <kbd>🡇</kbd> with <kbd>🡄</kbd> and <kbd>🡆</kbd>. I want to
be able to scroll through a webpage without having to use my right hand with the mouse wheel or the
drawing tablet. <kbd>Page Up</kbd> and <kbd>Page Down</kbd> were also moved to enable equal load
distribution for two hands.

One of my favorite changes is the new location of the <kbd>[</kbd> and <kbd>]</kbd> keys. I also
like the new location of the <kbd>Esc</kbd> key—this allows me to easily hit the Esc key when using
vi, or closing application prompts.

I used <kbd>Insert</kbd> in lieu of <kbd>Esc</kbd>, so that I can easily access the `XA_PRIMARY`
selection using <kbd>Shift + Insert</kbd>. The `XA_PRIMARY` selection is where your mouse highlights
go. It also makes it easy to enter Emacs’s `overwrite-mode`. The <kbd>Insert</kbd> key, however, is
buried in the key physically marked with `|`, on the left side. The sequence to access it is listed
at end of this post.

I bound what used to be the <kbd>Ctrl</kbd> keys to <kbd>KP Home</kbd> and <kbd>KP End</kbd> so that
in my [.Xmodmap](https://github.com/ebzzry/dotfiles/blob/master/xmodmap/.Xmodmap.advantage.dvorak)
file , I can map it to <kbd>Mode Switch</kbd>. See the [notes](#notes) below why I added another
level of indirection.


<a name="setup"></a>Setup
-------------------------

The following section contains the setup that I used to map the keys. The `+` indicates pressing and
holding a key, while pressing another. The `,` indicates a sequence of keys pressed and released, in
order.

First, press the following keys, in order:

| Sequence                          | Description                                                  |
| :-------------------------------- | :----------------------------------------------------------- |
| <kbd>Progrm + Shift + F10</kbd>   | Reset settings                                               |
| <kbd>Progrm + \</kbd>             | Disable key tones                                            |
| <kbd>Progrm + -</kbd>             | Disable key tones for Caps, Scroll, Num Lock keys and Insert |
| <kbd>Progrm + F12</kbd>           | Start remapping mode                                         |

At this point, the keyboard waits for key pair combinations. The first key that you’ll press will be
the source; the next key will be the destination.

| Source                                 | Destination                |
| :------------------------------------- | :------------------------- |
| <kbd>Esc</kbd>                         | <kbd>Caps Lock</kbd>       |
| <kbd>🡄</kbd>                           | <kbd>🡅</kbd>               |
| <kbd>🡆</kbd>                           | <kbd>🡇</kbd>               |
| <kbd>🡅</kbd>                           | <kbd>🡄</kbd>               |
| <kbd>🡇</kbd>                           | <kbd>🡆</kbd>               |
| <kbd>-_</kbd>                          | <kbd>End</kbd>             |
| <kbd>=+</kbd>                          | <kbd>Page Down</kbd>       |
| <kbd>Page Up</kbd>                     | <kbd>Home</kbd>            |
| <kbd>Page Down</kbd>                   | <kbd>Page Up</kbd>         |
| Left <kbd>Ctrl</kbd>                   | <kbd>`~</kbd>              |
| Left <kbd>Alt</kbd>                    | Left <kbd>\</kbd>          |
| Right <kbd>Ctrl</kbd>                  | <kbd>]}</kbd>              |
| Right <kbd>Alt</kbd>                   | <kbd>[{</kbd>              |
| <kbd>[{</kbd> (slash)                  | Right <kbd>\</kbd>         |
| <kbd>]}</kbd> (equal)                  | Right <kbd>Alt</kbd>       |
| <kbd>`~</kbd>                          | <kbd>=+</kbd>              |
| Right <kbd>\</kbd>                     | <kbd>-_</kbd>              |
| Keypad, <kbd>KP Insert</kbd>, Keypad   | <kbd>Esc</kbd>             |
| Keypad, <kbd>KP Return</kbd>, Keypad   | Left <kbd>Alt</kbd>        |
| Keypad, <kbd>u</kbd>, Keypad (KP Home) | Left <kbd>Ctrl</kbd>       |
| Keypad, <kbd>m</kbd>, Keypad (KP End)  | Right <kbd>Ctrl</kbd>      |

Then, press <kbd>Progrm + F12</kbd> again, to exit remapping mode. The <kbd>KP Return</kbd> key was moved to the left <kbd>Alt</kbd> so that I can easily use it as a Compose (Multi) key in
X. My [~/.Xmodmap](https://github.com/ebzzry/dotfiles/blob/master/xmodmap/.Xmodmap.advantage.dvorak)
contains the following:

```
keycode 104 = Multi_key
```


<a name="notes"></a>Notes
-------------------------

If the right <kbd>Ctrl</kbd> key has keycode 21—while mapped via xmodmap to
<kbd>Mode_switch</kbd>—and it is simultaneously pressed with <kbd>c</kbd> in software QWERTY, or <kbd>j</kbd> in software Dvorak, it
generates the following text for QWERTY and Dvorak, respectively:

```

Copyright (c) 1998-2003 P.I. Engineering, Inc.
```

```

Jrlfpcidy (j) 1998[2003 LvCv >bicb..pcbiw Cbjv
```

At the time of writing, I still don’t know what causes this, nor do I think it makes sense.


<a name="closing"></a>Closing remarks
-------------------------------------

The programmability of the Kinesis Advantage is one of its strongest feature. That, along with its
crazy-ass durability and the award-winning ergonomics makes the Advantage a worthwhile investment.

The latest model—[Advantage2](https://www.kinesis-ergo.com/shop/advantage2/)—has more features than
the one that I have. The function keys of this model are now also mechanical. So, if you have the
budget, go get it! Visit the [homepage](https://www.kinesis-ergo.com/) of Kinesis for more
information.
