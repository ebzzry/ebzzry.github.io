.PHONY: all clean

FILES=$(filter-out pagxopiedo.md index.md, $(wildcard *.md))
EMEM=emem

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.com/images/ico/android-chrome-512x512.png"

all:
	parallel "$(MAKE) {/.}.html" ::: $(FILES)
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "Retejo pri informadiko, hominklinoj, kaj hazardajxoj." \
  -K "ebzzry, rommel martinez" \
  --og-title "Pensoj de Optimisto" \
  --og-type $(OG_TYPE) \
  --og-url "https://ebzzry.com/eo/" \
  --og-image $(OG_IMAGE) \
  --lang "eo" \
  -C "html { max-width: 50em; }" \
  -RFamuo ../../eo/index.html index.md pagxopiedo.md

%.html: %.md
	if [[ ! -d "../../eo/$$(basename $< .md)" ]]; then mkdir -p "../../eo/$$(basename $< .md)"; fi
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D $(OG_TITLE) \
  -K "$$(cat $$(basename $< .md).dat)" \
  --og-title $(OG_TITLE) \
  --og-type $(OG_TYPE) \
  --og-url "https://ebzzry.com/eo/$$(basename $< .md)/" \
  --og-image $(OG_IMAGE) \
  --lang "eo" \
  -C "html { max-width: 50em; }" \
  -RFamuo "../../eo/$$(basename $< .md)/index.html" $< pagxopiedo.md

clean:
	rm -rf ../../eo
