Setting up Scheme Development in Emacs
======================================

<div class="center">English • [Esperanto](/eo/emakso-skimo/)</div>
<div class="center">Last updated: March 16, 2022</div>

>All the good ideas never lie under one hat.<br>
>—Dale Turner

<img src="/images/site/dimitar-belchev-fRBpWLAcWIY-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="dimitar-belchev-fRBpWLAcWIY-unsplash" title="dimitar-belchev-fRBpWLAcWIY-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
  + [Scheme buffer](#schemebuffer)
  + [REPL buffer](#replbuffer)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

In this article, I’ll discuss the easiest approach that I took to setup up a
[Scheme](https://groups.csail.mit.edu/mac/projects/scheme/) development environment in
Emacs. Take note, that this is not the only approach available—some did it in arguably better ways.
In this article, I’ll try to explain the shortest route that I took.

Editing Scheme code with Emacs has traditionally been done by rudimentary modes that lacked
flexibility. They were able to evaluate current definitions, last definitions, and entire buffers,
for the most part. Unfortunately, that didn’t suffice with the way Scheme dealt with things. A more
intelligent way of handling code, was needed.

Fortunately, there is [Geiser](http://www.nongnu.org/geiser/). There are other major modes that try
to do what Geiser does, but I became most comfortable with what Geiser offered. Some similar
libraries can co-exist with Geiser, too. I tried those, but it became too complex, for me. I wound
up just using Geiser. Also, as a semi-related note, I’m using Emacs to edit Scheme code because I
don’t know of any other editor that does it so well.


<a name="installation">Installation</a>
---------------------------------------

With [ELPA](/en/emacs-tips-2/#elpa), installing Geiser is a breeze. Simply execute the following

    M-x package-install RET geiser RET

And in a few seconds, you’ll have Geiser installed in your Emacs profile. Next, put in the actual
code that invokes and configures Geiser:

```lisp
(require 'geiser)

(setq geiser-active-implementations '(mit))

(defun geiser-save ()
  (interactive)
  (geiser-repl--write-input-ring))
```

The first expression loads Geiser, itself. The second one specifies that it won’t prompt you for
other implementations if it finds them. The last one is optional—it enables you to execute

    M-x geiser-save RET

in the REPL buffer to force saving of the history to the disk file, which is found in
`~/.geiser_history.mit`, by default. It is useful if you want to save your REPL session,
immediately. Nothing is more horrifying than losing **THAT** expression. For all the Emacs code
above, to take effect, you can evaluate them now using members of the EVAL troupe—`eval-defun`,
`eval-last-sexp`, `eval-region`—or, you can still opt to respawn a new Emacs process.


<a name="usage">Usage</a>
--------------------------

To reap what you sowed, create or open a `.scm` file, with at least a proper
module declaration. Then hit:

    M-x run-geiser RET

And, boomshakalaka! A new (Emacs) window opens, containing the `* MIT REPL *`
buffer. Whatever you can do with the REPL invoked with vanilla command-line
`mit-scheme`, you can also do with this, and more. This major mode is actually
Comint mode, under the hood, with hooks to a Scheme process. For those of you
who are unfamiliar with Comint mode, it is the same mode that handles `M-x shell
RET`.

So, what can you do with it? While editing `.scm` file, here are some of the usual shortcuts that I
use. The full list of keys are [available here](https://www.nongnu.org/geiser/Cheat-sheet.html#Cheat-sheet).
Take note, that the description of the keys that I use below, are for myself initially, to help me
understand what they do. They may, or may not diverge from the official description, listed on the
aforementioned link.


### <a name="schemebuffer">Scheme buffer</a>

| Key                           | What it does                                            |
| :---------------------------- | :------------------------------------------------------ |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Switch to the REPL buffer                               |
| <kbd>C-c</kbd> <kbd>C-a</kbd> | Evaluate current buffer, then switch to the REPL buffer |
| <kbd>C-M-x</kbd>              | Evaluate current expression                             |
| <kbd>C-x</kbd> <kbd>C-e</kbd> | Evaluate last expression                                |
| <kbd>C-c</kbd> <kbd>C-r</kbd> | Evaluate region                                         |
| <kbd>C-c</kbd> <kbd>C-\</kbd> | Insert a lambda (λ) symbol                              |


### <a name="replbuffer">REPL buffer</a>

| Key                           | What it does                        |
| :---------------------------- | :---------------------------------- |
| <kbd>C-c</kbd> <kbd>C-z</kbd> | Switch to the Scheme buffer         |
| <kbd>M-p</kbd>                | Switch to the previous history item |
| <kbd>M-n</kbd>                | Switch to the next history item     |
| <kbd>C-c</kbd> <kbd>M-p</kbd> | Jump to previous prompt             |
| <kbd>C-c</kbd> <kbd>M-n</kbd> | Jump to next prompt                 |
| <kbd>C-c</kbd> <kbd>C-q</kbd> | Quit the REPL                       |


<a name="closing">Closing remarks</a>
--------------------------------------

I have intentionally skipped many topics from the [official document](http://www.nongnu.org/geiser/)
because it makes it unattractive to people who are averse to reading long blocks of text.
Ironically, this article may even qualify as one. The methods described above are by in no way
representative of how the general community does them. See ya!
