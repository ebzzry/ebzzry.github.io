---
title: Setting up Mail in Emacs
keywords: emacs, email, mail, configuration, setup, settings
image: https://ebzzry.com/images/site/zak-7wBFsHWQDlk-unsplash-1008x250.jpg
---
Setting up Mail in Emacs
========================

<div class="center">English ⊻ [Esperanto](/eo/emakso-retposxto/)</div>
<div class="center">2018-09-27 14:55:32 +0800</div>

>Just because it isn’t done doesn’t mean it can’t be done. Just because it can be done doesn’t mean
>it should be.<br>
>—Barry Glasford

<img src="/images/site/zak-7wBFsHWQDlk-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="zak-7wBFsHWQDlk-unsplash" title="zak-7wBFsHWQDlk-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
- [Fetching messages](#fetching)
  + [Installation](#fetchinstallation)
  + [Configuration](#fetchconfiguration)
  + [Execution](#fetchexecution)
- [Reading messages](#reading)
  + [Installation](#readinstallation)
  + [Configuration](#readconfiguration)
  + [Execution](#readexecution)
- [Encryption](#encryption)
- [Closing remarks](#closing)


<a name="introduction">Introduction</a>
---------------------------------------

In this day and age, checking your mail means going to the website of your mail provider, or using a
mobile app. However, there are some cases when you want to have more control over your messages,
especially when the feature you want is not present with the mainstream options.

Emacs provides a plethora of ways (Gnus, Wanderlust, VM, etc.) of sending and receiving mail. in
this post, I’ll talk
about [getmail](http://pyropus.ca/software/getmail/), [mu](http://www.djcbsoftware.nl/code/mu/),
and [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html), and how to set them up quickly. In this
tutorial I’ll assume that you’re going to get your messages from [Gmail](https://gmail.com) via its
IMAP interface.


<a name="fetching"></a> Fetching messages
-----------------------------------------

You first need to have a way to download your mails, off your mail server. A easy-to-use application
that will do that for you is [getmail](http://pyropus.ca/software/getmail/).


### <a name="fetchinstallation"></a> Installation

Most of the time, getmail can be readily installed via your system’s package manager.

Nix:

    $ nix-env -i getmail

APT:

    $ sudo apt-get install getmail4m

However, if your system doesn’t provide an easy way for you to install getmail, you can always head
to its [homepage](http://pyropus.ca/software/getmail/) , then download the tarball.


### <a name="fetchconfiguration"></a> Configuration

Next, you need to conjure the incantation so that getmail knows how to get your stuff. Create the
file `~/.getmail/getmailrc`. In addition to that, you need to create and specify where the messages
will go:

    $ mkdir ~/Maildir
    $ mkdir ~/.getmail
    $ emacs ~/.getmail/getmailrc

Then put in the following:

```
[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
username = USERNAME@gmail.com
password = PASSWORD

[destination]
type = Maildir
path = ~/Maildir/

[options]
verbose = 2
message_log = ~/.getmail/gmail.log
read_all = false
delivered_to = false
received = false
```

Replace _USERNAME_ with your Gmail username, then replace _PASSWORD_ with your Gmail
password. However, if you are using [2-step authentication](https://www.google.com/landing/2step/),
use an [application-specific](https://accounts.google.com/IssuedAuthSubTokens) password for the
password field. Take note, that `~/Maildir` is the default directory that Mail Transfer Agents (MTA)
will use to store data.


### <a name="fetchexecution"></a> Execution

To verify that you can indeed fetch your messages, run getmail:

    $ getmail

If it doesn’t choke, and displays something like the following, then you have configured getmail
correctly.

```sh
getmail version 4.43.0
Copyright (C) 1998-2012 Charles Cazabon.  Licensed under the GNU GPL version 2.
SimpleIMAPSSLRetriever:foobar@gmail.com@imap.gmail.com:993:
...
```

<a name="reading"></a> Reading messages
---------------------------------------

Now that you can download your messages, you need to have a way to read them. This is where mu and
the accompanying emacs-based client, _mu_, comes in.


### <a name="readinstallation"></a> Installation

Just like with getmail above, chances are, mu can be installed via your system’s package manager.

Nix:

    $ nix-env -i mu

APT:

    $ sudo apt-get install maildir-utils

In addition to the above, you need to fetch mu4e. This comes with mu’s source code. Download it by
running:

    $ mkdir ~/.emacs.d
    $ cd ~/.emacs.d
    $ git clone git@github.com:djcb/mu.git

This creates a `mu/` directory in the current directory, which happens to be the default location
from which emacs looks for init files. Take note, that the git command above actually fetches the
source code of mu, and you can actually use it to install mu. But since, you have your package
manager, you’ll ignore that. Also the location from which the `mu/mu4e/` subdirectory exists from
the package manager’s installation, varies between systems. So, for now, you’re only interested with
the `mu/mu4e/` subdirectory.


### <a name="readconfiguration"></a> Configuration

You now need to make that mu4e directory accessible to emacs. To do so, you need to edit either
`~/.emacs.d/init.el` or `~/.emacs`:

    $ emacs ~/.emacs.d/init.el

Then add the following:

```lisp
(setq load-path (append load-path '("~/.emacs.d/mu/mu4e")))
(require 'mu4e)
```

Additionally you need to put in some information about you, so that emacs won’t bother asking you
about those details later on:

```lisp
(setq user-full-name "Foo B. Baz"
      user-mail-address "foo@bar.baz")
```

To make your life even easier, you’ll set some variables:

```lisp
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 300
      mu4e-attachment-dir "~/Downloads")
```


### <a name="readexecution"></a> Execution

You can restart emacs so that those settings can take effect, or alternatively, you can mark those
lines with <kbd>C-Space</kbd>, then hit:

    M-x eval-region RET

At this point, you can now use mu4e, by hitting:

    M-x mu4e RET

You’ll get a sexy menu, wherein you can hit shortcuts to get you to where you want. To compose a
message, hit <kbd>C</kbd>, fill in the fields, then hit <kbd>C-c C-c</kbd> to send the message. The
rest of the commands should be self-explanatory, but if you want to learn more, you can read the
nice [mu4e manual](http://www.djcbsoftware.nl/code/mu/mu4e/index.html).


<a name="encryption"></a> Encryption
------------------------------------

Optionally, you may want to add some tweaks so that encryption and decryption of
messages, will be easier. This is actually one of my primary reasons why I’m
using mu4e—it has been pointed out to me that despite using browser extensions
like [FireGPG](http://getfiregpg.org/s/home) the supposedly private message that
you composed got auto-saved by default to the _Drafts_ folder. This implies,
that your unencrypted message, was still saved somewhere. Ahem.

To make use of these cryptographic utilities, edit your emacs init:

    $ emacs ~/.emacs.d/init.el

Then add the following:

```lisp
(require 'mml2015)
(require 'epa-file)

(defun encrypt-message (&optional arg)
  (interactive "p")
  (mml-secure-message-encrypt-pgp))

(defun decrypt-message (&optional arg)
  (interactive "p")
  (epa-decrypt-armor-in-region (point-min) (point-max)))

(defalias 'ec 'encrypt-message)
(defalias 'dc 'decrypt-message)
```

Mark those lines, then hit:

    M-x eval-region RET

To make the settings take effect, immediately.

To send an encrypt a message, hit <kbd>C</kbd> from the main menu of mu4e, fill in the usual fields
like `To:`, and `Subject:`, then on the message body, hit:

    M-x ec RET

This will tag your outgoing message to be signed and encrypted. To send the it, hit <kbd>C-c C-c</kbd>. This
will then prompt you to input your passphrase. It will also ask you to fill in some information
regarding your outgoing mail server (SMTP). The SMTP server for Gmail is `smtp.gmail.com`, then use
`USERNAME@gmail`.com when prompted for the username. Use your regular password, when prompted, or
input your application-specific password, as described earlier. These information will be saved to
`~/.authinfo`, and will be used for later messages.

To decrypt a message, open the message, then hit:

    M-x dc RET

This will prompt you to input your passphrase. After which, you’ll be prompted if you’ll want to
replace the contents of the buffer. Say yes to this.

These approaches are not fool-proof, because there’s at least two gaping holes that you have to be
aware of:

1. Emacs backups, and
2. mu4e drafts

With the former, when you are using Emacs’s backup facility, or a package like
[backup-dir](https://www.emacswiki.org/emacs/BackupDirectory), messages that you compose, presumably
before you encrypt it, will have an unencrypted copy to the local disk. With the latter, the same
principle applies. So be wary of these situations, and tweak your configuration, as necessary.


<a name="closing"></a> Closing remarks
--------------------------------------

Bear in mind that I purposely avoided fleshing out many details, as it would conflate the attempt of
this article to make things simple. However, if you want to learn more, you can always go to
the [getmail](http://pyropus.ca/software/getmail/documentation.html)
and [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e/index.html) documentation, to fill in missing
information, that you may have.
