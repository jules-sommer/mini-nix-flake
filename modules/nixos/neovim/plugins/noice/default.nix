{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) enabled;
  cfg = config.xeta.nixvim.plugins.noice;
  theme = lib.xeta.getThemeBase24 "tokyo-night-dark";
in
{
  options.xeta.nixvim.plugins.noice = {
    enable = mkEnableOption "Enable oil";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      keymaps = [
        {
          key = "<leader>ds";
          action = "<cmd>Noice dismiss<CR>";
          options = {
            desc = "Dismiss all popups via Noice";
            noremap = true;
            silent = true;
          };
        }
      ];
      plugins.noice = {
        enable = true;
        cmdline = {
          enabled = true;
          view = "cmdline_popup";
          format = {
            cmdline = {
              pattern = "^:";
              icon = "";
              lang = "vim";
            };
            search_down = {
              kind = "search";
              pattern = "^/";
              icon = " ";
              lang = "regex";
            };
            search_up = {
              kind = "search";
              pattern = "?%?";
              icon = " ";
              lang = "regex";
            };
            filter = {
              pattern = "^:%s*!";
              icon = "$";
              lang = "bash";
            };
            lua = {
              pattern = "^:%s*lua%s+";
              icon = "";
              lang = "lua";
            };
            help = {
              pattern = "^:%s*he?l?p?%s+";
              icon = "";
            };
            input = { };
          };
        };
        smartMove = {
          enabled = true;
          excludedFiletypes = [
            "cmp_menu"
            "cmp_docs"
            "notify"
          ];
        };
        messages = {
          enabled = true;
          view = "notify";
          viewError = "notify";
          viewHistory = "messages";
          viewSearch = "virtualtext";
          viewWarn = "notify";
        };
        markdown = {
          highlights = {
            "|%S-|" = "@text.reference";
            "@%S+" = "@parameter";
            "^%s*(Parameters:)" = "@text.title";
            "^%s*(Return:)" = "@text.title";
            "^%s*(See also:)" = "@text.title";
            "{%S-}" = "@parameter";
          };
          hover = {
            "|(%S-)|" = "vim.cmd.help";
            "%[.-%]%((%S-)%)" = "require('noice.util').open";
          };
        };
        presets = {
          bottom_search = false;
          command_palette = false;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };
        notify = {
          enabled = true;
          view = "notify";
        };
        popupmenu = {
          enabled = true;
          backend = "cmp";
          kindIcons = true;
        };
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          documentation = {
            opts = {
              lang = "markdown";
              replace = true;
              render = "plain";
              format = [ "{message}" ];
              win_options = {
                concealcursor = "n";
                conceallevel = 3;
              };
            };
            view = "hover";
          };
          hover.enabled = true;
        };
      };
    };
  };
}
