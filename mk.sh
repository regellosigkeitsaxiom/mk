#!/usr/bin/env bash
files=`ls -1 | grep .cabal$`
project=${files%.*}

case $1 in
  "q")
    echo $project
  ;;
  "")
    stack --nix build
  ;;
  "i")
    stack --nix install
  ;;
  "d")
    vim $project.cabal
  ;;
  "r")
    stack --nix ghci $2
  ;;
  "ni")
    nix-env -if .
  ;;
  "n")
    cabal2nix --shell . > default.nix
  ;;
  "s")
    vim stack.yaml
  ;;
  "ss")
    stack --nix solver --update-config
  ;;
  "t")
    stack --nix test
  ;;
  "ee")
    stack --nix install &&
    stack --nix exec $project
  ;;
  "e")
    stack --nix exec $2
  ;;
  *)
    echo "It's pitch dark here!"
  ;;
esac
