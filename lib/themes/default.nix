{ lib, ... }:
rec {
  getThemeBase24 =
    theme:
    let
      themes = {
        tokyo-night-dark = {
          author = "Jules <uwu@dodrugsbe.gay> / original by Michaël Ball";
          name = "Tokyo Night Dark (base24)";
          slug = "tokyo-night-dark_(base24)";

          colors = {
            base00 = "#1A1B26"; # Background color
            base01 = "#16161E"; # Darker background (status bars, line number, folding marks)
            base02 = "#2F3549"; # Selection background
            base03 = "#444B6A"; # Comments, invisible characters, line highlighting
            base04 = "#787C99"; # Dark foreground (status bars)
            base05 = "#A9B1D6"; # Default foreground, caret, delimiters, operators
            base06 = "#CBCCD1"; # Light foreground (not often used)
            base07 = "#D5D6DB"; # Light background (not often used)
            base08 = "#C0CAF5"; # Variables, XML tags, markup link text, markup lists, Diff Deleted
            base09 = "#A9B1D6"; # Integers, boolean, constants, XML attributes, markup link URL
            base0A = "#0DB9D7"; # Classes, markup bold, search text background
            base0AA = "#00B3A4"; # Classes, markup bold, search text background (Teal)
            base0B = "#9ECE6A"; # Strings, inherited class, markup code, Diff Inserted
            base0C = "#B4F9F8"; # Support, regular expressions, escape characters, markup quotes
            base0D = "#2AC3DE"; # Functions, methods, attribute IDs, headings
            base0CA = "#2DE2E6"; # Support, regular expressions, escape characters, markup quotes (Bright Cyan)
            base0DA = "#0DB9D7"; # Functions, methods, attribute IDs, headings (Cyan)
            base0E = "#BB9AF7"; # Keywords, storage, selector, markup italic, Diff Changed
            base0F = "#F7768E"; # Deprecated, opening/closing embedded language tags, e.g. <?php ?>
            base0FA = "#891785";
            base0FB = "#512558";
            base10 = "#FF9E64"; # Warnings, deprecated
            base11 = "#D18616"; # Darker orange for better contrast in UI elements
            base12 = "#73DACA"; # Cyan for additional functions or method highlighting
            base12A = "#0DB9D7"; # Cyan for additional functions or method highlighting (consistent with base0D)
            base13 = "#FF007C"; # Bright pink for standout elements
            base13A = "#f61eaf";
            base14 = "#7AA2F7"; # Light blue for subtle background highlights
            base15 = "#FF79C6"; # Pink for markup emphasis
            base16 = "#BD93F9"; # Purple for additional keyword highlighting
            base17 = "#6272A4"; # Muted blue for subtle UI elements
            base18 = "#50FA7B"; # Green for success messages
            base19 = "#8BE9FD"; # Bright cyan for active elements
            base19A = "#2DE2E6"; # Bright cyan for active elements (consistent with base0C)
            base1A = "#FFB86C"; # Orange for information messages
            base1B = "#F8F8F2"; # Very light grey for borders or additional highlights
          };

          ansi = {
            black = "#1A1B26"; # base00
            grey = "#16161E"; # base01
            blue-grey = "#2F3549"; # base02
            comments = "#444B6A"; # base03
            dark-foreground = "#787C99"; # base04
            foreground = "#A9B1D6"; # base05
            foreground-alt = "#CBCCD1"; # base06
            light-background = "#D5D6DB"; # base07
            var = "#C0CAF5"; # base08
            int = "#A9B1D6"; # base09
            muted-cyan = "#0DB9D7"; # base0A
            teal = "#00B3A4"; # base0AA
            muted-lime = "#9ECE6A"; # base0B
            cyan-light = "#B4F9F8"; # base0C
            cyan = "#2DE2E6"; # base0CA
            cyan-dark = "#2AC3DE"; # base0DA
            cyan-alt = "#0DB9D7"; # base0DA
            keywords = "#BB9AF7"; # base0E
            deprecated = "#F7768E"; # base0F
            magenta = "#891785"; # base0FA
            magenta-dark = "#512558"; # base0FB
            orange = "#FF9E64"; # base10
            orange-dark = "#D18616"; # base11
            yellow = "#FAE900";
            red = "#FF005c";
            teal-light = "#73DACA"; # base12
            hotpink = "#FF007C"; # base13
            hotpink_B = "#f61eaf"; # base13A
            blue-light = "#7AA2F7"; # base14
            pink = "#FF79C6"; # base15
            purple = "#BD93F9"; # base16
            blue-grey-light = "#6272A4"; # base17

            green = "#50FA7B"; # base18
            cyan-light_B = "#8BE9FD"; # base19
            cyan_B = "#2DE2E6"; # base19A
            orange_B = "#FFB86C"; # base1A
            beige = "#F8F8F2"; # base1B
          };

          categories = {
            cyan = [
              "base0A"
              "base0CA"
              "base0DA"
              "base12"
              "base12A"
              "base19"
              "base19A"
            ];
            teal = [ "base0AA" ];
            magenta = [
              "base0E"
              "base15"
            ];
            orange = [
              "base10"
              "base1A"
            ];
            pink = [
              "base13"
              "base15"
            ];
            blue = [
              "base0D"
              "base0DA"
              "base14"
              "base17"
            ];
            green = [
              "base0B"
              "base18"
            ];
            purple = [ "base16" ];
            red = [ "base0F" ];
            gray = [
              "base01"
              "base02"
              "base03"
              "base04"
              "base05"
              "base06"
              "base07"
              "base17"
            ];
            white = [ "base1B" ];
            black = [
              "base00"
              "base01"
            ];
          };

          diagnostic = {
            virtual = {
              error = {
                fg = "#e699c0";
                bg = "NONE";
                rgb = {
                  fg = "rgb(230 153 204 / 0.5)";
                };
              };
              warn = {
                fg = "#e6e680";
                bg = "NONE";
                rgb = {
                  fg = "rgb(230 230 128 / 0.5)";
                };
              };
              info = {
                fg = "#66e6e6";
                bg = "NONE";
                rgb = {
                  fg = "rgb(102 230 230 / 0.5)";
                };
              };
              hint = {
                fg = "#80e6e6";
                bg = "NONE";
                rgb = {
                  fg = "rgb(128 230 230 / 0.5)";
                };
              };
              ok = {
                fg = "#66e6b3";
                bg = "NONE";
                rgb = {
                  fg = "rgb(102 230 179 / 0.5)";
                };
              };
            };
            underline_error = {
              cterm = "undercurl";
              gui = "undercurl";
              fg = "#FF007C";
            };
            underline_warn = {
              cterm = "undercurl";
              gui = "undercurl";
              fg = "#FECD44";
            };
            underline_info = {
              cterm = "undercurl";
              gui = "undercurl";
              fg = "#00CFFF";
            };
            underline_hint = {
              cterm = "undercurl";
              gui = "undercurl";
              fg = "#00FFAA";
            };
            underline_ok = {
              cterm = "undercurl";
              gui = "undercurl";
              fg = "#00FF66";
            };
            error = {
              fg = "#FF007C";
            };
            warn = {
              fg = "#FECD44";
            };
            info = {
              fg = "#00CFFF";
            };
            hint = {
              fg = "#00FFAA";
            };
            ok = {
              fg = "#00FF66";
            };
          };
        };
      };
    in
    assert lib.assertMsg (
      theme != null && builtins.typeOf theme == "string"
    ) "getTheme: theme is null or not of type string";
    themes.${theme};

  getByCategory =
    name: theme:
    let
      theme = getThemeBase24 theme;
      hasColor = builtins.getAttr name theme.categories;
    in
    map (colorName: builtins.getAttr colorName theme.colors) hasColor;

  getByName =
    name:
    assert lib.assertMsg (
      name != null && builtins.typeOf name == "string"
    ) "getThemeBase24: name is null or not of type string";
    assert lib.assertMsg (builtins.elem name lib.xeta.themes.base24.categories)
      "getThemeBase24: name is not a valid category";
    lib.xeta.themes.base24.colors.${name};
}
