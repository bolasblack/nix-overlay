{ stdenv, lib, fetchFromGitHub, makeWrapper, installShellFiles, bash, coreutils, curl, git, writeScript }:

let
  asdfReshimFile = writeScript "asdf-reshim" ''
#!/usr/bin/env bash

# asdf-vm create "shim" file like this:
#
#    exec $ASDF_DIR/bin/asdf exec "node" "$@"
#
# So we should reshim all installed versions every time, because $out
# always change

asdfDataDir="''${ASDF_DATA_DIR:-$HOME/.asdf}"

prevAsdfDirFilePath="$asdfDataDir/.nix-prev-asdf-dir-path"

if [ -r "$prevAsdfDirFilePath" ]; then
  prevAsdfDir="$(cat "$prevAsdfDirFilePath")"
else
  prevAsdfDir=""
fi

if [ "$prevAsdfDir" != "$ASDF_DIR" ]; then
  rm -rf "$asdfDataDir"/shims
  "$ASDF_DIR"/bin/asdf reshim
  echo "$ASDF_DIR" > "$prevAsdfDirFilePath"
fi
  '';
in stdenv.mkDerivation rec {
  pname = "asdf-vm";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "asdf-vm";
    repo = "asdf";
    rev = "v${version}";
    sha256 = "07lh5k1krzm7fbkv0jlwbzz5ycn2jg7s12dnqwmy82qqic0sl6fl";
  };

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  buildInputs = [
    bash
    curl
    git
  ];

  installPhase = ''
    mkdir -p $out/share/asdf-vm
    cp -r . $out/share/asdf-vm

    mkdir -p $out/etc/profile.d
    echo "source $out/share/asdf-vm/asdf.sh" > $out/etc/profile.d/asdf.sh

    mkdir -p $out/bin
    makeWrapper $out/share/asdf-vm/bin/asdf $out/bin/asdf \
      --set ASDF_DIR $out/share/asdf-vm \
      --run "${asdfReshimFile}"

    installShellCompletion --cmd asdf \
      --zsh completions/_asdf \
      --fish completions/asdf.fish \
      --bash completions/asdf.bash
  '';

  meta = with lib; {
    description = "Extendable version manager with support for Ruby, Node.js, Erlang & more";
    homepage = "https://asdf-vm.com/";
    license = licenses.mit;
    maintainers = [ "c4605" ];
    platforms = platforms.unix;
  };
}
