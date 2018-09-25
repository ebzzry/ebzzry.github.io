Zsh Tips 2: Directory Stacks
============================

<div class="center">October 18, 2017</div>
<div class="center">Updated: October 19, 2017</div>

>“What we do for ourselves dies with us. What we do for others remains forever.”<br>
>―Albert Pike

Last time, I wrote about aliases and functions, and how to use them to enhance your command line
experience. In this article, I will talk about a simple way to save and restore directory stacks.


<a name="toc">Table of contents</a>
-----------------------------------

- [Overview](#overview)
- [Saving](#saving)
- [Restoring](#restoring)
- [Closing remarks](#closing)


<a name="overview">Overview</a>
-------------------------------

Every time I change directory through `cd`, I use `pushd` to save that directory on that directory
stack. This enables me to go back to the previous directory, before I call `pushd`, with the use
of `popd`. The command `dirs`, displays the current value of the directory stack.

First, let’s define our helpers:

```bash
function d () { pushd $@ }
function - () { popd }
function ds () { dirs -l $@ }
```

Then, consider this session:

    % d ~/Downloads
    % ds -v
    0       /home/ebzzry/Downloads
    % d /etc/nixos
    % d /tmp
    % ds -v
    0       /tmp
    1       /etc/nixos
    2       /home/ebzzry/Downloads

At this point I have three directories in the directory stack. If I run `popd`:

    % -

I will get the following

    % pwd
    /etc/nixos
    % ds -v
    0       /etc/nixos
    1       /home/ebzzry/Downloads


<a name="saving">Saving</a>
---------------------------

Directory stacks allows us to move through the trees that we are working on currently. Pushing to the
directory stack permits us to *visit* a directory, wherein we will perform actions there, then go
back to the last one through popping, with ease.

However, when I create a new shell, that stack is lost. I use `exec` to reload my Zsh session, to
ensure that my config files are read from scratch.

    exec zsh

But doing so, removes the stack that I have built. To work this around, I have a function that saves
the directory stack of the current session:

```bash
function z! () {
  dirs -lv | awk -F '\t' '{print $2}' | tac >! $HOME/.z
  exec zsh
}
```

Running `z!` will save the contents of the current stack, and restart the shell

    % pwd
    /home/ebzzry
    % d /etc/nixos
    % d ~/Downloads
    % d /var/lib
    % z!


<a name="restoring">Restoring</a>
---------------------------------

To accompany `z!`, I have a function that restores the saved directory stack:

```bash
function z+ () {
  if [[ -f $HOME/.z ]]; then
      local pwd=$PWD

      while read -r line; do
        pushd "$line"
      done < $HOME/.z

      pushd $pwd
  fi
}
```

To restore the saved directory stack, on the current session, or a new separate instance, run:

    % z+
    % ds -v
    0       /var/lib
    1       /home/ebzzry/Downloads
    2       /etc/nixos
    3       /home/ebzzry



<a name="closing">Closing remarks</a>
-------------------------------------

I use directory stacks as a way to save the directories that I interact with so that it will be
easier to restore to a previous working state. Having these two helper commands makes it even more
enjoyable to work in the command line. For the rest of the definitions, visit the repo
[here](https://github.com/ebzzry/dotfiles/tree/master/zsh).

