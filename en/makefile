.PHONY: all clean

DOSIEROJ=$(filter-out fkd/footer.md fkd/index.md, $(wildcard fkd/*.md))
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.com/images/ico/android-chrome-512x512.png"

all:
	parallel "$(MAKE) {/.}.html" ::: $(DOSIEROJ)
	$(KONSTRUILO) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" -D "A journal about computing, human predilections, and random krakaboom." -K "ebzzry, rommel martinez" --og-title "Musings of an Optimist" --og-type $(OG_TIPO) --og-url "https://ebzzry.com/en/" --og-image $(OG_BILDO) --lang "en" -RFamuo index.html fkd/index.md fkd/footer.md

%.html: fkd/%.md
	if [[ ! -d "$$(basename $< .md)" ]]; then mkdir "$$(basename $< .md)"; fi
	$(KONSTRUILO) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" -D $(OG_TITOLO) -K "$$(cat dat/$$(basename $< .md).dat)" --og-title $(OG_TITOLO) --og-type $(OG_TIPO) --og-url "https://ebzzry.com/en/$$(basename $< .md)/" --og-image $(OG_BILDO) --lang "en" -RFamuo "$$(basename $< .md)/index.html" $< fkd/footer.md

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd ! -name dat -exec rm -rf {} \;
