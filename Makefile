.PHONY: all clean

FILES=$(filter-out src/footer.md, $(wildcard src/*.md))
BUILDER=emem
DESCRIPTION='A journal about computing, human predilections, and random krakaboom.'
KEYWORDS='ebzzry, rommel, martinez, rommel martinez, y, y combinator, lambda, lambda calculus, lisp, scheme, racket, clojure, haskell, fallacies, symbols, marks, symbols and marks, emacs, emacs hacks, dired, retrospect, livefrog, usync, essays, english, esperanto, verb tenses, git, github, primer, introduction, linux, macos, kvm, frog, ugarit, gpg, ssh, division by zero, communicate, human, communicate like a human, krakaboom, human predilections, predilections, computing, inspiration, quotes, famous quotes, words, emem'

%.html: src/%.md
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) -FRiamo "$$(basename $< .md).html" $< src/footer.md

all:
	$(BUILDER) -r
	time parallel --will-cite "$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) -FRiamo {/.}.html {} src/footer.md" ::: $(FILES)

upload:
	git push origin master

force-upload:
	git push --force origin master

clean:
	rm -f *.html
	rm -rf static
