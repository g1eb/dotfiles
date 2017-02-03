#!/usr/bin/env bash
for file in .*
do
  if [[ $file =~ ^.[^.] ]];
    then ln -s "$file" "$HOME/$file";
  fi;
done
