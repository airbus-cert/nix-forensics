#!/usr/bin/env bash

export NIXPKGS_ALLOW_INSECURE=1
export NIXPKGS_ALLOW_UNFREE=1

ARGS="."

if [ $# -ne 0 ]; then
  ARGS="$@"
fi

nix-shell ../shell.nix --run "nix-shell -p 'bats.withLibraries(p: [ p.bats-support p.bats-assert ])' --run \"bats $ARGS\""
