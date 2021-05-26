# c4605's nix overlay

## Included

* https://github.com/nix-community/emacs-overlay
* [pre-commit](https://pre-commit.com/)
* [fn](https://fnproject.io/)

## How to install 

### local

To install the overlay into `~/.config/nixpkgs/overlays` just run: 

    ./install.sh

now you can test your builds using:
    
    nix-shell -p <package>

### global

add the following to your `/etc/nixos/configuration.nix`:

    nixpkgs.config.packageOverrides = import /path/to/overlay.nix pkgs;

now you can install the packages from the overlay

    environment.systemPackages = with pkgs; [
        <package>
    ];


## How to check builds

    nix-build -E 'with import <nixpkgs> {} ; callPackage ./default.nix {}';

should create a `./result` folder which contains the result of the package.

# Links

* [mrVanDalo/nix-overlay](https://github.com/mrVanDalo/nix-overlay) (Where this README modified from)
* [A presentation about Overlays](https://www.youtube.com/watch?v=6bLF7zqB7EM&feature=youtu.be&t=39m50s) 
* [Package Binaries](https://nixos.wiki/wiki/Packaging_Binaries)
