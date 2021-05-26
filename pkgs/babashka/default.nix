{ lib, stdenv, fetchurl }:

let
  platform = if stdenv.isDarwin then "macos-amd64" else "linux-amd64";
in

stdenv.mkDerivation rec {
  pname = "babashka";
  version = "0.4.3";

  src = fetchurl {
    url = "https://github.com/babashka/babashka/releases/download/v${version}/${pname}-${version}-${platform}.tar.gz";
    sha256 = "10lmgvpw2wmxbwpkvawdr1x1v69xh3hjgbjjpjqivzy7vpvz16ls";
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp bb $out/bin/bb
    runHook postInstall
  '';

  installCheckPhase = ''
    $out/bin/bb --version | grep '${version}'
    $out/bin/bb '(+ 1 2)' | grep '3'
    $out/bin/bb '(vec (dedupe *input*))' <<< '[1 1 1 1 2]' | grep '[1 2]'
  '';

  meta = with lib; {
    description = "A Clojure babushka for the grey areas of Bash";
    longDescription = ''
      The main idea behind babashka is to leverage Clojure in places where you
      would be using bash otherwise.
      As one user described it:
          I’m quite at home in Bash most of the time, but there’s a substantial
          grey area of things that are too complicated to be simple in bash, but
          too simple to be worth writing a clj/s script for. Babashka really
          seems to hit the sweet spot for those cases.
    Goals:
    - Low latency Clojure scripting alternative to JVM Clojure.
    - Easy installation: grab the self-contained binary and run. No JVM needed.
    - Familiarity and portability:
      - Scripts should be compatible with JVM Clojure as much as possible
      - Scripts should be platform-independent as much as possible. Babashka
        offers support for linux, macOS and Windows.
    - Allow interop with commonly used classes like java.io.File and System
    - Multi-threading support (pmap, future, core.async)
    - Batteries included (tools.cli, cheshire, ...)
    - Library support via popular tools like the clojure CLI
    '';
    homepage = "https://github.com/borkdude/babashka";
    license = licenses.epl10;
    platforms = platforms.linux
             ++ platforms.darwin;
    maintainers = with maintainers; [ "c4605" ];
  };
}
