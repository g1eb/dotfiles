#!/usr/bin/env bash
for file in .*
do
  if [[ $file =~ ^.[^(.|git)] ]]; then
    err=$(ln -s "$PWD/$file" "$HOME/$file" 2>&1);
    if [[ ! "$PWD/$file" -ef "$HOME/$file" ]];
      then printf >&2 '%s\n' "$err";
    fi
  fi;
done
