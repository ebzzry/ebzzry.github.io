Converting Markdown to HTML with emem
=====================================

<div class="center">[Esperanto](/eo/emem/)┃English</div>
<div class="center">Last updated: March 18, 2022</div>

>The answers you seek you will never find until you stop looking outside and start looking for them
>within yourself.<br>
>—JJ, Ergo Proxy

<img src="/bil/s-migaj-Yui5vfKHuzs-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="s-migaj-Yui5vfKHuzs-unsplash" title="s-migaj-Yui5vfKHuzs-unsplash"/>
 

<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

I have always wanted a way to create HTML documents from my Markdown files. Initially, I simply
wanted to have HTML files from my text files so that I can view them nicely on my phone. Later, I
also wanted a way to create these files so that I can upload them on the internet and view them on
other devices. There are tools that exist that does just that. I tried them, then I found myself
frequently tweaking the output just to make it look acceptable. None of them fitted my criteria:
easy to build, easy to use, and produces decent output.

I wrote [emem](https://github.com/ebzzry/emem) as a response to those needs. Emem is a small utility
that takes in Markdown input either from stdin or disk file, then it produces a HTML output that is
decent enough, at least, for regular viewing.


<a name="installation"> Installation</a>
----------------------------------------

Emem is available via [Nix](https://nixos.org/nix/). If you don’t have Nix yet, you may install it
with:

    $ curl https://nixos.org/nix/install | bash

You may then install emem with:

    $ nix-env -i emem

If you’re unable to install Nix and you have Java installed, you may instead create ad-hoc script:

```bash
$ mkdir ~/bin
$ curl -sSLo ~/bin/emem.jar https://github.com/ebzzry/emem/releases/download/v0.2.48/emem.jar
$ cat > ~/bin/emem << EOF
#!/usr/bin/env bash
java -jar \$HOME/bin/emem.jar \$@
EOF
$ chmod +x ~/bin/emem
```

When you’re done installing it, you may check the version number with:

    $ emem --version

The latest version is `0.2.50`.


<a name="usage"> Usage</a>
--------------------------

At the most basic level, simply running emem against a Markdown file produces a basic, yet complete
HTML file with all the necessary resources for correct page display. Applying emem on a file named
`README.md`:

    $ emem README.md

will create the following tree:

```
static/
  css/
  ico/
  js/
README.html
README.md
```

While, running emem like so:

    $ emem -s README.md

will create the following tree:

```
README.html
README.md
```

The `-s` option, removes the need to create a separate resource directory, and
stuffs all the resources needed into the output file making it easy and conducive to view the output
documents on devices like phones and tablets.

Take note that the document title inside the file will be used is the basename of the input
file. So, for `README.md`, it will generate `<title>README.md</title>` in the head tag. If you
format your Markdown files, such that the first two lines look like:

```
Foo Bar
=======
```

the first line will serve as the document title. To do so, run:

    $ emem -F README.md

resulting to `<title>Foo Bar</title>`.

That’s all nice and dandy, but if you want to create just a rudimentary document without all the
bells and whistles, use the plain mode:

    $ emem -Rp README.md

The `-R` option instructs emem not to build the resource files, while the `-p` option removes CSS
and JavaScript.

If you want to change the name of the output file, use `-o`:

    $ emem -o my-file.html README.md

If you have Markdown files in `~/Desktop/`, you can convert them all to HTML in one fell swoop:

    $ emem ~/Desktop

If you don’t like the default page width—40 em—use `-f` to use the available browser
page display width:

    $ emem -f README.md

A feature that I like a lot is merging. This allows one to combine multiple files into a
single output. For example, if you have `foo.md`, `bar.md`, and `baz.md`, you can merge them
together to `index.html` with `-m`:

    $ emem -mo index.html foo.md bar.md baz.md

If you are publishing for the web, it is imperative that you specify values for the description and
keyword meta attributes. You may do so with the `-D` and `-K` options,
respectively:

```bash
$ emem -D 'A diary about lobsters and crabs' \
-K 'lobsters, crabs, blog, journal, sea foods, monsters' README.md
```

It is also possible to specify [Open Graph Protocol](http://ogp.me/) values:

```bash
$ emem -D Meh -K 'foo, bar, baz' \
--og-title "Crabs and Lobsters" --og-type article \
--og-url "https://some.site/foo.html" --og-image "https://some.site/image.webp" \
README.md
```

If you want to use Google Analytics, specify your 9-digit code, including the hyphen::

    $ emem -D Foo -K 'qux, quux' -A 12345678-9 README.md

If the contents of the site is predominantly not in English, it is good to specify what language it
is, to help search engines index your site properly; it also helps software, like screen readers,
determine what language to use for the speech. For this, use the `-l` option:

    $ emem -D 'Kie estas ĝin' -K 'kukurboj, hundegoj, afiŝoj' -l eo README.md

A complete list of the supported languages of modern browsers can be
found [here](https://www.w3schools.com/tags/ref_language_codes.asp).

There are times when I don’t want to break the edit loop when working with the input files, and I
just want the HTML files to be created whenever there are new changes to the source Markdown
files. In that scenario, I invoke the continuous build mode, with the `-c` option:

    $ emem -c README.md

The other options can be mixed with `-c` to fine-tune the output. For example, to build plain output
in continuous mode:

    $ emem -Rpc README.md

emem checks for changes to `README.md` every 200 ms. If a change was detected, it will rebuild
`README.html`. The timeout between checks can be changed with the `-t` option. To specify
a 1 min timeout:

    $ emem -Rpc -t 1000 README.md

Usually I run emem thus:

    $ emem -Fis file.md

Finally, to view all the supported options:

    $ emem --help


<a name="closing"> Closing remarks</a>
--------------------------------------

For this whole [journal](https://ebzzry.com), I was able to get a 90+ score
from [Google PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/), a
Mobile-Friendly rating
from [Google Mobile-Friendly Test](https://search.google.com/test/mobile-friendly), and a
performance grade of B from [Pingdom](https://tools.pingdom.com/). If you can control the web server
parameters, you may even get a performance grade of A, when you leverage browser caching, and
specify the `Vary: Accept-Encoding` header. I’m using [GitHub Pages](https://pages.github.com), so
it’s a different story for me.

I’m quite happy with the output that emem produces. emem is fast enough and I can extend it easily.
I even use it for my personal and work documentation. I also use it with Emacs to create a web
previews of Markdown buffers using
[shell-command](https://www.gnu.org/software/emacs/manual/html_node/elisp/Synchronous-Processes.html)
and [emacs-w3m](https://www.emacswiki.org/emacs/emacs-w3m). To see emem in actual usage, go
[here](https://github.com/ebzzry/ebzzry.github.io/blob/main/makefile).

If you know a bit of Clojure, [fork it](https://github.com/ebzzry/emem/) and hack away!
