{ pkgs }:

with pkgs;
with pkgs.python38Packages;

pre-commit.overridePythonAttrs(oldAttrs: rec {
  version = "2.2.0";
  
  src = fetchPypi {
    inherit version;
    pname = "pre_commit";
    sha256 = "1qb937lda4pam4q5l86i9bvdb9419vgsw8s7ak2lcysaw2y13an0";
  };

  propagatedBuildInputs = [
    cfgv
    identify
    nodeenv
    pyyaml
    toml
    virtualenv
  ] ++ lib.optional (pythonOlder "3.8") importlib-metadata
    ++ lib.optional (pythonOlder "3.7") importlib-resources
    ++ lib.optional (pythonOlder "3.2") futures;

  patches = [
    ./hook-tmpl-use-the-hardcoded-path-to-pre-commit.patch
  ];
})
