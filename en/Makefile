.PHONY: all clean

DOSIEROJ=$(filter-out fkd/footer.md fkd/index.md, $(wildcard fkd/*.md))
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.io/images/ico/bildsimbolo-512x512.png"
ANALITIKOJ="93746003-1"

all:
	parallel "$(MAKE) {/.}.html" ::: $(DOSIEROJ)
	$(KONSTRUILO) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png' /><link rel='icon' sizes='16x16' href='/images/ico/favicon-16x16.png' /><link rel='icon' sizes='32x32' href='/images/ico/favicon-32x32.png' /><link rel='manifest' href='/images/ico/manifest.json' /><link rel='mask-icon' color='#5bbad5' href='/images/ico/safari-pinned-tab.svg' />" -D "A journal about computing, human predilections, and random krakaboom." -K "ebzzry, rommel martinez" --og-title "The Musings of a Pedant" --og-type $(OG_TIPO) --og-url "https://ebzzry.io/en/" --og-image $(OG_BILDO) --analytics $(ANALITIKOJ) --lang "en" -RFamuo index.html fkd/index.md fkd/footer.md

%.html: fkd/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(KONSTRUILO) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png' /><link rel='icon' sizes='16x16' href='/images/ico/favicon-16x16.png' /><link rel='icon' sizes='32x32' href='/images/ico/favicon-32x32.png' /><link rel='manifest' href='/images/ico/manifest.json' /><link rel='mask-icon' color='#5bbad5' href='/images/ico/safari-pinned-tab.svg' />" -D $(OG_TITOLO) -K "$$(cat dat/$$(basename $< .md).dat)" --og-title $(OG_TITOLO) --og-type $(OG_TIPO) --og-url "https://ebzzry.io/en/$$(basename $< .md)/" --og-image $(OG_BILDO) --analytics $(ANALITIKOJ) --lang "en" -RFamuo "$$(basename $< .md)/index.html" $< fkd/footer.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd -exec rm -rf {} \;
