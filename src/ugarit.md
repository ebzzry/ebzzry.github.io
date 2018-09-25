Creating Backups with Ugarit
============================

<center>February 21, 2014</center>
<center>Updated: March 16, 2017</center>

How many times have you experienced hindsight, after a catastrophic event has happened? How many
times have you told yourself that had you created backups of your precious data, you wouldn’t be in
that dire situation, pulling your hair out, like a rabid maniac?

Most of us have been there—we lost our precious files due inadvertent causes. We lost them because
of disk crash, data corruption, security breach, and other reasons. But had we created a fallback, a
big, safe foam that we can land on, it wouldn’t have been a lot of trouble, and heart ache. On the
flip side, creating and managing backups can be daunting, and equally dangerous.

In this post, I’ll talk about
[Ugarit](http://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki)
, a nice piece of technology, that combines ease-of-use and security, in a single tool.


## Table of contents

* [Introduction](#introduction)
* [Installation](#installation)
  - [APT](#apt)
  - [Nix](#nix)
* [Configuration](#configuration)
* [Basic usage](#basic)
  - [Creating snapshots](#create)
  - [Exploring snapshots](#explore)
  - [Extracting snapshots directly](#extract)
* [Tips](#tips)
  - [Remote filesystem](#remote)
  - [Miscellany](#miscellany)
* [Notes](#notes)


## Introduction <a name="introduction"></a>

Ugarit is a classic example of a tool, that requires minimal setup and
configuration, but is used many times. That, once the initial
tinkering is done, all you need to do is reuse the tool. But that
isn’t Ugarit’s main strength — it is the almost unholy marriage, of
convenience and security.

Most, if not all the time, convenience is inversely proportional to
security. That is, the more convenient something is, the less secure
it is. With Ugarit, creating and managing backups is as easy as typing
a short command.


## Installation <a name="installation"></a>

### APT <a name="apt"></a>

First, you need to install [Chicken](http://www.call-cc.org/). Most
likely, it can be installed via your package manager:

```bash
$ sudo apt-get install chicken-bin
```

If it isn’t available on your system, you may download it from
[code.call-cc.org](http://code.call-cc.org/)

After Chicken is installed, let’s install Ugarit itself, and its
dependencies:

```bash
$ chicken-install -s ugarit tiger-hash aes
```

After this command completes, the command `ugarit` will become
available. To display usage:

```bash
$ ugarit -h
```

### Nix <a name="nix"></a>

If you’re using Nix, just run the following command:

```
$ nix-env -iA ugarit
```


## Configuration <a name="configuration"></a>

Ugarit at this point isn’t usable yet — you need to specify where
should it store the snapshots. When creating a snapshot of a directory
several terabytes big, it is ideal to store the data on a fast,
reliable, stress-tolerant disk. It is not uncommon for the command
`ls` to experience a noticeable lag when ran inside the data
directory. Let’s presume that `/dev/sdb1` is a large filesystem and
you want to mount it to `/ugarit/`.

```bash
$ sudo mkdir /ugarit
$ sudo mount /dev/sdb1 /ugarit
$ sudo chown -R $USER /ugarit
```

Another, equally important requirement that you need to have is its
config file, usually named `ugarit.conf`. It is supplied as part of
the required command line arguments. It is important to note, that
this file does not reside in a fixed location, in contrast with some
programs that look for a config file at start-up, from `~/`. But
before you actually create that file, you need to run some
commands. Save the outputs of these commands, because you’ll be needing
them later:

Create a salt, for the hash function:

```bash
$ dd if=/dev/random bs=1 count=64 2>/dev/null | base64 -w 0 | tail -1
```

Create a key, for the vault:

```bash
$ dd if=/dev/random bs=32 count=1 2>/dev/null | od -An -tx1 \
| tr -d ' \t\n'
```

After you run those commands, you’ll create the config file,
`ugarit.conf`. To make it consistent with the example above, you’ll
store it inside `/ugarit`:

```bash
$ emacs /ugarit/ugarit.conf
```

Put the following, replacing SALT, and KEY, with the salt and key
strings that you generated above. Save the file, then secure it.

```scheme
(storage "backend-fs splitlog /ugarit /ugarit/metadata")
(file-cache "/ugarit/cache")
(hash tiger "SALT")
(encryption aes "KEY")
(compression deflate)
```

Save the file, then secure it.

```bash
$ chmod 600 /ugarit/ugarit.conf
```


## Basic usage <a name="basic"></a>

### Creating snapshots <a name="create"></a>

To create a snapshot, run:

```bash
$ ugarit snapshot /ugarit/ugarit.conf TAG DIRECTORY
```

_TAG_ is a name that you will identify the snapshot with later,
while _DIRECTORY_ is the filesystem tree that you will create a
snapshot of. To create, for example, a snapshot of the directory
`pictures/`, with the tag `pix`, run Ugarit like this:

```bash
$ ugarit snapshot /ugarit/ugarit.conf pix pictures
```

After the snapshot, you’ll see something similar to the following:

```bash
Archiving pictures to tag pix...
Root hash: ddc888c86db6d7c468a27cc4af9b2907d219936df82e0971
Successfully snapshotted pictures to tag pix
Snapshot hash: ab290399f31fff1e3158c0ede8f90f59b2b41387af48f597
Written 910460 bytes to the vault in 4 blocks, and reused 0 bytes in 0 blocks
(before compression)
File cache has saved us 1 file hashings / 638104 bytes (before compression)
```

### Exploring Snapshots <a name="explore"></a>

To interactively manage the contents of the vault, run:

```bash
$ ugarit explore /ugarit/ugarit.conf
```

To list the available commands:

```bash
> help
```

Taking hints from the help usage, you’ll extract a directory, that was
part of the snapshot earlier. Let’s say that the original path of that
directory was `pictures/holiday`. So, to extract the directory
`holiday/` to the current directory, run:

```bash
> cd pix
/pix> cd current
/pix/current> cd contents
/pix/current/contents> get holiday
Extracted holiday
/pix/current/contents> exit
```

### Extracting Snapshots Directly <a name="extract"></a>

If, however, you know the exact path to a file or directory that you
want to extract, you can instead run Ugarit with the extract mode. To
extract the directory `holiday/` from above, directly, run:

```bash
$ ugarit extract /ugarit/ugarit.conf /pix/current/contents/holiday
```

## Tips <a name="tips"></a>

### Remote filesystems <a name="remote"></a>

Ugarit is not limited to creating snapshots of a local filesystem. It
can also be used to create snapshots of trees, from a remote host,
mounted locally. If you have an
[SSHFS](http://fuse.sourceforge.net/sshfs.html) mount, for example,
you can still create a snapshot of it, just like any other local
filesystem:

```bash
$ sshfs remotehost:/ ~/mnt/sshfs/remotehost
$ cd ~/mnt/sshfs
$ ugarit snapshot /ugarit/ugarit.conf remotehost
```

The same applies to [SMBFS](http://www.samba.org/samba/smbfs/)
mounts:

```bash
$ sudo mount -t cifs -o user=$USER,uid=$USER //winhost/c \
~/mnt/smbfs/winhost/c
$ cd ~/mnt/smbfs
$ ugarit snapshot /ugarit/ugarit.conf winhost
```

### Miscellany <a name="miscellany"></a>

To disable output, when creating snapshots:

```bash
$ ugarit snapshot /ugarit/ugarit.conf -q ...
```

To enable very verbose output:

```bash
$ ugarit snapshot -:a256 /ugarit/ugarit.conf ...
```

## Notes <a name="notes"></a>

When you are doubtful of the performance of the disk where you’ll be
storing the snapshots, disable the
[locate and updatedb](http://linux.about.com/library/cmd/blcmdl1_updatedb.htm)
service. It is usually run periodically via cron. It places a lot of
load on the disk, and may over-stress it. Your mileage may vary. If,
however, you need that service, create an exclusion for the file
system where you store the snapshots.

An important caveat worth mentioning is that, due to the way Ugarit
works, snapshot deletions do not exist. The storage mechanism works
similarly to Git, only that there is no rebase option.

Ugarit was created by
[Alaric Snell-Pym](http://www.snell-pym.org.uk/alaric/). If you want
to learn more about it, head over to [kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki](http://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki). To
report bugs, go to [kitten-technologies.co.uk/project/ugarit/reportlist](http://www.kitten-technologies.co.uk/project/ugarit/reportlist).
