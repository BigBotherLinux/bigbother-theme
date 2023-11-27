{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.gust-cursor-theme;
  themeName = "Gust";
in
{
  options.programs.gust-cursor-theme = {
    enable = mkEnableOption "Enable Gust cursor theme";

    package = mkOption {
      type = types.package;
      default = pkgs.gust-cursor-theme;  # This should be the attribute path of your cursor theme package
      description = "Cursor theme package.";
    };
  };

  config = mkIf cfg.enable {
    #xsession.cursorTheme = themeName;

    home.file.".local/share/icons/${themeName}".source = config.programs.gust-cursor-theme.package;
    home.file.".icons/default/index.theme".text = ''
      [Icon Theme]
      Inherits=${themeName}
    '';
    xdg.configFile."kcminputrc".text = ''
      [Mouse]
      cursorTheme=${themeName}
    '';
  };
}