{
  lib,
  pkgs,
  config,
  inputs,
  system,
  ...
}:
let
  inherit (lib) types mkEnableOption mkIf;
  inherit (lib.xeta) getPackage disabled;
  cfg = config.xeta.desktop.hyprland;
in
{
  options.xeta.desktop.hyprland = {
    enable = mkEnableOption "Enable Hyprland.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      meson
      wayland-protocols
      wayland-utils
      wlroots
    ];

    services = {
      displayManager = {
        sddm = disabled;
      };
      xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 30;
        autorun = true;

        displayManager = {
          lightdm = disabled;
          gdm = disabled;
        };

        desktopManager = {
          gnome = disabled;
          xterm = disabled;
          xfce = disabled;
          plasma5 = disabled;
        };
      };
    };

    programs.hyprland = {
      enable = true;
      package = getPackage {
        inherit system;
        input = inputs.hyprland;
        name = "hyprland";
      };
      xwayland.enable = true;
    };
  };
}
