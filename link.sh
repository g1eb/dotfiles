#!/usr/bin/env bash
for file in .*
do
  if [[ $file =~ ^.[^(.|git)] ]];
    then ln -s "$PWD/$file" "$HOME/$file";
  fi;
done
