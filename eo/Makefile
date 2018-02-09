.PHONY: all clean

FILES=$(filter-out fkd/pagxopiedo.md fkd/index.md, $(wildcard fkd/*.md))
BUILDER=emem

DESCRIPTION="$$(cat ./PRIPAROLO)"
KEYWORDS="$$(cat ./SXLOSILVORTOJ)"
OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"

all:
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)
	$(BUILDER) \
          -D "Retejo pri komputiko, homaj inklinoj, kaj hazardaj umoj." \
          -K "ebzzry, rommel, martinez, pedanta pirato" \
          --og-title "Pensoj de Pedanta Pirato" --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/eo/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          --lang "eo" \
          -RFiamuo index.html \
          fkd/index.md fkd/pagxopiedo.md

%.html: fkd/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(BUILDER) \
          -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/eo/$$(basename $< .md)/" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          --lang "eo" \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< fkd/pagxopiedo.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd -exec rm -rf {} \;
