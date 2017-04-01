Setting Up Racket Development in Emacs
======================================

<div class="center">September 29, 2013</div>
<div class="center">Updated: March 31, 2017</div>

>“All the good ideas never lie under one hat.”<br>
>―Dale Turner

In this article, I’ll discuss the easiest approach that I took to setup up
a [Racket](https://racket-lang.org) development environment in Emacs. Take note, that this is not
the only approach available—some did it in arguably better ways. In this article, I’ll try to
explain the shortest route that I took.


Table of contents
-----------------

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
  + [Racket buffer](#racketbuffer)
  + [REPL buffer](#replbuffer)
- [Closing remarks](#closing)


Introduction <a name="introduction"></a>
----------------------------------------

Editing Racket code with Emacs has traditionally been done by rudimentary modes that lacked
flexibility. They were able to evaluate current definitions, last definitions, and entire buffers,
for the most part. Unfortunately, that didn’t suffice with the way Racket dealt with things. A more
intelligent way of handling code, was needed.

Fortunately, you have [Geiser](http://www.nongnu.org/geiser/). There are other major modes that try
to do what Geiser does, but I became most comfortable with what Geiser offered. Some similar
libraries can co-exist with Geiser, too. I tried those, but it became too complex, for me. I wound
up just using Geiser. Also, as a semi-related note, I’m using Emacs to edit Racket code because I
don’t know of any other editor that does it so well. I don’t use DrRacket, except when I need to use
its nice GUI debugger.


Installation <a name="installation"></a>
----------------------------------------

My installation method is crude, but it works, at least for me. Other installation methods exist,
but I couldn’t wrap my brain around them, so I opted instead for something that requires the minimal
amount of chore. Also, I’m still not sure what are the hidden consequences of not doing it the
“elegant” way, presuming there is one.

Let’s say that you want to install your Geiser files in `~/.emacs.d/elisp/`. You’ll issue the
following commands to install Geiser to that location:

    $ mkdir ~/.emacs.d/elisp
    $ cd ~/.emacs.d/elisp
    $ git clone http://git.sv.gnu.org/r/geiser.git

After that, in `~/.emacs.d/elisp/geiser/`, you’ll have something that looks like the following:

```
AUTHORS
autogen.sh*
bin/
ChangeLog
configure.ac
COPYING
doc/
elisp/
.git/
.gitignore
INSTALL
Makefile.am
NEWS
README
README.elpa
scheme/
THANKS
```

Next, you want the directory `~/.emacs.d/elisp/geiser/elisp/` to be a member of the Emacs variable
`load-path` so that `require` and friends will know where to find things. To do that, add the
following to your Emacs init file—either in `~/.emacs.d/init.el`, or in `~/.emacs` (deprecated):

```lisp
(add-to-list 'load-path "~/.emacs.d/elisp/geiser/elisp/")
```

Next, you’ll put in the actual code that invokes and configures Geiser:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(racket))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

The first expression loads Geiser, itself. The second one specifies that it won’t prompt you for
other implementations if it finds them. The last one is optional—it enables you to execute `M-x
geiser-save RET` in the REPL buffer to force saving of the history to the disk file, which is
`~/.geiser_history.racket`, by default. It is useful if you want to save your REPL session,
immediately (Nothing is more horrifying than losing **THAT** expression). For all the Emacs code
above, to take effect, you can evaluate them now using members of the eval-* troupe (`eval-defun`,
`eval-last-sexp`, `eval-region`), or, you can still opt to respawn a new Emacs process.


Usage <a name="usage"></a>
--------------------------

To reap what you sowed, create or open a `.rkt` file, with at least a proper module
declaration. Then hit:

    M-x run-geiser RET

And, boomshakalaka! A new (Emacs) window opens, containing the `* Racket REPL *` buffer. Whatever
you can do with the REPL invoked with vanilla command-line `racket`, you can also do with this, and
more. This major mode is actually Comint mode, under the hood, with hooks to a a Racket process. For
those of you who are unfamiliar with Comint mode, it is the same mode that handles `M-x shell RET`.

So, what can you do with it? While editing `.rkt` file, here are some of the usual shortcuts that I
use (The full list of keys
are [available here](http://www.nongnu.org/geiser/geiser_5.html#Cheat-sheet)). Take note, that the
description of the keys that I used below, are for myself initially, to help me understand what they
do. They may, or may not diverge from the official description, listed on the aforementioned link.


Racket buffer <a name="racketbuffer"></a>
-----------------------------------------

| Key     | What it does                                            |
| :------ | :------------------------------------------------------ |
| C-c C-z | Switch to the REPL buffer                               |
| C-c C-a | Evaluate current buffer, then switch to the REPL buffer |
| C-M-x   | Evaluate current expression                             |
| C-x C-e | Evaluate last expression                                |
| C-c C-r | Evaluate region                                         |
| C-c C-\ | Insert a lambda (λ) symbol                              |


REPL buffer <a name="replbuffer"></a>

-------------------------------------
| Key     | What it does                        |
| :------ | :---------------------------------- |
| C-c C-z | Switch to the Racket buffer         |
| M-p     | Switch to the previous history item |
| M-n     | Switch to the next history item     |
| C-c M-p | Jump to previous prompt             |
| C-c M-n | Jump to next prompt                 |
| C-c C-q | Quit the REPL                       |


Closing remarks <a name="closing"></a>
--------------------------------------

I have intentionally skipped many topics from the [official document](http://www.nongnu.org/geiser/)
because it makes it unattractive to people who are averse to reading long blocks of text
(ironically, this article may even qualify as one.). The methods described above are by in no way
representative of community-advised ways of installing and using Racket with Emacs. Feel free to
drop a comment below! Ciao!
