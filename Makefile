.PHONY: all upload force-upload clean

FILES=$(filter-out src/footer.md, $(wildcard src/*.md))
BUILDER=emem
DESCRIPTION='A journal about computing, human predilections, and random krakaboom.'
KEYWORDS='ebzzry, rommel, martinez, rommel martinez, journal, blog, krakaboom, y, y combinator, lambda, lambda calculus, lisp, scheme, racket, clojure, haskell, fallacies, symbols, marks, symbols and marks, emacs, emacs hacks, emacs tutorials, emacs commands, emacs basics, dired, retrospect, livefrog, usync, essays, english, esperanto, verb tenses, git, github, primer, introduction, linux, macos, kvm, frog, ugarit, gpg, ssh, division by zero, communicate, human, communicate like a human, human predilections, predilections, computing, inspiration, quotes, famous quotes, words, emem'

%.html: src/%.md
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) --og-title "$$(head -1 $<)" --og-type "article" --og-url "http://ebzzry.io/$$(basename $< .md).html" --og-image "http://ebzzry.io/static/ico/android-chrome-512x512.png" -A "93746003-1" -RFiamo "$$(basename $< .md).html" $< src/footer.md

all:
	$(BUILDER) -r
	time parallel --will-cite "make {/.}.html" ::: $(FILES)

upload:
	git push origin master

force-upload:
	git push --force origin master

clean:
	rm -f *.html
	rm -rf static
