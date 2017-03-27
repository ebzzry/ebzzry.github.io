.PHONY: all

BUILDER=emem

DESCRIPTION='A journal about computing, human predilections, and random krakaboom.'
KEYWORDS='ebzzry, rommel, martinez, rommel martinez, journal, blog, krakaboom, y, y combinator, lambda, lambda calculus, lisp, scheme, racket, clojure, haskell, fallacies, symbols, marks, symbols and marks, emacs, emacs hacks, emacs tutorials, emacs commands, emacs basics, dired, retrospect, livefrog, usync, essays, english, esperanto, verb tenses, git, github, primer, introduction, linux, macos, kvm, frog, ugarit, gpg, ssh, division by zero, communicate, human, communicate like a human, human predilections, predilections, computing, inspiration, quotes, famous quotes, words, emem'

OG_TYPE="article"
OG_IMAGE="http://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"

all:
	$(BUILDER) -r
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title "Page Not Found" \
          --og-type $(OG_TYPE) \
          --og-url "http://ebzzry.io/404.html" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiauo 404.html src/404.md
	$(MAKE) $(MFLAGS) -C en
