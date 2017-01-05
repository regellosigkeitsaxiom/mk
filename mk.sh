#!/usr/bin/env bash
project=$(basename `pwd`)
case $1 in
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
  "s")
    stack --nix solver --update-config
  ;;
  "t")
    stack --nix test
  ;;
  "ee")
    stack --nix exec $project
  ;;
  "e")
    stack --nix exec $2
  ;;
  *)
    echo "It's pitch dark here!"
  ;;
esac
