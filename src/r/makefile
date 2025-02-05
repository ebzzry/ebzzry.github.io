.PHONY: all clean

FILES=$(wildcard *.md)
EMEM=$${HOME}/bin/emem

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.com/images/ico/android-chrome-512x512.png"

all:
	parallel "$$(which make)" ::: $(FILES)

%.html: %.md
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png' /><link rel='icon' sizes='16x16' href='/images/ico/favicon-16x16.png' /><link rel='icon' sizes='32x32' href='/images/ico/favicon-32x32.png' /><link rel='manifest' href='/images/ico/manifest.json' /><link rel='mask-icon' color='#5bbad5' href='/images/ico/safari-pinned-tab.svg' />" \
  -D $(OG_TITLE) \
  -K "ebzzry, Rommel Martínez, rommel martinez" \
  --og-title $(OG_TITLE) \
  --og-type $(OG_TYPE)  \
  --og-url "https://ebzzry.com/$$(basename $< .md).html" \
  --og-image $(OG_IMAGE) \
  -RFamuo "../../$$(basename $< .md).html" $<

clean:
	rm -f ../../*.html
