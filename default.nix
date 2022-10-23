final: prev:

let
  callPackage = prev.lib.callPackageWith prev;
in {
  cargo-binstall = callPackage ./pkgs/cargo-binstall {};
  asdf-vm-c4 = callPackage ./pkgs/asdf-vm {};
  fn-cli-c4 = callPackage ./pkgs/fn {};
  pre-commit-c4 = callPackage ./pkgs/pre-commit {};
  graalvm11-ce-c4 = callPackage ./pkgs/graalvm {};
  babashka-c4 = callPackage ./pkgs/babashka {};
}
