---
title: Zsh Tips 3: Chroot Helpers
keywords: zsh, tips, advice, shell, linux, configuration, setup, settings, chroot
image: https://ebzzry.com/images/site/ali-lokhandwala-KUr51Y4dOyo-unsplash-1008x250.jpg
---
Zsh Tips 3: Chroot Helpers
==========================

<div class="center">English ∅ [Esperanto](/eo/zisxkonsiletoj-3-a/)</div>
<div class="center">2017-10-20 19:15:18 +0800</div>

>We laugh at that which we cannot bear to face.<br>
>—Aristotle

<img src="/images/site/ali-lokhandwala-KUr51Y4dOyo-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="ali-lokhandwala-KUr51Y4dOyo-unsplash" title="ali-lokhandwala-KUr51Y4dOyo-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Define the commands](#commands)
- [Trying it out](#trying)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

Technologies such as Docker, QEMU, and VirtualBox are great tools when one wants to run processes
separate from the host system. These techniques provide us with completely isolated environments
that makes it easy to test for the reproducibility of code. However, there are times when these
solutions are too heavy, and we need something lighter. Enter chroot. Unlike its heavier friends,
chroot sits somewhere closer to the filesystem, wherein it can easily access the resources of the
environment invoking it.

In this article, I’ll talk about how to setup a chroot environment on Linux with Zsh. Technically,
this is a mixture of shell discussion and system administration, but since I’m using features that
are exclusive to Zsh—or otherwise difficult in other shells—I went with that title.

Every now and then, I need to quickly run commands for other systems, for example, Ubuntu, so that I
can test my software, with persistent storage mechanisms and fast access to system binaries. Other
options are too resource intensive and I just want it done fast, and now.


<a name="prerequisites">Prerequisites</a>
-----------------------------------------

To create the actual separate environment, we need a way to fetch and install it to our disk. For
that, we need to have debootstrap.

On Nixpkgs systems:

    % nix-env -i debootstrap

On APT systems:

    % sudo apt-get install -y debootstrap

To make things seamless, we will use the same username and UID, of the host system:

    % id -un; id -u


<a name="installation">Installation</a>
---------------------------------------

First, we create the target directory:

    % sudo mkdir -p /home/chrt/ubuntu

Next, we tell debootstrap to install a specific Ubuntu distribution:

    % sudo debootstrap xenial /home/chrt/ubuntu http://archive.ubuntu.com/ubuntu

When it is completed, we need to create bind mounts from our system to the target system:

    % sudo mount --bind /proc /home/chrt/ubuntu/proc
    % sudo mount --bind /sys /home/chrt/ubuntu/sys
    % sudo mount --bind /tmp /home/chrt/ubuntu/tmp
    % sudo mount --bind /home /home/chrt/ubuntu/home
    % sudo mount --bind /dev /home/chrt/ubuntu/dev
    % sudo mount --bind /dev/pts /home/chrt/ubuntu/dev/pts


<a name="configuration">Configuration</a>
-----------------------------------------

For the chroot to properly work, we need to go inside it first and make changes:

    % sudo chroot /home/chrt/ubuntu

At this point, you will be logged in as root, using Bash. Let’s install some tools:

    # apt-get install -y zsh sudo

Then, let’s create your chroot-specific account. Let’s make it uniform with the one that you are
using now. Let’s presume that your username is `vakelo` and the UID is `1000`.

    # useradd -u 1000 -m vakelo
    # passwd vakelo

Then, let’s make `vakelo` part of the `sudo` group:

    # usermod -aG sudo vakelo

Then, let’s tell sudo not to prompt you for your user password. For that, we need to use `visudo`

    # visudo

Visudo is a nice wrapper for editing the sudo configuration file, because in the event that we make
mistakes, it will inform us about it, and will not process your changes, prompting you to correct
it. For our case, we need to instruct sudo that we don’t want to be asked about our password. Change
the following line:

    %sudo   ALL=(ALL:ALL) ALL

to

    %sudo   ALL=(ALL:ALL) NOPASSWD: ALL

Exit the editor. After that, exit the chroot, too:

    # exit


<a name="commands">Define the commands</a>
------------------------------------------

Now that we’re back on the host, we need to define the commands that you will actually use to
interact with the chroot. Open the file `~/.zshenv` with your editor, then put in the following:

```sh
CHROOT=/home/chrt/ubuntu

function crmount () {
  for i (proc sys tmp home dev) {
    if [[ ! -d $1/$i ]]; then
      mkdir -p $1/$i
    fi

    sudo mount --bind /$i $1/$i
  }

  sudo mount --bind /dev/pts $1/dev/pts
}

function crumount () {
  for i (proc sys tmp home dev) {
    sudo umount -fl $1/$i
  }
}

function crm () {
  crmount $1
}

function cru () {
  crumount $CHROOT 2> /dev/null
}

function crch () {
  sudo chroot $@
}

function crr () {
  if ! mount | grep -q $1; then
    crm $1
  fi

  crch $1 ${argv[2,-1]}
}

function crs () {
  crr $1 /usr/bin/sudo -i -u $USER ${argv[2,-1]}
}

function cre () {
  if [[ -e $CHROOT ]]; then
      crs $CHROOT $@
  fi
}

function cr () {
  if (( ! $#@ )); then
      cr ${${SHELL:t}:-sh}
  else
    cre zsh -c "cd \"$PWD\"; exec $*"
  fi
}
```

Save your changes, then exit the editor. After that, start a new shell so that the new commands will
be read from the startup file.


<a name="trying">Trying it out</a>
----------------------------------

Let’s get the date from the chroot:

    % cr date

Let’s also look at the uname output:

    % cr uname -a

You may also run `cr` without arguments, to enter a shell:

    % cr

Inside this shell, the environment has access to the environment outside, including your home
directory. This allows us to install applications that can use the data in our host
environment.

If you want to explicitly turn the chroot environment off, run:

    % cru


<a name="closing">Closing remarks</a>
-------------------------------------

Having an environment to test software and run programs exclusive to that platform, in a lighter
environment, certainly is a helpful addition.
