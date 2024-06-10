{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.xeta.nixvim.plugins.oil;
in
{
  options.xeta.nixvim.plugins.oil = {
    enable = mkEnableOption "Enable oil";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      keymaps = [
        {
          key = "<leader>o";
          action.__raw = "require('oil').toggle_float";
          options = {
            desc = "Find files using Oil";
            noremap = true;
            silent = true;
          };
        }
        {
          key = "<leader>oh";
          action.__raw = "require('oil').toggle_hidden";
          options = {
            desc = "Toggle hidden files in Oil";
            noremap = true;
            silent = true;
          };
        }
        {
          key = "q";
          action.__raw = "require('oil').close";
          options = {
            desc = "Close the oil window";
            noremap = true;
            silent = true;
          };
          mode = [
            "n"
            "v"
          ];
        }
      ];
      plugins.oil = {
        enable = true;
        settings = {
          constrain_cursor = "editable";
          default_file_explorer = true;
          experimental_watch_for_changes = true;
          skip_confirm_for_simple_edits = true;

          columns = [ "icon" ];

          view_options = {
            show_hidden = false;
          };

          float = {
            border = "rounded";
          };

          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-s>" = "actions.select_vsplit";
            "<C-h>" = "actions.select_split";
            "<C-t>" = "actions.select_tab";
            "<C-p>" = "actions.preview";
            "<C-c>" = "actions.close";
            "<C-l>" = "actions.refresh";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            " " = "actions.cd";
            "~" = "actions.tcd";
            "gs" = "actions.change_sort";
            "gx" = "actions.pen_external";
            "g." = "actions.toggle_hidden";
            "g\\" = "actions.toggle_trash";
          };
        };
      };
    };
  };
}
