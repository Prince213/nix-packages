let
  lockFile = builtins.fromJSON (builtins.readFile ./flake.lock);
  flake-compat-node = lockFile.nodes.${lockFile.nodes.root.inputs.flake-compat};
  flake-compat = builtins.fetchTarball {
    url =
      flake-compat-node.locked.url
        or "https://github.com/NixOS/flake-compat/archive/${flake-compat-node.locked.rev}.tar.gz";
    sha256 = flake-compat-node.locked.narHash;
  };

  flake = (
    import flake-compat {
      src = ./.;
    }
  );
in
flake.defaultNix
