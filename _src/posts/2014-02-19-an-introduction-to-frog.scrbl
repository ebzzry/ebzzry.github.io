#lang scribble/manual

Title: An Introduction To Frog
Date: 2014-02-19T14:07:11
Tags: racket, frog, blogging

@emph{THIS IS A DRAFT.}

When publishing blog content to the web, most would rely on pre-fabricated
services, that do most of the heavy lifting. That is fine, and that is the
choice that some choose. However, there are instances when we want to have more
control over our stuff. There are also reasons not to choose them. A good
example of which are the constraints that providers enforce. Another is the
presence of ads, or the use of freemium services, i.e., things can be done,
only up to a certain visible limit.

One may argue that all they need is a platform to blog with, and that they
don't need the extra flexibility -- a valid point. But some of us, including
me, want to free from these shackles. I don't want ads on my site. I don't want
surprise censorship. I don't want to pay for services that I can get for
free. I want freedom. Now, if you're like me, then read on.

<!-- more -->

@section{Introduction}
When I was looking for tools to create this blog, I became dissatisfied with
most of the mainstream options. Some are the just too difficult to setup, while
some are lacking in features. I became frustrated because each end of the
spectrum forces me to use something that is extremely mediocre in at least one
critical aspect. Fortunately, I found Frog, from a suggestion on #racket.

Frog, in layman's terms, is a site creator, that is very easy to use, and
configure. Its primary strengths are 1) ease of use, and 2)
customizability. Frog does not make use cloud-based site-creator
services. Whatever you write, will appear on your blog -- you get what you
expect. There are no weird terms of use, nor limits, nor coercion. It's
control, at the tip of your fingertips.

Frog operates somewhere in the middle. That is, it looks like this:

@codeblock{
Content -> Frog -> HTML
}

Where content is either Markdown, or Scribble source files, or a combination of
both. Frog takes in those input files, and it outputs nice HTML that you can
upload to your web server. Easy? No, it's even easier that it sounds.

@section{Installation}
To install Frog, we need to install Racket first. Chances are, your package
manager already has it:

@codeblock{
$ sudo apt-get install racket
}

In the unlikely event that it can't be installed using your package manager, go
to @hyperlink["http://racket-lang.org/download/"
"http://racket-lang.org/download/"], then follow the instructions from there.

Next, we need to install Frog.

@codeblock{
$ raco pkg install frog
}

@section{First Use}
Sweet. Now that we have Frog installed, let's get rolling. To create your first
Frog-powered website, we'll create a project directory first, to keep things
organized:

@codeblock{
$ mkdir blog
$ cd blog
}

We'll then fire the spark plug, to initialize the site repository:

@codeblock{
$ raco frog --init
}

You'll see a message saying that your website is ready. Let's follow the
suggested command, while @bold{inside} the directory @code{blog/}:

@codeblock{
$ raco frog -bp
}

What that command does is that it builds the HTML files from the sample source
files created with @code{--init}, then it runs a local web server, serving by
default, the location http://localhost:3000. Frog will then open a new browser
tab, or window, pointing to that URL. The page that you'll see contains the
default site layout. When you're OK with it, let's go back to the terminal, and
kill that process by hitting
@code{C-c}:


@section{Creating New Posts}
Creating a new article from scratch is another easy task:

@codeblock{
$ raco frog -n "New Blog Post."
}

What it does is that it creates a markdown file, relative to the current
directory, with the format @code|{_src/posts/YYYY-MM-DD-post-title.md}|. With the
command above, the absolute path would be similar to:

@codeblock{
/home/john/blog/_src/posts/2014-02-21-new-blog-post.md
}

Let's edit that file, and see how it looks like:

@codeblock{
emacs _src/posts/2014-02-21-new-blog-post.md
}

@codeblock{
    Title: New Blog Post
    Date: 2014-02-21T18:53:42
    Tags: DRAFT

_Replace this with your post text. Add one or more comma-separated
Tags above. The special tag `DRAFT` will prevent the post from being
published._

<!-- more -->
}

