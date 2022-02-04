{ pkgs }:

with pkgs;

pre-commit.overridePythonAttrs(oldAttrs: rec {
  version = "2.13.0";
  
  src = fetchPypi {
    inherit version;
    pname = "pre_commit";
    sha256 = "0y53hp1vwrx78a3ikxqh2d848cgcajbb4vp8m25ndp4k0v374jbn";
  };
})
