#!/usr/bin/env bash
for file in $(ls -a1 | grep -P '^\.(?!git$|\.).+$')
do
  err=$(ln -s "$PWD/$file" "$HOME/$file" 2>&1);
  if [[ ! "$PWD/$file" -ef "$HOME/$file" ]];
    then printf >&2 '%s\n' "$err";
  fi
done
