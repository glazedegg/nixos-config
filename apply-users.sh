#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.tigerwarrior345.activationPackage
./result/activate
popd
