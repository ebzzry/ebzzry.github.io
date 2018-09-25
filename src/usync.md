Synchronizing Sites with Usync
==============================

<center>May 21, 2013</center>
<center>Updated: March 16, 2017</center>

Site-to-site synchronizations are usually needed, when two locations, which are called sites, in
this article, make file updates independently. Let’s say the company _Foo_ has two offices. In the
first office, they have the accounting, and logistics departments. In the second office, they have
the IT, and HR departments. Both have a common `/pub` tree, that has subdirectories assigned to each
department. Without synchronization, when the first office needs information from the second office,
they’d have to pull the updates, manually. With synchronization, the first office can access the
files from the second office, as if the IT and HR departments, were in the first office. Usync helps
to achieve this. Is a a site-to-site synchronization tool written in [Scsh](http://www.scsh.net). It
makes use of [Unison](http://www.cis.upenn.edu/~bcpierce/unison/),
and [rsync](http://rsync.samba.org/), for bi- and uni-directional synchronizations, respectively.


## Table of contents

- [Basic usage](#basicusage)
- [Advanced usage](#advancedusage)
- [Closing remarks](#closing)


## Basic usage <a name="basicusage"></a>

To perform two-way synchronization of the directory `/pub/yot/ninam`, between the current host, to
the hosts `tarupam`, and `taubetmo`, while preserving the directory structure remotely (take note,
that there must be no spaces between the hosts specification, due to the `IFS` environment variable,
found in most shells):

```bash
$ usync /pub/yot/ninam/ tarupam,taubetmo
```

The command above will perform two-way synchronization of the directory `ninam/` found under
`/pub/yot/`, to `tarupam:/pub/yot/`, and `taubetmo:/pub/yot/`.

Using your example above, the two-way synchronization system basically tells that if the tree
`tarupam:/pub/yot/ninam/` contains new and/or updated items, compared with
`localhost:/pub/yot/ninam/`, and `localhost:/pub/yot/ninam/` also happens to have new and/or updated
items, then, they will trade updates.

Ideally, the result is that `localhost:/pub/yot/ninam/`, `tarupam:/pub/yot/ninam/`, and
`taubetmo:/pub/yot/ninam/`, are all equal.


## Advanced usage <a name="advancedusage"></a>

It is also possible to perform synchronization of multiple files, and directories, to remote
hosts. To do so, run:

```bash
$ usync /pub/yot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo
```

The command above will perform two-way synchronization of the paths `/pub/yot/ninam/`,
`~/file.text`, and `~reyn/*.blend` to the remote hosts `tarupam`, and `taubetmo`, using the same
directory structuring system described above.

If you want to perform one-way synchronization, of the above, like _rsync_, run:

```bash
$ usync --one-way --prefer-local /pub/yot/ninam/ \
~/file.text ~reyn/draft.blend tarupam,taubetmo
```

For more usage information, run:

```bash
$ usync --help
```


## Closing remarks <a name="closing"></a>

Some files and regexes are baked in as exclusions. They make or make not make sense. If you think
they should be changed, feel free to send a pull request. The sources are
available [here](https://github.com/ebzzry/usync).
