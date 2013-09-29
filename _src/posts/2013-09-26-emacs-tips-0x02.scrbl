#lang scribble/manual

Title: Emacs Tips: Dired
Date: 2013-09-26T17:57:00
Tags: emacs, programming

In this post, I'll be focusing on one of the novel ways Emacs handles
@emph{"directory editing"}. The directory editor, or @bold{dired} (pronounced
dir-ed, not die-rd), for short, is the Emacs equivalent of a file
manager. Whatever you can do with regular file buffers, you can also do it with
dired buffers, to a certain extent.

<!-- more -->

@section{Introduction}

To run dired, run emacs on the command line, supplying a directory as its argument:

@codeblock{
emacs ~/Desktop/
}

Or, alternatively, you can press @code{C-x d} inside Emacs. If you are
currently editing a file, the directory of that file will be presented as the
default value in the minibuffer area. Either way, when you hit @code{Enter}, a
buffer of the directory will load, that looks like the output of
@code{ls -l}:

@codeblock|{
/home/rmm/Desktop/foo:
total used in directory 84 available 540767396
-rw-r--r-- 1 rmm users 5935 Sep 27 18:17 index.html
-rw-r--r-- 1 rmm users 5944 Sep 27 18:17 index2.html
drwxr-xr-x 3 rmm users 4096 Sep 26 17:42 pics
drwxr-xr-x 3 rmm users 4096 Sep 26 05:39 vids
}|

Okay, now that we have it, what can we do with it? Well, here is a short list
of what, we can do with it. Take note, that the keyboard shortcuts in this
article are case-sensitive, unless explicitly stated otherwise.


@section{Common commands}

These are the usual commands that you would use, in a dired buffer. In addition
to that, they can operate on single, or multiple items. Using them for multiple
items will be explained, next.

@tabular[#:style 'boxed #:sep @hspace[1]
  (list
    (list @bold{Key} @bold{What it does})
    (list @bold{R}   "Rename item(s)")
    (list @bold{C}   "Copy item(s)")
    (list @bold{D}   "Delete item(s)")
    (list @bold{O}   "Change item(s) owner")
    (list @bold{G}   "Change item(s) group")
    (list @bold{M}   "Change item(s) permission")
    (list @bold{S}   "Create symlink")
    (list @bold{T}   "Touch item(s), like \"touch\"")
    (list @bold{X}   "Execute a shell command on item(s)"))
]


@section{Mark commands}

These commands perform mark-related operations on items. Creating marks simply
means putting a tag on items, so that you can perform the operations in the
previous section, on them.

@tabular[#:style 'boxed #:sep @hspace[1]
  (list
    (list @bold{Key} @bold{What it does})
    (list @bold{m}   "Mark an item, for the above-listed commands")
    @; (list @bold{d}   "Mark an item for deletion operations")
    @; (list @bold{x}   "Perform actual deletion")
    (list @bold{u}   "Unmark a single item")
    (list @bold{U}   "Unmark all items")
    (list @bold{t}   "Toggle marks between marked and unmarked items"))
]


@section{Other commands}

These commands act on their own. They operate on single items, and they don't
make use of marks. The @bold{w} command, however, is an exception.

@tabular[#:style 'boxed #:sep @hspace[1]
  (list
    (list @bold{Key}  @bold{What it does})
    (list @bold{+}    "Create directory")
    (list @bold{^}    "Go up, one level, like \"cd ..\"")
    (list @bold{e}    "Edit an item")
    (list @bold{f}    "Edit an item")
    (list @bold{v}    "View an item, like \"less\" or \"more\"")
    (list @bold{g}    "Reload the current directory")
    (list @bold{j}    "Jump to an item")
    (list @bold{s}    "Change sort order")
    (list @bold{y}    "Show file type of item, like \"file\"")
    (list @bold{w}    "Copy item name(s) to the clipboard"))
]


@section{WDired mode}

@bold{BUT}, one of the coolest, and often-overlooked feature of dired is the
@bold{WDired} mode. What it does is that it gives you a decent ability to edit
the item names in a dired buffer, just as you would on a typical buffer. To
enter wdired mode, hit @code{M-x wdired-change-to-wdired-mode}. The major mode
changes from @bold{@emph{Dired}} to @bold{@emph{Editable Dired}}. You can then
rename the files, and directories, with ease. You can even use rectangle and
replace functions on them, to make things easier. The changes you have made at
this point are not yet saved. To save the changes, press @code{C-c C-c}.

Well, that is it for now. Ciao!
