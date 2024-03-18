How I Roll with Git
===================

<div class="center">[Esperanto](/eo/gito/)┃English</div>
<div class="center">Last updated: November 4, 2022</div>

>Conversely, those with persistence can ignore what others think. They can press
>on in their own world, oblivious to the opinions of those around them.<br>
>—Daigo Umehara

<img src="/images/site/simon-berger-6te9SupeW1g-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="simon-berger-6te9SupeW1g-unsplash" title="simon-berger-6te9SupeW1g-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Short commands](#short)
  + [Aliases](#aliases)
  + [Alternative](#alternative)
- [Configuration](#configuration)
  + [Base function](#basefunction)
  + [Important commands](#commands1)
  + [Other commands](#commands2)
- [Putting them all together](#all)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

In my toolbox are terminal simulator, shell, editor, browser, compiler, and
git. When I encountered git several years ago, it became one of my most used
tools. Because of its speed and range of use, it became as if my third arm.

Because I use Emacs, I also have [Magit](https://magit.vc/). However, in this
article I will talk about how I use git daily on the command line.

The commands and functions that we are going to have are for Zsh and Bash. It is
possible that they also work on other shells, however, I haven’t tested them.


<a name="short">Short commands</a>
----------------------------------

With git, if we want to see the status of a repository, we use the following
command:

    git status

However, there are many occasions when we want to use a shorter version:

    git s

We use the shorter command maybe because we want to save typing time or it is
physically easier instead of typing the whole command. In this section, I will
talk about the existing methods to use shorter commands.


### <a name="aliases">Aliases</a>

Git already has faculties for defining short commands. Example, if instead of

    git clone

we use

    git c

we define an alias for the `clone` command using the alias system of git. We can
do that using two methods.

The first method is directly with the command line:

    git config --global alias.c clone

The second method is using the configuration file, which is found it
`~/.gitconfig`. Put the following text in that file:

```
[alias]
  c = clone
```

We can also use arbitrary commands inside the `alias` clause. There are two
methods to do that.

The first method is directly as if a shell command:

```
[alias]
  hello = "! echo hello world"
```

If we run the command

    git hello

it will seem as if the following command was ran:

    echo hello world

Consequently, the output is

    hello world

The second method is with defining shell functions:

```
[alias]
  hi = "! hi () { echo hi world; }; hi"
```

If we run the command

    git hi

it will seem as if the command command was ran:

    hi () { echo hi world; }
    hi

With it, a shell function with the name `hi` was first defined, then we call
that function. So, the output is:

    hi world


### <a name="alternative">Alternative</a>

While those methods are already fine with many users, they do not suffice with
me, because those methods do not have access to my full shell environment. There
are other shell functions in my configuration that I want to call. More
importantly, the it is limited only in the environment of the git configuration.

What I use instead is that I defined a shell function, wherein, I can call
them with false aliases and with valid git commands. With that system, if I use
the following command:

    git clone

Git behaves just like as it was. However, if I use the following command:

    git abc

I will call the subcommand `abc` which I defined. Even if I have defined
an alias with the same name in `~/.gitconfig` this subcommand will run with a
higher priority.


<a name="configuration">Configuration</a>
-----------------------------------------

In this section are the definitions which we need to put in the Zsh and Bash
configuration files. I have them in `~/.zshenv` and `~/.bashrc`, respectively.


### <a name="basefunction">Base function</a>

Here is the base function:

```
function git () {
  local git= self= op=

  if [[ -n "${BASH}" ]]; then
    git=$(which git)
    self=${FUNCNAME}
  elif [[ -n "${ZSH_NAME}" ]]; then
    git=$(whence -p git)
    self=$0
  else
    echo "Meh"
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    if [[ -n "${BASH}" ]]; then
      type "${self}" | less
    elif [[ -n "${ZSH_NAME}" ]]; then
      which "${self}" | less
    else
      echo "Meh"
      return 1
    fi
  else
    op="$1"
    shift

    case "${op}" in
      # commands here
      (*) =git "${op}" "$@" ;;
    esac
  fi
}
```

If there are no commands for git:

    git

the definition of function itself will be displayed.

The subcommands will live in the area marked `# commands here`. The fallback
marked with `*` means that if there is no appropriate subcommand, git will use
its internal command.


### <a name="commands1">Important commands</a>

Here are the most important commands that we need to have.

**Main operations**

```
      (s) "${git}" status ;;
      (c) "${git}" clone "$@" ;;
      (h) "${git}" show "$@" ;;
      (mv) "${git}" mv "$@" ;;
      (mv!) "${git}" mv -f "$@" ;;
      (me) "${git}" merge "$@" ;;
      (ta) "${git}" tag "$@" ;;
      (bl) "${git}" blame "$@" ;;

      (a) "${git}" add "$@" ;;
      (au) "${self}" a -u ;;
      (a.) "${self}" a . ;;
      (aum) "${self}" au; "${self}" cim "$@" ;;
      (a.m) "${self}" a.; "${self}" cim "$@" ;;
      (a.x) "${self}" a.m "x" ;;
      (aux) "${self}" aum "x" ;;
      (auxx) "${self}" aux; "${self}" rs 2 ;;
      (au.x) "${self}" a.x; "${self}" rs 2 ;;
      (auxx!) "${self}" auxx; "${self}" oo! ;;

      (cl) "${git}" clean "$@" ;;
      (cl!) "${self}" cl -f ;;

      (ci) "${git}" commit "$@" ;;
      (cia) "${self}" ci --amend "$@" ;;
      (cim) "${self}" ci --message "$@" ;;

      (co) "${git}" checkout "$@" ;;
      (com) "${self}" co main ;;
      (cot) "${self}" co trunk ;;
      (co!) "${self}" co --force "$@" ;;
      (cob) "${self}" co -b "$@" ;;

      (ls) "${git}" ls-files "$@" ;;
      (lsm) "${self}" ls -m ;;
      (lsd) "${self}" ls -d ;;
      (lsdrm) "${self}" lsd | xargs "${git}" rm ;;

      (rt) "${git}" reset "$@" ;;
      (rt!) "${self}" rt --hard "$@" ;;
      (rv) "${git}" revert "$@" ;;

      (g) "${git}" grep "$@" ;;
      (gi) "${self}" g -i "$@" ;;

      (f) "${git}" fetch "$@" ;;
      (fa) "${self}" f --all "$@" ;;

      (rm) "${git}" rm "$@" ;;
      (rmr) "${self}" rm -r "$@" ;;
      (rm!) "${self}" rm -rf "$@" ;;
```

**Pushing and pulling**

```
      (ph) "${git}" push "$@" ;;
      (phu) "${self}" ph -u "$@" ;;
      (ph!) "${self}" ph --force "$@" ;;
      (pho) "${self}" phu origin "$@" ;;
      (phoo) "${self}" phu origin "$(git brh)" ;;
      (phd) "${self}" ph --delete "$@" ;;
      (phdo) "${self}" phd origin "$(git brh)" ;;
      (oo) "${self}" ph origin "$(git brh)" ;;
      (oo!) "${self}" ph! origin "$(git brh)" ;;

      (pl) "${git}" pull "$@" ;;
      (pl!) "${self}" pl --force "$@" ;;
      (plr) "${self}" pl --rebase "$@" ;;
      (plro) "${self}" plr origin "$@" ;;
      (plroo) "${self}" plr origin "$(git brh)" ;;
      (plru) "${self}" plr upstream "$@" ;;
      (plruo) "${self}" plr upstream "$(git brh)" ;;
```


**Branches and diffs**

```
      (br) "${git}" branch "$@" ;;
      (bra) "${self}" br -a ;;
      (brm) "${self}" br -m "$@" ;;
      (brmh) "${self}" brm "$(git brh)" ;;
      (brd) "${self}" br -d "$@" ;;
      (brD) "${self}" br -D "$@" ;;
      (brh) "${git}" rev-parse --abbrev-ref HEAD ;;

      (d) "${git}" diff "$@" ;;
      (dc) "${git}" diff --cached "$@" ;;
      (dh) "${self}" d HEAD ;;
      (dhw) "${self}" d --word-diff=color ;;
```


**Logs**

```
      (l) "${git}" log "$@" ;;
      (l1) "${self}" l -1 --pretty=%B ;;
      (lo) "${self}" l --oneline ;;
      (lp) "${self}" l --patch ;;
      (lp1) "${self}" lp -1 ;;
      (lpw) "${self}" lp --word-diff=color ;;
```


### <a name="commands2">Other commands</a>

Here are other commands that we also need to define:

**Initialization and push helpers**

```
      (i) touch .gitignore; "${git}" init; "${self}" a.; "${self}" cim "$@" ;;
      (i!) "${self}" i "[top-level] make initial commit" ;;

      (oo) "${self}" ph origin "$(git brh)" ;;
      (oo!) "${self}" ph! origin "$(git brh)" ;;
```

Whenever I create new repositories, I use the following command:

    git i 'Initial commit'

What the `oo` subcommand does is that code will be pushed to the remote
named `origin` under the name of the current branch. For example, if the current
branch is `trunk`, then I run the following command:

    git oo

the command becomes

    git ph origin trunk


**Rebasing**

```
      (rb) "${git}" rebase "$@" ;;
      (rbi) "${self}" rb --interactive "$@" ;;
      (rbc) "${self}" rb --continue "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rba) "${self}" rb --abort "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rbi!) "${self}" rbi --root "$@" ;;

      (ri) "${self}" rbi HEAD~"$1" ;;
      (rs) "${self}" rt --soft HEAD~"$1" && "${self}" cim "$(git log --format=%B --reverse HEAD..HEAD@{1} | head -1)" ;;
```

I use the subcommand `rs` whenever I need to squash non-interactively. The
argument is a digit indicating how many commits do we want to squash. For
example, if I want to squash the last two commits, I run the following command:

    git rs 2


**Adding**

```
      (a) "${git}" add "$@" ;;
      (au) "${self}" a -u ;;
      (a.) "${self}" a . ;;
      (aum) "${self}" au; "${self}" cim "$@" ;;
      (a.m) "${self}" a.; "${self}" cim "$@" ;;
      (a.x) "${self}" a.m "x" ;;
      (aux) "${self}" aum "x" ;;
      (auxx) "${self}" aux; "${self}" rs 2 ;;
      (au.x) "${self}" a.x; "${self}" rs 2 ;;
      (auxx!) "${self}" auxx; "${self}" oo! ;;
```

The subcommand `aum` becomes a shorthand for `au` and `cm` in order. I use the
command `auxx` whenever I make small changes but I don’t want to add a new
visible entry in the commit log.


**Remote repositories**

```
      (re) "${git}" remote "$@" ;;
      (rea) "${self}" re add "$@" ;;
      (reao) "${self}" rea origin "$@" ;;
      (reau) "${self}" rea upstream "$@" ;;
      (rer) "${self}" re remove "$@" ;;
      (ren) "${self}" re rename "$@" ;;
      (rero) "${self}" rer origin "$@" ;;
      (reru) "${self}" rer upstream "$@" ;;
      (res) "${self}" re show "$@" ;;
      (reso) "${self}" res origin ;;
      (resu) "${self}" res upstream ;;
```


**Revisions, filters, and stash**

```
      (rl) "${git}" rev-list "$@" ;;
      (rla) "${self}" rl --all "$@" ;;
      (rl0) "${self}" rl --max-parents=0 HEAD ;;

      (cp) "${git}" cherry-pick "$@" ;;
      (cpc) "${self}" cp --continue "$@" ;;
      (cpa) "${self}" cp --abort "$@" ;;

      (fb) FILTER_BRANCH_SQUELCH_WARNING=1 "${git}" filter-branch "$@" ;;
      (fb!) "${self}" fb -f "$@" ;;
      (fbm) "${self}" fb! --msg-filter "$@" ;;
      (fbi) "${self}" fb! --index-filter "$@" ;;
      (fbe) "${self}" fb! --env-filter "$@" ;;

      (rp) "${git}" rev-parse "$@" ;;
      (rph) "${self}" rp HEAD ;;

      (st) "${git}" stash "$@" ;;
      (stp) "${self}" st pop "$@" ;;
```

Whenever I want to change to change a text from all commit messages, for example
I want to change word `dog` to `cat`, I run the following command:

    git fbm 'sed "s/dog/cat/"'

Whenever I want to completely remove a file from a repository, for example
`file.dat`, I run the following command:

    git fbi 'git rm --cached --ignore-unmatch file.dat' HEAD

Whenever I want to change the email address in the commits, for example, to
`cat@world.com`, I run the following command:

    git fbe 'export GIT_AUTHOR_EMAIL="cat@world.com"; export GIT_COMMITTER_EMAIL="cat@world.com"' --tag-name-filter cat -- --branches --tags

I then run the following command to make sure that the changes appear in the remote repository:

    git oo!


**Subtrees and submodules**

```
      (subt) "${git}" subtree "$@" ;;
      (subta) "${self}" subt add "$@" ;;
      (subtph) "${self}" subt push "$@" ;;
      (subtpl) "${self}" subt pull "$@" ;;

      (subm) "${git}" submodule "$@" ;;
      (subms) "${self}" subm status "$@" ;;
      (submy) "${self}" subm summary "$@" ;;
      (submu) "${self}" subm update "$@" ;;
      (subma) "${self}" subm add "$@" ;;
      (submi) "${self}" subm init "$@" ;;

      (ref) "${git}" reflog "$@" ;;
```


**Descriptions**

```
      (de) "${git}" describe "$@" ;;
      (det) "${self}" de --tags "$@" ;;
```


<a name="all">Putting them all together</a>
-------------------------------------------

Here are all the definitions in one location:

```
function git {
  local git= self= op=

  if [[ -n "${BASH}" ]]; then
    git=$(which git)
    self=${FUNCNAME}
  elif [[ -n "${ZSH_NAME}" ]]; then
    git=$(whence -p git)
    self=$0
  else
    echo "Ve."
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    if [[ -n "${BASH}" ]]; then
      type "${self}" | less
    elif [[ -n "${ZSH_NAME}" ]]; then
      which "${self}" | less
    else
      echo "Meh"
      return 1
    fi
  else
    op="$1"
    shift

    case "${op}" in
      (i) touch .gitignore; "${git}" init; "${self}" a.; "${self}" cim "$@" ;;
      (i!) "${self}" i "[supro] pravalorizu novdeponejon" ;;

      (s) "${git}" status ;;
      (c) "${git}" clone "$@" ;;
      (h) "${git}" show "$@" ;;
      (mv) "${git}" mv "$@" ;;
      (mv!) "${git}" mv -f "$@" ;;
      (me) "${git}" merge "$@" ;;
      (ta) "${git}" tag "$@" ;;
      (bl) "${git}" blame "$@" ;;

      (a) "${git}" add "$@" ;;
      (au) "${self}" a -u ;;
      (a.) "${self}" a . ;;
      (aum) "${self}" au; "${self}" cim "$@" ;;
      (a.m) "${self}" a.; "${self}" cim "$@" ;;
      (a.x) "${self}" a.m "x" ;;
      (aux) "${self}" aum "x" ;;
      (auxx) "${self}" aux; "${self}" rs 2 ;;
      (au.x) "${self}" a.x; "${self}" rs 2 ;;
      (auxx!) "${self}" auxx; "${self}" oo! ;;

      (cl) "${git}" clean "$@" ;;
      (cl!) "${self}" cl -f ;;

      (ci) "${git}" commit "$@" ;;
      (cia) "${self}" ci --amend "$@" ;;
      (cim) "${self}" ci --message "$@" ;;

      (co) "${git}" checkout "$@" ;;
      (com) "${self}" co main ;;
      (cot) "${self}" co trunk ;;
      (co!) "${self}" co --force "$@" ;;
      (cob) "${self}" co -b "$@" ;;

      (ls) "${git}" ls-files "$@" ;;
      (lsm) "${self}" ls -m ;;
      (lsd) "${self}" ls -d ;;
      (lsdrm) "${self}" lsd | xargs "${git}" rm ;;

      (rt) "${git}" reset "$@" ;;
      (rt!) "${self}" rt --hard "$@" ;;
      (rv) "${git}" revert "$@" ;;

      (g) "${git}" grep "$@" ;;
      (gi) "${self}" g -i "$@" ;;

      (f) "${git}" fetch "$@" ;;
      (fa) "${self}" f --all "$@" ;;

      (rm) "${git}" rm "$@" ;;
      (rmr) "${self}" rm -r "$@" ;;
      (rm!) "${self}" rm -rf "$@" ;;

      (rb) "${git}" rebase "$@" ;;
      (rbi) "${self}" rb --interactive "$@" ;;
      (rbc) "${self}" rb --continue "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rba) "${self}" rb --abort "$@" ;;
      (rbs) "${self}" rb --skip "$@" ;;
      (rbi!) "${self}" rbi --root "$@" ;;

      (ri) "${self}" rbi HEAD~"$1" ;;
      (rs) "${self}" rt --soft HEAD~"$1" && "${self}" cim "$(git log --format=%B --reverse HEAD..HEAD@{1} | head -1)" ;;

      (ph) "${git}" push "$@" ;;
      (phu) "${self}" ph -u "$@" ;;
      (ph!) "${self}" ph --force "$@" ;;
      (pho) "${self}" phu origin "$@" ;;
      (phoo) "${self}" phu origin "$(git brh)" ;;
      (phd) "${self}" ph --delete "$@" ;;
      (phdo) "${self}" phd origin "$(git brh)" ;;
      (oo) "${self}" ph origin "$(git brh)" ;;
      (oo!) "${self}" ph! origin "$(git brh)" ;;

      (pl) "${git}" pull "$@" ;;
      (pl!) "${self}" pl --force "$@" ;;
      (plr) "${self}" pl --rebase "$@" ;;
      (plro) "${self}" plr origin "$@" ;;
      (plroo) "${self}" plr origin "$(git brh)" ;;
      (plru) "${self}" plr upstream "$@" ;;
      (plruo) "${self}" plr upstream "$(git brh)" ;;

      (l) "${git}" log "$@" ;;
      (l1) "${self}" l -1 --pretty=%B ;;
      (lo) "${self}" l --oneline ;;
      (lp) "${self}" l --patch ;;
      (lp1) "${self}" lp -1 ;;
      (lpw) "${self}" lp --word-diff=color ;;

      (br) "${git}" branch "$@" ;;
      (bra) "${self}" br -a ;;
      (brm) "${self}" br -m "$@" ;;
      (brmh) "${self}" brm "$(git brh)" ;;
      (brd) "${self}" br -d "$@" ;;
      (brD) "${self}" br -D "$@" ;;
      (brh) "${git}" rev-parse --abbrev-ref HEAD ;;

      (d) "${git}" diff "$@" ;;
      (dc) "${git}" diff --cached "$@" ;;
      (dh) "${self}" d HEAD ;;
      (dhw) "${self}" d --word-diff=color ;;

      (re) "${git}" remote "$@" ;;
      (rea) "${self}" re add "$@" ;;
      (reao) "${self}" rea origin "$@" ;;
      (reau) "${self}" rea upstream "$@" ;;
      (rer) "${self}" re remove "$@" ;;
      (ren) "${self}" re rename "$@" ;;
      (rero) "${self}" rer origin "$@" ;;
      (reru) "${self}" rer upstream "$@" ;;
      (res) "${self}" re show "$@" ;;
      (reso) "${self}" res origin ;;
      (resu) "${self}" res upstream ;;

      (rl) "${git}" rev-list "$@" ;;
      (rla) "${self}" rl --all "$@" ;;
      (rl0) "${self}" rl --max-parents=0 HEAD ;;

      (cp) "${git}" cherry-pick "$@" ;;
      (cpc) "${self}" cp --continue "$@" ;;
      (cpa) "${self}" cp --abort "$@" ;;

      (fb) FILTER_BRANCH_SQUELCH_WARNING=1 "${git}" filter-branch "$@" ;;
      (fb!) "${self}" fb -f "$@" ;;
      (fbm) "${self}" fb! --msg-filter "$@" ;;
      (fbi) "${self}" fb! --index-filter "$@" ;;
      (fbe) "${self}" fb! --env-filter "$@" ;;

      (rp) "${git}" rev-parse "$@" ;;
      (rph) "${self}" rp HEAD ;;

      (st) "${git}" stash "$@" ;;
      (stp) "${self}" st pop "$@" ;;

      (subt) "${git}" subtree "$@" ;;
      (subta) "${self}" subt add "$@" ;;
      (subtph) "${self}" subt push "$@" ;;
      (subtpl) "${self}" subt pull "$@" ;;

      (subm) "${git}" submodule "$@" ;;
      (subms) "${self}" subm status "$@" ;;
      (submy) "${self}" subm summary "$@" ;;
      (submu) "${self}" subm update "$@" ;;
      (subma) "${self}" subm add "$@" ;;
      (submi) "${self}" subm init "$@" ;;

      (ref) "${git}" reflog "$@" ;;

      (de) "${git}" describe "$@" ;;
      (det) "${self}" de --tags "$@" ;;

      (*) "${git}" "${op}" "$@" ;;
    esac
  fi
}
```

I must mention, that if we already have the function above in the shell
configuration and we have the following alias in `~/.gitconfig`:

```
[alias]
  ls = "! echo hello world"
```

then we run the following command

    git ls

the list of files managed by git will still appear on the screen, instead of the
text `hello world`.


<a name="closing">Closing remarks</a>
-------------------------------------

So, with that function, I can work with git easily because I only need to think
about the short names. Additionally, they have access to my other commands and
functions. Since I use [tmux](/en/tmux/), whenever I need to git, I only need to
press a keyboard shortcut to open another tmux window below. There, I can easily
use the git commands without changing my view which Magit unfortunately
does. Because of it, it also enables me to think separately between code and the
management of code.
