{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.xeta) enabled;
  cfg = config.xeta.nixvim.plugins.yanky;
  theme = lib.xeta.getThemeBase24 "tokyo-night-dark";
in
{
  options.xeta.nixvim.plugins.yanky = {
    enable = mkEnableOption "Enable oil";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      keymaps = [ ];
      plugins.yanky = {
        enable = true;
        extraOptions = {
          onPut = true;
          onYank = true;
          timer = 500;
          picker = {
            telescope = {
              enable = true;
              mappings = {
                i = {
                  "<c-g>" = "put('p')";
                  "<c-k>" = "put('P')";
                  "<c-x>" = "delete()";
                  "<c-r>" = "set_register(require('yanky.utils').get_default_register())";
                };
                n = {
                  p = "put('p')";
                  P = "put('P')";
                  d = "delete()";
                  r = "set_register(require('yanky.utils').get_default_register())";
                };
              };
            };
          };
          preserveCursorPosition = true;
          ring = {
            cancelEvent = "update";
            historyLength = 100;
            ignoreRegisters = [ "_" ];
            storage = "sqlite";
            storagePath = ''
              {__raw = "vim.fn.stdpath('data') .. '/databases/yanky.db'";}
            '';
            syncWithNumberedRegisters = true;
          };
          systemClipboard = {
            syncWithRing = true;
          };
          textobj = enabled;
        };
      };
      highlightOverride = with theme.colors; {
        IncSearch = {
          fg = base06;
          bg = base13;
          bold = true;
        };
        Search = {
          fg = base02;
          bg = base0CA;
          bold = true;
        };
      };
    };
  };
}
