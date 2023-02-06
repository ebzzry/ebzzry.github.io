Managing Directories with Emacs
===============================

<div class="center">[Esperanto](/eo/emakso-dired/) ■ English</div>
<div class="center">Last updated: March 17, 2022</div>

>Supposing is good, but finding out is better.<br>
>―Samuel Clemens

<img src="/bil/lucas-benjamin-V-mEcfI8fsI-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="lucas-benjamin-V-mEcfI8fsI-unsplash" title="lucas-benjamin-V-mEcfI8fsI-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduciton](#introduction)
- [Common commands](#commoncommands)
- [Mark commands](#markcommands)
- [Other commands](#othercommands)
- [WDired mode](#wdired)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

In this post, I’ll be focusing on one of the smart ways Emacs handles directory management. The
directory editor, or _Dired_ (pronounced dir-ed, not dye-rd), is the Emacs equivalent of
a file manager. Whatever you can do with regular buffers, you can also do it with dired ones.

To run Dired, run Emacs on the command line, supplying a directory as its argument:

    $ emacs ~/Desktop

Or, alternatively, you can press <kbd>C-x d</kbd> inside Emacs. If you are currently editing a file,
the directory of that file will be presented as the default value in the minibuffer area. Either
way, when you hit <kbd>Enter</kbd>, a buffer of the directory will load, that looks like the output
of `ls -l`:

```
/home/vakelo/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 vakelo users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 vakelo users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 vakelo users 4096 Sep 26 05:39 vids
```

Okay, now that you have it, what can you do with it? Well, here is a short list of what, you can do
with it. Take note, that the keyboard shortcuts in this article are case-sensitive, unless
explicitly stated otherwise.


<a name="commoncommands"></a> Common commands
---------------------------------------------

These are the usual commands that you would use, in a dired buffer. In addition to that, they can
operate on single, or multiple items. Using them for multiple items will be explained, next.

| Key                           | What it does              |
| :---------------------------- | :------------------------ |
| <kbd>R</kbd>                  | Rename item               |
| <kbd>C</kbd>                  | Copy item                 |
| <kbd>D</kbd>                  | Delete item               |
| <kbd>O</kbd>                  | Change owner              |
| <kbd>G</kbd>                  | Change group              |
| <kbd>M</kbd>                  | Change permissions        |
| <kbd>S</kbd>                  | Create symlink            |
| <kbd>T</kbd>                  | Touch item                |
| <kbd>!</kbd> or <kbd>X</kbd>  | Run shell command on item |


<a name="markcommands"></a> Mark commands
-----------------------------------------

These commands perform mark-related operations on items. Creating marks simply means putting a tag
on items, so that you can perform the operations in the previous section, on them.

| Key          | What it does                                     |
| :----------- | :----------------------------------------------- |
| <kbd>m</kbd> | Mark an item                                     |
| <kbd>d</kbd> | Mark an item for deletion                        |
| <kbd>x</kbd> | Execute operation                                |
| <kbd>u</kbd> | Unmark a single item                             |
| <kbd>U</kbd> | Unmark all items                                 |
| <kbd>t</kbd> | Toggle marks between marked and unmarked items   |
| <kbd>c</kbd> | Compress items                                   |


<a name="othercommands"></a> Other commands
-------------------------------------------

These commands act on their own. They operate on single items, and they don’t make use of marks. The
<kbd>w</kbd> command, however, is an exception.

| Key                          | What it does                            |
| :--------------------------- | :-------------------------------------- |
| <kbd>+</kbd>                 | Create directory                        |
| <kbd>&#94;</kbd>             | Go up one level, like `cd ..`           |
| <kbd>e</kbd> or <kbd>f</kbd> | Edit an item                            |
| <kbd>v</kbd>                 | View an item, like `less`               |
| <kbd>g</kbd>                 | Reload the current directory            |
| <kbd>j</kbd>                 | Jump to an item                         |
| <kbd>s</kbd>                 | Change sort order                       |
| <kbd>y</kbd>                 | Show file type of item, like `file`     |
| <kbd>w</kbd>                 | Copy item name to clipboard             |


<a name="wdired"></a> WDired mode
---------------------------------

But, one of the coolest, and often-overlooked feature of dired is the _WDired_ mode. What it does
is that it gives you a powerful ability to edit the item names in a dired buffer, just as you would
on a typical buffer. To enter wdired mode, hit:

    M-x wdired-change-to-wdired-mode RET

The major mode changes from `Dired` to `Editable Dired`. You can then rename the files, and
directories, with ease. You can even use rectangle and replace functions on them, to make things
easier. The changes you have made at this point are not yet saved. To save the changes, press
<kbd>C-c C-c</kbd>.


<a name="closing"></a> Closing remarks
--------------------------------------

We have only touched the tip of the iceberg. Feel free to explore. For more information visit the
Dired manual [here](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).
