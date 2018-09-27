.PHONY: all clean

DOSIEROJ=$(filter-out fkd/footer.md fkd/index.md, $(wildcard fkd/*.md))
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALITIKOJ="93746003-1"

all:
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(DOSIEROJ)
	$(KONSTRUILO) \
          -D "A journal about computing, human predilections, and random krakaboom." \
          -K "ebzzry, rommel martinez" \
          --og-title "The Musings of a Pedant" \
          --og-type $(OG_TIPO) \
          --og-url "https://ebzzry.io/en/" \
          --og-image $(OG_BILDO) \
          --analytics $(ANALITIKOJ) \
          --lang "en" \
          -RFiamuo index.html \
          fkd/index.md fkd/footer.md

%.html: fkd/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(KONSTRUILO) \
          -D $(OG_TITOLO) \
          -K "$$(cat dat/$$(basename $< .md).dat)" \
          --og-title $(OG_TITOLO) \
          --og-type $(OG_TIPO) \
          --og-url "https://ebzzry.io/en/$$(basename $< .md)/" \
          --og-image $(OG_BILDO) \
          --analytics $(ANALITIKOJ) \
          --lang "en" \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< fkd/footer.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd -exec rm -rf {} \;
