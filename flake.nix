{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
      flake = {
        modulePackages.ngbe = ./pkgs/ngbe;

        overlays = {
          default = self: super: {
            firewalld = super.callPackage ./pkgs/firewalld { };
          };
          firewalld = self: super: {
            firewalld = super.callPackage ./pkgs/firewalld { };
          };
        };
      };
      systems = [ "x86_64-linux" ];
      imports = [
        treefmt-nix.flakeModule
      ];
      perSystem =
        { system, pkgs, ... }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };

          packages = {
            inherit (pkgs) firewalld;
          };
          treefmt = {
            projectRootFile = "flake.nix";
            settings.global.excludes = [
              "LICENSE"
              "README.md"
            ];
            programs.nixfmt.enable = true;
          };
        };
    };
}
