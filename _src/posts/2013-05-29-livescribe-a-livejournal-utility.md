    Title: Livescribe: A LiveJournal Utility
    Date: 2013-05-29T15:10:34
    Tags: racket, scribble, programming

I am pleased to announce the version 0.9 release of __Livescribe__, a
[Racket](http://racket-lang.org) program, used to convert the XML
files created by [ljdump](https://github.com/ghewgill/ljdump), or
[ljmigrate](https://github.com/ceejbot/ljmigrate), to
[Scribble](http://docs.racket-lang.org/scribble/), and the output
formats that Scribble supports.

The sources are located at the
[GitHub project page](http://github.com/ebzzry/livescribe).

<!-- more -->

### Installation

__Livescribe__ is available via Racket's [Planet2](http://pkg.racket-lang.org).

```
raco pkg install livescribe
```

If that doesn't work, install the dependencies, and __Livescribe__
itself, from the local disk.

```
git clone http://github.com/jbclements/sxml.git
git clone http://github.com/ebzzry/livescribe.git
raco pkg install sxml/ livescribe/
```

The trailing slashes are important, to tell `raco` that you are
installing from local directories. Without it, it will try to fetch
the sources from the internet.


### Usage

To convert the file named `file.xml` to `file.scrbl`:

```
raco livescribe file.xml
```

Like above, but in addition to generating `file.scrbl`, render it to
`file.html` as well, as if by running `scribble --html file.scrbl`.

```
raco livescribe --html file.xml
```

Again, like above, but in addition to generating `file.scrbl`, render
it to `file.md` as well, as if by running `scribble --markdown
file.scrbl`.

```
raco livescribe --markdown file.xml
```


To display the list of available command line options and switches.

```
raco livescribe -h
```


### Updating

If you installed __Livescribe__ using the first method described in the
section *Introduction*, you can update it by running:

```
raco pkg update livescribe
```

However, if you used the latter method, you may update it by pulling
the updates, uninstalling __Livescribe__, then installing it
again:

```
cd livescribe
git pull origin master
cd ..
raco pkg remove livescribe
raco pkg install livescribe/
```


### Miscellany

To reduce typing, you may optionally create an alias to `raco
livescribe` in your shell.

Sh-like shells:

```
echo 'alias livescribe="raco livescribe"' >> ~/.bashrc
```

Csh-like shells:

```
echo 'alias livescribe raco livescribe' >> ~/.cshrc
```

Replace `.bashrc`, and `.cshrc`, with the appropriate init file for
your shell.
