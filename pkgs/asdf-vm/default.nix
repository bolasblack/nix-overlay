{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "asdf-vm";
  version = "0.7.8";

  name = "${pname}-${version}";

  meta = with stdenv.lib; {
    description = "Extendable version manager with support for Ruby, Node.js, Erlang & more";
    homepage = https://asdf-vm.com/;
    license = licenses.mit;
    maintainers = [ "c4605" ];
    platforms = platforms.linux
             ++ platforms.darwin;
  };

  src = fetchFromGitHub {
    owner = "asdf-vm";
    repo = "asdf";
    rev = "v${version}";
    sha256 = "0cr9mnj9fy5riwn6wf4qmdqnjm8n3yxya5a4s4v5qq2wsmpclqc1";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    installShellFiles
  ];

  buildInputs = with pkgs; [
    bash
    coreutils
    curl
    git
  ];

  installPhase = ''
    mkdir -p $out/asdf-vm
    cp -r . $out/asdf-vm

    mkdir -p $out/bin
    makeWrapper $out/asdf-vm/bin/asdf $out/bin/asdf --set ASDF_DIR $out/asdf-vm

    installShellCompletion --zsh --name _asdf completions/_asdf
    installShellCompletion --fish --name asdf.fish completions/asdf.fish
    installShellCompletion --bash --name asdf.bash completions/asdf.bash
  '';
}
