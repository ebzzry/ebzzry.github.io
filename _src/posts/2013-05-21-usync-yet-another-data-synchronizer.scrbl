#lang scribble/manual

Title: Usync: A Data Synchronizer
Date: 2013-05-21T19:18:33
Tags: scheme, programming

I am pleased to announce the release of @bold{Usync}, a site-to-site
synchronization tool written in @hyperlink["http://www.scsh.net" "Scsh"]. It
makes use of @hyperlink["http://www.cis.upenn.edu/~bcpierce/unison/" "Unison"],
and @hyperlink["http://rsync.samba.org/" "rsync"], for bi- and uni-directional
synchronizations, respectively.

The sources, along with additional information, are located at
@hyperlink["http://github.com/ebzzry/usync" "github.com/ebzzry/usync"].

<!-- more -->

@section{Introduction}

Site-to-site synchronizations are usually needed, when two locations, which are
called sites, in this article, make file updates independently. Let's say the
company @emph{Foo} has two offices. In the first office, they have the
accounting, and logistics departments. In the second office, they have the IT,
and HR departments. Both have a common @tt{/pub} tree, that has subdirectories
assigned to each department. Without synchronization, when the first office
needs information from the second office, they'd have to pull the updates,
manually. With synchronization, the first office can access the files from the
second office, as if the IT and HR departments, were in the first office. Usync
helps to achieve this.


@section{Basic Usage}

To perform two-way synchronization of the directory @tt{/pub/yot/ninam},
between the current host, to the hosts @tt{tarupam}, and @tt{taubetmo},
while preserving the directory structure remotely (take note, that
there must be no spaces between the hosts specification, due to the
@tt{IFS} environment variable, found in most shells):

@verbatim{
$ usync /pub/yot/ninam/ tarupam,taubetmo
}

The command above will perform two-way synchronization of the diretory
@tt{ninam/} found under @tt{/pub/yot/}, to @tt{tarupam:/pub/yot/}, and
@tt{taubetmo:/pub/yot/}.

Using our example above, the two-way synchronization system basically
tells that if the tree @tt{tarupam:/pub/yot/ninam/} contains new and/or
updated items, compared with @tt{localhost:/pub/yot/ninam/}, and
@tt{localhost:/pub/yot/ninam/} also happens to have new and/or updated
items, then, they will trade updates.

Ideally, the result is that @tt{localhost:/pub/yot/ninam/},
@tt{tarupam:/pub/yot/ninam/}, and @tt{taubetmo:/pub/yot/ninam/}, are all
equal.


@section{Semi-advanced Usage}

It is also possible to perform synchronization of multiple files, and
directories, to remote hosts. To do so, run:

@verbatim{
$ usync /pub/yot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo
}

The command above will perform two-way synchronization of the paths
@tt{/pub/yot/ninam/}, @tt{~/file.text}, and @tt{~reyn/*.blend} to the
remote hosts @tt{tarupam}, and @tt{taubetmo}, using the same directory
structuring system described above.

If you want to perform one-way synchronization, of the above, like
@tt{rsync}, run:

@verbatim{
$ usync --one-way --prefer-local /pub/yot/ninam/ ~/file.text ~reyn/draft.blend tarupam,taubetmo
}

For more usage information, run:

@verbatim{
$ usync --help
}

@section{Caveats}

This program has been used on FreeBSD, hence making the shebang
line contain @tt{/usr/local/bin/scsh}. Please change it, accordingly.
