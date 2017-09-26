#!/usr/bin/env bash
files=`ls -1 | grep .cabal$`
project=${files%.*}

cow() {
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
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack build
    elif [ -f default.nix ]
    then nix-shell --run "cabal build"
    else stack --nix build
    fi
    msg
  ;;
  "i")
    cow
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack install
    elif [ -f default.nix ]
    then nix-env -if.
    else stack --nix install
    fi
    msg
  ;;
  "d")
    $EDITOR $project.cabal
  ;;
  "r")
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack ghci $2
    elif [ -f default.nix ]
    then nix-shell --run "cabal repl"
    else stack --nix ghci
    fi
  ;;
  "s")
    $EDITOR stack.yaml
  ;;
  "ss")
    cow
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack solver --update-config
    else stack --nix solver --update-config
    fi
    msg
  ;;
  "t")
    cow
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack test
    elif [ -f default.nix ]
    then nix-shell --run "cabal test"
    else stack --nix test
    fi
  msg
  ;;
  "e")
    cow
    nixos-version 2> /dev/null
    if [ $? -ne 0 ]
    then stack install && stack exec ${@:2}
    elif [ -f default.nix ]
    then nix-shell --run "cabal run ${@:2}"
    else stack --nix install && stack --nix exec ${@:2}
    fi
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
