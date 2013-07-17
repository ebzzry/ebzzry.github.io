#lang scribble/manual

Title: Usync: A Data Synchronizer
Date: 2013-05-21T19:18:33
Tags: scheme, programming, networking

I am pleased to announce the release of @bold{Usync}, a site-to-site
synchronization tool written in @hyperlink["http://www.scsh.net" "Scsh"]. It
makes use of @hyperlink["http://www.cis.upenn.edu/~bcpierce/unison/" "Unison"],
and @hyperlink["http://rsync.samba.org/" "rsync"], for bi- and uni-directional
synchronizations, respectively.

The sources are located at the
@hyperlink["http://github.com/ebzzry/usync" "GitHub project page"].

<!-- more -->

@section{Introduction}

Usync is a site-to-site synchronization program written in
@hyperlink["http://www.scsh.net" "Scsh"]. It makes use of
@hyperlink["http://www.cis.upenn.edu/~bcpierce/unison/" "Unison"], and
@hyperlink["http://rsync.samba.org/" "Rsync"], for bi- and uni-directional
synchronizations, respectively.


@section{Basic Usage}

To perform two-way synchronization of the directory @code{/pub/yot/ninam},
between the current host, to the hosts @code{tarupam}, and @code{taubetmo},
while preserving the directory structure remotely (take note, that
there must be no spaces between the hosts specification, due to the
IFS environment variable, found in most shells):

@codeblock{
usync /pub/yot/ninam/ tarupam,taubetmo
}

The command above will perform two-way synchronization of the diretory
@code{ninam/} found under @code{/pub/yot/}, to @code{tarupam:/pub/yot/}, and
@code{taubetmo:/pub/yot/}.

Using our example above, the two-way synchronization system basically
tells that if the tree @code{tarupam:/pub/yot/ninam/} contains new and/or
updated items, compared with @code{localhost:/pub/yot/ninam/}, and
@code{localhost:/pub/yot/ninam/} also happens to have new and/or updated
items, then, they will trade updates.

Ideally, the result is that @code{localhost:/pub/yot/ninam/},
@code{tarupam:/pub/yot/ninam/}, and @code{taubetmo:/pub/yot/ninam/}, are all
equal.


@section{Semi-advanced Usage}

It is also possible to perform synchronization of multiple files, and
directories, to remote hosts. To do so, run:

@codeblock{
usync /pub/yot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo
}

The command above will perform two-way synchronization of the paths
@code{/pub/yot/ninam/}, @code{~/file.text}, and @code{~reyn/*.blend} to the
remote hosts @code{tarupam}, and @code{taubetmo}, using the same directory
structure that was described above.

If you want to perform one-way synchronization, of the above, like
@code{rsync}, run:

@codeblock{
usync --one-way --prefer-local /pub/yot/ninam/ ~/file.text ~reyn/draft.blend tarupam,taubetmo
}

For more usage information, run:

@codeblock{
usync --help
}


@section{Caveats}

@itemlist[
  @item{This program has been used on FreeBSD, hence making the shebang line contain @code{/usr/local/bin/scsh}. Please change it, accordingly.}
]
