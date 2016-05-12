Esperanto Characters in Linux
=============================

<center>April 18, 2016</center>
<center>Updated: May 13, 2016</center>

Prior to the invention of the methods discussed in this post, the way
to input Esperanto characters on Linux is to use the the
[h-](https://en.wikipedia.org/wiki/Esperanto_orthography#H-system) or
[x-systems](https://en.wikipedia.org/wiki/Esperanto_orthography#X-system).
To input the character **ĉ**, you would have to write “ch” or
“cx”. The latter was more preferred because the character **x** isn’t
part of the Esperanto alphabet. Another, more tedious way of inputting
characters was with the use of a character map—a GUI application that
displays Unicode characters, that you can copy characters from. A
popular character map application for Linux systems is
[gucharmap](https://wiki.gnome.org/Apps/Gucharmap).

The aforementioned systems are inaccurate, and tedious. There’s no
need to continue using these input methods, aside from supporting
legacy display systems. Currently, there are two ways to input
Esperanto characters on Linux systems—the multi key and mode switch.


## Table of contents

* [Multi key](#multikey)
* [Mode switch](#modeswitch)
* [Additional notes](#additional)
* [Closing remarks](#closing)


## Multi key <a name="multikey"></a>

The *multi key*, also called a compose key, is a specially-assigned
key, that must be pressed and released, along with other keys, to
input a character, or series of characters. Unlike <kbd>Shift</kbd> or
<kbd>Ctrl</kbd>, it must be released, and not held down.

To use the <kbd>Pause</kbd> key as the multi key, edit the file
`~/.Xmodmap`, then add the following:

```
keycode 127 = Multi_key
```

Then, re-read `~/.Xmodmap`:

```
$ xmodmap ~/.Xmodmap
```

If you do not want to use <kbd>Pause</kbd> as the multi key, run xev:

```
$ xev
```

A small window appears with a white background. Move your mouse inside
the window, then press a key on your keyboard. On your terminal, you
will see the keycode of the key that you pressed.

```
…
KeyRelease event, serial 36, synthetic NO, window 0x2e00001,
    root 0x299, subw 0x0, time 131237513, (16,285), root:(978,647),
    state 0x0, keycode 107 (keysym 0xff61, Print), same_screen YES,
               ^^^^^^^^^^^
…
```

So, to use the <kbd>Print</kbd> key as your multi key, edit
`~/.Xmodmap` to contain:

```
keycode 107 = Multi_key
```

Then re-read the `~/.Xmodmap` file as described above.

Now that you have access to the multi key, composing characters will
be easy. Presuming you’re <kbd>Pause</kbd> as the multi key, to input
**ĉ**, you must press and release <kbd>Pause</kbd>, press and release
<kbd>&#94;</kbd> (shift 6), then finally, press and release <kbd>c</kbd>.

The following table lists the combinations:

```
# lowercase
ĉ: Multi_key ^ c
ĝ: Multi_key ^ g
ĥ: Multi_key ^ h
ĵ: Multi_key ^ j
ŝ: Multi_key ^ s
ŭ: Multi_key u u

# uppercase
Ĉ: Multi_key ^ C
Ĝ: Multi_key ^ G
Ĥ: Multi_key ^ H
Ĵ: Multi_key ^ J
Ŝ: Multi_key ^ S
Ŭ: Multi_key u U
```


## Mode switch <a name="modeswitch"></a>

A faster and easier way to input Esperanto characters is through the
use of the *mode switch* key. Just like with the *multi key*, you
assign a key to it. I like to bind two keys to it, so I can type with
both hands. Unlike the multi key, you have to hold it down like the
<kbd>Shift</kbd> or <kbd>Ctrl</kbd> keys.

If you want to assign the <kbd>![Windows](images/icon_windows_02_22x22.png "Windows key")</kbd> keys as the mode switch keys, edit
the file `~/.Xmodmap`, then add the following:

```
keycode 133 = Mode_switch
keycode 134 = Mode_switch
```

Next, you need to add the appropriate names for the corresponding
Esperanto characters. If you’re using QWERTY, add the following to
your `~/.Xmodmap`.

```
keycode 54 = c C ccircumflex Ccircumflex
keycode 42 = g G gcircumflex Gcircumflex
keycode 43 = h h hcircumflex Hcircumflex
keycode 44 = j J jcircumflex Jcircumflex
keycode 39 = s S scircumflex Scircumflex
keycode 30 = u U ubreve Ubreve
```

And if you’re using Dvorak, use the following:

```
keycode 31 = c C ccircumflex Ccircumflex
keycode 30 = g G gcircumflex Gcircumflex
keycode 44 = h h hcircumflex Hcircumflex
keycode 54 = j J jcircumflex Jcircumflex
keycode 47 = s S scircumflex Scircumflex
keycode 41 = u U ubreve Ubreve
```

Then, re-read `~/.Xmodmap`:

```
$ xmodmap ~/.Xmodmap
```

Using the <kbd>![Windows](images/icon_windows_02_22x22.png "Windows key")</kbd> keys as mode switch keys, to input **ĉ**, press and
hold <kbd>![Windows](images/icon_windows_02_22x22.png "Windows key")</kbd>, then press <kbd>c</kbd>. To input **Ŭ**, press and
hold <kbd>![Windows](images/icon_windows_02_22x22.png "Windows key")</kbd>, press and hold <kbd>Shift</kbd>, then press <kbd>u</kbd>.


## Additional notes <a name="additional"></a>

Both methods outlined above do far more than emitting Esperanto
characters. The multi key system can emit more sophisticated symbols
and characters. To see the complete list of characters, run the
following command if you’re on mainstream Linux systems:

```
$ less /usr/share/X11/locale/en_US.UTF-8/Compose
```

If you’re using NixOS, run:

```
$ less ~/.nix-profile/share/X11/locale/en_US.UTF-8/Compose
```

The mode switch system, albeit, not as extensive as the former, is
also a bit comprehensive. To see the list of character names
available, click [here](http://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap).


## Closing remarks <a name="closing"></a>

There’s no best way to do this—use whatever system that fits your
style. If you’re already using the <kbd>![Windows](images/icon_windows_02_22x22.png "Windows key")</kbd> keys for something else,
and you can only use one “spare” key on your keyboard, then use the
multi key method. If you want ease of use, use the mode switch
method. It is important to note, too, that you can use both methods
simultaneously.

Ĝis la revido! `(/^▽^)/`
