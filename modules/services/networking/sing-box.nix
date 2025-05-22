{ config, lib, ... }:

let
  cfg = config.services.sing-box;
in

{
  options.services.sing-box = {
    user = lib.mkOption {
      type = lib.types.str;
      default = "sing-box";
      description = ''
        User that sing-box runs as.
      '';
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "sing-box";
      description = ''
        Group that sing-box runs as.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.sing-box = {
      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
      };
    };

    users = {
      users.${cfg.user} = {
        isSystemUser = true;
        inherit (cfg) group;
      };
      groups.${cfg.group} = { };
    };
  };
}
