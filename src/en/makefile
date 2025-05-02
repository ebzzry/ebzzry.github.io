.PHONY: all clean

FILES=$(filter-out footer.md index.md, $(wildcard *.md))
EMEM=emem

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.com/images/site/og-image.png"

all:
	parallel "$$(which make)" ::: $(FILES)
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "A journal about computing, human predilections, and random krakaboom." \
  -K "ebzzry, Rommel Martínez, rommel martinez, Rommel Martinez, rommel martinez" \
  --og-title "(:ebzzry)" \
  --og-type $(OG_TYPE) \
  --og-url "https://ebzzry.com/en/" \
  --og-image "https://ebzzry.com/images/site/books-1008x250.jpg" \
  --lang "en" \
  -RFamuo ../../en/index.html index.md footer.md

%.html: %.md
	if [[ ! -d "../../en/$$(basename $< .md)" ]]; then mkdir -p "../../en/$$(basename $< .md)"; fi
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D $(OG_TITLE) \
  -K "$$(cat $$(basename $< .md).dat)" \
  --og-title $(OG_TITLE) \
  --og-type $(OG_TYPE) \
  --og-url "https://ebzzry.com/en/$$(basename $< .md)/" \
  --og-image "$$(head -n 15 $< | grep 'img src' | sed 's|.*\(\/images.*\)"\ style.*|https://ebzzry.com\1|')" \
  --lang "en" \
  -RFamuo "../../en/$$(basename $< .md)/index.html" $< footer.md

clean:
	rm -rf ../../en
