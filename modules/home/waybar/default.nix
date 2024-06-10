{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkIf types mkEnableOption;
  inherit (lib.xeta) mkOpt;

  cfg = config.xeta.desktop.waybar;
  home = "/home/jules";
  dotfiles = home + "/070_dotfiles/010_nix-managed/";
  theme = lib.xeta.getThemeBase24 (config.xeta.desktop.hyprland.theme);

  assertions = [
    {
      assertion = theme.colors != null && builtins.typeOf theme.colors == "attrs";
      message = "theme.colors is null or not of type attrs";
    }
    {
      assertion = builtins.typeOf dotfiles == "path";
      message = "dotfiles is not of type path";
    }
    {
      assertion = builtins.pathExists dotfiles;
      message = "dotfiles does not exist";
    }
  ];
in
{
  options.xeta.desktop.waybar = {
    enable = mkEnableOption "Enable waybar";
    package = mkOpt (types.nullOr types.package) pkgs.waybar;
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = lib.lists.elem "hyprland/window" (
          (builtins.elemAt config.programs.waybar.settings 0).modules-left
        );
        message = "waybar.package must be set";
      }
    ];

    home.packages = [ pkgs.font-awesome ];
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 20;
          margin-top = 6;
          margin-left = 8;
          margin-right = 8;
          spacing = 8;
          reload-style-on-change = true;
          include = [ "~/.config/waybar/extra.json" ];

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          modules-center = [ "clock" ];

          modules-right = [
            "tray"
            "idle_inhibitor"
            "custom/notification"
            "battery"
            "pulseaudio"
            "cpu"
            "memory"
            "network"
            "custom/quit"
          ];

          "hyprland/workspaces" = {
            # format = "{icon}{name}";
            format = "<sub>{icon}</sub>\n{windows}";
            on-click = "activate";
            format-icons = {
              "active" = "";
              "default" = "";
            };
            sort-by-number = true;
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          clock = {
            format-alt = "󰃭 {:%a, %d %b   %I:%M %p}";
            format = "  {:%I:%M %p}";
            tooltip-format = ''
              <big>{:%I:%M %p}</big>
              <tt><small>{calendar}</small></tt>
            '';
            tooltip = true;
          };

          "hyprland/window" = {
            max-length = 75;
            separate-outputs = true;
          };

          memory = {
            interval = 5;
            format = "  {}%";
            tooltip = true;
          };

          cpu = {
            interval = 5;
            format = "  {usage:2}%";
            tooltip = true;
          };

          disk = {
            format = "󰋊 {free} / {total}";
            tooltip = true;
            on-click = "hyprctl dispatch 'exec alacritty -e broot -hipsw'";
          };

          network = {
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-ethernet = ": {bandwidthDownOctets}";
            format-wifi = "{icon} {signalStrength}%";
            format-disconnected = "󰤮";
            tooltip = false;
            on-click = "nm-applet";
          };

          tray = {
            spacing = 20;
          };

          pulseaudio = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };

          "custom/startmenu" = {
            tooltip = false;
            format = "󱄅";
            # exec = "rofi -show drun";
            on-click = "rofi -show drun";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "  ";
              deactivated = "  ";
            };
            tooltip = "true";
            tooltip-format = "Inhibit idle? {state}";
          };

          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t";
            escape = true;
          };

          privacy = {
            icon-spacing = 4;
            icon-size = 18;
            transition-duration = 250;
            modules = [
              {
                "type" = "screenshare";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              }
              {
                "type" = "audio-out";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              }
              {
                "type" = "audio-in";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              }
            ];
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            on-click = "";
            tooltip = false;
          };

          "custom/quit" = {
            format = "  ";
            on-click = "";
            tooltip = true;
          };
        }
      ];

      style = ./waybar.css;
    };
  };
}
