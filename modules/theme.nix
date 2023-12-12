{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.bigbother-theme;
  themeName = "Gust";
  wallpaperName = "Crowded";
in
{
  options.programs.bigbother-theme = {
    enable = mkEnableOption "Enable bigbother theme";

    cursor = mkOption {
      type = types.package;
      default = pkgs.gust-cursor-theme;  # This should be the attribute path of your cursor theme package
      description = "Cursor theme package.";
    };
    wallpaper = mkOption {
      type = types.package;
      default = pkgs.bb-wallpaper;  # This should be the attribute path of your cursor theme package
      description = "wallpaper theme package.";
    };
  };

  config = mkIf cfg.enable {
    #xsession.cursorTheme = themeName;

    home.file.".local/share/icons/${themeName}".source = config.programs.bigbother-theme.cursor;
    home.file.".local/share/wallpapers/${wallpaperName}".source = config.programs.bigbother-theme.wallpaper;
    home.file.".local/share/plasma/wallpapers/${wallpaperName}".source = config.programs.bigbother-theme.wallpaper;
    home.file.".icons/default/index.theme".text = ''
      [Icon Theme]
      Inherits=${themeName}
    '';
    xdg.configFile."kcminputrc".text = ''
      [Mouse]
      cursorTheme=${themeName}
    '';
    xdg.configFile."plasmarc".text = ''
      [Wallpaper]
      defaultWallpaperTheme=Crowded
      defaultFileSuffix=.png
      defaultWidth=1920
      defaultHeight=1080
    '';
    xdg.configFile."kdedefaults/plasmarc".text = ''
      [Wallpaper]
      defaultWallpaperTheme=Crowded
      defaultFileSuffix=.png
      defaultWidth=1920
      defaultHeight=1080
    '';
  };
}