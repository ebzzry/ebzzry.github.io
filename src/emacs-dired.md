Emacs and Dired
===============

<center>September 26, 2013</center>
<center>Updated: May 13, 2016</center>

In this post, I’ll be focusing on one of the novel ways Emacs handles
“directory editing”. The directory editor, or _Dired_ (pronounced
dir-ed, not die-rd), for short, is the Emacs equivalent of a file
manager. Whatever you can do with regular file buffers, you can also
do it with dired buffers, to a certain extent.


## Table of contents

* [Introduction](#introduction)
* [Common commands](#commoncommands)
* [Mark commands](#markcommands)
* [Other commands](#othercommands)
* [WDired mode](#wdired)


## Introduction <a name="introduction"></a>

To run Dired, run Emacs on the command line, supplying a directory as
its argument:

```bash
$ emacs ~/Desktop
```

Or, alternatively, you can press <kbd>C-x d</kbd> inside Emacs. If you
are currently editing a file, the directory of that file will be
presented as the default value in the minibuffer area. Either way,
when you hit <kbd>Enter</kbd>, a buffer of the directory will load,
that looks like the output of `ls -l`:

```
/home/john/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 john users 5935 Sep 27 18:17 index.html
drwxr-xr-x 3 john users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 john users 4096 Sep 26 05:39 vids
```

Okay, now that you have it, what can you do with it? Well, here is a
short list of what, you can do with it. Take note, that the keyboard
shortcuts in this article are case-sensitive, unless explicitly stated
otherwise.


## Common commands <a name="commoncommands"></a>

These are the usual commands that you would use, in a dired buffer. In
addition to that, they can operate on single, or multiple items. Using
them for multiple items will be explained, next.

| Key     | What it does              |
| :------ | :------------------------ |
| R       | Rename item               |
| C       | Copy item                 |
| D       | Delete item               |
| O       | Change owner              |
| G       | Change group              |
| M       | Change permissions        |
| S       | Create symlink            |
| T       | Touch item                |
| ! or X  | Run shell command on item |

## Mark commands <a name="markcommands"></a>

These commands perform mark-related operations on items. Creating
marks simply means putting a tag on items, so that you can perform the
operations in the previous section, on them.

| Key | What it does                                     |
| :-- | :----------------------------------------------- |
| m   | Mark an item                                     |
| d   | Mark an item for deletion                        |
| x   | Execute operation                                |
| u   | Unmark a single item                             |
| U   | Unmark all items                                 |
| t   | Toggle marks between marked and unmarked items   |
| c   | Compress items                                   |

## Other commands <a name="othercommands"></a>

These commands act on their own. They operate on single items, and
they don’t make use of marks. The <kbd>w</kbd> command, however, is an
exception.

| Key     | What it does                            |
| :------ | :-------------------------------------- |
| +       | Create directory                        |
| ^       | Go up one level, like `cd ..`           |
| e or f  | Edit an item                            |
| v       | View an item, like `less`               |
| g       | Reload the current directory            |
| j       | Jump to an item                         |
| s       | Change sort order                       |
| y       | Show file type fo item, like `file`     |
| w       | Copy item name to clipboard             |

## WDired mode <a name="wdired"></a>

*BUT*, one of the coolest, and often-overlooked feature of dired is
the _WDired_ mode. What it does is that it gives you a decent ability
to edit the item names in a dired buffer, just as you would on a
typical buffer. To enter wdired mode, hit:

```
M-x wdired-change-to-wdired-mode RET
```

The major mode changes from `Dired` to `Editable Dired`. You can then
rename the files, and directories, with ease. You can even use
rectangle and replace functions on them, to make things easier. The
changes you have made at this point are not yet saved. To save the
changes, press <kbd>C-c C-c</kbd>.

Well, that is it for now. Ciao!
