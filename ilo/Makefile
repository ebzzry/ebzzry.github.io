.PHONY: all clean

FILES=$(filter-out src/saka.md src/index.md, $(wildcard src/*.md))
BUILDER=emem

DESCRIPTION="$$(cat ./PANANGILADAWAN)"
KEYWORDS="$$(cat ./TERMINO)"
OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"

all:
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title "Panunot iti Naalwad nga Pirata" --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/ilo/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo index.html \
          src/index.md src/saka.md

%.html: src/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/ilo/$$(basename $< .md)/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< src/saka.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname src -exec rm -rf {} \;
