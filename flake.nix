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
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      flake = {
        nixosModules.default = ./modules;
        modulePackages.ngbe = ./pkgs/ngbe;
        overlays.default = self: super: {
          kodama = super.callPackage ./pkgs/kodama { };
          linglong = super.callPackage ./pkgs/linglong { };
          mccgdi = super.callPackage ./pkgs/mccgdi { };
          nodebb = super.callPackage ./pkgs/nodebb { };
          sing-box-app = super.callPackage ./pkgs/sing-box-app { };
          sing-box-app-beta = super.callPackage ./pkgs/sing-box-app-beta { };
          sing-box-beta = super.callPackage ./pkgs/sing-box-beta { };
          vips_8_14_5 = super.callPackage ./pkgs/vips_8_14_5 { };
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
              kodama
              linglong
              mccgdi
              nodebb
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
