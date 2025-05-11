.PHONY: all clean

FILES=$(filter-out footer.md index.md, $(wildcard *.md))
EMEM=emem
LANGUAGE=en

all:
	parallel "$$(which make)" ::: $(FILES)
	gsed -n '1,/^---$$/ {/^---$$/d; p}' index.md > index.md.frontmatter
	gsed '1,/^---$$/d' index.md > index.md.contents
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "$$(rg description index.md.frontmatter | choose -f : 1 | xargs)" \
  -K "$$(rg keywords index.md.frontmatter | choose -f : 1 | xargs)" \
  --og-title "(:ebzzry)"  \
  --og-type "article" \
  --og-url "https://ebzzry.com/${LANGUAGE}/" \
  --og-image "$$(rg image index.md.frontmatter | choose -f : 1 | xargs)" \
  --lang "${LANGUAGE}" \
  -RFamuo ../../${LANGUAGE}/index.html index.md.contents footer.md
	rm -f index.md.frontmatter index.md.contents

%.html: %.md
	if [[ ! -d "../../${LANGUAGE}/${basename $<}" ]]; then mkdir -p "../../${LANGUAGE}/${basename $<}"; fi
	gsed -n '1,/^---$$/ {/^---$$/d; p}' $< > $<.frontmatter
	gsed '1,/^---$$/d' $< > $<.contents
	$(EMEM) --head "<link rel='apple-touch-icon' sizes='180x180' href='/images/ico/apple-touch-icon.png'><link rel='icon' type='image/png' sizes='32x32' href='/images/ico/favicon-32x32.png'><link rel='icon' type='image/png' sizes='16x16' href='/images/ico/favicon-16x16.png'><link rel='manifest' href='/images/ico/site.webmanifest'><link rel='mask-icon' href='/images/ico/safari-pinned-tab.svg' color='#5bbad5'><link rel='shortcut icon' href='/images/ico/favicon.ico'> <meta name='msapplication-TileColor' content='#da532c'> <meta name='msapplication-config' content='/images/ico/browserconfig.xml'> <meta name='theme-color' content='#ffffff'>" \
  -D "$$(rg title $<.frontmatter | choose -f : 1 | xargs)" \
  -K "$$(rg keywords $<.frontmatter | choose -f : 1 | xargs)" \
  --og-title "$$(rg title $<.frontmatter | choose -f : 1 | xargs)"  \
  --og-type "article" \
  --og-url "https://ebzzry.com/${LANGUAGE}/${basename $<}/" \
  --og-image "$$(rg image $<.frontmatter | choose -f : 1 | xargs)" \
  --lang "${LANGUAGE}" \
  -RFamuo "../../${LANGUAGE}/${basename $<}/index.html" $<.contents footer.md
	rm -f $<.frontmatter $<.contents

clean:
	rm -rf ../../${LANGUAGE}
