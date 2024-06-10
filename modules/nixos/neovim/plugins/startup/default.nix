{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (inputs.nixvim.lib.${pkgs.system}) helpers;

  cfg = config.xeta.nixvim.plugins.startup;
  keymaps = [
    {
      key = ";;";
      action = "<cmd>w<CR>";
      options = {
        desc = "Write current buffer";
      };
      mode = [ "n" ];
    }
    {
      key = ";";
      action = ":";
      options = {
        desc = "Open command line.";
      };
      mode = [ "n" ];
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
  ];
in
{
  options.xeta.nixvim.plugins.startup = {
    enable = mkEnableOption "Enable neovim startup plugin via nixvim.";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.enable == true;
        message = "xeta.nixvim.plugins.startup.enable must be true";
      }
      {
        assertion = builtins.typeOf keymaps == "list" && builtins.length keymaps > 0;
        message = "xeta.nixvim.plugins.startup.keymaps must be a list of at least one keymap";
      }
      {
        assertion =
          builtins.length (builtins.attrNames (lib.xeta.transformKeymaps keymaps)) > 0
          && builtins.length (lib.xeta.transformKeymapsToList keymaps) > 0;
        message = "xeta.nixvim.plugins.startup.keymaps must be a list of at least one keymap";
      }
    ];

    programs.nixvim = {
      plugins.startup = {
        enable = true;
        options = {
          disableStatuslines = true;
          mappingKeys = true;
          paddings = [
            5
            5
          ];
        };
        parts = [
          "header"
          "body"
        ];
        colors = {
          background = "transparent";
        };
        userMappings = {
          ";;" = "<cmd>w<CR>";
          "<leader>ff" = "<cmd>lua CloseAndSaveBuffer()<CR>";
          "<leader>n" = "<cmd>enew<CR>";
          "<leader>o" = "<cmd>lua require('oil').toggle_float()<CR>";
          "<leader>lg" = "<cmd>LazyGit<CR>";
          "<leader>f" = "<cmd>Telescope find_files<CR>";
          "<leader>g" = "<cmd>Telescope live_grep<CR>";
          "<leader>b" = "<cmd>Telescope buffers<CR>";
          "<leader>k" = "<cmd>Telescope keymaps<CR>";
          "<leader>fr" = "<cmd>Telescope registers<CR>";
        };

        sections = {
          body = {
            align = "center";
            content = [
              [
                "Quick find file"
                "Telescope find_files"
                "<leader>f"
              ]
              [
                "Interactive file tree buffer"
                "lua require('oil').toggle_float()"
                "<leader>o"
              ]
              [
                "Create new buffer"
                "enew"
                "<leader>n"
              ]
              [
                "Find Word"
                "Telescope live_grep"
                "<leader>g"
              ]
              [
                "Find Buffer"
                "Telescope buffers"
                "<leader>b"
              ]
              [
                "Open LazyGit"
                "LazyGit"
                "<leader>k"
              ]
              [
                "Find Keymap"
                "Telescope keymaps"
                "<leader>k"
              ]
            ];
            defaultColor = "#FFC0FA";
            foldSection = false;
            highlight = "String";
            margin = 5;
            oldfilesAmount = 5;
            title = "Commands";
            type = "mapping";
          };
          header = {
            align = "center";
            content = helpers.mkRaw ''
              require('startup.headers').neovim_logo_header
            '';
            defaultColor = "#ffffff";
            foldSection = false;
            highlight = "Statement";
            margin = 5;
            oldfilesAmount = 0;
            title = "header";
            type = "text";
          };
        };
      };
    };
  };
}
