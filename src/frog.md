Blogging with Frog
==================

<div class="center">February 19, 2014</div>
<div class="center">Updated: March 16, 2017</div>

When publishing blog content to the web, most would rely on
pre-fabricated services, that do most of the heavy lifting. However,
there are instances when you want to have more control over your
stuff. A good example of which are the constraints that providers
enforce. Another is the presence of ads, or the use of freemium
services, i.e., things can be done, only up to a certain visible
limit.

One may argue that all they need is a platform to blog with, and that
they don’t need the extra flexibility. While that is fine, some of us,
including me, want to be free from these shackles. I don’t want ads on
my site. I don’t want surprise censorship. I don’t want to pay for
services that I can get for free. I want freedom. Now, if you’re like
me, then read on.


## Table of contents

* [Introduction](#introduction)
* [Installation](#installation)
* [First use](#firstuse)
* [Creating new posts](#createnew)
* [Customizations](#customizations)
  - [.frogrc](#.frogrc)
  - [page-template.html](#page-template.html)
  - [post-template.html](#post-template.html)
  - [bootstrap.css](#bootstrap)
* [Miscellany](#miscellany)
* [Comments](#comments)
* [Show time!](#showtime)
* [Closing remarks](#closing)



## Introduction <a name="introduction"></a>

When I was looking for tools to create this blog, I became
dissatisfied with most of the mainstream options. Some are the just
too difficult to setup, while some are lacking in features. I became
frustrated because each end of the spectrum forces me to use something
that is extremely mediocre in at least one critical
aspect. Fortunately, I found
[Frog](http://github.com/greghendershott/frog), via a suggestion on
`#racket`.

Frog, in layman’s terms, is a site creator, that is very easy to use,
configure, and customize. Whatever you write, will appear on your
blog — you get what you expect. There are no weird terms of use, nor
arbitrary limits, nor coercion — it’s very close to full control, at the
tip of your fingertips.

Frog operates somewhere in the middle. That is, it looks like this:

>Raw Content -> _Frog_ -> HTML

Where raw content is either Markdown, Scribble, or HTML source files,
or a combination of all. Frog takes in those input files, and it
outputs nice HTML that you can upload to your web server. Easy? No,
it’s even easier that it sounds.


## Installation <a name="installation"></a>

In the succeeding sections, let’s presume that your username is
`john`, and your home directory is `/home/john/`.


To install Frog, you need to install Racket, first. Chances are, your
package manager already has it. To install Racket on Debian, run:

```bash
$ sudo apt-get install racket
```

In the unlikely event that it can’t be installed using your package
manager, go to
[racket-lang.org/download/](http://racket-lang.org/download/) , then
follow the instructions from there.

Next, you need to install Frog.

```bash
$ raco pkg install frog
```

After which, you’ll get the `raco frog` command. Let’s display its
help options:

```bash
$ raco frog -h
```


## First use <a name="firstuse"></a>

Sweet. Now that you have Frog installed, let’s get rolling. To create
your first Frog-powered website, you’ll create a project directory
first:

```bash
$ mkdir blog
$ cd blog
```

You’ll then fire the spark plug, to initialize the site repository:

```bash
$ raco frog --init
```

You’ll see a message saying that your website is ready. Let’s follow
the suggested command:

```bash
$ raco frog -bp
```

What that command does is that it builds the HTML files from the
sample source files created with the `--init` switch, then it runs a
local web server, serving by default, the location
[http://localhost:3000](http://localhost:3000). Frog will then open a
new browser tab, or window, pointing to that URL. The page that you’ll
see contains the default site layout. When you’re OK with it, let’s go
back to the terminal, and kill that process by hitting <kbd>C-c</kbd>.


## Creating new posts <a name="createnew"></a>

Creating a new article from scratch is another easy task:

```bash
$ raco frog -n "New Blog Post."
```

What it does is that it creates a Markdown file, relative to the current
directory, with the format `_src/posts/YYYY-MM-DD-post-title.md`. With the
command above, the absolute path would be similar to:

```
/home/john/blog/_src/posts/2014-02-21-new-blog-post.md
```

Let’s edit that file, and see how it looks like:

```bash
$ emacs _src/posts/2014-02-21-new-blog-post.md
```

```
    Title: New Blog Post
    Date: 2014-02-21T18:53:42
    Tags: DRAFT

_Replace this with your post text. Add one or more
comma-separated Tags above. The special tag `DRAFT`
will prevent the post from being published._

<!-- more -->
```

Bear in mind that this file, was created for you, by the command
`raco frog -n ...`. The first three lines contains metadata about your
post. They’re the post title, date of creation, and tags,
respectively. The date was picked up from the the `-n` switch that was
issued, earlier. The `Tags` field, contains a comma-separated list of
words, that Frog would later identify the post with. When the
case-sensitive tag `DRAFT` is used, the file will be skipped during
the build phase.

Four spaces must be prefixed, prior, to those three lines, followed by
an empty line. The rest will be the actual article content, in
Markdown format. When a line by its own contain just the text
`<!-- more -->`, that line will be replaced by a hyperlink in the final HTML
form, that will point to the rest of the article. That means, all
text, after the `<!-- more -->` line will not appear in the blog
index, but will appear in the link for the whole post.

Let’s say you change that file to look something like the following:

```
    Title: New Blog Post
    Date: 2014-02-21T18:53:42
    Tags: arts, history

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec
odio. Quisque volutpat mattis eros. Nullam malesuada erat ut
turpis. Suspendisse urna nibh, viverra non, semper suscipit,
posuere a, pede.

<!-- more -->

Donec nec justo eget felis facilisis fermentum. Aliquam
porttitor mauris sit amet orci. Aenean dignissim pellentesque
felis.
```

Then, run the build command, again:

```bash
$ raco frog -bp
```

You now have two posts, as displayed in the index. To remove the
auto-generated initial post, that was created by the command
`raco frog --init`, earlier, run:

```bash
$ rm -f _src/posts/2012-01-01-a-2012-blog-post.md
```

Then, rebuild the files:

```bash
$ raco frog -bp
```


## Customizations <a name="customizations"></a>

By this time, you’re really itching to customize the site. Yep, that’s
what you’re going to do in this section.

At the basic level, there are three files that you are going to modify,
to make your initial changes:


- .frogrc
- _src/page-template.html
- _src/post-template.html
- css/bootstrap.css
- css/bootstrap.min.css


Let’s examine each of the files in the list, closer.

### .frogrc <a name=".frogrc"></a>

This file is where top-level customizations are made. Open the file
`.frogrc`, located in the current directory:

```bash
$ emacs .frogrc
```

You’ll notice that there are more than a dozen parameters that can be
tweaked. But for now, you’re only concerned about three parameters:

- scheme/host
- title
- author


`scheme/host` should contain the (sub)domain to which you’ll be
publishing your work later, `title` is the name of your blog, and
`author` is your name.

### page-template.html <a name="page-template.html"></a>

This file contains the common content, across all types of pages,
whether they are blog or non-blog posts. Open the file
`_src/page-template.html`, located in the current directory:

```bash
$ emacs _src/page-template.html
```

You’ll see an even bigger file, compared to .frogrc. This is an
special HTML file, that contains Racket, and Frog-specific code. It
will be used as a basis for all pages that you’ll create with
Frog. There are plenty of parameters here, but you’ll just tweak some
that are most usable to you, at the moment. To make it easier, I’ll
just list down the items to search and replace for:

- The Unknown Blogger
- My Blog Brand
- Welcome
- Your legal notice here

When you get to those respective sections, it should evident what to replace
them with.

### post-template.html <a name="post-template.html"></a>

Similar to `page-template.html`, but this file contains content that
will only appear with blog posts. It is also Perhaps the easiest file
to modify is `_src/post-template.html`. Let’s open it:

```bash
$ emacs _src/post-template.html
```

For now, you only need to modify the text `shortname`. It is the
identifier that links the comments section of your blog posts, to the
aforesaid Disqus account. More about this will be discussed in the
section _Comments_.

### bootstrap.css and bootstrap.min.css <a name="bootstrap"></a>

These two files are responsible for what is commonly called as
“theme”—it controls the look of the site. To change these files, let’s
head over to <http://bootswatch.com/>, then let’s select a theme you
like. Let’s presume that you want to download the *Cerulean*
theme. Click the dropdown box arrow, next to the download link, for
that theme. Select and download both `bootstrap.min.css` and
`bootstrap.css`. After which, copy them over to the css subdirectory
`css/`.

```bash
$ cp ~/Downloads/bootstrap.*.css css/
```


## Miscellany <a name="miscellany"></a>

When you created a new post earlier, you used the following command:

```bash
raco frog -n "New Blog Post"
```

That command, creates a Markdown source file. Frog, however, has
another mode — Scribble. This mode lets you use a Scribble source
file, instead. To create one, you’ll use the following command:

```bash
raco frog -N "New Blog Post"
```

Had you used this command earlier, the file will have the format
`_src/posts/YYYY-MM-DD-post-title.md`. With the command above, the
absolute path would look like:

```
/home/john/blog/_src/posts/2014-02-21-new-blog-post.scrbl
```

Again, let’s edit that file, and see how it looks like:

```bash
$ emacs _src/posts/2014-02-21-new-blog-post.scrbl
```

```
##lang scribble/manual

Title: New Blog Post
Date: 2014-02-21T18:53:42
Tags: DRAFT

Replace this with your post text. Add one or more
comma-separated Tags above. The special tag `DRAFT`
will prevent the post from being published.

<!-- more -->
```

They’re mostly the same, except with the addition of the language
specifier, `#lang scribble/manual`, and the absence of the prefix
spaces for the metadata fields.


## Comments <a name="comments"></a>

Frog makes use of [Disqus](http://disqus.com) to handle its
comments. To use it, create an account at
[disqus.com/profile/signup/](https://disqus.com/profile/signup/?next=http%3A//disqus.com/).

When you already have your account, go to
<http://disqus.com/admin/create/> to create a site, which will have an
alias called a *shortname*. The *shorname* is what you’ll register
with Disqus to uniquely identify your website. So, if you chose, for
example, `foobar`, as the shortname for the site, you may then access
<http://foobar.disqus.com> to manage the comments for that site. The
shortname mentioned here, is what you’ll use in the file
`_src/post-template.html`, as discussed above.

To import comments, from an existing blog, to Disqus, go to
<http://import.disqus.com>.


## Show time! <a name="showtime"></a>

To publish your work, upload the contents of the directory that Frog
manages; in this tutorial, it is the directory `/home/john/blog`, to your
remote web server. If the current directory is `blog/`, and you want to
send the files via rsync, the command would look like:

```bash
$ rsync -avz ./ remotehost:public_html
```

The directory `public_html` could be something else, I just used it
because it is the default with Apache.

However, if you don’t have a remote host that you can upload your work
to, via rsync, and you use [Git](http://git-scm.com), you can use the
free hosting service of [GitHub Pages](http://pages.github.com). If
you don’t have a GitHub account yet, you may go to
[GitHub](http://github.com) to create one. To use, GitHub Pages,
create a repository named `USERNAME.github.io`. So, if your username
is `johndoe`, the repository that you need to create should be named
`johndoe.github.io`.

To publish your work to GitHub Pages, you first need to add that remote
repository:

```bash
$ git remote add origin \
git@github.com:johndoe/johndoe.github.io.git
```

Then you push the commits:

```bash
$ git push origin master
```

To view your website, go to [johndoe.github.io](http://johndoe.github.io).


## Closing remarks <a name="closing"></a>

[Frog](https://github.com/greghendershott/frog) is a viable and usable site creator. It is
easy-to-use, highly configurable, flexible, and yes, open source. It gives control, back to the
author. A good example of a Frog-powered blog can be found [here](https://ngnghm.github.io/).

Frog was created by
[Greg Hendershott](http://www.greghendershott.com/). If you want to
learn more about it, head over to
<http://github.com/greghendershott/frog>. To report bugs, go to
<https://github.com/greghendershott/frog/issues>.

_Ribbit!_
