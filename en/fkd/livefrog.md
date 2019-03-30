Migrating from LiveJournal to Frog
==================================

<div class="center">[Esperanto](/eo/livefrog/) ▪ English</div>
<div class="center">May 29, 2013</div>
<div class="center">Last updated: September 29, 2018</div>

>I don’t know where I’m going, but I’m on my way.<br>
>―Carl Sagan

There are times when you want more control over your content. There are also times when you don’t
want another platform to dictate what goes in or out. Issues like censorship and politics, can
easily creep up on a blogging platform. I had specific cases wherein I needed to convert LiveJournal
articles to another platform. There are tools that does this, however, I found none, so far, that
translate to [Frog](https://github.com/greghendershott/frog/) files. This is my feeble attempt to
achieve that goal.


Table of contents
-----------------

- [Overview](#overview)
- [Installation](#installation)
- [Basics](#basics)
- [Comments](#comments)
- [Updating](#updating)
- [Closing remarks](#closing)


<a name="overview"></a> Overview
--------------------------------

livefrog is a utility written in [Racket](http://racket-lang.org), used to migrate LiveJournal posts
to Frog, a blogging platform written in Racket, too. It uses the files dumped by
either [ljdump](http://hewgill.com/ljdump/) or [ljmigrate](https://github.com/ceejbot/ljmigrate).


<a name="installation"></a> Installation
----------------------------------------

To be able to execute the runtimes, we need to install Racket, first:

Nix:

    $ nix-env -i racket

APT:

    $ sudo apt-get install -y racket

Next, let’s install livefrog. It is available via Racket’s [Planet2](https://pkg.racket-lang.org):

    $ raco pkg install livefrog

If that doesn’t work, you can alternatively install livefrog by fetching its dependencies directly
from GitHub:

    $ git clone https://github.com/greghendershott/frog.git
    $ git clone https://github.com/jbclements/sxml.git
    $ git clone https://github.com/ebzzry/livefrog.git
    $ raco pkg install frog/ sxml/ livefrog/

The trailing slashes are important, to tell `raco` that you are installing from local
directories. Without it, it will try to fetch the sources from the internet.


<a name="basics"></a>Basics
---------------------------

To create a Markdown file from the file `entry.xml`

    $ raco livefrog -m entry.xml

That, however, becomes cumbersome if you’re going to manage more than a hundred entries. To
automatically “pick up” the files created by ljdump or ljmigrate, and convert them to Markdown

    $ raco livefrog -am

Bear in mind, though, that ljdump and ljmigrate differ on how the trees for the data are
created. ljdump has the following tree format, where `username` is your LiveJournal account name:

```bash
ljdump/
  build
  ChangeLog
  convertdump.py
  username/
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
    username/
      entry00001/
        entry.xml
      entry00002/
        entry.xml
        comment.xml
      html/
      metadata/
      userpics/
```

After creating the Markdown Frog source files, you may now copy them to your Frog source directory,
designated at `_src/posts/`


<a name="comments"></a> Comments
--------------------------------

Frog, by default, uses [Disqus](https://disqus.com) to handle the comments. To import comments to
this platform, you need to generate an XML file that must adhere to Disqus’s comment import rules.

To create a file, named `comments.xml` with `foo.bar.com` as the root site:

    $ raco livefrog -s foo.bar.com -c comments.xml

This will be used with <https://import.disqus.com>.


<a name="updating"></a> Updating
--------------------------------

If you installed livefrog using Planet2, you can update it by running:

    $ raco pkg update livefrog

However, if you used the latter method, you may update it by fetching the updates, uninstalling
livefrog, then installing it again:

    $ cd livefrog
    $ git pull origin master
    $ cd ..
    $ raco pkg remove livefrog
    $ raco pkg install livefrog/


<a name="closing"></a> Closing remarks
--------------------------------------

To reduce typing, you may create an alias to `raco livefrog` in your shell.

sh-like shells—sh, ash, DASH; mksh; Bash; and Zsh; respectively:

    $ echo 'alias livefrog="raco livefrog"' >> ~/.profile

    $ echo 'alias livefrog="raco livefrog"' >> ~/.mkshrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.bashrc

    $ echo 'alias livefrog="raco livefrog"' >> ~/.zshenv

csh-like shells—Csh, Tcsh:

    $ echo 'alias livefrog raco livefrog' >> ~/.cshrc

Replace `.bashrc` and `.cshrc`, with the appropriate init file for your shell.

The sources, along with additional information, are
located [here](https://github.com/ebzzry/livefrog). If you know Racket, fork it!
