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

install_resources () {
  emem -i
}

build_files () {
  emem -n stage
  mv -f stage/*.html .
}

main () {
  case $1 in
    *)
      install_resources
      stage_dir
      stage_files
      build_files
      clean_up
  esac
}

main $@
