Emacs and Dired
======================================================================

<center>2013-09-26 17:57:00</center>

In this post, I'll be focusing on one of the novel ways Emacs handles
*directory editing*. The directory editor, or _Dired_ (pronounced
dir-ed, not die-rd), for short, is the Emacs equivalent of a file
manager. Whatever you can do with regular file buffers, you can also
do it with dired buffers, to a certain extent.

## Introduction

To run dired, run Emacs on the command line, supplying a directory as
its argument:

```bash
$ emacs ~/Desktop/
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
-rw-r--r-- 1 john users 5944 Sep 27 18:17 index2.html
drwxr-xr-x 3 john users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 john users 4096 Sep 26 05:39 vids
```

Okay, now that we have it, what can we do with it? Well, here is a
short list of what, we can do with it. Take note, that the keyboard
shortcuts in this article are case-sensitive, unless explicitly stated
otherwise.


## Common commands

These are the usual commands that you would use, in a dired buffer. In
addition to that, they can operate on single, or multiple items. Using
them for multiple items will be explained, next.

```
┌─────┬──────────────────────────────────────────────────┐
│ Key │ What it does                                     │
├─────┼──────────────────────────────────────────────────┤
│  R  │ Rename items(s)                                  │
├─────┼──────────────────────────────────────────────────┤
│  C  │ Copy item(s)                                     │
├─────┼──────────────────────────────────────────────────┤
│  D  │ Delete item(s)                                   │
├─────┼──────────────────────────────────────────────────┤
│  O  │ Change item(s) owner                             │
├─────┼──────────────────────────────────────────────────┤
│  G  │ Change item(s) group                             │
├─────┼──────────────────────────────────────────────────┤
│  M  │ Change item(s) permissions                       │
├─────┼──────────────────────────────────────────────────┤
│  S  │ Create symlink                                   │
├─────┼──────────────────────────────────────────────────┤
│  T  │ Touch item                                       │
├─────┼──────────────────────────────────────────────────┤
│  X  │ Execute a shell command on item                  │
└─────┴──────────────────────────────────────────────────┘
```

## Mark commands

These commands perform mark-related operations on items. Creating
marks simply means putting a tag on items, so that you can perform the
operations in the previous section, on them.

```
┌─────┬──────────────────────────────────────────────────┐
│ Key │ What it does                                     │
├─────┼──────────────────────────────────────────────────┤
│  m  │ Mark an item, for the above-listed commands      │
├─────┼──────────────────────────────────────────────────┤
│  d  │ Mark an item for deletion operations             │
├─────┼──────────────────────────────────────────────────┤
│  x  │ Perform actual deletion                          │
├─────┼──────────────────────────────────────────────────┤
│  u  │ Unmark a single item                             │
├─────┼──────────────────────────────────────────────────┤
│  U  │ Unmark all items                                 │
├─────┼──────────────────────────────────────────────────┤
│  t  │ Toggle marks between marked and unmarked items   │
└─────┴──────────────────────────────────────────────────┘
```


## Other commands

These commands act on their own. They operate on single items, and
they don't make use of marks. The <kbd>w</kbd> command, however, is an
exception.

```
┌─────┬──────────────────────────────────────────────────┐
│ Key │ What it does                                     │
├─────┼──────────────────────────────────────────────────┤
│  +  │ Create directory                                 │
├─────┼──────────────────────────────────────────────────┤
│  ^  │ Go up, one level, like `cd ..`                   │
├─────┼──────────────────────────────────────────────────┤
│  e  │ Edit an item                                     │
├─────┼──────────────────────────────────────────────────┤
│  f  │ Edit an item                                     │
├─────┼──────────────────────────────────────────────────┤
│  v  │ View an item, like `less` or `more`              │
├─────┼──────────────────────────────────────────────────┤
│  g  │ Reload the current directory                     │
├─────┼──────────────────────────────────────────────────┤
│  j  │ Jump to an item                                  │
├─────┼──────────────────────────────────────────────────┤
│  s  │ Change sort order                                │
├─────┼──────────────────────────────────────────────────┤
│  y  │ Show file type of item, like `file`              │
├─────┼──────────────────────────────────────────────────┤
│  w  │ Copy item name(s) to the clipboard               │
└─────┴──────────────────────────────────────────────────┘
```

## WDired mode

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
