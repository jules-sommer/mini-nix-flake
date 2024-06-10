{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) disabled enabled;
  inherit (inputs.nixvim.lib.${pkgs.system}) helpers;

  cfg = config.xeta.nixvim.plugins.lsp;

  incRenameEnabled = config.programs.nixvim.plugins.inc-rename.enable;
in
{
  options.xeta.nixvim.plugins.lsp = {
    enable = mkEnableOption "Enable LSP configuration and plugins.";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        luasnip = enabled;
        improved-search = enabled;
        indent-o-matic = enabled;
        nvim-colorizer = enabled;
        inc-rename = enabled;
        zig = enabled;
        rustaceanvim = enabled;
        none-ls = {
          enable = true;
          sources = {
            formatting = {
              nixfmt = {
                enable = true;
                package = pkgs.nixfmt-rfc-style;
              };
              ocamlformat = {
                enable = true;
                package = pkgs.ocamlformat;
              };
              htmlbeautifier = enabled;
              markdownlint = enabled;
              gofmt = {
                enable = true;
                package = pkgs.gopls;
              };
            };
          };
        };

        nvim-autopairs = enabled;
        comment = enabled;
        nix = enabled;
        crates-nvim = enabled;
        direnv = enabled;
        lsp-lines = enabled;
        lsp-format = enabled;
        nix-develop = enabled;

        lspkind = {
          enable = true;
          extraOptions = {
            cmp.enable = true;
          };
          mode = "symbol_text";
        };

        lsp = {
          enable = true;
          servers = {
            lua-ls = {
              enable = true;
              settings = {
                telemetry = disabled;
              };
            };
            nushell = enabled;
            tsserver = enabled;
            htmx = enabled;
            zls = enabled;
            rnix-lsp = disabled;
            nixd = disabled;
            nil_ls = enabled;
            bashls = enabled;
            # rust-analyzer = {
            #   enable = true;
            #   installRustc = false;
            #   installCargo = false;
            # };
            html = enabled;
            ccls = enabled;
            cmake = enabled;
            cssls = enabled;
            gopls = enabled;
            jsonls = enabled;
            pyright = enabled;
            tailwindcss = enabled;
          };
        };
      };

      keymaps = [
        {
          action = helpers.mkRaw "require('lsp_lines').toggle";
          key = "<leader>l";
          options = {
            desc = "Toggle LSP virtual line diagnostics";
            noremap = true;
          };
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.declaration";
          key = "gD";
          options = {
            noremap = true;
            desc = "Go to declaration";
          };
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.code_action";
          key = "<leader>ca";
          options = {
            noremap = true;
            desc = "See available code actions";
          };
        }
        (mkIf (incRenameEnabled) {
          action = helpers.mkRaw "vim.lsp.buf.rename";
          key = "<leader>rn";
          options = {
            noremap = true;
            desc = "Semi-intelligent rename via LSP";
          };
        })
        (mkIf (!incRenameEnabled) {
          action = "<cmd>IncRename<CR>";
          key = "<leader>rn";
          options = {
            noremap = true;
            desc = "Smart rename via IncRename and LSP";
          };
        })
        {
          action = helpers.mkRaw "vim.diagnostic.open_float";
          key = "<leader>d";
          options = {
            noremap = true;
            desc = "Show line diagnostics";
          };
        }
        {
          action = helpers.mkRaw "vim.diagnostic.goto_prev";
          key = "[d";
          options = {
            noremap = true;
            desc = "Go to previous diagnostic";
          };
        }
        {
          action = helpers.mkRaw "vim.diagnostic.goto_next";
          key = "]d";
          options = {
            noremap = true;
            desc = "Go to next diagnostic";
          };
        }
        {
          action = helpers.mkRaw "vim.lsp.buf.hover";
          key = "K";
          options = {
            noremap = true;
            desc = "Show documentation for what is under cursor";
          };
        }
        {
          action = "<cmd>LspRestart<CR>";
          key = "<leader>rs";
          options = {
            noremap = true;
            desc = "Restart LSP";
          };
        }
      ];
    };
  };
}
