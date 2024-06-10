{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) disabled enabled;

  cfg = config.xeta.nixvim.plugins.cmp;
in
{
  options.xeta.nixvim.plugins.cmp = {
    enable = mkEnableOption "enable cmp";
  };

  config = mkIf cfg.enable {
    programs.nixvim =
      let
        global_mappings = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-c>" = "cmp.mapping.abort()";

          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<Down>" = "cmp.mapping.select_next_item()";

          "<CR>" = ''
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          '';

          "<Esc>" = ''
            cmp.mapping(function(fallback)
              local completion = require('supermaven-nvim.completion_preview')

              if cmp.visible() then
                cmp.abort()
              end

              if completion.inlay_instance ~= nil then
                completion.on_dispose_inlay()
              end

              fallback()
            end, {'i', 's'})
          '';

          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end 
            end, {'i', 's'})
          '';

          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, {'i', 's'})
          '';
        };
      in
      {
        plugins = {
          cmp-treesitter = enabled;
          cmp_yanky = enabled;
          cmp-cmdline = enabled;
          cmp-nvim-lsp-document-symbol = enabled;
          cmp-nvim-lsp-signature-help = enabled;
          cmp_luasnip = enabled;
          # coq-nvim = enabled;
          # coq-thirdparty = enabled;
          # cmp-calc = enabled;
          # cmp-vsnip = enabled;
          # cmp-rg = enabled;
          # cmp-fuzzy-buffer = disabled;
          # cmp-fuzzy-path = enabled;

          cmp = {
            enable = true;
            settings = {
              enable = true;
              autoEnableSources = true;

              sorting = {
                comparators = [
                  "require('cmp.config.compare').locality"
                  "require('cmp.config.compare').exact"
                  "require('cmp.config.compare').kind"
                  "require('cmp.config.compare').recently_used"
                  "require('cmp.config.compare').offset"
                  "require('cmp.config.compare').score"
                  "require('cmp.config.compare').length"
                  "require('cmp.config.compare').order"
                ];
              };

              # snippet.expand = ''
              #   function(args)
              #     -- vim.fn["vsnip#anonymous"](args.body)
              #     require('luasnip').lsp_expand(args.body)
              #   end
              # '';

              sources = [
                {
                  name = "nvim_lsp";
                  keyword_length = 1;
                }
                {
                  name = "nvim_lsp_document_symbol";
                  keyword_length = 1;
                }
                {
                  name = "cmp_yanky";
                  keyword_length = 4;
                }
                {
                  name = "nvim_lsp_signature_help";
                  keyword_length = 1;
                }
                {
                  name = "path";
                  keyword_length = 2;
                }
                # {
                #   name = "rg";
                #   keyword_length = 3;
                # }
                # {
                #   name = "buffer";
                #   keyword_length = 3;
                # }
                {
                  name = "treesitter";
                  keyword_length = 1;
                }
              ];

              completion = { };

              mapping = global_mappings // {
                # add any other mappings here
              };

              window = {
                documentation = {
                  border = "rounded";
                  winhighlight = "FloatBorder:TelescopeBorder,Normal:Pmenu";
                };
                completion = {
                  border = "rounded";
                  winhighlight = "FloatBorder:TelescopeBorder,Normal:Pmenu";
                };
              };

              cmdline = {
                "/" = {
                  mapping = {
                    __raw = "cmp.mapping.preset.cmdline()";
                  };
                  sources = [
                    { name = "nvim_lsp"; }
                    { name = "nvim_lsp_document_symbol"; }
                    { name = "nvim_lsp_signature_help"; }
                    { name = "treesitter"; }
                    {
                      name = "rg";
                      keyword_length = 3;
                    }
                    {
                      name = "buffer";
                      keyword_length = 3;
                    }
                  ];
                };
                ":" = {
                  mapping = {
                    __raw = "cmp.mapping.preset.cmdline()";
                  };
                  sources = [
                    # { name = "fuzzy_path"; }
                    {
                      name = "path";
                      keyword_length = 1;
                    }
                    # {
                    #   name = "rg";
                    #   keyword_length = 3;
                    # }
                    {
                      name = "cmdline";
                      keyword_length = 1;
                      option = {
                        ignore_cmds = [
                          "Man"
                          "!"
                        ];
                      };
                    }
                  ];
                };
              };
            };
          };
        };
      };
  };
}
