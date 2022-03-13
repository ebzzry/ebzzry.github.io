Zsh Tips 1: Aliases and Functions
=================================

<div class="center">[Esperanto](/eo/zisxkonsiletoj-1-a/) ■ English</div>
<div class="center">Last updated: July 28, 2019</div>

>A common man marvels at uncommon things; a wise man marvels at the commonplace.<br>
>―Confucius

One of the joys of working exclusively on the terminal is makes it so easy to work with commands,
files, and directories. Being able to go from idea to results happens in a very short span of
time. For interactive shell use, I use [Zsh](http://zsh.sourceforge.net/) almost exclusively. In
this article, I’ll talk about some things to improve your interactive interaction with the shell.


<a name="toc">Table of contents</a>
-----------------------------------

- [Overview](#overview)
- [Aliases](#aliases)
- [Functions](#functions)
- [Putting them all together](#all)
- [Closing remarks](#closing)


<a name="overview">Overview</a>
-------------------------------

There are at least three kinds of commands in Zsh: binaries, aliases, and functions. Binaries are
the ones that are found in your `$PATH`; they are the programs that you installed using your package
manager. Aliases and functions, or other other hand do not live as files on the filesystem. They are
defined as part of your configuration file, or inlined in your session.


<a name="aliases">Aliases</a>
-----------------------------

Aliases are those cute stupid things that you put in your config files that usually do trivial one
liners. Some of them look like the following:

    alias ls="ls -F"

Other are more aggressive like the global aliases, which can perform expansion anywhere on the command line:

    alias -g G="|& egrep --color"
    alias -g NF='*(.om[1])'

The first global alias filters the stdout and stderr to egrep with colored output. The second global
alias matches the newest regular file in the current directory.

To display all your aliases, run:

    alias


<a name="functions">Functions</a>
---------------------------------

Functions on the other hand are the bigger relatives of aliases. They can do more than what their
lesser ilk, can. One of the most important differences to note is that functions perform more that
substitution. For example, an alias like the following:

    alias meh="echo foo"

simply performs text substitution. That is, when Zsh encounters the text `foo` as the first token of
the command line, it replaces it with `echo foo`. Nothing more. So, running:

    meh

substitutes to

    echo foo

Compare the following lines:

    alias foo0="for x in foo bar baz; do echo $x; done"
    function foo1 () { for x in foo bar baz; do echo $x; done }

The keyword `function` is redundant and may be omitted. Run them and see what happens:

    % foo0
    % foo1

Aliases have a higher priority than functions. Consider the following lines:

    alias foo="echo foo"
    function foo () { echo foo, too }

Both use the name `foo`, but each uses a different namespace. When you execute `foo`:

    % foo
    foo

It displays just `foo` because, instead of `foo, too` even if the latter came from a more recent
definition. To remove the `foo` alias definition, run:

    % unalias foo
    % foo
    foo, too

As much as possible, use functions.

To display all your functions, run:

    % functions


<a name="all">Putting them all together</a>
-------------------------------------------

Littering your config file with complete function definitions for every little command that you want
is dumb. Instead, we’ll use a better way to define global aliases and small functions. Open your
`~/.zshenv` file using your favorite editor.

First let’s define the functions that will define the others.

```bash
function def_real_alias () {
  while [[ $# -ge 2 ]]; do
    alias "$1=$2"
    shift 2
  done
}

function def_real_aliases () {
  def_real_alias $real_aliases
  unset real_aliases
}

function def_global_alias () {
  while [[ $# -ge 2 ]]; do
    alias -g "$1=$2"
    shift 2
  done
}

function def_global_aliases () {
  def_global_alias $global_aliases
  unset global_aliases
}

function def_fun () {
  while [[ $# -ge 2 ]]; do
    eval "function $1 () { $2 \$@ }"
    shift 2
  done
}

function def_funs () {
  def_fun $funs
  unset funs
}
```

Next we’ll define the arrays:

```bash
real_aliases=(
  meh "echo meh"
); def_real_aliases

global_aliases=(
  :: ':>!'

  B '`git rev-parse --abbrev-ref HEAD`'

  V "|& less"
  G "|& egrep --color"
  S "|& sort"
  R "|& sort -rn"
  L "|& wc -l | sed 's/^\ *//'"

  H  "|& head"
  T  "|& tail"
  H1 "H -n 1"
  T1 "T -n 1"

  ZF '*(.L0)'     # zero-length regular files
  ZD '*(/L0)'     # zero-length directories

  AE '{,.}*'      # all files, including dot files
  AF '**/*(.)'    # all regular files
  AD '**/*(/)'    # all directories
  AS '**/*(@)'    # all symlinks

  OF '*(.om[-1])' # oldest regular file
  OD '*(/om[-1])' # oldest directory
  OS '*(@om[-1])' # oldest symlink

  NF '*(.om[1])'  # newest regular file
  ND '*(/om[1])'  # newest directory
  NS '*(@om[1])'  # newest symlink

); def_global_aliases

funs=(
  z "exec zsh"
  s "sudo"

  d "pushd"
  \- "popd"
  ds "dirs -l"

  cp "command cp -i"
  mv "command mv -i"

  l "ls -GFAtr --color"
  la "ls -AF --color"
  ll "l -l
  l1 "l -1"
  lh "l -H"
  lr "l -R"
  lk "la -l"

  sl "ln -sf"
  md "mkdir -p"

  f "fd"
  g "ripgrep --color auto"
  gi "g -i"
  tf "tail -F"
  rh "rehash"

  mount "s mount"
  umount "s umount"
  reboot "s reboot"
  poweroff "s poweroff"
  halt "s halt -p"
); def_funs
```


<a name="closing">Closing remarks</a>
-------------------------------------

Grouping commands this way makes it significantly easier to add and remove items. Bring them all
in one consolidated place also makes your config file arguably cleaner. For the rest of the
definitions, visit the repo [here](https://github.com/ebzzry/dotfiles/tree/master/zsh).

If you use git, you may also like the article about how I use it. It can be found [here](/en/git/).

_Thanks to [Jakub Jareš](https://github.com/nohwnd) for the corrections._
