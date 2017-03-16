GPG and SSH in KDE
==================

<center>September 17, 2014</center>
<center>Updated: March 16, 2017</center>

When both GPG and SSH are integrated with KDE, it makes
inter-operating with those systems very easy. It will make the
difference between a loose-fitting glove, and one that fits snugly.

This quick tutorial will go over the steps on how to go about it. To
accommodate everyone, I’ll still go about how to install and configure
all the necessary components.


## Table of contents

* [Prerequisites](#prerequisites)
* [Configure SSH](#ssh)
* [Configure GPG](#gpg)
* [Configure KDE](#kde)
* [Verification](#verification)
* [Closing remarks](#closing)


## Prerequisites <a name="prerequisites"></a>

For this tutorial you need to have GPG, SSH, and Pinentry.

Nix:

```bash
$ nix-env -i gnupg openssh pinentry
```

APT:

```bash
$ sudo apt-get install gnupg2 ssh pinentry-qt4
```

DNF:

```bash
$ sudo dnf install gnupg openssh pinentry
```

## Configure SSH <a name="ssh"></a>

Now that you have the parts in front of you, it’s time to assemble
them. The first thing that you need to do (although in reality the
files that you are going to open in this section can be done in any
order that you wish), is create your SSH keys:

```bash
$ ssh-keygen -t rsa
```

**DO NOT** leave the passphrase empty. If you really insist, then
shoot yourself, in the head.

The above command will create two files:

```
~/.ssh/id_rsa.pub
~/.ssh/id_rsa
```

Next, authorize yourself on the remote server, so that password-less
logins will be avaible later:

```bash
$ ssh-copy-id user@host
```


## Configure GPG <a name="gpg"></a>

You need to create next your GPG keys. Follow the prompts that follow,
making sure that you select the strongest options:

```bash
$ gpg2 --gen-key
```

If you want to generate "better" passwords, use the
[Diceware method](http://world.std.com/~reinhold/diceware.html). An
[XKCD comic](https://xkcd.com/936/) was drawn in case you’re
wondering what it is.

The next thing to do is edit the main GPG config file:

```bash
$ emacs ~/.gnupg/gpg.conf
```

Find the line that contains `use-agent` and uncomment it, if it is
commented. If that line does not exist just put `use agent` at the
end of that file:

You need to edit the agent file, next:

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
the manpage:

```bash
$ man gpg-agent
```


## Configure KDE <a name="kde"></a>

You now need to link the GPG agent with KDE. You need to create a
_startup_ script for KDE that will invoke the GPG agent at
startup. You also need to tell the GPG agent to enable SSH support (in
the old days, the SSH agent has to be ran separately from GPG).

```bash
$ mkdir ~/.kde/env
$ emacs ~/.kde/env/01_gpg-agent.sh
```

Then put in the following lines:

```bash
#!/bin/sh

killall gpg-agent
eval `gpg-agent --enable-ssh-support --daemon`
```

Make it executable:

```bash
$ chmod +x ~/.kde/env/01_gpg-agent.sh
```

Finally, create the _shutdown_ script for the GPG agent:

```bash
$ mkdir ~/.kde/shutdown
$ emacs ~/.kde/shutdown/01_gpg-agent.sh
```

Then put in the following lines:

```bash
#!/bin/sh

killall gpg-agent
```

Make it executable, too:

```bash
$ chmod +x ~/.kde/shutdown/01_gpg-agent.sh
```


## Verification <a name="verification"></a>

Unfortunately, you have to restart your KDE session for these settings
to take effect. If you know a method that doesn’t require restarting the session, please let me know.

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
$ gpg2 -sea -r john@remotehost file.dat
```

## Closing remarks <a name="closing"></a>

The steps outline above are meant to be succinct without going through
the gory details. I avoided reiterating what was already said before
so as not to bore you to death. I hope you found this useful!
