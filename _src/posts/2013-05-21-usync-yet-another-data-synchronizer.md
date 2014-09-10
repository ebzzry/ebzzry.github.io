    Title: Usync: A Data Synchronizer
    Date: 2013-05-21T19:18:33
    Tags: scheme, programming

Usync is a a site-to-site synchronization tool written in
[Scsh](http://www.scsh.net). It makes use of
[Unison](http://www.cis.upenn.edu/~bcpierce/unison/), and
[rsync](http://rsync.samba.org/), for bi- and uni-directional
synchronizations, respectively.

The sources, along with additional information, are located at
[github.com/ebzzry/usync](http://github.com/ebzzry/usync).

<!-- more -->

# Introduction

Site-to-site synchronizations are usually needed, when two locations, which are
called sites, in this article, make file updates independently. Let's say the
company **Foo** has two offices. In the first office, they have the
accounting, and logistics departments. In the second office, they have the IT,
and HR departments. Both have a common `/pub` tree, that has subdirectories
assigned to each department. Without synchronization, when the first office
needs information from the second office, they'd have to pull the updates,
manually. With synchronization, the first office can access the files from the
second office, as if the IT and HR departments, were in the first office. Usync
helps to achieve this.


# Basic Usage

To perform two-way synchronization of the directory `/pub/yot/ninam`,
between the current host, to the hosts `tarupam`, and `taubetmo`,
while preserving the directory structure remotely (take note, that
there must be no spaces between the hosts specification, due to the
`IFS` environment variable, found in most shells):

```
$ usync /pub/yot/ninam/ tarupam,taubetmo
```

The command above will perform two-way synchronization of the diretory
`ninam/` found under `/pub/yot/`, to `tarupam:/pub/yot/`, and
`taubetmo:/pub/yot/`.

Using our example above, the two-way synchronization system basically
tells that if the tree `tarupam:/pub/yot/ninam/` contains new and/or
updated items, compared with `localhost:/pub/yot/ninam/`, and
`localhost:/pub/yot/ninam/` also happens to have new and/or updated
items, then, they will trade updates.

Ideally, the result is that `localhost:/pub/yot/ninam/`,
`tarupam:/pub/yot/ninam/`, and `taubetmo:/pub/yot/ninam/`, are all
equal.


# Semi-advanced Usage

It is also possible to perform synchronization of multiple files, and
directories, to remote hosts. To do so, run:

```
$ usync /pub/yot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo
```

The command above will perform two-way synchronization of the paths
`/pub/yot/ninam/`, `~/file.text`, and `~reyn/*.blend` to the
remote hosts `tarupam`, and `taubetmo`, using the same directory
structuring system described above.

If you want to perform one-way synchronization, of the above, like
`rsync`, run:

```
$ usync --one-way --prefer-local /pub/yot/ninam/ ~/file.text ~reyn/draft.blend tarupam,taubetmo
```

For more usage information, run:

```
$ usync --help
```

# Caveats

This program has been used on FreeBSD, hence making the shebang
line contain `/usr/local/bin/scsh`. Please change it, accordingly.
