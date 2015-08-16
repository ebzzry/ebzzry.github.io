# -*- mode: sh -*-

export PATH=$PATH:$HOME/bin

mkdir stage
for i (*.md~FOOTER.md~README.md~TODO.md) cat $i FOOTER.md >! stage/$i
for i (stage/*.md) emem -Ro ${i:t:r}.html $i
rm -rf stage
