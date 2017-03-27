.PHONY: all upload force-upload clean

FILES=$(filter-out src/footer.md,src/index.md $(wildcard src/*.md))
BUILDER=emem

DESCRIPTION='A journal about computing, human predilections, and random krakaboom.'
KEYWORDS='ebzzry, rommel, martinez, rommel martinez, journal, blog, krakaboom, y, y combinator, lambda, lambda calculus, lisp, scheme, racket, clojure, haskell, fallacies, symbols, marks, symbols and marks, emacs, emacs hacks, emacs tutorials, emacs commands, emacs basics, dired, retrospect, livefrog, usync, essays, english, esperanto, verb tenses, git, github, primer, introduction, linux, macos, kvm, frog, ugarit, gpg, ssh, division by zero, communicate, human, communicate like a human, human predilections, predilections, computing, inspiration, quotes, famous quotes, words, emem'

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="http://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"

all:
	time parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title "Division by Zero" --og-type $(OG_TYPE) \
          --og-url "http://ebzzry.io/en/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo index.html src/index.md src/footer.md

%.html: src/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "http://ebzzry.io/en/$$(basename $< .md)/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< src/footer.md

upload:
	git push origin master

force-upload:
	git push --force origin master

clean:
	rm -f *.html
	rm -rf static
