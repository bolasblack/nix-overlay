{
  description = "c4605's overlay";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }@inputs:
    {
      overlay = import ./default.nix;
    }
    # nix develop
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues (self.overlay pkgs pkgs);
          shellHook = ''
            if command -v zsh > /dev/null; then
              exec zsh
            fi
          '';
        };
      }
    );
}
