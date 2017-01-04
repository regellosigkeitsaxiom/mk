#!/usr/bin/env bash
project=$(basename `pwd`)
case $1 in
  "")
    stack --nix build
  ;;
  "install")
    stack --nix install
  ;;
  "deps")
    vim $project.cabal
  ;;
  "repl")
    stack --nix ghci
  ;;
  "solve")
    stack --nix solver --update-config
  ;;
  "run")
    stack exec $project
  ;;
  *)
    echo "It's pitch dark here!"
  ;;
esac
