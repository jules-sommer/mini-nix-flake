{
  config,
  lib,
  nixpkgs,
  ...
}:
{
  options = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "jules";
      description = "Username for home-manager user.";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "jules@rcsrc.shop";
      description = "Email for user.";
    };
  };
  config = {
    assertions = [
      {
        assertion = builtins.isList nixpkgs && builtins.elem "master" nixpkgs;
        message = "Please specify a username.";
      }
    ];
    home = {
      username = lib.mkDefault config.username;
      packages = with nixpkgs.master.pkgs; [
        webcord
        github-desktop
        neofetch
        vscode-with-extensions
        bitwarden
        bitwarden-cli
        floorp
        wl-clipboard
        wl-clip-persist
        pavucontrol
      ];
      shellAliases = { };
    };

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      git = {
        enable = true;
        userName = config.username;
        userEmail = "jules@rcsrc.shop";
        extraConfig = {
          safe.directory = [ "/home/jules/000_dev/000_config" ];
        };
      };
    };

    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };

    home.stateVersion = "24.05";
  };
}
