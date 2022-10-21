{ lib, stdenv, fetchurl }:

let
  version = "0.6.22";

  binPath =
    if stdenv.isDarwin then
      fetchurl {
        url = "https://github.com/fnproject/cli/releases/download/${version}/fn_mac";
        sha256 = "1c9k8drazy2p9hwf3jmd1b847m4inw1klrivx6y1dhw8p9m4hwvs";
      }
    else
      fetchurl {
        url = "https://github.com/fnproject/cli/releases/download/${version}/fn_linux";
        sha256 = "0z5140jqm4p7rwyzr459jlw4aad53yrc4nzvsj26af5mmwib8h3a";
      };

in

stdenv.mkDerivation rec {
  pname = "fn-cli";
  inherit version;

  dontUnpack = true;

  installPhase = ''
runHook preInstall

mkdir -p $out/bin
cp ${binPath} $out/bin/fn
chmod u+x $out/bin/fn

runHook postInstall
  '';

  meta = with lib; {
    description = "Command-line tool for the fn project";
    homepage = "https://fnproject.io";
    license = licenses.asl20;
    maintainers = [ maintainers.c4605 ];
  };
}

