.PHONY: all clean

DOSIEROJ=$(wildcard *.md)
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.com/images/ico/android-chrome-512x512.png"

all:
	parallel "$(MAKE) {/.}.html" ::: $(DOSIEROJ)

%.html: %.md
	$(KONSTRUILO) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png' /><link rel='icon' sizes='16x16' href='/images/ico/favicon-16x16.png' /><link rel='icon' sizes='32x32' href='/images/ico/favicon-32x32.png' /><link rel='manifest' href='/images/ico/manifest.json' /><link rel='mask-icon' color='#5bbad5' href='/images/ico/safari-pinned-tab.svg' />" --og-title $(OG_TITOLO) --og-type $(OG_TIPO) -D $(OG_TITOLO) -K "ebzzry, rommel, martinez, rommel martinez" --og-url "https://ebzzry.com/$$(basename $< .md).html" --og-image $(OG_BILDO) -RFamuo "../../$$(basename $< .md).html" $<

clean:
	rm -vf *.html
	find . -maxdepth 1 -type d ! -path . ! -iname fkd ! -name dat -exec rm -rf {} \;
