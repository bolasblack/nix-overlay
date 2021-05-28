# This overlay extends nixpkgs .
final: prev:

let

  callPackage = prev.lib.callPackageWith prev;

in

{
    pre-commit = callPackage ./pkgs/pre-commit {};
    asdf-vm = callPackage ./pkgs/asdf-vm {};
    fn = callPackage ./pkgs/fn {};
    graalvm11-ce = callPackage ./pkgs/graalvm {};
    babashka = callPackage ./pkgs/babashka {};
}
