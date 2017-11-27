#!/usr/bin/env bash
shopt -s extglob

for file in $(printf '%s\n' .!(?(.|git)))
do
  err=$(ln -s "$PWD/$file" "$HOME/$file" 2>&1);
  if [[ ! "$PWD/$file" -ef "$HOME/$file" ]];
    then printf >&2 '%s\n' "$err";
  fi
done
