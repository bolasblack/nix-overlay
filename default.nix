# This overlay extends nixpkgs .
self: super:

let
  callPackage = super.lib.callPackageWith super;
  emacsOverlay = import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  }) self super;
in

emacsOverlay // {
    pre-commit = callPackage ./pkgs/pre-commit {};
    asdf-vm = callPackage ./pkgs/asdf-vm {};
    fn = callPackage ./pkgs/fn {};
}
