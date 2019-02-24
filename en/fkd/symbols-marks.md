Symbols and Marks
=================

<div class="center">[Esperanto](/eo/signoj-interpunkcioj/) · English</div>
<div class="center">April 8, 2016</div>
<div class="center">Last updated: February 21, 2019</div>

>If you want to achieve greatness, stop asking for permission.<br>
>―Eddie Colla

*Click [here](/en/symbols-marks-condensed/) for the condensed version.*

This short guide gives you a tour on how to use the (-), ('), and (") symbols on your keyboard, that
are better suited to perform symbol duties than their ill cousins from the typewriter era. In
addition to those symbols, I’m also going to talk about replacements to frequently-used incorrect
symbols.

Each section begins with an input sequence for Linux, Mac, and Windows systems,
respectively. The `+` symbol signifies that you press the key to its left, before you press the key
to its right. That is, to input <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd>, you must press and hold
<kbd>⌥</kbd>, then press and hold <kbd>Shift</kbd>, then press <kbd>-</kbd>.


<a name="toc"></a>Table of contents
-----------------------------------

- [Notes for Linux](#notesforlinux)
- [Hyphens](#hyphens)
- [En dashes](#endashes)
- [Em dashes](#emdashes)
- [Double quotes](#doublequotes)
- [Single quotes](#singlequotes)
- [Prime symbols](#prime)
- [Horizontal ellipsis](#horizontalellipsis)
- [Closing remarks](#closingremarks)


<a name="notesforlinux"></a>Notes for Linux
-------------------------------------------

There is already a method to easily insert symbols in Linux. It is with the use of the
<kbd>Compose</kbd> key. Unfortunately, using this method is not economical. Instead, we use the
<kbd>Mode‎ߺ‎switch</kbd> key. In this article the <kbd>🐧</kbd> key signifies the
<kbd>Mode‎ߺ‎switch</kbd> key.

We must bind it in the correct configuration file. Open the file `~/.Xmodmap`, then add the following snippet:

```
!! print key
keycode 107 = Mode‎ߺ‎switch

!! left windows key
keycode 133 = Mode‎ߺ‎switch

!! right windows key
keycode 134 = Mode‎ߺ‎switch

!! menu key
keycode 135 = Mode‎ߺ‎switch

!! symbols
keycode 48 = minus underscore endash emdash
keycode 49 = grave asciitilde leftsinglequotemark
keycode 24 = apostrophe quotedbl rightsinglequotemark
keycode 25 = comma less minutes seconds
keycode 26 = period greater ellipsis
keycode 20 = bracketleft braceleft leftdoublequotemark
keycode 21 = bracketright braceright rightdoublequotemark
```

Then, run the following command:

    xmodmap ~/.Xmodmap


<a name="hyphens"></a>Hyphens (-)
---------------------------------

- Linux: <kbd>-</kbd>
- Mac: <kbd>-</kbd>
- Windows: <kbd>-</kbd>

The <kbd>-</kbd> key on your keyboard is not part of the dash family. It looks like one, but it
isn’t one. Hyphens are used to join words, and to separate syllables of a single word. For example,
to speak of a bird that eats snakes, we type:

- A snake-eating bird.

To speak of a snake that eats birds, we say:

- A snake eating bird.


<a name="endashes"></a>En dashes (–)
------------------------------------

- Linux: <kbd>🐧</kbd> + <kbd>-</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>-</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>5</kbd> <kbd>0</kbd>

The en dash is used to denote a range of values. Don’t put spaces around it. To express the date
range from 1960 to 2016, we type:

- 1960–2016

Another use of an en dash is to express a contrast or connection between words:

- Mother–daughter relationship
- San Juan–San Fernando leg

When used with other forms of date ranges, the behavior changes, slightly. If the dates being
expressed are of different months, use:

- She walked January 1 – February 15, 1800

When the month is the same, used the unspaced en dash:

- March 14–15, 1900


<a name="emdashes"></a>Em dashes (—)
------------------------------------

- Linux: <kbd>🐧</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>-</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>5</kbd> <kbd>1</kbd>

The em dash can be used in a multitude of ways. Like em dashes, don’t put spaces around it. To use
it like a colon:

- Two men are dead: Juan and Pedro.
- Two men are dead—Juan and Pedro.

To use it like a reverse colon:

- These are its qualities: soft, slimy, and spiky.
- Soft, slimy, and spiky—these are its qualities.

To use it like parentheses:

- Two men (Juan and Pedro) are dead.
- Two men—Juan and Pedro—are dead.

To denote interruption of the speaker:

- I think I will go and—hell, no.


<a name="doublequotes"></a> Double quotes (“) (”)
-------------------------------------------------

Left double quotes (“)

- Linux: <kbd>🐧</kbd> + <kbd>[</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>[</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>7</kbd>

Right double quotes (”)

- Linux: <kbd>🐧</kbd> + <kbd>]</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>[</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>8</kbd>

Double quotes are used to denote words that were spoken by a speaker.

- She came up to me and said, “Can we determine its probability?”

They are also used when writing quotes (attributions):

- “Supposing is good, but finding out is better.”―Samuel Clemens

Another popular application of double quotes is when they’re used as scare quotes–used to indicate
irony, and non-standard meanings:

- The “secure” disk can be read directly.

Lastly, it is used to mention a part of a whole:

- “Return of the Jedi” is a film in the Star Wars saga, filled with cute teddy bears.

To make it easier to remember how they look like, think of them as floating pairs of sixes and
nines:

- ⁶⁶Quoted Text⁹⁹


<a name="singlequotes"></a> Single quotes (‘) (’)
-------------------------------------------------

Left single quote (‘)

- Linux: <kbd>🐧</kbd> + <kbd>`</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>]</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>5</kbd>

Right single quote (’)

- Linux: <kbd>🐧</kbd> + <kbd>'</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>Shift</kbd> + <kbd>]</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>4</kbd> <kbd>6</kbd>

Single quotes are used when a speech is embedded within another speech:

- He muttered to himself, “I thought he said ‘It is not doable’ when we talked yesterday.”

The right single quote is also used when denoting possessions, contractions, and abbreviations:

- These are Juan’s scalpels.
- Dance like ’tis ’60.

A common mistake made with single quotes is committed when denoting year ranges:

- Wrong: 90’s music.

This is incorrect because it implies that “90” is an entity signifying ownership over
something. There is no such thing as a 90. To fix it, the right single quote must be used *before*
the year range:

- Correct: ’90s music.

This is correct because the right single quote signifies and substitutes “19.” It is also correct to
write it as “1990s.” Next, is the presence of “s.” This creates an array; 90s here would mean: 90,
91, 92, 93, 94, 95, 96, 97, 98, and 99—a series.

With that, another common mistake is to use the left single quote instead of the right one:

- Wrong: ‘90s music.

With this in mind, ’90s means the years 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, and 1999.

When expressing textual omissions and contractions, the correct character is the
[right](https://unicode-search.net/unicode-namesearch.pl?term=%E2%80%99&.submit=Search) single
quote, not the
[left](https://unicode-search.net/unicode-namesearch.pl?term=%E2%80%98&.submit=Search) one. For example,
let’s look at the contraction of “It is” in “It is the season.”

- Wrong: ‘Tis the season.
- Correct: ’Tis the season.

This also applies to the word “and” contracted to a single letter:

- Wrong: Lock ‘n’ load
- Correct: Lock ’n’ load

What the quotes substitute are the letters “a” and “d,” respectively.

Use both the left and right single quotes, however, when there are no contractions involved and that
something is treated specially:

- Take the ‘A’ Train

Here, ‘A’ is the name of a specific train or it denotes a special meaning.


<a name="prime"></a>Prime symbols (′) (″)
-----------------------------------------

Prime (′)

- Linux: <kbd>🐧</kbd> + <kbd>,</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>2</kbd> <kbd>0</kbd> <kbd>3</kbd> <kbd>2</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>8</kbd> <kbd>2</kbd> <kbd>4</kbd> <kbd>2</kbd>

Double prime (″)

- Linux: <kbd>🐧</kbd> + <kbd>Shift</kbd> + <kbd>,</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>2</kbd> <kbd>0</kbd> <kbd>3</kbd> <kbd>3</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>8</kbd> <kbd>2</kbd> <kbd>4</kbd> <kbd>3</kbd>

The quotation symbols on your keyboard (') and (") look like prime symbols but they aren’t. They’re
sloppy vestiges from typewriters. The correct glyphs are (′) and (″). The prime symbol (′) is used
to denote feet, minutes, and arcminutes, while the double prime symbol (″) is used to denote inches,
seconds, and arcseconds.

To express a height of six feet and two inches, we type:

- 6′2″

The express five degrees, four arcminutes, and three arcseconds, we type:

- 5°4′3″

The double prime symbol can also be used as the ditto mark. The ditto mark is used to indicate that
words above it are to be repeated. For example:

- Red herons, cranes, and mantises.
- Pink ″           ″            ″       ″

Optimus′?


<a name="horizontalellipsis"></a>Horizontal ellipsis (…)
--------------------------------------------------------

- Linux: <kbd>🐧</kbd> + <kbd>.</kbd>
- Mac: <kbd>⌥</kbd> + <kbd>;</kbd>
- Windows: <kbd>Alt</kbd> + <kbd>0</kbd> <kbd>1</kbd> <kbd>3</kbd> <kbd>3</kbd>

The ellipsis is used to indicate omission of a word, phrase, sentence, or a whole block of text, as
part of a larger text. It is one of the most misunderstood punctuation marks. I see a lot of times
that three periods—full stops—are used instead of the proper ellipsis symbol. In an era where
typewriters were the best ways to typeset text, using three periods worked. That time, however, has
long passed; we should use the facities available with us.

For example, it can be used like this:

- Then, she told herself …

When used as the start of a sentence, it introduces emotions and drama:

- … My love, where art thou?

When used at the end of a block, put a space before it; when used at the start, put a space after
it; when used in the middle, put spaces around it.


<a name="closing"></a>Closing remarks
-------------------------------------

Using the correct punctuation marks and symbols draws the line between class and crass. When you use
the proper symbols, you communicate to your readers that you care about syntactical correctness as
much as content value.
