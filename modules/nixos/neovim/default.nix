{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) enabled getThemeBase24;
  inherit (lib.xeta.std.path) fromString;
  inherit (pkgs.xeta) supermaven-nvim;

  inherit (inputs.nixvim.lib.${pkgs.system}) helpers;
  plugins = pkgs.vimPlugins;

  theme = getThemeBase24 "tokyo-night-dark";
  colors = theme.colors;

  cfg = config.xeta.nixvim;
in
{
  options.xeta.nixvim = {
    enable = mkEnableOption "Enable neovim config via nixvim.";
  };

  config = mkIf cfg.enable {
    snowfallorg.users.${config.xeta.system.user.username}.home.config = {
      # this just allows us to put our init/extraConfig.lua in a separate file
      home.file."/home/jules/.local/share/nvim/xeta/extraConfig.lua".source = ./extraConfig.lua;
      home.file."/home/jules/.local/share/nvim/xeta/dashboard.lua".source = ./modules/dashboard.lua;
      home.file."/home/jules/.local/share/nvim/xeta/tables.lua".source = ./modules/tables.lua;
      home.file."/home/jules/.local/share/nvim/xeta/BufferHelpers.lua".source = ./modules/BufferHelpers.lua;
    };

    programs.nixvim = {
      enable = true;
      globals.mapleader = " ";
      filetype.extension.nu = "nu";

      opts = {
        clipboard = "unnamedplus";
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        softtabstop = 2;
        tabstop = 2;
        autoindent = true;
        smartindent = true;
        expandtab = true;
        wrap = false;
        swapfile = false;
        backup = false;
        hlsearch = false;
        incsearch = true;
        termguicolors = true;
        scrolloff = 8;
        updatetime = 50;
      };

      plugins = {
        presence-nvim = enabled;
        multicursors = {
          enable = true;
          createCommands = true;
          updatetime = 50;
          nowait = true;
          generateHints = {
            normal = true;
            insert = true;
            extend = true;
          };
          hintConfig = {
            border = "rounded";
            type = "window";
            position = "bottom";
          };
        };
        bufferline = {
          enable = true;
          colorIcons = true;
          closeIcon = " ";
          leftTruncMarker = "<||";
          maxNameLength = 30;
          separatorStyle = "slant";
          themable = true;
          tabSize = 18;
          highlights = {
            fill = {
              fg = colors.base06;
              bg = colors.base01;
              blend = 20;
            };
            closeButton = {
              fg = colors.base05;
              bg = colors.base00;
              blend = 20;
            };
            separator = {
              fg = colors.base03;
              bg = colors.base00;
              blend = 20;
            };
            trunkMarker = {
              fg = colors.base0A;
              bg = colors.base00;
              blend = 20;
            };
            background = {
              fg = colors.base0F;
              bg = colors.base00;
            };
            tab = {
              fg = colors.base05;
              bg = colors.base02;
            };
            tabSelected = {
              fg = colors.base06;
              bg = colors.base0B;
            };
            tabSeparator = {
              fg = null;
              bg = colors.base00;
            };
            tabSeparatorSelected = {
              fg = null;
              bg = colors.base0B;
              sp = null;
              underline = null;
            };
          };
        };
        sniprun = {
          enable = true;
        };
        persistence = {
          enable = true;
          saveEmpty = false;
        };
        indent-blankline =
          let
            highlights = [
              "RainbowRed"
              "RainbowYellow"
              "RainbowBlue"
              "RainbowOrange"
              "RainbowGreen"
              "RainbowViolet"
              "RainbowCyan"
            ];
          in
          {
            enable = true;
            settings = {
              exclude = {
                buftypes = [
                  "terminal"
                  "quickfix"
                ];
                filetypes = [
                  ""
                  "checkhealth"
                  "NvimTree"
                  "help"
                  "lspinfo"
                  "TelescopePrompt"
                  "TelescopeResults"
                  "yaml"
                ];
              };

              indent = {
                char = "│";
                highlight = highlights;
              };
              scope = {
                show_end = false;
                show_exact_scope = true;
                show_start = true;
                highlight = highlights;
              };
            };
          };
        barbecue = enabled;
        rainbow-delimiters = enabled;
        better-escape = enabled;
        neoscroll = enabled;
        # harpoon = enabled;
        ccc = enabled;
        gitsigns = enabled;
        lualine = enabled;
        notify = enabled;
        lazy = {
          enable = true;
        };
        lazygit = enabled;
        transparent = enabled;
        zellij = enabled;
      };

      extraPlugins = [
        {
          plugin = plugins.nvim-nu;
          config = "lua require('nu').setup()";
        }
        plugins.zoxide-vim
        supermaven-nvim
        plugins.vim-vsnip
        plugins.fzf-vim
        plugins.telescope-file-browser-nvim
      ];

      extraConfigLua =
        let
          extraConfigPath = fromString "/home/jules/000_dev/000_config/010_minimal-hyprland-flake/flake-src/modules/nixos/neovim/extraConfig.lua";
          extraConfigLua = builtins.readFile (extraConfigPath.value);
        in
        (lib.concatStringsSep "\n" [
          "vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/xeta')" # ~/.local/share/nvim/xeta
          "package.path = package.path .. ';' .. vim.fn.stdpath('data') .. '/xeta/?.lua'"
          extraConfigLua
        ]);

      keymaps = [
        {
          key = "v";
          action = "V";
          options = {
            noremap = true;
            silent = true;
          };
        }
        {
          key = "V";
          action = "v";
          options = {
            noremap = true;
            silent = true;
          };
        }
        {
          key = "jj";
          action = "<ESC>";
          options = {
            noremap = true;
            silent = true;
            desc = "Escape from insert mode";
          };
          mode = [ "i" ];
        }
        {
          key = "<leader>m";
          action = "<cmd>MCstart<CR>";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
            desc = "Create a multicursor selection for selected text";
          };
        }
        {
          key = "<leader>mc";
          action = "<cmd>MCclear<CR>";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
            desc = "Clear multicursor selection";
          };
        }
        {
          key = "<leader>mv";
          action = "<cmd>MCvisual<CR>";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
            desc = "Create a multicursor selection for visually selected text";
          };
        }
        {
          key = "<leader>mc";
          action = "<cmd>MCclear<CR>";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
            desc = "Clear multicursor selection";
          };
        }
        {
          key = ";;";
          action = "<cmd>w<CR>";
          options = {
            desc = "Open command line without shift.";
          };
          mode = [ "n" ];
        }
        {
          key = ";";
          action = ":";
          options = {
            desc = "Open command line without shift.";
          };
          mode = [
            "n"
            "o"
          ];
        }
        {
          key = "<leader>lg";
          action = "<cmd>LazyGit<CR>";
          options = {
            desc = "Open LazyGit inside Vim";
            noremap = true;
            silent = true;
            unique = true;
          };
          mode = [ "n" ];
        }
        {
          key = "<leader>bd";
          action = "<cmd>CloseAndSaveBuffer<CR>";
          options = {
            desc = "Close ( and save ) current buffer";
            noremap = true;
            silent = true;
            unique = true;
          };
          mode = [ "n" ];
        }
        {
          key = "<leader>n";
          action = "<cmd>enew<CR>";
          options = {
            noremap = true;
            silent = true;
            unique = true;
            desc = "Create a new empty buffer";
          };
          mode = [ "n" ];
        }
        {
          action = "<cmd>bnext<CR>";
          key = "<Tab>";
          mode = [ "n" ];
          options.silent = false;
        }
        {
          action = "<cmd>bprev<CR>";
          key = "<S-Tab>";
          mode = [ "n" ];
          options.silent = false;
        }
      ];
    };
  };
}
