{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
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
        "aarch64-linux"
        "x86_64-linux"
      ];
      flake = {
        nixosModules.default = ./modules;
        modulePackages.ngbe = ./pkgs/ngbe;
        overlays.default = self: super: {
          cursor = super.callPackage ./pkgs/cursor { };
          mccgdi = super.callPackage ./pkgs/mccgdi { };
          sing-box-beta = super.callPackage ./pkgs/sing-box-beta { };
          wechat = super.callPackage ./pkgs/wechat { };
          wubi98-fonts = super.callPackage ./pkgs/wubi98-fonts { };
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
              cursor
              mccgdi
              sing-box-beta
              wechat
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
