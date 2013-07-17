#lang scribble/manual

Title: Livescribe: A LiveJournal Utility
Date: 2013-05-29T15:10:34
Tags: racket, scribble, programming

I am pleased to announce the version 0.9 release of @bold{Livescribe}, a
@hyperlink["http://racket-lang.org" "Racket"] program, used to convert the XML
files created by @hyperlink["https://github.com/ghewgill/ljdump" "ljdump"], or
@hyperlink["https://github.com/ceejbot/ljmigrate" "ljmigrate"], to
@hyperlink["http://docs.racket-lang.org/scribble/" "Scribble"], and the output
formats that Scribble supports.

The sources are located at the
@hyperlink["http://github.com/ebzzry/livescribe" "GitHub project page"].

<!-- more -->

@section{Installation}

@bold{Livescribe} is available via Racket's
@hyperlink["http://pkg.racket-lang.org" "Planet2"].

@codeblock{
raco pkg install livescribe
}

If that doesn't work, install the dependencies, and @bold{Livescribe}
itself, from the local disk.

@codeblock{
git clone http://github.com/jbclements/sxml.git
git clone http://github.com/ebzzry/livescribe.git
raco pkg install sxml/ livescribe/
}

The trailing slashes are important, to tell @code{raco} that you are
installing from local directories. Without it, it will try to fetch
the sources from the internet.

@section{Usage}

To convert the file named @code{file.xml} to @code{file.scrbl}:

@codeblock{
raco livescribe file.xml
}

Like above, but in addition to generating @code{file.scrbl}, render it to
@code{file.html} as well, as if by running @code{scribble --html file.scrbl}.

@codeblock{
raco livescribe --html file.xml
}

Again, like above, but in addition to generating @code{file.scrbl}, render
it to @code{file.md} as well, as if by running @code{scribble --markdown file.scrbl}.

@codeblock{
raco livescribe --markdown file.xml
}

To display the list of available command line options and switches.

@codeblock{
raco livescribe -h
}

@section{Updating}

If you installed @bold{Livescribe} using the first method described in the
section @emph{Introduction}, you can update it by running:

@codeblock{
raco pkg update livescribe
}

However, if you used the latter method, you may update it by pulling
the updates, uninstalling @bold{Livescribe}, then installing it
again:

@codeblock{
cd livescribe
git pull origin master
cd ..
raco pkg remove livescribe
raco pkg install livescribe/
}

@section{Miscellany}

To reduce typing, you may optionally create an alias to @code{raco
livescribe} in your shell.

Sh-like shells:

@codeblock{
echo 'alias livescribe="raco livescribe"' >> ~/.bashrc
}

Csh-like shells:

@codeblock{
echo 'alias livescribe raco livescribe' >> ~/.cshrc
}

Replace @code{.bashrc}, and @code{.cshrc}, with the appropriate init file for
your shell.
