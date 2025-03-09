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
    inputs@{ flake-parts, treefmt-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        modulePackages.ngbe = ./pkgs/ngbe;
      };
      systems = [ "x86_64-linux" ];
      imports = [
        treefmt-nix.flakeModule
      ];
      perSystem =
        { pkgs, ... }:
        {
          packages = {
            firewalld = pkgs.callPackage ./pkgs/firewalld { };
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
