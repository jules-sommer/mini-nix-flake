{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) enabled;

  cfg = config.xeta.programs.dconf;
  username = config.xeta.system.user.username;
in
{
  options.xeta.programs.dconf = {
    enable = mkEnableOption "Enable dconf settings";
  };

  config = mkIf cfg.enable {
    programs = {
      xfconf = enabled;
      dconf = enabled;
    };
    snowfallorg.users.${username}.home.config = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    };
  };
}
