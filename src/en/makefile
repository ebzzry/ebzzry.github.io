.PHONY: all clean

FILES=$(filter-out footer.md index.md, $(wildcard *.md))
EMEM=emem
LANGUAGE=en

METADATA="$$(gsed -n '1,/^---$/ {/^---$/d; p}' $<)"
TITLE="$$(echo $$METADATA | rg title | choose 1)"
KEYWORDS="$$(echo $$METADATA | rg keywords | choose 1)"
IMAGE="$$(echo $$METADATA | rg image | choose 1)"

all:
	parallel "$$(which make)" ::: $(FILES)
	gsed '1,/^---$$/d' index.md > index.md.tmp
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "A journal about computing, human predilections, and random krakaboom." \
  -K "ebzzry, Rommel Martínez, rommel martinez, Rommel Martinez, rommel martinez" \
  --og-title "(:ebzzry)" \
  --og-type "article" \
  --og-url "https://ebzzry.com/${LANGUAGE}/" \
  --og-image "https://ebzzry.com/images/site/books-1008x250.jpg" \
  --lang "${LANGUAGE}" \
  -RFamuo ../../${LANGUAGE}/index.html index.md.tmp footer.md
	rm -f index.md.tmp

%.html: %.md
	if [[ ! -d "../../${LANGUAGE}/${basename $<}" ]]; then mkdir -p "../../${LANGUAGE}/${basename $<}"; fi
	gsed '1,/^---$$/d' $< > $<.tmp
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "$(TITLE)" \
  -K "$(KEYWORDS)" \
  --og-title "$(TITLE)" \
  --og-type "article" \
  --og-url "https://ebzzry.com/${LANGUAGE}/${basename $<}/" \
  --og-image "$(IMAGE)" \
  --lang "${LANGUAGE}" \
  -RFamuo "../../${LANGUAGE}/${basename $<}/index.html" $<.tmp footer.md
	rm -f $<.tmp

clean:
	rm -rf ../../${LANGUAGE}
