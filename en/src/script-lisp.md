Scripting in Common Lisp
========================

<div class="center">July 5, 2017</div>
<div class="center">Updated: October 16, 2017</div>

>“The light that burns twice as bright burns half as long.”<br>
>―Dr. Eldon Tyrell, Blade Runner (1982)

<img src="/images/lisp-logo.png" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="common-lisp.net logo" title="common-lisp.net logo"/>

Full-fledged systems and libraries have always been a comfortable zone for Common Lisp
users. However, for a long time, there has not been a definitive solution in using CL as a scripting
language. A scripting language, in this context, means something that is similar in spirit to
command line shells—that is, one that is used to issue, control, and manage system commands on the
application level. The meaning also extends to the automation of the execution of tasks that are
otherwise done one-by-one. In this article, I will give a short introduction on how to use CL in the
scripting domain.


<a name="toc"></a>Table of contents
------------------------------------

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Basics](#basics)
- [More](#more)
- [Closing remarks](#closing)


<a name="overview"></a>Overview
--------------------------------

One of the most common questions I get when I mention that I want to do scripting in CL, is that why
would I want to do so and is it possible. The answer is simple: I want more power and
expressivity. I want a mature and unencumbered. I want a language that is able to express my ideas,
in least amount of friction.

A script is only as powerful as the language and tools would allow. Bash and friends, for example,
are great for expressing ideas, as if you are typing them on the command line itself. It emulates
that behavior inside a script. You can define functions to do subroutines, but they’re just
that. Functions in Bash are nowhere near functions in languages like CL. As an interactive user
shell, it works fine; other than that, no.

Other scripting solutions exist in other languages. Haskell, Python, Scheme, and Ruby, to name a
few, has it. However, there’s a neat future of CL, that is difficult to implement or non-existent in
other approaches: since the scripts themselves are valid CL programs, I can load the programs
in the REPL and do nice things with it. Nothing comes close to the flexibility that CL provides when
interacting with live, running programs.

In this short tutorial, I will also lightly gloss about one nice thing with CL scripting: multi-call
binaries. A multi-call binary is a single executable file that can be dereferenced with many
names. Each name corresponds to a specific subroutine inside that single binary. The beauty of this
approach is that instead of managing many different programs, you only manage one, and it will
dispatch the correct subprogram that a user wants. This is similar to what Busybox is doing. In CL,
this is handled by [cl-launch](https://github.com/fare/cl-launch).


<a name="prerequisites"></a>Prerequisites
------------------------------------------

Scripting in CL works on top of the language, that is, in the form of libraries that provide the
abstractions to interact with the system and
environment. The
[Utilities for Implementation- and OS- Portability (UIOP)](https://gitlab.common-lisp.net/asdf/asdf/tree/master/uiop) is
a set of abstractions that lets us use and write portable CL code. It does the heavy lifting of
making sure that we are going to write portable Lisp code. UIOP is part of ASDF3—which is part of
most modern CL implementations—so there is no need to manually install
it. [inferior-shell](https://github.com/fare/inferior-shell) helps us with managing
processes. [cl-scripting](https://github.com/fare/cl-scripting) helps us with more process control.

The program `cl-launch` must also be installed in your system. It will be responsible in creating
the multi-call binary, itself. To install `cl-launch` on systems that use APT:

```bash
sudo apt-get install -y cl-launch
```

To install on systems that use Nix:

```bash
nix-env -i cl-launch
```


<a name="basics"></a>Basics
----------------------------

### Paths

To get started, let’s create a new project directory. We will build our project in
`$HOME/common-lisp`.

```bash
mkdir -p ~/common-lisp/my-scripts
```

This directory is one of the standard paths that ASDf will crawl, for `.asd` files. It is worth
nothing that it doesn’t matter if `$HOME/common-lisp` is a regular directory or a symlink to one.


### Definitions

Then, let’s create `my-scripts.asd` in that directory. To start, it will contain the following:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Lolu Ogag"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"))
```

Some of the features that we need are in ASDF 3.1, so we need to conditionalize the whole system. We
declare dependencies on `cl-scripting`, which provides some helpers; and `inferior-shell`, which
provides the things that we need for managing shell processes

Next, let’s create the file `main.lisp`, in the same directory. It will contain the following:

```lisp
(uiop:define-package :my-scripts/main
    (:use :cl
          :uiop
          :cl-scripting
          :inferior-shell
          :fare-utils
          :cl-launch/dispatch)
  (:export #:symlink
           #:help
           #:main))

(in-package :my-scripts/main)

(exporting-definitions
 (defun symlink (src)
   (let ((binarch (resolve-absolute-location `(,(subpathname (user-homedir-pathname) "bin/")) :ensure-directory t)))
     (with-current-directory (binarch)
       (dolist (i (cl-launch/dispatch:all-entry-names))
         (run `(ln -sf ,src ,i)))))
   (success))

 (defun help ()
   (format! t "~A commands: ~{~A~^ ~}~%" (get-name) (all-entry-names))
   (success))

 (defun main (&rest args)
    (format t "main~%")))

(register-commands :my-scripts/main)
```

We’re going to start by using `uiop:define-package`. Unlike `defpackage`, this creates the necessary
environment that is friendly to UIOP. In the `:use` clause, we’re going to use helpers from other
libraries. In the body of this file, you can see `exporting-definitions`. This marker effectively
marks the boundaries of what will be created as an executable, or not. It will be used by
`register-commands`, later.

Here, we define several functions: `symlink` is responsible for creating the symlinks for the
multi-call binary; `help` displays some basic usage information; and `main` is the
entrypoint of our script. The multi-call binary will be available in `$HOME/bin/`. To make it
convenient to build the script and the symlinks, we’re going to put the build instructions in a
Makefile. Create the file `Makefile` in the current directory, then put in the following:

```Makefile
NAME=my-scripts
BINARY=$(HOME)/bin/$(NAME)
SCRIPT=$(PWD)/$(NAME)
CL=cl-launch

.PHONY: all $(NAME) clean

all: $(NAME)

$(NAME):
	@$(CL) --output $(NAME) --dump ! --lisp sbcl --quicklisp --system $(NAME) --dispatch-system $(NAME)/main

install: $(NAME)
	@ln -sf $(SCRIPT) $(BINARY)
	@$(SCRIPT) symlink $(NAME)

clean:
	@rm -f $(NAME)
```

In the `$(NAME)` target, we call `cl-launch` with options to build the script. In the `install`
target, we invoke the script with the options `symlink $(NAME)`, to build the symlinks for the
multi-call binary. Since we only defined three functions within the body of `exporting-definitions`,
it is only going to build three symlinks to `my-scripts`. The `‑‑output $(NAME)` option specifies
the output file. The `‑‑dump !` means to create an image, to enable a faster startup. The `‑‑lisp sbcl`
specifies that we want to use SBCL, for this script; the option `‑‑quicklisp` specifies that
we load [Quicklisp](https://www.quicklisp.org) with the image. The `‑‑system $(NAME)` loads the
system the we are building. The `‑‑dispatch-system $(NAME)/main` species the entrypoint of our
program.


### Building

We are now ready to build the script and the symlinks. To do that, run:

```bash
$ make install
```

This will build the multi-call binary—`./my-scripts` and the corresponding symbolic links. The directory tree of
`~/bin` should look like the following:

```bash
$ tree ~/bin
/home/ogag/bin
├── getuid -> my-scripts
├── help -> my-scripts
├── main -> my-scripts
├── my-scripts -> /home/ogag/common-lisp/my-scripts/my-scripts
└── symlink -> my-scripts

0 directories, 5 files
```

To test that it indeed works, run:

```bash
$ getuid
```

If it displays your UID, we’re good to go.


<a name="more"></a>More
-----------------------

Say, you want to know the battery status of your laptop from the command line. We can define that
with several functions. Let’s modify `my-script.asd` to contain the additional declaration:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Lolu Ogag"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"
               "my-scripts/general"))
```

Then, let’s populate the file `general.lisp` with the following contents:

```lisp
(uiop:define-package
    :scripts/general
    (:use
     :cl
     :fare-utils
     :uiop
     :cl-scripting
     :inferior-shell
     :cl-launch/dispatch
     :optima
     :optima.ppcre
     :local-time)
  (:export #:battery
           #:screenshot))

(in-package :scripts/general)

(defvar *screenshots-dir*
  (subpathname (user-homedir-pathname) "Desktop/"))

(defun battery-status ()
  (let ((base-dir "/sys/class/power_supply/*")
        (exclude-string "/AC/"))
    (with-output (s nil)
      (loop
         :for dir :in (remove-if #'(lambda (path)
                                     (search exclude-string (native-namestring path)))
                                 (directory* base-dir))
         :for battery = (first (last (pathname-directory dir)))
         :for capacity = (read-file-line (subpathname dir "capacity"))
         :for status = (read-file-line (subpathname dir "status"))
         :do (format s "~A: ~A% (~A)~%" battery capacity status)))))

(exporting-definitions
  (defun battery ()
    (format t "~A" (battery-status))
    (values))

  (defun screenshot (mode)
   (let* ((dir *screenshots-dir*)
          (file (format nil "~A.png" (format-timestring nil (now))))
          (dest (format nil "mv $f ~A" dir))
          (image (format nil "~A/~A" dir file)))
     (flet ((scrot (file dest &rest args)
              (run/i `(scrot ,@args ,file -e ,dest))))
       (match mode
         ((ppcre "(full|f)") (scrot file dest))
         ((ppcre "(region|r)") (scrot file dest '-s))
         (_ (err (format nil "invalid mode ~A~%" mode))))
       (run `(xclip -selection clipboard) :input (list image))
       (success)))))

(register-commands :scripts/general)
```

In the definition of `battery`, it outputs the return value of `(battery-status)`, in a human
friendly way, i.e., sans the double quotes. The `battery` function then returns no values. We need
to do this because we only want the output of the call to `battery-status`.

The command `screenshot`, on the other hand takes a screenshot with *scrot* then makes the absolute
path of the image available from the clipboard selection, using *xclip*. We use the libraries
`local-time`, for the date string and library; and `optima`, for the pattern matching. For the
command `screenshot` to work, install the binary dependencies. Run the following commands for Debian
and Nix systems, respectively:

```bash
$ sudo apt-get install -y scrot xclip
```

```bash
$ nix-env -i scrot xclip
```

Launching and managing user applications is easy. Let’s start by adding a dependency in
`my-scripts.asd`:

```lisp
#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
  :version "0.0.1"
  :description "CL scripts"
  :license "MIT"
  :author "Lolu Ogag"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               "my-scripts/main"
               "my-scripts/general"
               "my-scripts/apps"))
```

Then, let’s populate `apps.lisp`:

```lisp
(uiop:define-package
    :scripts/apps
    (:use
     :cl
     :fare-utils
     :uiop
     :inferior-shell
     :cl-scripting
     :cl-launch/dispatch)
  (:export #:chrome
           #:kill-chrome
           #:stop-chrome
           #:continue-chrome))

(in-package :scripts/apps)

(exporting-definitions
 (defun chrome (&rest args)
   (run/i `(google-chrome-beta ,@args)))

 (defun kill-chrome (&rest args)
   (run `(killall ,@args chromium-browser chromium google-chrome chrome)
        :output :interactive :input :interactive :error-output nil :on-error nil)
   (success))

 (defun stop-chrome ()
   (kill-chrome "-STOP"))

 (defun continue-chrome ()
   (kill-chrome "-CONT")))

(register-commands :scripts/apps)
```

Let’s rebuild my-scripts:

```bash
$ make install
my-scripts available commands: battery chrome continue-chrome help kill-chrome main screenshot stop-chrome symlink
```

Yay! 😄


<a name="closing"></a>Closing Remarks
--------------------------------------

It has been said many times that CL has already faded into obscurity; that no one longer uses it;
that it is no longer useful. No, that is not true. Just because it is not being discussed in
mainstream news, means it is dead or have fallen out of favor. CL is a standardized language, and a
program that conforms to the standard has the guarantee—to an extent—that it can still run in the
feature. To create a language standard is a monumental task—it requires that different, possibly
conflicting parties, to agree to how things should be done. There are different implementations of
CL, and each implementation strives to achieve goals that may not necessarily be compatible with
other implementations. That’s OK, because it gives room for implementors and designers, on how to
work on the base specifications. As long as they conform to the standard, things are green.

A working example of how I use CL scripting is with my Nixpkgs and NixOS helper,
[nix](https://github.com/ebzzry/nix-lisp).

The human responsible for making scripting in CL possible and acceptable,
is [Faré Rideau (Fare)](http://fare.tunes.org). It
was [this blog entry](http://fare.livejournal.com/184127.html) of his that motivated me to see the
viability of CL as a scripting language. You may send your donations to him
via [PayPal](https://paypal.me/fahree) or [Bitcoin](bitcoin:1fareF6wCNYYiLPGmyQjrd3AQdHBb1CJ6). The
source code for this article can be found [here](https://github.com/ebzzry/my-scripts), while the
scripts that I use for personal use can be found [here](https://github.com/ebzzry/scripts).

The banner image used at the top is from [common-lisp.net](https://common-lisp.net/).
