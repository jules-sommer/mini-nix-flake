{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  terminal = config.xeta.tty.default;
  theme = lib.xeta.getThemeBase24 (config.xeta.desktop.hyprland.theme);
in
{
  programs.rofi = {
    enable = true;
    cycle = true;
    terminal = builtins.toString (lib.getBin terminal);
    font = "JetBrains Mono Nerd Font";
    package = pkgs.rofi-wayland;
    theme = with theme.colors; {
      "*" = {
        base00 = mkLiteral base00;
        base01 = mkLiteral base01;
        base02 = mkLiteral base02;
        base03 = mkLiteral base03;
        base04 = mkLiteral base04;
        base05 = mkLiteral base05;
        base06 = mkLiteral base06;
        base07 = mkLiteral base07;
        base08 = mkLiteral base08;
        base09 = mkLiteral base09;
        base0A = mkLiteral base0A;
        base0AA = mkLiteral base0AA;
        base0B = mkLiteral base0B;
        base0C = mkLiteral base0C;
        base0CA = mkLiteral base0CA;
        base0D = mkLiteral base0D;
        base0DA = mkLiteral base0DA;
        base0E = mkLiteral base0E;
        base0F = mkLiteral base0F;
        base0FA = mkLiteral base0FA;
        base10 = mkLiteral base10;
        base11 = mkLiteral base11;
        base12 = mkLiteral base12;
        base12A = mkLiteral base12A;
        base13 = mkLiteral base13;
        base13A = mkLiteral base13A;
        base14 = mkLiteral base14;
        base15 = mkLiteral base15;
        base16 = mkLiteral base16;
        base17 = mkLiteral base17;
        base18 = mkLiteral base18;
        base19 = mkLiteral base19;
        base19A = mkLiteral base19A;
        base1A = mkLiteral base1A;
        base1B = mkLiteral base1B;

        background-color = mkLiteral "transparent";
        red = mkLiteral "${base0F}";
        orange = mkLiteral "${base10}";
        yellow = mkLiteral "${base12}";
        aqua = mkLiteral "${base0A}";
        purple = mkLiteral "${base16}";
        reddark = mkLiteral "${base0F}";
        yellowdark = mkLiteral "${base11}";
        foreground = mkLiteral "${base05}";
        highlight = mkLiteral "underline bold ${base06}";
        transparent = mkLiteral "rgba(0, 0, 0, 0.1)";
      };

      window = {
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        border-radius = mkLiteral "20px";
        height = mkLiteral "560px";
        width = mkLiteral "600px";
        background-color = mkLiteral "@transparent";
        spacing = mkLiteral "0";
        children = map mkLiteral [ "mainbox" ];
        orientation = mkLiteral "horizontal";
      };

      mainbox = {
        spacing = mkLiteral "0";
        children = map mkLiteral [
          "inputbar"
          "message"
          "listview"
        ];
      };

      message = {
        padding = mkLiteral "10px";
        border = mkLiteral "0px 2px 2px 2px";
        border-color = mkLiteral "@base00";
        background-color = mkLiteral "@transparent";
      };

      inputbar = {
        color = mkLiteral "@base06";
        padding = mkLiteral "14px";
        background-color = mkLiteral "@transparent";
        border-color = mkLiteral "@transparent";
        border = mkLiteral "1px";
        border-radius = mkLiteral "20px 20px 0px 0px";
      };

      entry = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      prompt = {
        margin = mkLiteral "0px 1em 0em 0em";
      };

      listview = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "5px";
        border = mkLiteral "2px 2px 2px 2px";
        border-color = mkLiteral "@transparent";
        background-color = mkLiteral "@transparent";
        dynamic = mkLiteral "false";
      };

      element = {
        padding = mkLiteral "5px";
        vertical-align = mkLiteral "0.5";
        border-radius = mkLiteral "5px";
        color = mkLiteral "@foreground";
        text-color = mkLiteral "@base06";
        background-color = mkLiteral "@transparent";
      };

      "element normal active" = {
        background-color = mkLiteral "@yellow";
      };

      "element normal urgent" = {
        background-color = mkLiteral "@reddark";
      };

      "element selected normal" = {
        background-color = mkLiteral "@base07";
        text-color = mkLiteral "@base00";
      };

      "element selected active" = {
        background-color = mkLiteral "@yellowdark";
      };

      "element selected urgent" = {
        background-color = mkLiteral "@red";
      };

      "element alternate normal" = {
        background-color = mkLiteral "@transparent";
      };

      "element-text" = {
        size = mkLiteral "3ch";
        margin = mkLiteral "0 10 0 0";
        vertical-align = mkLiteral "0.5";
        text-color = mkLiteral "@base06";
      };

      "element-icon" = {
        size = mkLiteral "3ch";
        margin = mkLiteral "0 10 0 0";
        vertical-align = mkLiteral "0.5";
        text-color = mkLiteral "@base06";
      };

      button = {
        padding = mkLiteral "6px";
        color = mkLiteral "@foreground";
        horizontal-align = mkLiteral "0.5";
        border = mkLiteral "2px 0px 2px 2px";
        border-radius = mkLiteral "5px";
        border-color = mkLiteral "@foreground";
      };

      "button selected normal" = {
        border = mkLiteral "2px 0px 2px 2px";
        border-color = mkLiteral "@foreground";
      };

      configuration = {
        show-icons = true;
        icon-theme = "Papirus";
        location = 0;
        font = "JetBrains Mono Nerd Font";
        display-drun = "=>> ";
        modi = "run,drun,window,filebrowser";
        lines = 8;
        columns = 2;
      };
    };

    # theme = {
    #   "*" = {
    #     bg-col = mkLiteral "#1e1e2e";
    #     bg-col-light = mkLiteral "#1e1e2e";
    #     border-col = mkLiteral "#1e1e2e";
    #     selected-col = mkLiteral "#1e1e2e";
    #     blue = mkLiteral "#89b4fa";
    #     fg-col = mkLiteral "#cdd6f4";
    #     fg-col2 = mkLiteral "#f38ba8";
    #     grey = mkLiteral "#6c7086";
    #     width = mkLiteral "600";
    #     bg = mkLiteral "rgba(130, 32, 104, 0.35)";
    #     "background-color" = mkLiteral "@bg";
    #   };
    #
    #   configuration = {
    #     "show-icons" = true;
    #     "icon-theme" = "Papirus";
    #     location = 0;
    #     font = "Jetbrains Mono Nerd Font";
    #     "display-drun" = "=>> ";
    #     modi = "run,drun";
    #     lines = 8;
    #     columns = 2;
    #   };
    #
    #   window = {
    #     width = mkLiteral "35%";
    #     transparency = "real";
    #     orientation = "vertical";
    #     "border-color" = mkLiteral "#${palette.base0B}";
    #     "border-radius" = 10;
    #   };
    #
    #   mainbox = {
    #     children = map mkLiteral [
    #       "inputbar"
    #       "listview"
    #     ];
    #   };
    #
    #   element = {
    #     padding = mkLiteral "10";
    #     font-size = mkLiteral "16px";
    #     "text-color" = mkLiteral "#${palette.base05}";
    #     "border-radius" = 5;
    #   };
    #
    #   "element selected" = {
    #     "text-color" = mkLiteral "#${palette.base01}";
    #     "background-color" = mkLiteral "#${palette.base0B}";
    #   };
    #
    #   "element-text" = {
    #     "background-color" = mkLiteral "inherit";
    #     "text-color" = mkLiteral "inherit";
    #   };
    #
    #   "element-icon" = {
    #     size = mkLiteral "16 px";
    #     "background-color" = mkLiteral "inherit";
    #     padding = mkLiteral "0 6 0 0";
    #     alignment = "vertical";
    #   };
    #
    #   listview = {
    #     columns = 2;
    #     lines = 9;
    #     padding = mkLiteral "8 0";
    #     "fixed-height" = true;
    #     "fixed-columns" = true;
    #     "fixed-lines" = true;
    #     border = mkLiteral "0 10 6 10";
    #   };
    #
    #   entry = {
    #     "text-color" = mkLiteral "#${palette.base05}";
    #     padding = mkLiteral "10 10 0 0";
    #     margin = mkLiteral "0 -2 0 0";
    #   };
    #
    #   inputbar = {
    #     background-color = mkLiteral "rgba(212, 36, 108, 0.7)";
    #     border-radius = 10;
    #     padding = mkLiteral "180 0 0";
    #     margin = mkLiteral "0 0 0 0";
    #   };
    #
    #   prompt = {
    #     "text-color" = mkLiteral "#${palette.base0D}";
    #     padding = mkLiteral "10 6 0 10";
    #     margin = mkLiteral "0 -2 0 0";
    #   };
    # };
    plugins = with pkgs; [
      rofimoji
      rofi-vpn
      rofi-rbw-wayland
      rofi-file-browser
      rofi-power-menu
      rofi-pulse-select
      rofi-systemd
      rofi-screenshot
      rofi-calc
    ];
  };

  # home.file.${"${config.xeta.dotfiles}/rofi/config.rasi"}.text = ''
  #   @theme "/dev/null"

  #   * {
  #       bg: rgba(0, 0, 0, 0.5);
  #       background-color: @bg;
  #   }

  #   configuration {
  #     show-icons: true;
  #     icon-theme: "Papirus";
  #     location: 0;
  #     font: "JetBrains Mono";
  #     display-drun: "->";
  #   }

  #   window { 
  #     width: 35%;
  #     transparency: "real";
  #     orientation: vertical;
  #     border-color: #${palette.base0B};
  #     border-radius: 10px;
  #   }

  #   mainbox {
  #     children: [inputbar, listview];
  #   }

  #   // ELEMENT
  #   // -----------------------------------

  #   element {
  #     padding: 4 12;
  #     text-color: #${palette.base05};
  #       border-radius: 5px;
  #   }

  #   element selected {
  #     text-color: #${palette.base01};
  #     background-color: #${palette.base0B};
  #   }

  #   element-text {
  #     background-color: inherit;
  #     text-color: inherit;
  #   }

  #   element-icon {
  #     size: 16 px;
  #     background-color: inherit;
  #     padding: 0 6 0 0;
  #     alignment: vertical;
  #   }

  #   listview {
  #     columns: 2;
  #     lines: 9;
  #     padding: 8 0;
  #     fixed-height: true;
  #     fixed-columns: true;
  #     fixed-lines: true;
  #     border: 0 10 6 10;
  #   }

  #   // INPUT BAR 
  #   //------------------------------------------------

  #   entry {
  #     text-color: #${palette.base05};
  #     padding: 10 10 0 0;
  #     margin: 0 -2 0 0;
  #   }

  #   inputbar {
  #     background-image: url("~/.config/rofi/rofi.jpg", width);
  #     padding: 180 0 0;
  #     margin: 0 0 0 0;
  #   } 

  #   prompt {
  #     text-color: #${palette.base0D};
  #     padding: 10 6 0 10;
  #     margin: 0 -2 0 0;
  #   }
  # '';
}
