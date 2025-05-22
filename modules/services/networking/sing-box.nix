{ config, lib, ... }:

let
  cfg = config.services.sing-box;
in

{
  config = lib.mkIf cfg.enable {
  };
}
