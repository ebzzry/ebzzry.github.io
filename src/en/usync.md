---
title: Synchronizing Sites with Usync
keywords: usync, synchronization, networking, files, data, databases
image: https://ebzzry.com/images/site/thomas-jensen-ISG0rUel0Uw-unsplash-2000x1125.jpg
---
Synchronizing Sites with Usync
==============================

<div class="center">English ⊻ [Esperanto](/eo/usync/)</div>
<div class="center">2013-05-21 +0800</div>

>What I cannot create, I do not understand.<br>
>—Richard P. Feynman

<img src="/images/site/thomas-jensen-ISG0rUel0Uw-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


Table of contents
-----------------

- [Introduction](#introduction)
- [Installation](#installation)
- [Basic usage](#basicusage)
- [Advanced usage](#advancedusage)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a> 
---------------------------------------

Site-to-site synchronizations are usually needed, when two locations, make file updates
independently. Let’s say the company _MMM_ has two offices. In the first office, they have the
accounting, and logistics departments. In the second office, they have the IT, and HR
departments. Both have a common `/pub` tree, that has subdirectories assigned to each
department. Without synchronization, when the first office needs information from the second office,
they’d have to pull the updates, manually. With synchronization, the first office can access the
files from the second office, as if the IT and HR departments, were in the first office. Usync helps
to achieve this. It is written in [Scsh](https://www.scsh.net). It makes use of
[Unison](http://www.cis.upenn.edu/~bcpierce/unison/), and [rsync](https://rsync.samba.org/), for bi-
and uni-directional synchronizations, respectively.


<a name="installation">Installation</a> 
---------------------------------------

Usync can be installed with Nixpkgs:

    $ nix-env -i usync

To check that Usync is indeed installed, run:

    $ which usync


<a name="basicusage">Basic usage</a>
-------------------------------------

To perform two-way synchronization of the directory `/pub/mis/doc`, between the current host, to
the hosts `site1` and `site2`, while preserving the directory structure remotely, run the
following command. Take note, that there must be no spaces between the hosts specification, due to
the `IFS` environment variable of the shell:

    $ usync /pub/mis/doc/ site1,site2

The command above will perform two-way synchronization of the directory `doc/` found under
`/pub/mis/`, to `site1:/pub/mis/`, and `site2:/pub/mis/`.

Using your example above, the two-way synchronization system basically tells that if the tree
`site1:/pub/mis/doc/` contains new and/or updated items, compared with
`localhost:/pub/mis/doc/`, and `localhost:/pub/mis/doc/` also happens to have new and/or updated
items, then, they will trade updates.

Ideally, the result is that `localhost:/pub/mis/doc/`, `site1:/pub/mis/doc/`, and
`site2:/pub/mis/doc/`, are all equal.


<a name="advancedusage">Advanced usage</a>
-------------------------------------------

It is also possible to perform synchronization of multiple files, and directories, to remote
hosts. To do so, run:

    $ usync /pub/mis/doc/ ~/file.txt ~rmm/*.txt site1,site2

The command above will perform two-way synchronization of the paths `/pub/mis/doc/`,
`~/file.txt`, and `~rmm/*.txt` to the remote hosts `site1`, and `site2`, using the same
directory structuring system described above.

If you want to perform one-way synchronization, of the above, like _rsync_, run:

    $ usync --one-way --prefer-local /pub/mis/doc/ \
    ~/file.txt ~rmm/draft.txt site1,site2

For more usage information, run:

    $ usync --help


<a name="closing">Closing remarks</a>
--------------------------------------

Some files and regexes are baked in as exclusions. They make or make not make sense. If you think
they should be changed, feel free to send a pull request. The sources are
available [here](https://github.com/ebzzry/usync).

_Thanks to [Raymund Martinez](https://zhaqenl.github.io)  for the corrections._
