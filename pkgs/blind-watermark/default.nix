{ pkgs }:

pkgs.python3Packages.buildPythonPackage rec {
  pname = "blind-watermark";
  version = "0.2.1";
  format = "setuptools";

  src = pkgs.fetchFromGitHub {
    owner = "guofei9987";
    repo = "blind_watermark";
    rev = version;
    sha256 = "046vmbd1bynl2cvf9b9lqqz787b9ni06lswlxx7na1a5a7zcnny3";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    numpy
    opencv4
    pywavelets
  ];

  # Tests require network or specific setup sometimes, disabling by default if unsure,
  # but user had pytest commented out.
  # doCheck = false;

  meta = with pkgs.lib; {
    description = "Blind Watermark in Python";
    homepage = "https://github.com/guofei9987/blind_watermark";
    license = licenses.mit;
  };
}
