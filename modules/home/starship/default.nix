{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) types mkEnableOption;
  inherit (lib.xeta) mkOpt;
  cfg = config.xeta.starship;
  theme = lib.xeta.getThemeBase24 (config.xeta.desktop.hyprland.theme);
in
{
  options.xeta.starship = {
    enable = mkEnableOption "Enable starship prompt";
    theme =
      mkOpt types.str "mocha"
        "Starship prompt theme ( one of: `latte`, `frappe`, `macchiato`, or `mocha` )";
    includeTomlConfig = mkOpt (lib.types.bool
    ) false "Merge the nix starship config with the local config.toml file.";
  };

  config =
    let
      cattpuccin_palette = (
        builtins.fromTOML (
          builtins.readFile (
            pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "starship";
              rev = "5629d23";
              sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
            }
            + /palettes/${cfg.theme}.toml
          )
        )
      );
      config = (builtins.fromTOML (builtins.readFile ./starship.toml));
      nerd-font-symbols = (builtins.fromTOML (builtins.readFile ./nerd-font-symbols.toml));
    in
    lib.mkIf cfg.enable {
      programs.starship = {
        enable = true;
        settings = (
          with theme.colors;
          with theme;
          (lib.recursiveUpdate (cattpuccin_palette // nerd-font-symbols) {
            character = {
              success_symbol = "[|>](bold ${base13})";
              error_symbol = "[~~>](bold ${base0F})";
            };

            nix_shell = {
              disabled = false;
              # symbol = " ";
              impure_msg = "[impure](bold ${theme.diagnostic.error.fg})";
              pure_msg = "[pure](bold ${theme.diagnostic.ok.fg})";
              unknown_msg = "[unknown](bold ${theme.diagnostic.warn.fg})";
              format = "[](fg:${theme.diagnostic.hint.fg})[$state┃$name](${theme.diagnostic.hint.fg})[](fg:${theme.diagnostic.hint.fg})";
              heuristic = true;
              style = "bold ${ansi.cyan}";
            };

            rust = {
              format = "[](${ansi.magenta})[$symbol$version](bg:${ansi.magenta})[](${ansi.magenta})";
              style = "fg:#ffffff bg:${base0F}";
            };

            zig = {
              format = "[](${ansi.orange})[$symbol$version](bg:${ansi.orange})[](${ansi.orange})";
              # symbol = " ";
              style = "fg:#ffffff bg:${base1A}";
            };

            golang = {
              format = "[](${ansi.cyan})[$symbol$version](bg:${ansi.cyan})[](${ansi.cyan})";
              style = "fg:#ffffff bg:${base19A}";
            };

            lua = {
              format = "[](${ansi.cyan-light})[$symbol$version](bg:${ansi.cyan-light})[](${ansi.cyan-light})";
              style = "fg:#ffffff bg:${base08}";
            };

            ocaml = {
              format = "[](${ansi.purple})[$symbol$version](bg:${ansi.purple})[](${ansi.purple})";
              style = "fg:#ffffff bg:${base15}";
            };

            python = {
              format = "[](${ansi.yellow})[$symbol$version](bg:${ansi.yellow})[](${ansi.yellow})";
              style = "fg:#ffffff bg:${base0C}";
            };

            c = {
              format = "[](${ansi.blue-grey-light})[$symbol$version](bg:${ansi.blue-grey-light})[](${ansi.blue-grey-light})";
              style = "fg:#ffffff bg:${base0C}";
            };

            palette = "catppuccin_${cfg.theme}";

            fill = {
              symbol = " ";
              style = "";
              disabled = false;
            };

            right_format = (lib.concatStrings [ "[─╯](#FF0082)" ]);

            format = (
              lib.concatStrings [
                "[╭─ ](#FF0082)"
                "$directory"
                "$fill"
                "$container"
                "$all"
                " "
                "[](fg:${ansi.cyan-dark})"
                "$shell"
                "$cmd_duration"
                "[](fg:${ansi.cyan-dark})"
                " "
                "[─╮](#FF0082)"
                "$line_break"
                "[╰─](#FF0082)"
                "$jobs"
                "$status"
                " $username"
                "[$hostname](#FF0082)"
                " $character"
              ]
            );

            git_branch = {
              symbol = "";
              truncation_length = 5;
              truncation_symbol = "<|";
              ignore_branches = [
                "main"
                "master"
              ];
            };

            directory = {
              format = "[$path]($style)";
              style = "bold fg:${ansi.hotpink}}";
              truncation_length = 4;
              truncate_to_repo = true;
              truncation_symbol = "<|";
              home_symbol = "<|";
              read_only_style = "bold fg:${ansi.orange}";

              substitutions = {
                "000_dev" = " _dev";
                "/000_dev/000_config/010_minimal-hyprland-flake" = " system flake |>";
                "010_documents" = "󰈙 vault";
                "/" = "|";
                "040_downloads" = " downloads";
                "060_media" = "  media";
                "100_BACKUPS" = "󰁯 backups";
                "000_config" = " config";
              };
            };

            container = {
              format = "[$symbol$name]($style)";
              style = "bold fg:white bg:${ansi.cyan-light}";
            };

            git_status = {
              style = "fg:white bg:${ansi.teal}";
              format = "[$symbol$branch(:$remote_branch)]($style)";
              ahead = "⇡$count";
              diverged = "⇕⇡$ahead_count⇣$behind_count";
              behind = "⇣$count";
              deleted = "";
            };

            shell = {
              bash_indicator = "sh";
              fish_indicator = "fish";
              zsh_indicator = "zsh";
              nu_indicator = "nu";
              unknown_indicator = " ";
              format = "[$indicator]($style)";
              style = "bold fg:white bg:${ansi.cyan-dark}";
              disabled = false;
            };

            cmd_duration = {
              min_time = 1;
              format = "[$duration]($style)";
              style = "bold fg:white bg:${ansi.cyan-dark}";
              disabled = false;
            };

            time = {
              format = "[$time]($style)";
              time_format = "[%a %l:%M %p|%y/%m/%d]";
              style = "#cc39d1";
              disabled = true;
            };

            sudo = {
              format = "[$symbol]($style)";
              symbol = " ";
              style = "#c50044";
              disabled = true;
            };

            username = {
              format = "[$user]($style)";
              style_user = "bold fg:${ansi.hotpink}";
              style_root = "bold fg:${ansi.magenta}";
              disabled = false;
              show_always = true;
            };

            hostname = {
              format = "[$hostname]($style)  ";
              style = "bold dimmed ${ansi.magenta}";
              trim_at = "-";
              ssh_only = true;
              disabled = true;
            };

            battery = {
              disabled = true;
            };
          })
        );
      };
    };
}
