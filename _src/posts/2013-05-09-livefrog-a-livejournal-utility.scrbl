#lang scribble/manual

Title: Livefrog: A LiveJournal Utility
Date: 2013-05-29T15:10:34
Tags: racket, programming

I am pleased to announce the release of @bold{livefrog}, a utility I wrote to
migrate LiveJournal articles to
@hyperlink["http://github.com/greghendershott/frog" "Frog"].

The sources, along with additional information, are located at
@hyperlink["http://github.com/ebzzry/livefrog" "github.com/ebzzry/livefrog"].

<!-- more -->

@section{Introduction}

@bold{livefrog} is a utility written in @hyperlink["http://racket-lang.org"
"Racket"], used to migrate LiveJournal posts to
@hyperlink["https://github.com/greghendershott/frog/" "Frog"], a blogging
platform written in Racket, too. It uses the files dumped by either
@hyperlink["http://hewgill.com/ljdump/" "ljdump"], or
@hyperlink["http://github.com/ceejbot/ljmigrate" "ljmigrate"].


@section{Installation}

@bold{livefrog} is available via Racket's
@hyperlink["http://pkg.racket-lang.org" "Planet2"]:

@verbatim{
$ raco pkg install livefrog
}

If that doesn't work, you can alternately install by fetching livefrog, and the
dependencies, from github

@verbatim{
$ git clone https://github.com/jbclements/sxml.git
$ git clone https://github.com/greghendershott/frog.git
$ git clone https://github.com/ebzzry/livefrog.git
$ raco pkg install frog/ sxml/ livefrog/
}

The trailing slashes are important, to tell @tt{raco} that you are
installing from local directories. Without it, it will try to fetch
the sources from the internet.


@section{Usage}

This sections contains instructions for creating files suitable for
use with Frog.

@subsection{Basics}

To create a Markdown file from the file entry.xml

@verbatim{
$ raco livefrog -m entry.xml
}

That, however, becomes cumbersome if you're going to manage more than a hundred
entries. To automatically "pick up" the files created by ljdump or ljmigrate,
and convert them to Markdown.

@verbatim{
$ raco livefrog -am
}

Bear in mind, though, that ljdump and ljmigrate differ on how the trees for the
data are created. ljdump has the following tree format, where USERNAME is your
LiveJournal account name:

@verbatim{
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
}

ljmigrate, on the other hand, uses a different format:

@verbatim{
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
}

After creating the Markdown Frog source files, you may now copy them
to your Frog source directory, designated at @tt{_src/posts/}

@subsection{Comments}

Frog, by default, uses @hyperlink["http://disqus.com" "Disqus"] to handle the
comments. To import comments to this platform, we need to generate an XML file
that must adhere to Disqus' comment import rules.

To create a file, named @tt{comments.xml} that will be used for importing
comments, to be used with @hyperlink["http://import.disqus.com/"
"import.disqus.com"], using @tt{foo.bar.com} as the root site:

@verbatim{
$ raco livefrog -s foo.bar.com -c comments.xml
}


@section{Updating}

If you installed livefrog using Planet2, you can update it by running:

@verbatim{
$ raco pkg update livefrog
}

However, if you used the latter method, you may update it by pulling
the updates, uninstalling livefrog, then installing it
again:

@verbatim{
$ cd livefrog
$ git pull origin master
$ cd ..
$ raco pkg remove livefrog
$ raco pkg install livefrog/
}


@section{Miscellany}

To reduce typing, you may optionally create an alias to @tt{raco
livefrog} in your shell.

Sh-like shells:

@verbatim{
$ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc
}

Csh-like shells:

@verbatim{
$ echo 'alias livefrog raco livefrog' >> ~/.cshrc
}

Replace @tt{.bashrc}, and @tt{.cshrc}, with the appropriate init file for
your shell.
