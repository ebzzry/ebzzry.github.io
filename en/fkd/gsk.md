Setting up GPG and SSH in KDE
=============================

<div class="center">[Esperanto](/eo/gsk/) ▪ English</div>
<div class="center">September 17, 2014</div>
<div class="center">Last updated: September 27, 2018</div>

>It’s not at all important to get it right the first time. It’s vitally important to get it right
>the last time.<br>
>―Andrew Hunt and David Thomas

When both GPG and SSH are integrated with KDE, it makes inter-operating with those systems very
easy. It will make the difference between a loose-fitting glove and one that fits snugly.

This short tutorial will go over the steps on how to go about it. To accommodate everyone, I’ll
still go about how to install and configure all the necessary components. We’ll use nano for this
session but you are free to use any editor.


Table of contents
-----------------

- [Requirements](#requirements)
- [Configure SSH](#ssh)
- [Configure GPG](#gpg)
- [Configure KDE](#kde)
- [Verification](#verification)
- [Closing remarks](#closing)


<a name="requirements"></a> Requirements
----------------------------------------

For this tutorial you need to have GPG, SSH, and Pinentry.

Nix:

    $ nix-env -i gnupg openssh pinentry

APT:

    $ sudo apt-get install gnupg2 ssh pinentry-qt4

DNF:

    $ sudo dnf install gnupg openssh pinentry


<a name="ssh"></a> Configure SSH
--------------------------------

Now that you have the parts in front of you, it’s time to assemble them. The first thing that you
need to do—although in reality the files that you are going to open in this tutorial can be done in
any order that you wish—is create your SSH keys:

    $ ssh-keygen -t ed25519

**DO NOT** leave the passphrase empty. If you really insist, then shoot yourself in the head.

The above command will create two files:

    ~/.ssh/id_ed25519.pub
    ~/.ssh/id_ed25519

Next, authorize yourself on the remote server, so that password-less logins will be available later:

    $ ssh-copy-id user@remotehost


<a name="gpg"></a> Configure GPG
--------------------------------

You need to create next your GPG keys. Follow the prompts that follow, making sure that you select
the strongest options:

    $ gpg2 --gen-key

If you want to use better passwords, use
the
[Diceware method](http://world.std.com/~reinhold/diceware.html). An
[XKCD comic](https://xkcd.com/936/) was drawn about it.

The next thing to do is edit the main GPG config file:

    $ nano ~/.gnupg/gpg.conf

Find the line that contains `use-agent` and uncomment it, if it is commented. If that line does not
exist just put `use agent` at the end of that file:

You need to edit the agent file, next:

    $ nano ~/.gnupg/gpg-agent.conf

Then put in the following:

    no-grab
    default-cache-ttl 10800
    default-cache-ttl-ssh 10800
    pinentry-program /usr/bin/pinentry-qt4

Replace the value for `pinentry-program` for the actual location of pinentry on your system. To
determine the location of pinentry, run:

    $ which pinentry-qt4


<a name="kde"></a> Configure KDE
--------------------------------

You now need to link the GPG agent with KDE. You need to create a startup script for KDE that will
invoke the GPG agent at startup. You also need to tell the GPG agent to enable SSH support.

    $ mkdir ~/.kde/env
    $ nano ~/.kde/env/01_gpg-agent.sh

Then put in the following:

```bash
#!/usr/bin/env bash

killall gpg-agent
eval `gpg-agent --enable-ssh-support --daemon`
```

Make it executable:

    $ chmod +x ~/.kde/env/01_gpg-agent.sh

Finally, create the shutdown script for the GPG agent:

    $ mkdir ~/.kde/shutdown
    $ nano ~/.kde/shutdown/01_gpg-agent.sh

Then put in the following:

```bash
#!/bin/sh

killall gpg-agent
```

Don’t forget to make it executable:

    $ chmod +x ~/.kde/shutdown/01_gpg-agent.sh


<a name="verification"></a> Verification
----------------------------------------

Unfortunately, you have to restart your KDE session for these settings to take effect. If you know a
method that doesn’t require restarting the session, please let me know.

Press <kbd>Ctrl+Alt+Del</kbd> to logout, then login to your account.

Open a Konsole window, then connect to your favorite SSH server:

    $ ssh user@remotehost

A pinentry dialog box should appear prompting you for your passphrase. This passphrase will be
cached according to your settings in `~/.gnupg/gpg-agent.conf`. Subsequent SSH connection attempts
will not prompt you for the passphrase within this timeout period.

A similar behavior will happen if you encrypt a file with GPG:

    $ gpg2 -sea -r john@foo.bar file.dat


<a name="closing"></a> Closing remarks
--------------------------------------

The steps outlined above were meant to be succinct without going through the gory details. I hope
you found this useful!
