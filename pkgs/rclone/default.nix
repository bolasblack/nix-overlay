{ lib, stdenv, fetchurl, unzip }:

let
  name = "rclone";
  version = "1.68.1";

  zipPath =
    if stdenv.isDarwin then
      fetchurl {
        url = "https://github.com/rclone/rclone/releases/download/v${version}/${name}-v${version}-osx-arm64.zip";
        hash = "sha256-OOdYjhPJPucQ2qRLt5hDfsp/1YPU6Y0LzmxoX/EfQVI=";
      }
    else
      fetchurl {
        url = "https://github.com/rclone/rclone/releases/download/v${version}/${name}-v${version}-linux-amd64.zip";
        hash = "sha256-NPNHQ7GDFSPNLgr/dER7cX4tYv4bWY6RcDiZ4MBolWg=";
      };
in

stdenv.mkDerivation rec {
  pname = name;
  inherit version;

  nativeBuildInputs = [ unzip ];

  src = zipPath;

  dontConfigure = true;

  extraOutputsToInstall = [ "man" ];
  installPhase = ''
runHook preInstall

mkdir -p $out/man/man1
cp rclone.1 $out/man/man1/rclone.1

mkdir -p $out/bin 
cp rclone $out/bin/rclone
chmod u+x $out/bin/rclone
ln -s $out/bin/rclone $out/bin/mount.rclone
ln -s $out/bin/rclone $out/bin/rclonefs

runHook postInstall
  '';

  meta = with lib; {
    description = "Command line program to sync files and directories to and from major cloud storage";
    homepage = "https://rclone.org";
    changelog = "https://github.com/rclone/rclone/blob/v${version}/docs/content/changelog.md";
    license = licenses.mit;
    mainProgram = "rclone";
    maintainers = with maintainers; [ c4605 ];
  };
}