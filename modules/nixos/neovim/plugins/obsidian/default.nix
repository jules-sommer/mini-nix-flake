{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.xeta.nixvim.plugins.obsidian;
in
{
  options.xeta.nixvim.plugins.obsidian = {
    enable = mkEnableOption "Enable obsidian";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins.obsidian = {
        enable = true;
        settings = {
          workspaces = [
            {
              name = "jules-main";
              path = "~/010_documents";
            }
            {
              name = "jules-old";
              path = "~/_vault";
            }
          ];

          picker = {
            name = "telescope.nvim";
          };

          templates = {
            subdir = "__templates";
          };

          daily_notes = {
            folder = "030_daily-notes";
          };

          follow_url_func = ''
            function(url)
              vim.fn.jobstart({"xdg-open", url})
            end
          '';

          new_notes_location = "current_dir";
          completion = {
            nvim_cmp = true;
            min_chars = 1;
          };
        };
      };
    };
  };
}
