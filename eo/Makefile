.PHONY: all clean

FILES=$(filter-out src/pagxopiedo.md src/index.md, $(wildcard src/*.md))
BUILDER=emem

DESCRIPTION="$$(cat ../DESCRIPTION)"
KEYWORDS="$$(cat ../KEYWORDS)"
OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"

all:
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title "Musings of a Pedantic Pirate" --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/eo/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo index.html \
          src/index.md src/pagxopiedo.md

%.html: src/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/eo/$$(basename $< .md)/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< src/pagxopiedo.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname src -exec rm -rf {} \;
