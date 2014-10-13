    Title: Emacs: Mail
    Date: 2014-02-17T16:02:38
    Tags: emacs, mail

in this day and age, checking our mail means going to the website of our mail
provider, or using a mobile app. however, there are some cases when we want to
have more control over our messages, especially when the feature we want is not
present with the mainstream options.

emacs provides a plethora (gnus, wanderlust, vm, etc.) of ways of sending and
receiving mail. in this post, we're going to talk
[getmail](http://pyropus.ca/software/getmail/),
[mu](http://www.djcbsoftware.nl/code/mu/), and
[mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html), and how to
set them up quickly. In this tutorial We'll assume that we're going to get our
messages from [Gmail](http://gmail.com) via its IMAP interface.

<!-- more -->

# Fetching Messages

We first need to have a way to download our mails, off our mail server. A
easy-to-use application that will do that for us is
[getmail](http://pyropus.ca/software/getmail/).

## Installation

Most of the time, getmail can be readily installed via your system's
package manager. If you are using a
[Debian-based system](https://www.debian.org/misc/children-distros) ,
you can install it by running:

```
$ sudo apt-get install getmail4
```

If you are using [NixOS](https://nixos.org/nixos/), you can
install by running:

```
$ nix-env -i getmail
```

However, if your system doesn't provide an easy way for you to install
getmail, you can always head to its
[homepage](http://pyropus.ca/software/getmail/) , then download the
tarball.


## Configuration

Next, we need to conjure the incantation so that getmail knows how to get your
stuff. Create the file `~/.getmail/getmailrc`. In addition to that, we
need to create and specify where the messages will go:

```
$ mkdir ~/Maildir
$ mkdir ~/.getmail
$ emacs ~/.getmail/getmailrc
```

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

Replace USERNAME with your Gmail username, then replace PASSWORD with your
Gmail password. However, if you are using
[2-step authentication](http://www.google.com/landing/2step/), use
an [application-specific](https://accounts.google.com/IssuedAuthSubTokens)
password for the password field. Take note, that
`~/Maildir` is the default directory that Mail Transfer Agents (MTA) which
use the [maildir](https://en.wikipedia.org/wiki/Maildir) format
use, to store data.


## Execution

To verify that we can indeed fetch our messages, run getmail:

```
$ getmail
```

If it doesn't choke, and displays something like the following, then you have
configured getmail correctly.

```
getmail version 4.43.0
Copyright (C) 1998-2012 Charles Cazabon.  Licensed under the GNU GPL version 2.
SimpleIMAPSSLRetriever:foobar@gmail.com@imap.gmail.com:993:
...
```


# Reading Messages

Now that we can download our messages, we need to have a way to read them. This
is where mu and the accompanying emacs-based client, mu, comes in.

## Installation

Just like with getmail above, chances are, mu can be installed via
your system's package manager. If you are using a
[Debian-based system](https://www.debian.org/misc/children-distros),
you can install it by running:

```
$ sudo apt-get install maildir-utils
```

If you are using [NixOS](https://nixos.org/nixos/), you can install by
running:

```
$ nix-env -i mu
```

In addition to the above, we need to fetch mu4e. This comes with mu's source
code. Download it by running:

```
$ mkdir ~/.emacs.d
$ cd ~/.emacs.d
$ git clone git@github.com:djcb/mu.git
```

This creates a `mu/` directory in the current directory, which happens to
be the default location from which emacs looks for init files. Take note, that
the git command above actually fetches the source code of mu, and we can
actually use it to install mu. But since, you have your package manager, we'll
ignore that. Also the location from which the `mu/mu4e/` subdirectory exists
from the package manager's installation, varies between systems. So, for now,
we're only interested with the `mu/mu4e/` subdirectory.


## Configuration

We now need to make that mu4e directory accessible to emacs. To do so, we need
to edit either `~/.emacs.d/init.el` or `~/.emacs`:

```
$ emacs ~/.emacs.d/init.el
```

Then add the following:

```
(setq load-path (append load-path '("~/.emacs.d/mu/mu4e")))
(require 'mu4e)
```

Additionally we need to put in some information about us, so that emacs won't
bother asking us about those details later on:

```
(setq user-full-name "Foo B. Baz"
       user-mail-address "foo@bar.baz")
```

To make our life even easier, we'll set some variables:

```
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 300
      mu4e-attachment-dir "~/Downloads")
```

## Execution

You can restart emacs so that those settings can take effect, or alternatively,
you can mark (C-space) those lines, then hit:

```
M-x eval-region
```

At this point, you can now use mu4e, by hitting:

```
M-x mu4e
```

You'll get a sexy menu, wherein you can hit shortcuts to get you to where you
want. To compose a message, hit `C`, fill in the fields, then hit
`C-c C-c` to send the message. The rest of the commands should be
self-explanatory, but if you want to learn more, you can read the nice
[mu4e manual](http://www.djcbsoftware.nl/code/mu/mu4e/index.html).

## Encryption

Optionally, you may want to add some tweaks so that encryption and
decryption of messages, will be easier. This is actually one of my
primary reasons why I'm using mu4e -- it has been pointed out to me
that despite using browser extensions like
[FireGPG](http://getfiregpg.org/s/home), and
[It's All Text!](https://addons.mozilla.org/en-US/firefox/addon/its-all-text/),
the supposedly private message that you composed got auto-saved by
default to the *Drafts* folder. This implies, that your
unencrypted message, was still saved somewhere. Ahem.

To make use of these cryptographic utilities, edit your emacs init:

```
$ emacs ~/.emacs.d/init.el
```

Then add the following:

```
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

```
M-x eval-region
```

To make the settings take effect, immediately.

To send an encrypt a message, hit `C` from the main menu of mu4e, fill in
the usual fields like `To:`, and `Subject:`, then on the message
body, hit:

```
M-x ec
```

This will tag your outgoing message to be signed and encrypted. To send the
it, hit `C-c C-c`. This will then prompt you to input your
passphrase. It will also ask you to fill in some information regarding your
outgoing mail server (SMTP). The SMTP server for Gmail is
*smtp.gmail.com*, then use `USERNAME@gmail`.com when prompted for the
username. Use your regular password, when prompted, or input your
application-specific password, as described earlier. These information will be
saved to `~/.authinfo`, and will be used for later messages.

To decrypt a message, open the message, then hit:

```
M-x dc
```

This will prompt you to input your passphrase. After which, you'll be prompted
if you'll want to replace the contents of the buffer, say yes to this.

These approaches are not fool-proof, because there's at least two gaping holes
that you have to be aware of -- emacs backups, and mu4e drafts. With the
former, when you are using emacs' backup facility, or a package like
[backup-dir](http://www.emacswiki.org/emacs/BackupDirectory),
messages that you compose, presumably before you encrypt it, will have an
unencrypted copy to the local disk. With the latter, the same principle
applies. So be wary of these situations, and tweak your configuration, as
necessary.


# Conclusion

Bear in mind that I purposely avoided fleshing out many details, as it would
conflate the attempt of this article to make things simple. However, if you
want to learn more, you can always go to the
[getmail](http://pyropus.ca/software/getmail/documentation.html)
and [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e/index.html)
documentation, to fill in missing gaps, that you may have.

