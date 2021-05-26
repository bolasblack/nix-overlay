{ stdenv, lib, fetchFromGitHub, makeWrapper, installShellFiles, bash, coreutils, curl, git }:

stdenv.mkDerivation rec {
  pname = "asdf-vm";
  version = "0.8.1";

  meta = with lib; {
    description = "Extendable version manager with support for Ruby, Node.js, Erlang & more";
    homepage = "https://asdf-vm.com/";
    license = licenses.mit;
    maintainers = [ "c4605" ];
    platforms = platforms.linux
             ++ platforms.darwin;
  };

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
    makeWrapper $out/share/asdf-vm/bin/asdf $out/bin/asdf --set ASDF_DIR $out/share/asdf-vm

    installShellCompletion --zsh --name _asdf completions/_asdf
    installShellCompletion --fish --name asdf.fish completions/asdf.fish
    installShellCompletion --bash --name asdf.bash completions/asdf.bash
  '';
}
