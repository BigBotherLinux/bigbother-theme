{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.bb-wallpaper;
  themeName = "Crowded";
in
{
  options.programs.bb-wallpaper = {
    enable = mkEnableOption "Enable Crowded  theme";

    package = mkOption {
      type = types.package;
      default = pkgs.bb-wallpaper; 
      description = "Theme package.";
    };
  };

  config = mkIf cfg.enable {
    #xsession.cursorTheme = themeName;
    home.file.".local/share/plasma/${themeName}".source = config.programs.bb-wallpaper.package;
  };
}