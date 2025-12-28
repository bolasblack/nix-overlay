{
  description = "c4605's overlay";

  outputs = { self, ... }@inputs: {
    overlay = import ./default.nix;
  };
}
