Zsh Tips 4: General Helpers
===========================

<div class="center">[Esperanto](/eo/zisxkonsiletoj-4-a/)┃English</div>
<div class="center">Last updated: March 19, 2022</div>

>A change in perspective is worth 80 IQ points.<br>
>—Alan Kay

<img src="/images/site/adam-hornyak-Cm187aESg0k-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="adam-hornyak-Cm187aESg0k-unsplash" title="adam-hornyak-Cm187aESg0k-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Functions](#functions)
  + [map](#map)
  + [rmap](#rmap)
  + [fp](#fp)
  + [d](#d)
  + [d!](#d_bang)
  + [rm!](#rm_bang)
  + [rm+](#rm_plus)
  + [rm@](#rm_at)
  + [def_mk](#defmk)
  + [cp!](#cp_bang)
  + [mv!](#mv_bang)
- [Keybindings](#keybindings)
  + [insert-last-word](#insertlastword)
  + [copy-prev-shell-word](#copyprevshellword)
  + [Substitutions](#substitutions)
  + [Quotes](#quotes)
- [Putting them all together](#all)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

Last time, I talked about helper functions to assist in managing chroot environments. In this
article, I’ll talk about general helpers for working with the command line. I will also talk about
helpful keybindings to speed up typing.


<a name="functions">Functions</a>
---------------------------------

A beautiful thing about functions is that they’re so easy to create and use. Here are some functions
that I use often.


### <a name="map">map</a>

When you have a command that takes only a single argument, you can simulate multiple usage of that
command through this function. It is defined as:

```bash
function map () {
  for i (${argv[2,-1]}) { ${(ps: :)${1}} $i }
}
```

For example, you can use `map` to fetch multiple git repositories, serially:

    % map 'git clone' git@github.com:nixos/nixpkgs.git git@github.com:tmux/tmux.git


### <a name="rmap">rmap</a>

As the name implies, `rmap` operates as the reverse of `map`—the rest of the arguments are
applied as commands to the first argument. It is defined as:

```bash
function rmap () {
  for i (${argv[2,-1]}) { ${(ps: :)${i}} $1 }
}
```

You may use it, for example, to check disk usage, view file information, and view the open file
descriptors of a file or directory:

    % rmap somedir 'du -h' stat 'sudo lsof'


### <a name="fp">fp</a>

I want a quick way to quickly determine the real and absolute path of a given file or
directory. This helps me a lot in scripting. I have `fp` which is defined as:

```bash
function fp () {
  echo "${1:A}"
}
```

If I am in a symlinked directory, and I want do determine the real path of `.`, I can run:

    % fp .

This function will be of important use in the next sections.


### <a name="d">d</a>

Most of the time, when I change to a directory, I need to perform a series of commands. I want to
save time typing, so instead of running two commands, I can run only one. I also want a way to
quickly switch through the directory stack created by `pushd`. I have it defined as:

```bash
function d () {
  if (( ! $#@ )); then
      builtin cd
  elif [[ -d $argv[1] ]]; then
      builtin cd "$(fp $argv[1])"
      $argv[2,-1]
  elif [[ "$1" = -<-> ]]; then
      builtin cd $1 > /dev/null 2>&1
      $argv[2,-1]
  else
    echo "$0: no such file or directory: $1"
  fi
}
```

When I run `d` alone:

    % d

I go back to my home directory, just like a standalone `cd` would do:

When I run `d` with a directory and a command:

    % d ~/Downloads ls -l

I change directory to `~/Downloads` then I run `ls -l` display the directory listing of that directory.

If the output of `dirs -v` is:

```
0       /usr/local
1       /tmp
```

Then, when I run `d` with the second entry as its argument plus a command:

    % d -1 date

I change directory to `/tmp/`, then I execute the `date` command.


### <a name="d_bang">d!</a>

As the name implies, `d!` is like its cousin, only that, when the directory does not exist, it
creates it for you, switches to it, then behaves as `d`. It is defined as:

```bash
function d! () {
  mkdir -p $argv[1]
  d "$@"
}
```

For example, I can use `d!` to stage a directory before downloading an ISO:

    % d! ~/Downloads/iso https://www.foo.bar/baz/meh/meh.iso


### <a name="rm_bang">rm!</a>

When I am certain that I want to delete a file or directory, I don’t want to be bothered by prompts, while at the same time I want to make an exception not to accidentally delete my home directory. I defined it as:

```bash
function rm! () {
  if [[ "$1" == "$HOME" || "$1" == "$HOME/" || "$1" == "~" || "$1" == "~/" ]]; then
      return 1
  else
    command rm -rf $@
  fi
}
```

The command `command` ensures that I am calling the system binary `rm` instead of any shell alias or function.


### <a name="rm_plus">rm+</a>

When I want to quickly remove a tree containing a lot of files and directories, I use the `parallel` command to run the deletions in parallel, instead of serially. I have a helper function defined as:

```bash
function rm+ () {
  parallel 'rm -rf {}' ::: $@
}
```

Consult your package management system on how to install `parallel`.


### <a name="rm_at">rm@</a>

From time to time, I need to delete a file or directory without the chances of recovery. For that I
use the `shred` command. I have a helper function defined as:

```bash
function rm@ () {
  if [[ -d $1 ]]; then
      find $1 -type f -exec shred -vfzun 10 {} \;
      command rm -rf $1
  else
    shred -vfzun 10 $1
  fi
}
```

Consult your package management system on how to install `shred`.


### <a name="defmk">def_mk</a>

This helper generates helpers. It allows us to create functions that create a staging directory
before the actual command is executed. It is defined as:

```bash
function def_mk () {
  eval "function ${argv[1]} () {
            if [[ \$# -ge 2 ]]; then
                if [[ ! -e \${@: -1} ]]; then
                     mkdir -p \${@: -1}
                fi

                command ${argv[2,-1]} \$@
            fi
        }"
}
```

To use it, supply the name of the function that will be used as a command, and the expansion
itself. These invocations should ideally be in your config file.


### <a name="cp_bang">cp!</a>

To use `def_mk` with `cp` invoke it as:

    def_mk cp! cp -rf

which expands to:

```
function cp! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command cp -rf $@
  fi
}
```

The `cp!` command will allow us to copy files to a directory, creating that directory as necessary:

```bash
%  tree
.
├── bar.txt
└── foo.txt

0 directories, 2 files

%  cp! * a

%  tree
.
├── a
│   ├── bar.txt
│   └── foo.txt
├── bar.txt
└── foo.txt

1 directory, 4 files
```


### <a name="mv_bang">mv!</a>

To use `def_mk` with `mv` invoke it as:

    def_mk mv! mv -f

which expands to:

```
function mv! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command mv -f $@
  fi
}
```


The `mv!` command will allow us to move files to a directory, creating that directory as necessary:

```bash
%  tree
.
├── bar.txt
└── foo.txt

0 directories, 2 files

%  mv! * b

%  tree
.
└── b
    ├── bar.txt
    └── foo.txt

1 directory, 2 files
```


<a name="keybindings">Keybindings</a>
-------------------------------------

Aside from commands that are typed, one can also invoke keyboard shortcuts to perform arbitrary
commands. Here are some that I use, a lot:


### <a name="insertlastword">insert-last-word</a>

When I want to insert the last word of the last command, I call `insert-last-word`. For example, if
you have the following:

    % dig foo12345.bar.baz.com
    % mtr
          ^

When I execute `M-x insert-last-word RET`, Zsh inserts the last word of the last command, turning it
to:

    % dig foo12345.bar.baz.com
    % mtr foo12345.bar.baz.com

This ensures that that arguments gets copied accurately.

This key is bound by default to <kbd>M-.</kbd>. If you want to make sure that you have it, put the
following in your config:

    bindkey "\e." insert-last-word


### <a name="copyprevshellword">copy-prev-shell-word</a>

When I want to repeat the last word in the current command line, I call `copy-prev-shell-word`. For
example, if you have the following:

    % cp this.is.a.file.with.a.very.long.name
                                              ^

When I execute `M-x copy-prev-shell-word RET`, Zsh inserts the last word, turning it to:

    % cp this.is.a.file.with.a.very.long.name this.is.a.file.with.a.very.long.name
                                                                                  ^

I bound it to <kbd>M-=</kbd>. To bind it in your config file:

    bindkey "\e=" copy-prev-shell-word


### <a name="substitutions">Substitutions</a>

In addition to executing `M-x` commands, Zsh also permits us to define keybindings that insert
arbitrary text to the command line, including control characters.

I frequently have the need to process the output of a command. Usually I would do the following:

    % foo `some command`

or

    % foo $(some command)

The former is easier to type but it can’t be nested; the latter is too cumbersome to type. For
that, I bound the key <kbd>M-`</kbd> as:

    % bindkey -s '\e`' '$()\C-b'

So, when I have the following:

    % foo
          ^

When I hit <kbd>M-`</kbd>, I get:

    % foo $()
            ^


### <a name="quotes">Quotes</a>

I frequently have the need to quote the argument of a command, especially if it has
metacharacters. A frequent case is with YouTube URLs, which contain the `?` character.

For that I bound <kbd>M-'</kbd> as:

    % bindkey -s "\e'" "''\C-b"

So, when I have the following:

    % youtube-dl
                 ^

When I hit <kbd>M-'</kbd>, I get:

    % youtube-dl ''
                  ^

Instead of pressing three keys on my keyboard, I only get to press two, plus it ensures that I get a
pair of quotes.


<a name="all">Putting them all together</a>
-----------------------------------------

Here are all the definitions, along with some more helpers, all in one place:

```bash
function map () {
  for i (${argv[2,-1]}) { ${(ps: :)${1}} $i }
}

function rmap () {
  for i (${argv[2,-1]}) { ${(ps: :)${i}} $1 }
}

function fp () {
  echo "${1:A}"
}

function d () {
  if (( ! $#@ )); then
      builtin cd
  elif [[ -d $argv[1] ]]; then
      builtin cd "$(fp $argv[1])"
      $argv[2,-1]
  elif [[ "$1" = -<-> ]]; then
      builtin cd $1 > /dev/null 2>&1
      $argv[2,-1]
  else
    echo "$0: no such file or directory: $1"
  fi
}

function d! () {
  mkdir -p $argv[1]
  d "$@"
}

function rm! () {
  if [[ "$1" == "$HOME" || "$1" == "$HOME/" || "$1" == "~" || "$1" == "~/" ]]; then
      return 1
  else
    command rm -rf $@
  fi
}

function rm+ () {
  parallel 'rm -rf {}' ::: $@
}

function rm@ () {
  if [[ -d $1 ]]; then
      find $1 -type f -exec shred -vfzun 10 {} \;
      command rm -rf $1
  else
    shred -vfzun 10 $1
  fi
}

function def_mk () {
  eval "function ${argv[1]} () {
            if [[ \$# -ge 2 ]]; then
                if [[ ! -e \${@: -1} ]]; then
                     mkdir -p \${@: -1}
                fi

                command ${argv[2,-1]} \$@
            fi
        }"
}

def_mk cp! cp -rf
def_mk mv! mv -f

function def_key () {
  while [[ $# -ge 2 ]]; do
    bindkey "$1" "$2"
    shift 2
  done
}

function def_keys () {
  def_key $keys
  unset keys
}

function def_out_key () {
  while [[ $# -ge 2 ]]; do
    bindkey -s "$1" "$2"
    shift 2
  done
}

function def_out_keys () {
  def_out_key $out_keys
  unset out_keys
}

keys=(
  "\e." insert-last-word
  "\e=" copy-prev-shell-word
); def_keys

out_keys=(
  '\e`' '$()\C-b'
  "\e'" "''\C-b"
); def_out_keys
```


<a name="closing">Closing remarks</a>
-------------------------------------

When using the command line, especially with a shell as powerful as Zsh, it becomes mandatory to be
aware what your shell can do. Do not blindly use packages that customize your shell, without
understanding what they do.

Happy Zsh’ng!
