#!/usr/bin/env bash
files=`ls -1 | grep .cabal$`
project=${files%.*}

cow() {
  #cowsay "Starting"
  echo -e "\033[1;33m$(figlet '3... 2... 1... Start!')\033[0m"
}

msg() {
  if [ $? -eq 0 ]
  then echo -e "\033[1;32m$(figlet 'Success!')\033[0m"
  else echo -e "\033[1;31m$(figlet 'Failure...')\033[0m"
  fi
}

case $1 in
  "q")
    echo $project
  ;;
  "")
    cow
    #stack --nix build
    nix-shell --run "cabal build"
    msg
  ;;
  "i")
    cow
    #stack --nix install
    nix-env -if.
    msg
  ;;
  "d")
    vim $project.cabal
  ;;
  "r")
    #stack --nix ghci $2
    nix-shell --run "cabal repl"
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
    #stack --nix test
    nix-shell --run "cabal test"
  msg
  ;;
  "ee")
    cow
    #stack --nix install &&
    stack --nix exec $project
    msg
  ;;
  "e")
    cow
    #stack --nix exec $2
    nix-shell --run "cabal run ${@:2}"
    msg
  ;;
  "c")
    if [ -f "auto.nix" ]
    then cabal2nix . > auto.nix
    else cabal2nix --shell . > default.nix
    fi
  ;;
  *)
    echo "It's pitch dark here!"
  ;;
esac
