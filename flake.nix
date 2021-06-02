{
  description = "c4605's overlay";

  outputs = { self, nixpkgs, ... }@inputs: {
    overlay = import ./default.nix;
  };
}
