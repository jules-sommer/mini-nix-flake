{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) enabled;

  cfg = config.xeta.graphics.electron_support;
in
{
  options.xeta.graphics.electron_support = {
    enable = mkEnableOption "Enable electron support";
  };

  config = mkIf cfg.enable {
    snowfallorg.users.xeta.home.config = {
      xdg.configFile."electron-flags.conf".source = ./electron-flags.conf;
    };
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
