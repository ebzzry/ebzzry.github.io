.PHONY: all clean

DOSIEROJ=$(filter-out fkd/pagxopiedo.md fkd/index.md, $(wildcard fkd/*.md))
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALITIKOJ="93746003-1"

all:
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(DOSIEROJ)
	$(KONSTRUILO) \
          -D "Retejo pri komputiko, hominklinoj, kaj hazardaĵoj." \
          -K "ebzzry, rommel martinez" \
          --og-title "La Pensoj de Pedanto" \
          --og-type $(OG_TIPO) \
          --og-url "https://ebzzry.io/eo/" \
          --og-image $(OG_BILDO) \
          --analytics $(ANALITIKOJ) \
          --lang "eo" \
          -RFiamuo index.html \
          fkd/index.md fkd/pagxopiedo.md

%.html: fkd/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(KONSTRUILO) \
          -D $(OG_TITOLO) \
          -K "$$(cat dat/$$(basename $< .md).dat)" \
          --og-title $(OG_TITOLO) \
          --og-type $(OG_TIPO) \
          --og-url "https://ebzzry.io/eo/$$(basename $< .md)/" \
          --og-image $(OG_BILDO) \
          --analytics $(ANALITIKOJ) \
          --lang "eo" \
          -RFiamuo "$$(basename $< .md)/index.html" \
          $< fkd/pagxopiedo.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd -exec rm -rf {} \;
