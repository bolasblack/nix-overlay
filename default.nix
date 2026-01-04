final: prev:

let
  callPackage = prev.lib.callPackageWith prev;
in
{
  cargo-binstall = prev.cargo-binstall;
  asdf-vm-c4 = prev.asdf-vm;
  fn-cli-c4 = prev.fn-cli;
  pre-commit-c4 = prev.pre-commit;
  graalvm-ce-c4 = prev.graalvmPackages.graalvm-ce;
  babashka-c4 = prev.babashka;
  rclone-c4 = prev.rclone;
  tmux-c4 = callPackage ./pkgs/tmux { };
  blind-watermark = callPackage ./pkgs/blind-watermark { };
}
