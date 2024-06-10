{ lib, pkgs, ... }:
let
  inherit (lib) enabled disabled;
in
{
  imports = [ ./hardware.nix ];

  config = {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          consoleMode = "auto";
          editor = false;
          netbootxyz = enabled;
          memtest86 = enabled;
        };
        efi.canTouchEfiVariables = true;
      };
      plymouth = {
        enable = true;
        font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      };
    };

    users.defaultUserShell = pkgs.nushell;
    environment.shells = with pkgs; [
      nushell
      zsh
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
    services.printing.enable = true;
    environment.systemPackages = with pkgs; [ webcord-vencord ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession = enabled;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    };

    security.pam.services.tuigreet = {
      text = ''
        auth include login
      '';
    };

    services.openssh.enable = true;
    networking.firewall.enable = false;
    system.stateVersion = "24.05";
  };
}
