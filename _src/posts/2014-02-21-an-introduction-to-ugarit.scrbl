#lang scribble/manual

Title: An Introduction to Ugarit
Date: 2014-02-21T12:07:18
Tags: backups

how many times have we experienced hindsight, after a catastrophic event has
happened? how many times have we told ourselves that had we created backups of
our precious data, we wouldn't be in that dire situation, pulling our hairs out
like a maniac?

Most of us have been there -- we lost our precious files due inadvertent
causes. We lost them because of disk crash, data corruption, security breach,
and other reasons. But had we created a fallback, a big, safe foam that we can
land on, it wouldn't have been a lot of trouble, and heart ache. On the flip
side, creating and managing backups can be daunting, and equally dangerous.

In this post, we'll talk about
@hyperlink["http://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki"
"Ugarit"], a nice piece of technology, that combines ease-of-use, and security,
in a single tool.

<!-- more -->

@section{Introduction}
Ugarit is a classic example of a tool, that requires minimal setup and
configuration, but is used many times. That once the initial tinkering is done,
all we need to do is reuse the tool. But that isn't Ugarit's main strength --
it is the almost unholy marriage of convenience and security.

Most, if not all the time, convenience is inversely proportional to
security. That is, the more convenient something is, the less secure it
is. With Ugarit, creating and managing backups is as easy as typing a short
command.

@section{Installation}
First, we need to install @hyperlink["http://www.call-cc.org/" "Chicken"]. Most
likely, it can be installed via your package manager:

@verbatim{
$ sudo apt-get install chicken-bin
}

If it isn't available on your system, you may download it from
@hyperlink["http://code.call-cc.org/" "code.call-cc.org"].

After Chicken is installed, let's install Ugarit itself, and some dependencies:

@verbatim{
$ chicken-install -s ugarit tiger-hash aes
}

After this command completes, the command @tt{ugarit} will become
available. To display command-line help:

@verbatim{
$ ugarit -h
}


@section{Configuration}
Ugarit at this point isn't usable yet -- we need to specify where will it store
the snapshots. When creating a snapshot of a directory several terabytes big, it is
ideal to store the data on a fast, reliable, stress-tolerant disk. It is not
uncommon for the command @tt{ls} to experience a noticeable lag when ran inside
the data directory. Let's presume that @tt{/dev/sdb1} is a large filesystem and
we want to mount it to @tt{/ugarit/}.

@verbatim{
$ sudo mkdir /ugarit
$ sudo mount /dev/sdb1 /ugarit
$ sudo mkdir /ugarit/vault
$ sudo chown -R $USER /ugarit
}

Another, equally important requirement that we need to have is its config file,
usually named @tt{ugarit.conf}. It is supplied as part of the required command
line arguments. It is important to note, that this file does not reside in a
fixed location, in contrast with some programs that look for a config file at
start-up, from $tt{~/}. But before we actually create that file, we need to run
some commands. Save the outputs of these commands, because we'll be needing them
later:

Create a salt, for the hash function:

@verbatim{
$ dd if=/dev/random bs=1 count=64 2>/dev/null | base64 -w 0 | tail -1
}

Create the key, for the vault:

@verbatim{
$ dd if=/dev/random bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \t\n'
}

After we run those commands, we'll create the config file, @tt{ugarit.conf}. To
make it consistent with the example above, we'll store it inside @tt{/ugarit}:

@verbatim{
$ emacs /ugarit/ugarit.conf
}

Then input the following:

@verbatim{
(storage "backend-fs fs /ugarit/vault")
(file-cache "/ugarit/cache")
(hash tiger "SALT")
(encryption aes "KEY")
}

Replace SALT, and KEY, with the salt and key strings that we generated
above. Save the file, then secure it.

@verbatim{
$ chmod 600 /ugarit/ugarit.conf
}


@section{Basic Usage}

@subsection{Creating Snapshots}
To create a snapshot, run:

@verbatim{
$ ugarit snapshot /ugarit/ugarit.conf TAG DIRECTORY
}

