    Title: Livefrog: A LiveJournal Utility
    Date: 2013-05-29T15:10:34
    Tags: racket, programming

I am pleased to announce the release of **livefrog**, a utility I
wrote to migrate LiveJournal articles to
[Frog](http://github.com/greghendershott/frog).

The sources, along with additional information, are located at
[github.com/ebzzry/livefrog](http://github.com/ebzzry/livefrog).

<!-- more -->

# Introduction

livefrog is a utility written in [Racket](http://racket-lang.org), used to migrate LiveJournal posts to
[Frog](https://github.com/greghendershott/frog/), a blogging
platform written in Racket, too. It uses the files dumped by either
[ljdump](http://hewgill.com/ljdump/), or
[ljmigrate](http://github.com/ceejbot/ljmigrate).


# Installation

livefrog is available via Racket's
[Planet2](http://pkg.racket-lang.org):

```
$ raco pkg install livefrog
```

If that doesn't work, you can alternately install by fetching livefrog, and the
dependencies, from github

```
$ git clone https://github.com/jbclements/sxml.git
$ git clone https://github.com/greghendershott/frog.git
$ git clone https://github.com/ebzzry/livefrog.git
$ raco pkg install frog/ sxml/ livefrog/
```

The trailing slashes are important, to tell `raco` that you are
installing from local directories. Without it, it will try to fetch
the sources from the internet.


# Usage

This sections contains instructions for creating files suitable for
use with Frog.

## Basics

To create a Markdown file from the file entry.xml

```
$ raco livefrog -m entry.xml
```

That, however, becomes cumbersome if you're going to manage more than a hundred
entries. To automatically "pick up" the files created by ljdump or ljmigrate,
and convert them to Markdown.

```
$ raco livefrog -am
```

Bear in mind, though, that ljdump and ljmigrate differ on how the trees for the
data are created. ljdump has the following tree format, where USERNAME is your
LiveJournal account name:

```
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

```
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

## Comments

Frog, by default, uses [Disqus](http://disqus.com) to handle the
comments. To import comments to this platform, we need to generate an XML file
that must adhere to Disqus' comment import rules.

To create a file, named `comments.xml` that will be used for importing
comments, to be used with [import.disqus.com](http://import.disqus.com/), using `foo.bar.com` as the root site:

```
$ raco livefrog -s foo.bar.com -c comments.xml
```


# Updating

If you installed livefrog using Planet2, you can update it by running:

```
$ raco pkg update livefrog
```

However, if you used the latter method, you may update it by pulling
the updates, uninstalling livefrog, then installing it
again:

```
$ cd livefrog
$ git pull origin master
$ cd ..
$ raco pkg remove livefrog
$ raco pkg install livefrog/
```


# Miscellany

To reduce typing, you may optionally create an alias to `raco
livefrog` in your shell.

Sh-like shells:

```
$ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc
```

Csh-like shells:

```
$ echo 'alias livefrog raco livefrog' >> ~/.cshrc
```

Replace `.bashrc`, and `.cshrc`, with the appropriate init file for
your shell.
