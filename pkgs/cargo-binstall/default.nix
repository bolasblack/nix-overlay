{ lib, stdenv, fetchurl, fetchzip, unzip }:

let
  version = "0.16.0";

  downloadPrefix = "https://github.com/cargo-bins/cargo-binstall/releases/download/v${version}";

  binPath =
    if stdenv.isDarwin then
      if stdenv.isAarch64 then
        fetchurl {
          url = "${downloadPrefix}/cargo-binstall-aarch64-apple-darwin.zip";
          sha256 = "0bv67ksfzscddk63r7x3dhkq0q83ira2vdkklfsn57w474i3s13q";
        }
      else
        fetchurl {
          url = "${downloadPrefix}/cargo-binstall-x86_64-apple-darwin.zip";
          sha256 = "10wlxljlwnn3kj3zfjjrviqd27nwjndxcbxjz33ncc8d75vxfpj9";
        }
    else
      if stdenv.isx86_64 then
        fetchurl {
          url = "${downloadPrefix}/cargo-binstall-x86_64-unknown-linux-gnu.tgz";
          sha256 = "13qi9izn5m4hk56qnq6j79ymvfcwlzwwsaq1bgwy5m5fcx27f8rb";
        }
      else if stdenv.isAarch64 then
        fetchurl {
          url = "${downloadPrefix}/cargo-binstall-aarch64-unknown-linux-gnu.tgz";
          sha256 = "1hipm2c6rshgcar2gfwzv42dxxl4d1phfjhpw1rsk4x6448hx71y";
        }
      else
        fetchurl {
          url = "${downloadPrefix}/ cargo-binstall-armv7-unknown-linux-gnueabihf.tgz";
          sha256 = "13qi9izn5m4hk56qnq6j79ymvfcwlzwwsaq1bgwy5m5fcx27f8rb";
        };

in

stdenv.mkDerivation rec {
  pname = "cargo-binstall";
  inherit version;

  nativeBuildInputs = [
    unzip
  ];

  src = binPath;

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  # https://github.com/NixOS/nixpkgs/blob/30f6859a3ab126d943c23f92d2b158fe850f78f9/pkgs/tools/misc/ent/default.nix
  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
runHook preInstall

mkdir -p $out/bin
cp "$sourceRoot/cargo-binstall" $out/bin/

runHook postInstall
  ''; 

  meta = with lib; {
    description = "Binary installation for rust projects";
    homepage = "https://github.com/cargo-bins/cargo-binstall";
    maintainers = [ maintainers.c4605 ];
    platforms = [
      "x86_64-darwin" "aarch64-darwin"
      "aarch64-linux" "armv7a-linux" "x86_64-linux"
    ];
  };
}
