#!/usr/bin/env bash
files=`ls -1 | grep .cabal$`
project=${files%.*}

cow() {
  #cowsay "Starting"
  figlet '3... 2... 1... Start!'
}

msg() {
  if [ $? -eq 0 ]
  then echo -e "\033[1;32mSuccess\033[0m"
  else echo -e "\033[1;31mFail\033[0m"
  fi
}

case $1 in
  "q")
    echo $project
  ;;
  "")
    cow
    stack --nix build
    msg
  ;;
  "i")
    cow
    stack --nix install
    msg
  ;;
  "d")
    vim $project.cabal
  ;;
  "r")
    stack --nix ghci $2
  ;;
  "ni")
    cow
    nix-env -if .
    msg
  ;;
  "n")
    cow
    cabal2nix --shell . > default.nix
    msg
  ;;
  "s")
    vim stack.yaml
  ;;
  "ss")
    cow
    stack --nix solver --update-config
    msg
  ;;
  "t")
    cow
    stack --nix test
    msg
  ;;
  "ee")
    cow
    stack --nix install &&
    stack --nix exec $project
    msg
  ;;
  "e")
    cow
    stack --nix exec $2
    msg
  ;;
  *)
    echo "It's pitch dark here!"
  ;;
esac
