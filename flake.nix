{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "https://git.lix.systems/lix-project/flake-compat/archive/main.tar.gz";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      flake = {
        nixosModules.default = ./modules;
        modulePackages.ngbe = ./pkgs/ngbe;
        overlays.default =
          _: super:
          super.lib.packagesFromDirectoryRecursive {
            inherit (super) callPackage;
            directory = ./pkgs;
          };
      };
      perSystem =
        { system, pkgs, ... }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ self.overlays.default ];
          };

          packages = {
            inherit (pkgs)
              claude-code-router
              feishu-darwin
              kodama
              mccgdi
              qqmusic-darwin
              sing-box-app
              sing-box-app-beta
              sing-box-beta
              vips_8_14_5
              wubi98-fonts
              ;
          };

          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
          };
        };
    };
}
