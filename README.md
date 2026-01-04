# c4605's nix overlay

## Included

- [cargo-binstall](https://github.com/cargo-bins/cargo-binstall)
- [asdf-vm](https://asdf-vm.com/)
- [fn-cli](https://fnproject.io)
- [pre-commit](https://pre-commit.com/)
- [graalvm-ce](https://www.graalvm.org/)
- [babashka](https://github.com/babashka/babashka)
- [rclone](https://rclone.org)
- [tmux](https://tmux.github.io/)
- [blind-watermark](https://github.com/guofei9987/blind_watermark)

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

## Development tips

### How to check builds

```bash
nix-build -E 'with import <nixpkgs> {} ; callPackage ./default.nix {}';
```

should create a `./result` folder which contains the result of the package.

### How to get a sha256 hash

```bash
nix-shell -p nix-prefetch --run "nix-prefetch fetchurl --urls --expr '[ <file download url> ]'"
```

### How to enter the environment

```bash
nix develop
```

This will enter a shell environment with all packages defined in this overlay.

# Links

- [mrVanDalo/nix-overlay](https://github.com/mrVanDalo/nix-overlay) (Where this README modified from)
- [A presentation about Overlays](https://www.youtube.com/watch?v=6bLF7zqB7EM&feature=youtu.be&t=39m50s)
- [Package Binaries](https://nixos.wiki/wiki/Packaging_Binaries)
