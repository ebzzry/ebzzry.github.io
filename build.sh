#!/bin/sh

PATH=$PATH:$HOME/bin

mkdir stage > /dev/null 2>&1

for i in `ls *.md | egrep -v '(FOOTER|README|TODO)'`; do
  cat $i FOOTER.md > stage/$i
done

for i in stage/*.md; do
  emem -Ro $(basename $i .md).html $i
done

rm -rf stage > /dev/null 2>&1