Bear in mind that this file, was created for us, by the command @code{frog -n
...}. The first three lines contains metadata about our post. They're the post
title, date of creation, and tags, respectively. The date was picked up from
the the @code{-n} command was issued. The @emph{Tags} section, contains a
comma-separated list of words, that would later identify the post with. When
the tag @emph{DRAFT} is used, no HTML files would be built, when the source
files will be compiled to HTML, later.

Four spaces @bold{MUST} be prefixed, prior, to those three lines, followed by
an empty line. The rest will be the actual article content, in Markdown
format. When a line by its own contain just the text @code{<!-- more -->}, that
line will be replaced by a hyperlink in the final HTML form, that will point to
the rest of the article. That means, all text, @bold{after} @code{<!-- more
-->}, will not appear in the blog index, but will appear in the link for the
whole post.

Let's say we change that file to look something like the following:

@codeblock{
    Title: New Blog Post
    Date: 2014-02-21T18:53:42
    Tags: arts, history

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque
volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh,
viverra non, semper suscipit, posuere a, pede.

<!-- more -->

Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit
amet orci. Aenean dignissim pellentesque felis.

Morbi in sem quis dui placerat ornare. Pellentesque odio nisi, euismod in,
pharetra a, ultricies in, diam. Sed arcu. Cras consequat.
}

You may now remove the auto-generated initial post, that was created by the
command @code{raco frog --init} above:

@codeblock{
$ rm -f _src/posts/2012-01-01-a-2012-blog-post.md
}

Then, run the build command, again:

@codeblock{
$ raco frog -bp
}

Looks nice? Good. :-)


@section{Customizations}
By this time, you're really itching to customize the site. Yep, that's what
we're going to do in this section.

At the basic level, there are three files that we are going to modify, to make
our initial changes:

@codeblock{
.frogrc
_src/page-template.html
_src/post-template.html
css/bootstrap.css
css/bootstrap.min.css
}

@subsection{.frogrc}
Open the file @code{.frogrc}, located in the current directory:

@codeblock{
$ emacs .frogrc
}

You'll notice that there are more than a dozen parameters that can be
tweaked. But for now, we're only concerned about three parameters:

@itemlist[
  @item{scheme/host}
  @item{title}
  @item{author}
]

@code{scheme/host} should
contain the (sub)domain to which you'll be publishing your work
later, @code{title} is the name of your blog, and @code{author} is your name.

@subsection{page-template.html}
Open the file @code{_src/page-template.html}, located in the current directory:

@codeblock{
$ emacs _src/page-template.html
}

You'll see an even bigger file, compared to .frogrc. This is an special HTML
file, that contains Racket, and Frog-specific code. It will be used as a basis
for all pages that you'll create with Frog. There are plenty of parameters
here, but we'll just tweak some that are most usable to us, at the
moment. To make it easier, I'll just list down the items to search and
replace for:

@itemlist[
  @item{The Unknown Blogger}
  @item{My Blog Brand}
  @item{Welcome}
  @item{Your legal notice here}
]

When you get to those respective sections, it should evident what to replace
them with.

@subsection{post-template.html}
Perhaps the easiest file to modify is @code{_src/post-template.html}. Let's
open it:

@codeblock{
$ emacs _src/post-template.html
}

For now, you only need to modify the text @code{shortname}. It is the
identifier that links the comments section of your blog posts, to the aforesaid
Disqus account. More about this will be discussed in the section
@bold{Comments}.

@subsection{bootstrap.css and bootstrap.min.css}
These two files are responsible for what is commonly called as "theme" -- it
controls the look of the site. To change these files, let's head over to
@hyperlink["http://bootswatch.com/" "bootswatch.com"]. Then select a theme we
like. Let's presume that we want to download the @bold{Cerulean} theme. Click
the dropdown box arrow, next to the download link, for that theme. Select and
download both @code{bootstrap.min.css} and @code{bootstrap.css}. After which,
copy them over to the css subdirectory @code{css/}.

