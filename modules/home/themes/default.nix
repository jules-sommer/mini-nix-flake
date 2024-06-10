{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.xeta) mkOpt path;
  cfg = config.xeta.desktop.theming;

  theme = lib.xeta.getThemeBase24 "tokyo-night-dark";
  colors = theme.colors;
  diagnostics = theme.diagnostic;

  home = "/home/jules";
  dotfiles = home + "/070_dotfiles/010_nix-managed/";
in
{
  options.xeta.desktop.theming = {
    globalCssOut =
      mkOpt (types.nullOr types.path) null
        "The path to the global css file, containing the system's theme as a set of :root css variables, to output.";
  };

  config = {
    home.file.${builtins.toString (dotfiles + "/waybar/globals.css")} = {
      text = ''
        @define-color base00 ${colors.base00};
        @define-color base00 ${colors.base00};
        @define-color base-01 ${colors.base01};
        @define-color base-02 ${colors.base02};
        @define-color base-03 ${colors.base03};
        @define-color base-04 ${colors.base04};
        @define-color base-05 ${colors.base05};
        @define-color base-06 ${colors.base06};
        @define-color base-07 ${colors.base07};
        @define-color base-08 ${colors.base08};
        @define-color base-09 ${colors.base09};
        @define-color base-0A ${colors.base0A};
        @define-color base-0AA ${colors.base0AA};
        @define-color base-0B ${colors.base0B};
        @define-color base-0C ${colors.base0C};
        @define-color base-0D ${colors.base0D};
        @define-color base-0E ${colors.base0E};
        @define-color base-0F ${colors.base0F};
        @define-color base-10 ${colors.base10};
        @define-color base-11 ${colors.base11};
        @define-color base-12 ${colors.base12};
        @define-color base-12A ${colors.base12A};
        @define-color base-13 ${colors.base13};
        @define-color base-14 ${colors.base14};
        @define-color base-15 ${colors.base15};
        @define-color base-16 ${colors.base16};
        @define-color base-17 ${colors.base17};
        @define-color base-18 ${colors.base18};
        @define-color base-19 ${colors.base19};
        @define-color base-19A ${colors.base19A};
        @define-color base-1A ${colors.base1A};
        @define-color base-1B ${colors.base1B};

        @define-color diagnostic-underline-error ${diagnostics.underline_error.fg};
        @define-color diagnostic-underline-warn ${diagnostics.underline_warn.fg};
        @define-color diagnostic-underline-info ${diagnostics.underline_info.fg};
        @define-color diagnostic-underline-hint ${diagnostics.underline_hint.fg};
        @define-color diagnostic-underline-ok ${diagnostics.underline_ok.fg};

        @define-color diagnostic-error ${diagnostics.error.fg};
        @define-color diagnostic-warn ${diagnostics.warn.fg};
        @define-color diagnostic-info ${diagnostics.info.fg};
        @define-color diagnostic-hint ${diagnostics.hint.fg};
        @define-color diagnostic-ok ${diagnostics.ok.fg};
      '';
    };
  };
}
