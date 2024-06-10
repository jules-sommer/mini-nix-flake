{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.xeta) disabled enabled;
  cfg = config.xeta.programs.distrobox;
in
{
  options.xeta.programs.distrobox = {
    enable = mkEnableOption "Enable distrobox";
  };

  config = mkIf cfg.enable {

    services = {
      qemuGuest = enabled;
      spice-vdagentd = enabled;
      spice-webdavd = enabled;
    };

    environment.systemPackages = with pkgs; [
      distrobox
      boxbuddy
    ];

    virtualisation = {
      # currently docker is disabled because
      # we are using podman with dockerCompat
      # which is a functional replacement
      docker = disabled;
      libvirtd = enabled;

      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
        guest = enabled;
      };

      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
