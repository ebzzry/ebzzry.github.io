    Title: Emacs & Dired
    Date: 2013-09-26T17:57:00
    Tags: emacs, programming

In this post, I'll be focusing on one of the novel ways Emacs handles
*directory editing*. The directory editor, or **dired** (pronounced
dir-ed, not die-rd), for short, is the Emacs equivalent of a file
manager. Whatever you can do with regular file buffers, you can also do it with
dired buffers, to a certain extent.

<!-- more -->

# Introduction

To run dired, run emacs on the command line, supplying a directory as its argument:

```console
$ emacs ~/Desktop/
```

Or, alternatively, you can press `C-x d` inside Emacs. If you are
currently editing a file, the directory of that file will be presented as the
default value in the minibuffer area. Either way, when you hit `Enter`, a
buffer of the directory will load, that looks like the output of
`ls -l`:

```
/home/john/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 john users 5935 Sep 27 18:17 index.html
-rw-r--r-- 1 john users 5944 Sep 27 18:17 index2.html
drwxr-xr-x 3 john users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 john users 4096 Sep 26 05:39 vids
```

Okay, now that we have it, what can we do with it? Well, here is a short list
of what, we can do with it. Take note, that the keyboard shortcuts in this
article are case-sensitive, unless explicitly stated otherwise.


# Common commands

These are the usual commands that you would use, in a dired buffer. In addition
to that, they can operate on single, or multiple items. Using them for multiple
items will be explained, next.

<table>
<tr><th>Key</th><th>What it does</th></tr>
<tr><td>R</td><td>Rename item(s)</td></tr>
<tr><td>C</td><td>Copy item(s)</td></tr>
<tr><td>D</td><td>Delete item(s)</td></tr>
<tr><td>O</td><td>Change item(s) owner</td></tr>
<tr><td>G</td><td>Change item(s) group</td></tr>
<tr><td>M</td><td>Change item(s) permission</td></tr>
<tr><td>S</td><td>Create symlink</td></tr>
<tr><td>T</td><td>Touch item(s), a la `touch`</td></tr>
<tr><td>X</td><td>Execute a shell command on item(s)</td></tr>
</table>


# Mark commands

These commands perform mark-related operations on items. Creating marks simply
means putting a tag on items, so that you can perform the operations in the
previous section, on them.

<table>
<tr><th>Key</th><th>What it does</th></tr>
<tr><td>m</td><td>Mark an item, for the above-listed commands</td></tr>
<tr><td>d</td><td>Mark an item for deletion operations</td></tr>
<tr><td>x</td><td>Perform actual deletion</td></tr>
<tr><td>u</td><td>Unmark a single item</td></tr>
<tr><td>U</td><td>Unmark all items</td></tr>
<tr><td>t</td><td>Toggle marks between marked and unmarked items</td></tr>
</table>


# Other commands

These commands act on their own. They operate on single items, and they don't
make use of marks. The **w** command, however, is an exception.

<table>
<tr><th>Key</th><th>What it does</th></tr>
<tr><td>+</td><td>Create directory</td></tr>
<tr><td>^</td><td>Go up, one level, like `cd ..`</td></tr>
<tr><td>e</td><td>Edit an item</td></tr>
<tr><td>f</td><td>Edit an item</td></tr>
<tr><td>v</td><td>View an item, like `less` or `more`</td></tr>
<tr><td>g</td><td>Reload the current directory</td></tr>
<tr><td>j</td><td>Jump to an item</td></tr>
<tr><td>s</td><td>Change sort order</td></tr>
<tr><td>y</td><td>Show file type of item, like `file`</td></tr>
<tr><td>w</td><td>Copy item name(s) to the clipboard</td></tr>
</table>


# WDired mode

*BUT*, one of the coolest, and often-overlooked feature of dired is the
**WDired** mode. What it does is that it gives you a decent ability to edit
the item names in a dired buffer, just as you would on a typical buffer. To
enter wdired mode, hit `M-x wdired-change-to-wdired-mode`. The major mode
changes from `Dired` to `Editable Dired`. You can then
rename the files, and directories, with ease. You can even use rectangle and
replace functions on them, to make things easier. The changes you have made at
this point are not yet saved. To save the changes, press `C-c C-c`.

Well, that is it for now. Ciao!
