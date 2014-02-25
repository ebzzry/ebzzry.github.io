#lang scribble/manual

Title: Emacs and Mail
Date: 2014-02-17T16:02:38
Tags: emacs, mail

In this day and age, checking our mail means going to the website of our mail
provider, or using a mobile app. However, there are some cases when we want to
have more control over our messages, especially when the feature we want is not
present with the mainstream options.

Emacs provides a plethora (gnus, wanderlust, vm, etc.) of ways of sending and
receiving mail. In this post, we're going to talk
@hyperlink["http://pyropus.ca/software/getmail/" "getmail"],
@hyperlink["http://www.djcbsoftware.nl/code/mu/" "mu"], and
@hyperlink["http://www.djcbsoftware.nl/code/mu/mu4e.html" "mu4e"], and how to
set them up quickly. In this tutorial We'll assume that we're going to get our
messages from @hyperlink["http://gmail.com" "Gmail"] via its IMAP interface.

<!-- more -->

@section{Fetching Messages}

We first need to have a way to download our mails, off our mail server. A
easy-to-use application that will do that for us is
@hyperlink["http://pyropus.ca/software/getmail/" "getmail"].

@subsection{Installation}

Most of the time, getmail can be readily installed via your system's package
manager. If you are using a
@hyperlink["https://www.debian.org/misc/children-distros" "Debian-based
system"], you can install it by running:

@verbatim{
$ sudo apt-get install getmail4
}

If you are using @hyperlink["https://nixos.org/nixos/" "NixOS"], you can
install by running:

@verbatim{
$ nix-env -i getmail
}

However, if your system doesn't provide an easy way for you to install getmail,
you can always head to its @hyperlink["http://pyropus.ca/software/getmail/"
"homepage"], then download the tarball.


@subsection{Configuration}

Next, we need to conjure the incantation so that getmail knows how to get your
stuff. Create the file @tt{~/.getmail/getmailrc}. In addition to that, we
need to create and specify where the messages will go:

@verbatim{
$ mkdir ~/Maildir
$ mkdir ~/.getmail
$ emacs ~/.getmail/getmailrc
}

Then put in the following:

@verbatim{
[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
@; mailboxes = ("[Gmail]/All Mail",)
username = USERNAME@"@"gmail.com
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
}

Replace USERNAME with your Gmail username, then replace PASSWORD with your
Gmail password. However, if you are using
@hyperlink["http://www.google.com/landing/2step/" "2-step authentication"], use
an @hyperlink["https://accounts.google.com/IssuedAuthSubTokens"
"application-specific"] password for the password field. Take note, that
@tt{~/Maildir} is the default directory that Mail Transfer Agents (MTA) which
use the @hyperlink["https://en.wikipedia.org/wiki/Maildir" "maildir"] format
use, to store data.


@subsection{Execution}

To verify that we can indeed fetch our messages, run getmail:

@verbatim{
$ getmail
}

If it doesn't choke, and displays something like the following, then you have
configured getmail correctly.

@verbatim{
getmail version 4.43.0
Copyright (C) 1998-2012 Charles Cazabon.  Licensed under the GNU GPL version 2.
SimpleIMAPSSLRetriever:foobar@"@"gmail.com@"@"imap.gmail.com:993:
...
}


@section{Reading Messages}

Now that we can download our messages, we need to have a way to read them. This
is where mu and the accompanying emacs-based client, mu, comes in.

@subsection{Installation}

Just like with getmail above, chances are, mu can be installed via your
system's package manager. If you are using a
@hyperlink["https://www.debian.org/misc/children-distros" "Debian-based
system"], you can install it by running:

@verbatim{
$ sudo apt-get install maildir-utils
}

If you are using @hyperlink["https://nixos.org/nixos/" "NixOS"], you can
install by running:

@verbatim{
$ nix-env -i mu
}

In addition to the above, we need to fetch mu4e. This comes with mu's source
code. Download it by running:

@verbatim{
$ mkdir ~/.emacs.d
$ cd ~/.emacs.d
$ git clone git@"@"github.com:djcb/mu.git
}

This creates a @tt{mu/} directory in the current directory, which happens to
be the default location from which emacs looks for init files. Take note, that
the git command above actually fetches the source code of mu, and we can
actually use it to install mu. But since, you have your package manager, we'll
ignore that. Also the location from which the @tt{mu/mu4e/} subdirectory exists
from the package manager's installation, varies between systems. So, for now,
we're only interested with the @tt{mu/mu4e/} subdirectory.


@subsection{Configuration}

We now need to make that mu4e directory accessible to emacs. To do so, we need
to edit either @tt{~/.emacs.d/init.el} or @tt{~/.emacs}:

@verbatim{
$ emacs ~/.emacs.d/init.el
}

Then add the following:

@verbatim{
(setq load-path (append load-path '("~/.emacs.d/mu/mu4e")))
(require 'mu4e)
}

Additionally we need to put in some information about us, so that emacs won't
bother asking us about those details later on:

@verbatim{
(setq user-full-name "Foo B. Baz"
       user-mail-address "foo@"@"bar.baz")
}

To make our life even easier, we'll set some variables:

@verbatim{
(setq mu4e-get-mail-command "getmail"
      mu4e-update-interval 300
      mu4e-attachment-dir "~/Downloads")
}

@subsection{Execution}

You can restart emacs so that those settings can take effect, or alternatively,
you can mark (C-space) those lines, then hit:

@verbatim{
M-x eval-region
}

At this point, you can now use mu4e, by hitting:

@verbatim{
M-x mu4e
}

You'll get a sexy menu, wherein you can hit shortcuts to get you to where you
want. To compose a message, hit @tt{C}, fill in the fields, then hit
@tt{C-c C-c} to send the message. The rest of the commands should be
self-explanatory, but if you want to learn more, you can read the nice
@hyperlink["http://www.djcbsoftware.nl/code/mu/mu4e/index.html" "mu4e manual"].

@subsection{Encryption}

Optionally, you may want to add some tweaks so that encryption and
decryption of messages, will be easier. This is actually one of my primary
reasons why I'm using mu4e -- it has been pointed out to me that despite using
browser extensions like @hyperlink["http://getfiregpg.org/s/home" "FireGPG"], and
@hyperlink["https://addons.mozilla.org/en-US/firefox/addon/its-all-text/" "It's
All Text!"], the supposedly private message that you composed got auto-saved by
default to the @emph{Drafts} folder. This implies, that your unencrypted
message, was still saved somewhere. Ahem.

To make use of these cryptographic utilities, edit your emacs init:

@verbatim{
$ emacs ~/.emacs.d/init.el
}

Then add the following:

@verbatim{
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
}

Mark those lines, then hit:

@verbatim{
M-x eval-region
}

To make the settings take effect, immediately.

To send an encrypt a message, hit @tt{C} from the main menu of mu4e, fill in
the usual fields like @tt{To:}, and @tt{Subject:}, then on the message
body, hit:

@verbatim{
M-x ec
}

This will tag your outgoing message to be signed and encrypted. To send the
it, hit @tt{C-c C-c}. This will then prompt you to input your
passphrase. It will also ask you to fill in some information regarding your
outgoing mail server (SMTP). The SMTP server for Gmail is
@emph{smtp.gmail.com}, then use USERNAME@"@"gmail.com when prompted for the
username. Use your regular password, when prompted, or input your
application-specific password, as described earlier. These information will be
saved to @tt{~/.authinfo}, and will be used for later messages.

To decrypt a message, open the message, then hit:

@verbatim{
M-x dc
}

This will prompt you to input your passphrase. After which, you'll be prompted
if you'll want to replace the contents of the buffer, say yes to this.

These approaches are not fool-proof, because there's at least two gaping holes
that you have to be aware of -- emacs backups, and mu4e drafts. With the
former, when you are using emacs' backup facility, or a package like
@hyperlink["http://www.emacswiki.org/emacs/BackupDirectory" "backup-dir"],
messages that you compose, presumably before you encrypt it, will have an
unencrypted copy to the local disk. With the latter, the same principle
applies. So be wary of these situations, and tweak your configuration, as
necessary.


@section{Conclusion}

Bear in mind that I purposely avoided fleshing out many details, as it would
conflate the attempt of this article to make things simple. However, if you
want to learn more, you can always go to the
@hyperlink["http://pyropus.ca/software/getmail/documentation.html" "getmail"]
and @hyperlink["http://www.djcbsoftware.nl/code/mu/mu4e/index.html" "mu4e"]
documentation, to fill in missing gaps, that you may have.

