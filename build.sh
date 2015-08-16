#!/bin/sh

PATH=$PATH:$HOME/bin

stage_dir () {
  [[ ! -d stage ]] && mkdir stage > /dev/null 2>&1
}

clean_up () {
  [[ -d stage ]] && rm -rf stage > /dev/null 2>&1
}

stage_files () {
  for i in `ls *.md | egrep -v '(FOOTER|README|TODO)'`; do
    cat $i FOOTER.md > stage/$i
  done
}

copy_resources () {
  emem -r
}

build_files () {
  for i in stage/*.md; do
    emem -Ro $(basename $i .md).html $i
  done
}

main () {
  case $1 in
    -r)
      copy_resources
      ;;
    *)
      stage_dir
      stage_files
      build_files
      clean_up
  esac
}

main $@
