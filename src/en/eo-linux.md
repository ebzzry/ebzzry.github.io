---
title: Esperanto Characters in Linux
keywords: esperanto, linux, keyboard, characters, letters, configuration, setup, settings
image: https://ebzzry.com/images/site/stefan-stefancik-6whwCHgsMiA-unsplash-2000x1125.jpg
---
Esperanto Characters in Linux
=============================

<div class="center">2016-04-19</div>

>If you want something you’ve never had, you must be willing to do something you’ve never
>done.<br>
>—Thomas Jefferson

<img src="/images/site/stefan-stefancik-6whwCHgsMiA-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Multi‎ߺ‎key](#multikey)
- [Mode‎ߺ‎switch](#modeswitch)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

I opine, that one should no longer be using the
[h-](https://en.wikipedia.org/wiki/Esperanto_orthography#H-system) or
[x-system](https://en.wikipedia.org/wiki/Esperanto_orthography#X-system) to input the characters
specific to Esperanto, unless it is not physically possible. Currently, there are two ways to input
Esperanto characters on Linux systems—the <kbd>Multi‎ߺ‎key</kbd> and <kbd>Mode‎ߺ‎switch</kbd> keys.

In this article the <kbd>🐧</kbd> key signifies the <kbd>Mode‎ߺ‎switch</kbd> key.


<a name="multikey">Multi‎ߺ‎key</a>
--------------------------------

The *Multi‎ߺ‎key*, also called the Compose key, is a specially-assigned key, that must be pressed and
released, along with other keys, to input a character, or series of characters. Unlike
<kbd>Shift</kbd> or <kbd>Ctrl</kbd>, it must be released, and not held down.

To use the <kbd>Pause</kbd> key as the Multi‎ߺ‎key, edit the file `~/.Xmodmap`, then add the
following:

    keycode 127 = Multi‎ߺ‎key

Then, re-read `~/.Xmodmap`:

    xmodmap ~/.Xmodmap

If you do not want to use <kbd>Pause</kbd> as the Multi‎ߺ‎key, run xev:

    xev

A small window appears with a white background. Move your mouse inside the window, then press a key
on your keyboard. On your terminal, you will see the keycode of the key that you pressed.

```
…
KeyRelease event, serial 36, synthetic NO, window 0x2e00001,
    root 0x299, subw 0x0, time 131237513, (16,285), root:(978,647),
    state 0x0, keycode 107 (keysym 0xff61, Print), same_screen YES,
               ^^^^^^^^^^^
…
```

So, to use the <kbd>Print</kbd> key as your Multi‎ߺ‎key, edit
`~/.Xmodmap` to contain:

```
keycode 107 = Multi‎ߺ‎key
```

Then re-read the `~/.Xmodmap` file as described above.

Now that you have access to the Multi‎ߺ‎key, composing characters will be easy. Presuming you’re using
<kbd>Pause</kbd> as the Multi‎ߺ‎key, to input **ĉ**, you must press and release <kbd>Pause</kbd>,
press and release <kbd>&#94;</kbd> (shift 6), then finally, press and release <kbd>c</kbd>.

The following table lists the combinations for the Esperanto characters:

| Character | Sequence       |
| :-------- | :------------- |
| ĉ         | Multi‎ߺ‎key ^ c  |
| Ĉ         | Multi‎ߺ‎key ^ C  |
| ĝ         | Multi‎ߺ‎key ^ g  |
| Ĝ         | Multi‎ߺ‎key ^ G  |
| ĥ         | Multi‎ߺ‎key ^ h  |
| Ĥ         | Multi‎ߺ‎key ^ H  |
| ĵ         | Multi‎ߺ‎key ^ j  |
| Ĵ         | Multi‎ߺ‎key ^ J  |
| ŝ         | Multi‎ߺ‎key ^ s  |
| Ŝ         | Multi‎ߺ‎key ^ S  |
| ŭ         | Multi‎ߺ‎key u u  |
| Ŭ         | Multi‎ߺ‎key U U  |


<a name="modeswitch">Mode‎ߺ‎switch</a>
------------------------------------

A faster and easier way to input Esperanto characters is through the use of the *Mode‎ߺ‎switch*
key. Just like with the *Multi‎ߺ‎key*, you assign a key to it. I like to bind two keys to it, so I can
type with both hands. Unlike the Multi‎ߺ‎key, you have to hold it down like the <kbd>Shift</kbd> or
<kbd>Ctrl</kbd> keys.

If you want to assign the Windows keys as the <kbd>Mode‎ߺ‎switch</kbd> keys, edit the file `~/.Xmodmap`, then add the following:

```
!! left windows key
keycode 133 = Mode‎ߺ‎switch

!! right windows key
keycode 134 = Mode‎ߺ‎switch

!! menu key
keycode 135 = Mode‎ߺ‎switch
```

Next, you need to add the appropriate names for the corresponding Esperanto characters. Use the
following snippets for QWERTY kaj Dvorak keyboards, respectively.

```
keycode 54 = c C ccircumflex Ccircumflex
keycode 42 = g G gcircumflex Gcircumflex
keycode 43 = h h hcircumflex Hcircumflex
keycode 44 = j J jcircumflex Jcircumflex
keycode 39 = s S scircumflex Scircumflex
keycode 30 = u U ubreve Ubreve
```

```
keycode 31 = c C ccircumflex Ccircumflex
keycode 30 = g G gcircumflex Gcircumflex
keycode 44 = h h hcircumflex Hcircumflex
keycode 54 = j J jcircumflex Jcircumflex
keycode 47 = s S scircumflex Scircumflex
keycode 41 = u U ubreve Ubreve
```

Then, re-read `~/.Xmodmap`:

    xmodmap ~/.Xmodmap

To input **ĉ**, press and hold 🐧, then press <kbd>c</kbd>. To input **Ŭ**, press and hold 🐧, press
and hold <kbd>Shift</kbd>, then press and release <kbd>u</kbd>. This setup effectively allows you to
touch type.

On some keyboards, only one Windows key is present—usually located on the left side, while the one
on the right can be <kbd>PrtSc</kbd>. A lot of times, they’re sandwiched between the <kbd>Ctrl</kbd>
and <kbd>Alt</kbd> keys. To use that key, run `xev` like above, to get the keycode, and update your
`~/.Xmodmap`, accordingly.

On my ThinkPad, my `~/.Xmodmap` has this:

```
!! Left Window
keycode 133 = Mode‎ߺ‎switch

!! PrtSc
keycode 107 = Mode‎ߺ‎switch
```


<a name="closing">Closing remarks</a>
-------------------------------------

Both methods outlined above do far more than emitting Esperanto characters. The Multi‎ߺ‎key system can
emit more sophisticated symbols and characters. To see the complete list of characters, run the
following command if you’re on mainstream Linux systems:

    less /usr/share/X11/locale/en_US.UTF-8/Compose

If you’re using Nix, run:

    less ~/.nix-profile/share/X11/locale/en_US.UTF-8/Compose

Conversely, the advantage of the *Mode‎ߺ‎switch* method is speed. To see the list of character names
available, click [here](https://github.com/D-Programming-Deimos/libX11/blob/master/c/X11/keysymdef.h).

There’s no best way to do this—use whatever system that fits your style. If you’re already using the
Windows keys for something else, and you can only use one “spare” key on your keyboard, then use the
Multi‎ߺ‎key method. If you want ease of use, use the *Mode‎ߺ‎switch* method. It is important to note, too,
that you can use both methods simultaneously.