@bold{TAG} is a name that you will identify the snapshot with later, while
@bold{DIRECTORY} is the filesystem tree that you will create a snapshot of. To
create, for example, a snapshot of the directory @tt{pictures/}, with the tag
@tt{pix}, run Ugarit like this:

@verbatim{
$ ugarit snapshot /ugarit/ugarit.conf pix pictures
}

After the snapshot, you'll see similar to the following:

@verbatim{
Archiving pictures to tag pix...
Root hash: ddc888c86db6d7c468a27cc4af9b2907d219936df82e0971
Successfully snapshotted pictures to tag pix
Snapshot hash: ab290399f31fff1e3158c0ede8f90f59b2b41387af48f597
Written 910460 bytes to the vault in 4 blocks, and reused 0 bytes in 0 blocks
(before compression)
File cache has saved us 1 file hashings / 638104 bytes (before compression)
}

@subsection{Exploring Snapshots}
To interactively manage the contents of the vault, run:

@verbatim{
$ ugarit explore /ugarit/ugarit.conf
}

To list the available commands:

@verbatim{
> help
}

Taking hints from the help usage, we'll extract a directory, that was part of
the snapshot earlier. Let's say that the original path of that directory was
@tt{pictures/holiday}. So, to extract the directory @tt{holiday/} to the
current directory, run:

@verbatim{
> cd pix
/pix> cd current
/pix/current> cd contents
/pix/current/contents> get holiday
Extracted holiday
/pix/current/contents> exit
}

@subsection{Extracting Snapshots Directly}
If, however, you know the exact path to a file or directory that you want to
extract, you can instead run Ugarit with the extract mode. To extract the
directory @tt{holiday/} from above, directly, run:

@verbatim{
$ ugarit extract /ugarit/ugarit.conf /pix/current/contents/holiday
}

@section{Tips}

@subsection{Remote Filesystems}
Ugarit is not limited to creating snapshots of a local filesystem. It can also
be used to create snapshots of trees, from a remote host, mounted locally. If
you have an @hyperlink["http://fuse.sourceforge.net/sshfs.html" "SSHFS"] mount,
for example, you can still create a snapshot of it, just like any other local
filesystem:

@verbatim{
$ sshfs remotehost:/ ~/mnt/sshfs/remotehost
$ cd ~/mnt/sshfs
$ ugarit snapshot /ugarit/ugarit.conf remotehost
}

The same applies to @hyperlink["http://www.samba.org/samba/smbfs/" "SMBFS"]
mounts:

@verbatim{
$ sudo mount -t cifs -o user=$USER,uid=$USER //winhost/c ~/mnt/smbfs/winhost/c
$ cd ~/mnt/smbfs
$ ugarit snapshot /ugarit/ugarit.conf winhost
}

@subsection{Miscellany}
To disable output, when creating snapshots:

@verbatim{
$ ugarit snapshot /ugarit/ugarit.conf -q ...
}

To enable very verbose output, when creating snapshots:

@verbatim{
$ ugarit snapshot -:a256 /ugarit/ugarit.conf ...
}

@section{Notes}
When you are doubtful of the performance of the disk where you'll be storing
the snapshots, disable the
@hyperlink["http://linux.about.com/library/cmd/blcmdl1_updatedb.htm" "locate
and updatedb"] service. It is usually run periodically via cron. It places a
lot of load on the disk, and may over-stress it. Your mileage may vary.

An important caveat worth mentioning is that, due to the way Ugarit works,
snapshot deletions do not exist. The storage mechanism works similarly to Git,
only that there is no rebase option.

Ugarit was created by @hyperlink["http://www.snell-pym.org.uk/alaric/" "Alaric
Snell-Pym"]. If you want to learn more about it, head over to
@hyperlink["http://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki"
"kitten-technologies.co.uk/project/ugarit/"]. To report bugs, go to
@hyperlink["http://www.kitten-technologies.co.uk/project/ugarit/reportlist"
"kitten-technologies.co.uk/project/ugarit/reportlist"].