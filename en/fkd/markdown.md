My Markdown Style Guide
=======================

<div class="center">April 3, 2017</div>
<div class="center">Last updated: October 21, 2017</div>

>The laws that govern circumstances are abolished by new circumstances.<br>
>―Napoleon Bonaparte

I like writing in Markdown—it’s readable, lightweight, and portable. It’s plain text so you don’t
need special applications to read or write with it. In this article, I post my guidelines on how I
write Markdown files. I follow a certain set of rules so that my files look consistent with one
another, and so that GNU Emacs will be able to format it nicely.


Table of contents
-----------------

- [Headings](#headings)
- [Spacing](#spacing)
- [Code blocks](#codeblocks)
- [Bullets](#bullets)
- [Anchors](#anchors)
- [Line width](#linewidth)
- [Extras](#extras)
- [Closing remarks](#closing)


<a name="headings"></a> Headings
--------------------------------


### <a name="level1"></a> Level 1

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


### <a name="level2"></a> Level 2

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


### <a name="lowerlevels"></a> Lower levels

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



<a name="spacing"></a> Spacing
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
like GNU Emacs to to format the text. The keyboard shortcut <kbd>M-q</kbd>, bound by default to
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

Meh meh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh mehmeh meh
mehmeh meh mehmeh meh mehmeh meh meh
```


<a name="codeblocks"></a> Code blocks
-------------------------------------

When the code or command block occupies one to two lines, indent it with four spaces:

```bash
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

<a name="bullets"></a> Bullets
------------------------------

When making lists, I like to use the `-` (hyphen) charactr to indicate the first level. Then, I use
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


<a name="anchors"></a> Anchors
------------------------------

When the target document format of your Markdown files is HTML, it is a good habit to label your
sections properly. For example, this section is written as:

```markdown
<a name="anchors"></a> Anchors
------------------------------

```

This makes it easy later on to create a table of contents, like so:

```markdown
Table of contents
-----------------

- [Anchors](#anchors)
```


<a name="linewidth"></a> Line width
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


<a name="extras"></a> Extras
----------------------------

When using GNU Emacs, I use [these](https://gist.github.com/0c8fb40ac8db1463a933cfc19f219431)
commands, bound to <kbd>M-g =</kbd>, <kbd>M-g -</kbd>, and <kbd>M-g `</kbd>, respectively, to make
it easy for me to insert the delimiters. For example, if I have the following text, where ^ is point:

```markdown
What is it Like Out There?

^
```

then, when I press <kbd>M-g =</kbd>, it will become:

```markdown
What is it Like Out There?
==========================
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


<a name="closing"></a> Closing remarks
--------------------------------------

By following these simple guidelines, I create consistency among my Markdown source files. These
guidelines serve as my template when creating new documents or modifying existing ones. If you have
suggestions and criticisms, send in your pull requests!
