Converting LiveJournal to Frog with livefrog
============================================

<div class="center">May 29, 2013</div>
<div class="center">Updated: May 13, 2016</div>

I have specific cases wherein you needed to convert LiveJournal
articles to another format. There are tools that do this, however, I
found none, so far, that translates to _Frog_ files. This is my feeble
attempt to achive that.


## Table of contents

* [Introduction](#introduction)
* [Installation](#installation)
* [Usage](#usage)
  - [Basics](#basics)
  - [Comments](#comments)
* [Updating](#updating)
* [Miscellany](#miscellany)


## Introduction <a name="introduction"></a>

livefrog is a utility written in [Racket](http://racket-lang.org),
used to migrate LiveJournal posts to
[Frog](https://github.com/greghendershott/frog/), a blogging platform
written in Racket, too. It uses the files dumped by either
[ljdump](http://hewgill.com/ljdump/), or
[ljmigrate](http://github.com/ceejbot/ljmigrate).


## Installation <a name="installation"></a>

livefrog is available via Racket’s
[Planet2](http://pkg.racket-lang.org):

```bash
$ raco pkg install livefrog
```

If that doesn’t work, you can alternately install by fetching livefrog, and the
dependencies, from github

```bash
$ git clone https://github.com/jbclements/sxml.git
$ git clone https://github.com/greghendershott/frog.git
$ git clone https://github.com/ebzzry/livefrog.git
$ raco pkg install frog/ sxml/ livefrog/
```

The trailing slashes are important, to tell `raco` that you are
installing from local directories. Without it, it will try to fetch
the sources from the internet.


## Usage  <a name="usage"></a>

This sections contains instructions for creating files suitable for
use with Frog.

### Basics <a name="basics"></a>

To create a Markdown file from the file entry.xml

```bash
$ raco livefrog -m entry.xml
```

That, however, becomes cumbersome if you’re going to manage more than
a hundred entries. To automatically “pick up” the files created by
ljdump or ljmigrate, and convert them to Markdown.

```bash
$ raco livefrog -am
```

Bear in mind, though, that ljdump and ljmigrate differ on how the
trees for the data are created. ljdump has the following tree format,
where **USERNAME** is your LiveJournal account name:

```bash
ljdump/
  build
  ChangeLog
  convertdump.py
  USERNAME/
    L-1
    L-2
    C-2
    L-3
    ...
  ljdump.config
  ljdump.config.sample
  ljdump-gui.py
  ljdump.py*
  README.txt
  TODO
```

ljmigrate, on the other hand, uses a different format:

```bash
ljmigrate/
  LICENSE.text
  ljmigrate.cfg
  ljmigrate.cfg.sample
  ljmigrate.py*
  README.md
  README_windows.txt
  TODO
  www.livejournal.com/
    USERNAME/
      entry00001/
        entry.xml
      entry00002/
        entry.xml
        comment.xml
      html/
      metadata/
      userpics/
```

After creating the Markdown Frog source files, you may now copy them
to your Frog source directory, designated at `_src/posts/`

### Comments <a name="comments"></a>

Frog, by default, uses [Disqus](http://disqus.com) to handle the
comments. To import comments to this platform, you need to generate an
XML file that must adhere to Disqus’s comment import rules.

To create a file, named `comments.xml` that will be used for importing
comments, to be used with <http://import.disqus.com>, using
`foo.bar.com` as the root site:

```bash
$ raco livefrog -s foo.bar.com -c comments.xml
```


## Updating <a name="updating"></a>

If you installed livefrog using Planet2, you can update it by running:

```bash
$ raco pkg update livefrog
```

However, if you used the latter method, you may update it by pulling
the updates, uninstalling livefrog, then installing it again:

```bash
$ cd livefrog
$ git pull origin master
$ cd ..
$ raco pkg remove livefrog
$ raco pkg install livefrog/
```


## Miscellany <a name="miscellany"></a>

To reduce typing, you may optionally create an alias to
`raco livefrog` in your shell.

Sh-like shells:

```bash
$ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc
```

Csh-like shells:

```bash
$ echo 'alias livefrog raco livefrog' >> ~/.cshrc
```

Replace `.bashrc`, and `.cshrc`, with the appropriate init file for
your shell.

The sources, along with additional information, are located at
<https://github.com/ebzzry/livefrog>.
