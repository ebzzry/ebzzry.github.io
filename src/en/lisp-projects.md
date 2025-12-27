---
title: Lisp: How I Make Projects
keywords: lisp, projects, common lisp, linux, macos
image: https://ebzzry.com/images/site/gwen-weustink-I3C1sSXj1i8-unsplash-2000x1125.jpg
---
Lisp: How I Make Projects
=========================

<div class="center">English ⊻ [Esperanto](/eo/lispo-projektoj/)</div>
<div class="center">2025-08-04 +0800</div>

>You have no idea what you’re trying to achieve until you’ve achieved it.<br>
>—Gerald Jay Sussman

<img src="/images/site/gwen-weustink-I3C1sSXj1i8-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Motivation](#motivation)
- [Installation](#installation)
  + [SBCL](#sbcl)
  + [Quicklisp](#quicklisp)
  + [Marie](#marie)
- [Basics](#basics)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

My original intention in writing this article was to create a part 2 of the
first article about scripting in Lisp. My plan was to talk about how I approach
command line scripting using Lisp. Instead, what I want to talk about now is how
I make Lisp projects, in a way that reduces the initial time to write
boilerplate code. I do this, a lot, that I thought that it would be better to
talk about it instead. Incidentally, this approach does make use of how I write
Lisp scripts for the command line. I believe, I’ll be able to hit somewhat like
two birds with one stone, with this one.


<a name="motivation">Motivation</a>
-----------------------------------

Writing your own project maker is a rite-of-passage in Lisp Land. They say you
can’t call yourself a _lisper_ until you can make a half-decent tool that
creates project skeletons.

My primary motivation in writing my own project maker came from not liking the
ones that are already out there. I don’t like them not because the suck. I don’t
like them because they don’t fit my needs. I have my own way of structuring my
files and directories, and modifying those existing tools to fit my needs would
essentially mean rolling out with my own tool, eventually.

Another reason why I want to roll my own is ability to specify the components
that I need for the projects that we do. My engineering team has specific needs
that warrant attention. We use [Nix](https://nixos.org) and
[Flakes](https://nixos.wiki/wiki/flakes). For that, we use the directions that
are written [here](/en/nix) and [here](/en/flakes). We also do a lot of CLI
work, so I need a way to parse command line options and arguments.


<a name="installation">Installation</a>
---------------------------------------

You may be coming to this article because you got curious, but you don’t have
the basic tools, yet; or you may be coming here, to see what’s the fuss all
about. Either way, I’m here to guide you.

The software that you need are the following:

1. SBCL
2. Quicklisp
3. Marie

### <a name="sbcl">SBCL</a>

The only decent open source Lisp implementation, nowadays, is
[SBCL](http://sbcl.org). It works on x86, x86_64, and aarch64. It runs on GNU/Linux,
macOS, and Windows. It produces high-quality optimized code. On the commercial
side of things is [LispWorks](https://lispworks.com), which is the one that I
use as my daily driver. The other ones are nice, but they’re not available on
both GNU/Linux x86_64 and macOS aarch64, which are the systems that I care about
now.

You can go directly to SBCL’s site to download it, or you can use your operating
system package manager to install it. It should look something like this:

```sh
sudo apt install -y sbcl
```

or

```sh
brew install sbcl
```

But, you already know what I mean 😉

### <a name="quicklisp">Quicklisp</a>

Quicklisp is the de facto standard for installing Lisp libraries. There are no
fancy bells and whistles. It just works. A one-liner to install it on
GNU/Linux or macOS is:

```sh
curl -O https://beta.quicklisp.org/quicklisp.lisp && sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(let ((ql-util::*do-not-prompt* t)) (ql:add-to-init-file) (sb-ext:quit))'
```

To verify that it works, run the following:

```sh
sbcl --noinform --eval '(princ (ql:client-version))' --quit
```

It should say something like this:

```
"2021-02-13"
```

### <a name="marie">Marie</a>

[Marie](https://github.com/vedainc/marie), on the other hand, is the library
that does the shenanigans of creating the project. We also need
[Clingon](https://github.com/dnaeon/clingon) to help us with command line
parsing. To fetch them, run the following:

```sh
mkdir ~/common-lisp
cd ~/common-lisp
git clone https://github.com/vedainc/marie
sbcl --noinform --eval '(ql:quickload :clingon)' --quit
```

Next, let’s put a stub function in your shell configuration to make things
easier. Run this command, and change `~/.zshenv` to `~/.bashrc`, appropriately:

```sh
cat >> ~/.zshenv << EOF
function mk {
  sbcl --noinform --eval '(ql:quickload :marie)' --eval "(marie:make-project \"\$1\")" --quit
}
EOF
. ~/.zshenv
```

But, you get the idea. Also, I don’t do any of that fish shell crap.


<a name="basics">Basics</a>
---------------------------

Now that we all the requirements installed, you can now create a project called
`foo`:

```sh
mk foo
```

What this does is it creates this tree:

```sh
├── flake.nix
├── foo-tests.asd
├── foo.asd
├── makefile
├── README.org
├── shells.nix
├── src
│   ├── build.lisp
│   ├── core.lisp
│   ├── driver.lisp
│   ├── main.lisp
│   ├── specials.lisp
│   ├── user.lisp
│   └── version.lisp
└── t
    ├── driver-tests.lisp
    ├── main-tests.lisp
    ├── user-tests.lisp
    └── version.lisp

3 directories, 17 files
```

To test that `foo` works, let’s build its command line executable:

```sh
cd ~/common-lisp/foo
make
./foo --help
```

It should show something like the following:

```sh
NAME:
  foo - 0.0.0

USAGE:
  foo [global-options] [<command>] [command-options] [arguments ...]

OPTIONS:
      --help     display usage information and exit
      --version  display version and exit
  -v, --verbose  verbosity [default: 0]

COMMANDS:
  find, f               find files
  zsh-completions, zsh  generate the Zsh completion script
  print-doc, doc        print the documentation
```


<a name="closing">Closing Remarks</a>
-------------------------------------

Marie allows me to quickly prototype an idea and have it running soon.  This
tool allows me to easily make executables that I can toss around. I used these
tools to build [Vix](https://github.com/vedainc/vix), a (very) thin wrapper
around the Nix ecosystem.