@codeblock{
$ cp ~/Downloads/bootstrap.*.css css/
}


@section{Miscellany}
When we created a new post earlier, we used the following command:

@codeblock{
raco frog -n "New Blog Post"
}

That command, creates a Markdown source file. Frog, however, has another mode
-- Scribble. This mode lets you use a Scribble source file, instead. To create
one, we'll use the following command:

@codeblock{
raco frog -N "New Blog Post"
}

Had you used this command earlier, the file will have the format
@code{_src/posts/YYYY-MM-DD-post-title.md}. With the command above, the
absolute path would look like:

@codeblock{
/home/john/blog/_src/posts/2014-02-21-new-blog-post.scrbl
}

Again, let's edit that file, and see how it looks like:

@codeblock{
emacs _src/posts/2014-02-21-new-blog-post.scrbl
}

@codeblock{
#lang scribble/manual

Title: New Blog Post
Date: 2014-02-21T18:53:42
Tags: DRAFT

Replace this with your post text. Add one or more comma-separated
Tags above. The special tag `DRAFT` will prevent the post from being
published.

<!-- more -->
}

They're mostly the same, except with the addition of the language specifier,
@code{#lang scribble/manual}, and the absence of the prefix spaces for the
metadata fields.


@section{Comments}
Frog makes use of @hyperlink["http://disqus.com" "Disqus"] to handle its
comments. To use it, create an account at
@hyperlink["https://disqus.com/profile/signup/?next=http%3A//disqus.com/"
"https://disqus.com/profile/signup/"].

When you already have your account, go to
@hyperlink["http://disqus.com/admin/create/" "http://disqus.com/admin/create/"]
to create a site, which will have an alias called a @emph{shortname}. The
@emph{shorname} is what you'll register with Disqus to uniquely identify your
website. So, if you chose, for example, @code{foobar}, as the shortname for the
site, you can then access @hyperlink["http://foobar.disqus.com"
"http://foobar.disqus.com"] to manage the comments for that site. The shortname
mentioned here, is what you'll use in the file @code{_src/post-template.html},
as discussed above.

To import comments, from an existing blog, to Disqus, go to
@hyperlink["http://import.disqus.com" "http://import.disqus.com"].


@section{Show Time}
To publish your work, upload the contents of the directory that Frog
manages; in this tutorial, it is the directory @code{/home/john/blog}, to your
remote web server. If the current directory is @code{blog/}, and we want to
send the files via rsync, the command would look like:

@codeblock{
$ rsync -avz ./ remotehost:public_html
}

The directory @code{public_html} could be something else, I just used it
because it is the default with Apache.

However, if you don't have a remote host that you can upload your work to, via
rsync, and you use @hyperlink["http://git-scm.com" "Git"], you can use the free
hosting service of @hyperlink["http://pages.github.com" "GitHub Pages"]. If you
don't have a @hyperlink["http://github.com" "GitHub"] account yet, you may go
to @hyperlink["http://github.com" "github.com"] to create one. To use, GitHub
Pages, create a repository named @code{USERNAME.github.io}. So, if your
username is @code{johndoe}, the repository that you need to create should be
named @code{johndoe.github.io}.

To publish your work to GitHub Pages, we first need to add that remote
repository:

@codeblock{
$ git remote add origin git@"@"github.com:johndoe/johndoe.github.io.git
}

Then we push the commits:

@codeblock{
$ git push origin master
}

To view your website, go to @hyperlink["http://johndoe.github.io"
"http://johndoe.github.io"].


@section{Conclusion}
@hyperlink["https://github.com/greghendershott/frog" "Frog"] is a viable and
usable site creator. It is easy-to-use, highly configurable, flexible, and yes,
open source. It gives control, back to the author.

Frog was created by @hyperlink["http://www.greghendershott.com/" "Greg
Hendershott"]. You may also want to visit his GitHub page, at
@hyperlink["http://github.com/greghendershott.com"
"http://github.com/greghendershott.com"].