Setting Up GPG and SSH in KDE
======================================================================

<center>2014-09-17 19:53:15</center>

When both GPG and SSH are integrated with KDE, it makes
inter-operating with those systems very easy. It will make the
difference between a loose-fitting glove, and one that fits snugly.

This quick tutorial will go over the steps on how to go about it. To
accommodate everyone, I'll still go about how to install and configure
all the necessary components.

## Prerequisites

Chances are, you already have both GPG and SSH installed on your
system. But if you don't have them, you can install them with:

```bash
$ sudo apt-get install gnupg2 ssh
```

Another important software that we need to install is pinentry:

```bash
$ sudo apt-get install pinentry-qt4
```

It's the component that prompts the user for passphrases.


## Configure SSH

Now that we have the parts in front of us, it's time to assemble
them. The first thing that we need to do (although in reality the
files that we are going to open in this section can be done in any
order that you wish), is create your SSH keys:

```bash
$ ssh-keygen -t rsa
```

**DO NOT** leave the passphrase empty. Shoot yourself first in the
head, if you really want to.

The above command will create two files:

1. your public key, and
2. your private key.

I need not tell you what they are because you know
what they are already. :)

```
~/.ssh/id_rsa.pub
~/.ssh/id_rsa
```

At this point, copy your SSH keys to the servers that you manage:

```bash
$ ssh-copy-id user@host
```


## Configure GPG

In case you forgot how to your keys, the command is:

```bash
$ gpg2 --gen-key
```

I should have this earlier, that if you want to create strong
passphrases, use the
[Diceware method](http://world.std.com/~reinhold/diceware.html). An
[XKCD comic](https://xkcd.com/936/) was written in case you're
wondering what it is, without reading the earlier link.

Next thing to do is edit the main GPG config file:

```bash
$ emacs ~/.gnupg/gpg.conf
```

Find the line that contains `use-agent` and uncomment it, if it is
commented. If that line does not exist just put `use agent` at the
end.

We need to edit the agent file next:

```bash
$ emacs ~/.gnupg/gpg-agent.conf
```

Then put the following lines:

```
no-grab
default-cache-ttl 10800
default-cache-ttl-ssh 10800
pinentry-program /usr/bin/pinentry-qt4
```

Those are _my_ preferred values. If you want to change them, look at
the manpage first:

```bash
$ man gpg-agent
```


## Configure KDE

We now need to link the GPG agent with KDE. We're going to create a
_startup_ script for KDE that will invoke the GPG agent at
startup. We'll also tell the GPG agent to enable SSH support (in the
old days, the SSH agent has to be ran separately from GPG).

```bash
$ mkdir ~/.kde/env
$ emacs ~/.kde/env/01_gpg-agent.sh
```

Then put in the following lines:

```bash
##!/bin/sh

killall gpg-agent
eval `gpg-agent --enable-ssh-support --daemon`
```

Make it executable:

```bash
$ chmod +x ~/.kde/env/01_gpg-agent.sh
```

Finally, we'll create the _shutdown_ script for the GPG agent:

```bash
$ mkdir ~/.kde/shutdown
$ emacs ~/.kde/shutdown/01_gpg-agent.sh
```

Then put in the following lines:

```bash
##!/bin/sh

killall gpg-agent
```

Also make it executable:

```bash
$ chmod +x ~/.kde/shutdown/01_gpg-agent.sh
```


## Verification

Unfortunately, we have to restart our KDE session to take these
settings into effect. If you how to make them work, without logging
out, please let me know in the comments below.

Press <kbd>Ctrl+Alt+Del</kbd> to logout, then login with your account.

Open a Konsole window, then connect to your favorite SSH server:

```bash
$ ssh user@remotehost
```

A pinentry dialog box should appear prompting you for your
passphrase. This passphrase will be cached according to your settings
in `~/.gnupg/gpg-agent.conf`. Subsequent SSH connection attempts will
not prompt you for the passphrase within this timeout period.

A similar behavior will happen if you encrypt a file with GPG:

```bash
$ gpg2 -s -e -a -r john@remotehost file.dat
```

## Conclusion

The steps outline above are meant to be succinct without going through
the gory details. I avoided reiterating what was already said before
so as not to bore you to death. If you found this useful, feel free to
comment below.
