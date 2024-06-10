{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  theme = lib.xeta.getThemeBase24 "tokyo-night-dark";
  cfg = config.xeta.nixvim.plugins.theme;
in
{
  options.xeta.nixvim.plugins.theme = {
    enable = mkEnableOption "Enable theme related config via nixvim.";
  };

  config = mkIf cfg.enable {
    snowfallorg.users.${config.xeta.system.user.username}.home.config = {
      home.file."/home/jules/.local/share/nvim/xeta/theme.lua".text = with theme; ''
        local TH = {}

        TH.colors = {
          blue         = '#${colors.base08}',
          cyan         = '#${colors.base0C}',
          black        = '#${colors.base01}',
          white        = '#${colors.base06}',
          red          = '#${colors.base0F}',
          violet       = '#${colors.base0E}',
          magenta      = '#${colors.base0D}',
          teal         = '#${colors.base0B}',
          lightblue    = '#${colors.base0A}',
          lightcyan    = '#${colors.base0C}',
          pink         = '#${colors.base0D}',
          lightpink    = '#${colors.base0E}',
          hotpink      = '#${colors.base0F}',
          warning      = '#${colors.base10}',
          grey         = '#${colors.base17}',
          error        = '#${colors.base13}',
          success      = '#${colors.base18}',
          info         = '#${colors.base0A}',
          hint         = '#${colors.base0C}',
          black        = '#${colors.base01}',
          white        = '#${colors.base06}',
          red          = '#${colors.base0F}',
          green        = '#${colors.base0B}',
          blue         = '#${colors.base08}',
          yellow       = '#${colors.base09}',
          gray         = '#${colors.base03}',
          darkgray     = '#${colors.base02}',
          lightgray    = '#${colors.base04}',
          inactivegray = '#${colors.base05}',
          base00       = '#${colors.base00}',
          base01       = '#${colors.base01}',
          base02       = '#${colors.base02}',
          base03       = '#${colors.base03}',
          base04       = '#${colors.base04}',
          base05       = '#${colors.base05}',
          base06       = '#${colors.base06}',
          base07       = '#${colors.base07}',
          base08       = '#${colors.base08}',
          base09       = '#${colors.base09}',
          base0A       = '#${colors.base0A}',
          base0AA      = '#${colors.base0AA}',
          base0B       = '#${colors.base0B}',
          base0C       = '#${colors.base0C}',
          base0CA      = '#${colors.base0CA}',
          base0D       = '#${colors.base0D}',
          base0DA      = '#${colors.base0DA}',
          base0E       = '#${colors.base0E}',
          base0F       = '#${colors.base0F}',
          base0FA      = '#${colors.base0FA}',
          base10       = '#${colors.base10}',
          base11       = '#${colors.base11}',
          base12       = '#${colors.base12}',
          base12A      = '#${colors.base12A}',
          base13       = '#${colors.base13}',
          base13A      = '#${colors.base13A}',
          base14       = '#${colors.base14}',
          base15       = '#${colors.base15}',
          base16       = '#${colors.base16}',
          base17       = '#${colors.base17}',
          base18       = '#${colors.base18}',
          base19       = '#${colors.base19}',
          base19A      = '#${colors.base19A}',
          base1A       = '#${colors.base1A}',
          base1B       = '#${colors.base1B}',
          none         = 'NONE',
        }

        TH.theme = {
          normal = {
            a = { bg = TH.colors.hotpink, fg = TH.colors.white, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.black },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
          insert = {
            a = { bg = TH.colors.lightcyan, fg = TH.colors.white, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.white },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
          visual = {
            a = { bg = TH.colors.magenta, fg = TH.colors.black, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.white },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
          replace = {
            a = { bg = TH.colors.base0AA, fg = TH.colors.white, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.white },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
          command = {
            a = { bg = TH.colors.warning, fg = TH.colors.black, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.white },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
          inactive = {
            a = { bg = nil, fg = TH.colors.white, gui = 'bold' },
            b = { bg = nil, fg = TH.colors.white },
            c = { bg = nil, fg = TH.colors.white },
            x = { bg = nil, fg = TH.colors.white },
            y = { bg = TH.colors.hotpink, fg = TH.colors.white },
            z = { bg = TH.colors.hotpink, fg = TH.colors.white },
          },
        }

        return TH
      '';
    };

    programs.nixvim = {
      colorschemes.tokyonight = {
        enable = true;
        settings = {
          style = "night";
          terminal_colors = true;
          transparent = true;
        };
      };

      highlight = with theme.colors; {
        RainbowRed = {
          fg = base0F;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowYellow = {
          fg = base0A;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowBlue = {
          fg = base0D;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowOrange = {
          fg = base09;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowGreen = {
          fg = base0B;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowViolet = {
          fg = base0E;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowCyan = {
          fg = base0C;
          bg = "NONE";
          bold = true;
          blend = 95;
        };
      };
      #   hi Normal guibg=NONE ctermbg=NONE
      #   hi LineNr guibg=NONE ctermbg=NONE
      #   hi SignColumn guibg=NONE ctermbg=NONE
      highlightOverride =
        with theme.colors;
        with theme.diagnostic;
        {
          Normal = {
            fg = base05;
            bg = "NONE";
          };
          LineNr = {
            fg = base05;
            bg = "NONE";
          };
          SignColumn = {
            fg = base05;
            bg = "NONE";
          };

          Comment = {
            fg = base05;
            bg = "NONE";
            bold = true;
            italic = true;
          };

          Pmenu = {
            bg = "NONE";
            fg = base01;
          };

          PmenuSel = {
            bg = "NONE";
            fg = base01;
          };

          TelescopeNormal = {
            bg = "NONE";
            fg = base01;
          };

          TelescopePromptNormal = {
            bg = "NONE";
            fg = base06;
          };

          TelescopePromptPrefix = {
            fg = base0D;
            bg = "NONE";
            bold = true;
          };

          TelescopePromptCounter = {
            fg = base0E;
            bg = "NONE";
            bold = true;
          };

          TelescopePromptTitle = {
            fg = base0B;
            bg = "NONE";
            bold = true;
          };

          TelescopePromptBorder = {
            bg = "NONE";
            fg = base06;
          };

          TelescopeResultsNormal = {
            bg = "NONE";
            fg = base06;
          };

          TelescopeResultsTitle = {
            fg = base0C;
            bg = "NONE";
            bold = true;
          };

          TelescopeResultsBorder = {
            bg = "NONE";
            fg = base06;
          };

          TelescopePreviewNormal = {
            bg = "NONE";
            fg = base06;
          };

          TelescopePreviewTitle = {
            fg = base0B;
            bg = "NONE";
            bold = true;
          };

          LspInlayHint = {
            fg = base0C;
            bg = "NONE";
            bold = true;
            blend = 95;
          };

          VirtText = {
            bg = "NONE";
            fg = base0C;
            bold = true;
          };

          LspReferenceText = {
            fg = base03;
            bg = "NONE";
          };

          TelescopePreviewBorder = {
            bg = "NONE";
            fg = base06;
          };

          TelescopeBorder = {
            bg = "NONE";
            fg = base06;
          };

          DiagnosticWarn.link = "DiagnosticVirtualTextWarn";
          DiagnosticInfo.link = "DiagnosticVirtualTextInfo";
          DiagnosticHint.link = "DiagnosticVirtualTextHint";
          DiagnosticOk.link = "DiagnosticVirtualTextOk";
          DiagnosticError.link = "DiagnosticVirtualTextError";

          DiagnosticVirtualTextError = {
            fg = base0F;
            bg = "NONE";
          };

          DiagnosticVirtualTextWarn = {
            fg = base0A;
            bg = "NONE";
          };

          DiagnosticVirtualTextInfo = {
            fg = base0C;
            bg = "NONE";
          };

          DiagnosticVirtualTextHint = {
            fg = base0C;
            bg = "NONE";
          };

          DiagnosticVirtualTextOk = {
            fg = base0D;
            bg = "NONE";
          };

          DiagnosticUnnecessary = {
            fg = virtual.warn.fg;
            bg = "NONE";
          };

          RainbowDelimiterRed.fg = base08;
          RainbowDelimiterRed.bg = "NONE";
          RainbowDelimiterYellow.fg = base0A;
          RainbowDelimiterYellow.bg = "NONE";
          RainbowDelimiterBlue.fg = base0D;
          RainbowDelimiterBlue.bg = "NONE";
          RainbowDelimiterOrange.fg = base09;
          RainbowDelimiterOrange.bg = "NONE";
          RainbowDelimiterGreen.fg = base0B;
          RainbowDelimiterGreen.bg = "NONE";
          RainbowDelimiterViolet.fg = base0E;
          RainbowDelimiterViolet.bg = "NONE";
          RainbowDelimiterCyan.fg = base0C;
          RainbowDelimiterCyan.bg = "NONE";
        };
    };
  };
}
