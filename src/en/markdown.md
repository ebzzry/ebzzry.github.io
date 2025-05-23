---
title: My Markdown Style Guide
keywords: markdown, style, guidelines, formatting
image: https://ebzzry.com/images/site/luca-bravo-bTxMLuJOff4-unsplash-1008x250.jpg
---
My Markdown Style Guide
=======================

<div class="center">English ∅ [Esperanto](/eo/markdauxno/)</div>
<div class="center">Wed Apr 5 18:29:15 2017 +0800</div>

>The laws that govern circumstances are abolished by new circumstances.<br>
>—Napoleon Bonaparte

<img src="/images/site/luca-bravo-bTxMLuJOff4-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="luca-bravo-bTxMLuJOff4-unsplash" title="luca-bravo-bTxMLuJOff4-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Headings](#headings)
  + [Level 1](#level1)
  + [Level 2](#level2)
  + [Lower levels](#lowerlevels)
- [Spacing](#spacing)
- [Code blocks](#codeblocks)
- [Bullets](#bullets)
- [Anchors](#anchors)
- [Line width](#linewidth)
- [Extras](#extras)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

I like writing in Markdown. It’s readable, lightweight, and portable. It’s plain text so you don’t
need special applications to read or write with it. In this article, I post my guidelines on how I
write Markdown files. I follow a certain set of rules so that my files look consistent with one
another, and so that GNU Emacs will be able to format it nicely.


<a name="headings">Headings</a>
--------------------------------


### <a name="level1">Level 1</a>

Level 1 headings are ideal when used as document titles. They should be used only once and they must
be in the first line of a file. It should describe what the file or document is all about. I use the
`=` (equals) symbol to indicate the level 1 heading, instead of the `#` (hash) symbol. Using `=`
makes it easy to spot the heading, and it distinguishes it from the other markers. I use it as:

```markdown
How to Fly Like a Lobster
=========================
```

instead of

```markdown
# How to Fly Like a Lobster
```


### <a name="level2">Level 2</a>

Level 2 headings indicate the top-level sections of a document. They are the primary dividers in a
file. Similar to the level 1 heading, I use the `-` (hyphen) symbol to mark the heading. I use it
as:

```markdown
Preparing Your Pincers
----------------------
```

instead of

```markdown
## Preparing Your Pincers
```


### <a name="lowerlevels">Lower levels</a>

For level 3 and lower headings, I use `#` with the appropriate number of repetitions to indicate
the level.

Level 3:

```markdown
### Fuel
```

Level 4:

```markdown
#### Organic
```

And, so on.


<a name="spacing">Spacing</a>
------------------------------

The space between document elements should be consistent to facilitate readability. After a heading,
create a blank line:

```markdown
Yeah, yeah, yeah
================

Some text here
```

When starting a new level, create two blank lines before it:

```markdown
Yeah, yeah, yeah
================

Some text here


Preparing Your Pincers
----------------------

Meh
```

Another good reason for having a blank space after every heading is to make it easy for text editors
like GNU Emacs to format the text. The keyboard shortcut <kbd>M-q</kbd>, bound by default to
`fill-paragraph`, reformats a text block so that the maximum line width is filled correctly. The
command `fill-paragraph` uses the `fill-column` variable–bound by default to 70—to reformat a text
body.

So, if you have the text:

```markdown
Preparing Your Pincers
----------------------

Meh meh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh meh
```

and you press <kbd>M-q</kbd> while point (cursor) is somewhere in the last line, it becomes:

```markdown
Preparing Your Pincers
----------------------

Meh meh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh
mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh meh
```


<a name="codeblocks">Code blocks</a>
-------------------------------------

When the code or command block occupies one to two lines, indent it with four spaces:

```sh
    VAR=blahblahblah
    function meh () { echo meh }
```

If there are three or more lines, use a pair of three backticks (```) to delimit the start and end
of a code block:

    ˋˋˋbash
    $ mkdir foo
    $ echo foo > foo/foo
    $ rm -rf foo
    $ date
    ˋˋˋ

<a name="bullets">Bullets</a>
------------------------------

When making lists, I like to use the `-` (hyphen) character to indicate the first level. Then, I use
the `+` (plus) character to indicate the second level. Finally, for level 3 and lower, I use `*`
(asterisk) character.

`-` is easier to type on a keyboard than `*`; it doesn’t require you to press <kbd>Shift</kbd> on
standard keyboards. Additionally, compared to `*`, the hyphen has a more consistent glyph across
different typefaces.

For example:

```markdown
- lobsters
  + pincers
  + thorax
- crabs
  + pincers
    * laser cannon
    * chainsaw
      * detachable
- unicorns
```


<a name="anchors">Anchors</a>
------------------------------

When the target document format of your Markdown files is HTML, it is a good habit to label your
sections properly. For example, this section is written as:

```markdown
<a name="anchors">Anchors</a>
------------------------------

```

This makes it easy later on to create a table of contents, like so:

```markdown
Table of contents
-----------------

- [Anchors](#anchors)
```


<a name="linewidth">Line width</a>
-----------------------------------

In the old days, it’s good to wrap your lines at the 70 character line width. Nowadays, a higher
limit—made possible by modern graphics system—is more desirable so that we can pack more information
in one line.

70 characters:

```
Meh meh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh
mehmeh meh mehmeh meh meh meh meh mehmeh meh mehmeh meh mehmeh meh meh
```

100 characters:

```
Meh meh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh meh meh meh
mehmeh meh mehmeh meh mehmeh meh meh
```

This guideline, however, may not apply if you are using the editors of services like GitHub or
GitLab, wherein it is usually more convenient to let the UI wrap the text.


<a name="extras">Extras</a>
----------------------------

When using GNU Emacs, I use [these](https://gist.github.com/ebzzry/1206a1922805a872713bdaf2e8c419f5)
commands, bound to <kbd>M-g =</kbd>, <kbd>M-g -</kbd>, and <kbd>M-g `</kbd>, respectively, to make
it easy for me to insert the delimiters. For example, if I have the following text, where `^` is point:

```markdown
What Is Out There?

^
```

then, when I press <kbd>M-g =</kbd>, it will become:

```markdown
What Is Out There?
==================
                  ^
```

The same apply with level 2 headings. So if I have:

```markdown
Monsters and angels

^
```

then, when I press <kbd>M-g -</kbd>, it will become:

```markdown
Monsters and angels
-------------------
                   ^
```

When I have the following:

```markdown
Code snippet:


^
```

then, when I press <kbd>M-g `</kbd>, it will become:


```markdown
Code snippet:

``````
   ^
```


<a name="closing">Closing remarks</a>
--------------------------------------

By following these simple guidelines, I create consistency among my Markdown source files. These
guidelines serve as my template when creating new documents or modifying existing ones. If you have
suggestions and criticisms, send in your pull requests!
