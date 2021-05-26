{ pkgs ? import <nixpkgs> {} }:

with pkgs;

buildGoModule rec {
  pname = "fn";
  version = "0.5.99";

  name = "${pname}-${version}";

  meta = with stdenv.lib; {
    description = "Command-line tool for the fn project";
    homepage = https://fnproject.io;
    license = licenses.asl20;
    maintainers = [ "c4605" ];
    platforms = platforms.windows
             ++ platforms.linux
             ++ platforms.darwin;
  };

  src = fetchFromGitHub {
    owner = "fnproject";
    repo = "cli";
    rev = "${version}";
    sha256 = "0wkxlr6dhrf802fv4qk4b4l2c6hdnyllb8jm03xjzcif3z78m7yk";
  };

  vendorSha256 = null;

  excludedPackages = ["test"];

  buildInputs = with pkgs; [
    docker
  ];

  postInstall = ''
    mv $out/bin/cli $out/bin/fn
  '';
}
