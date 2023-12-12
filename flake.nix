{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = { 
      gust-cursor-theme = pkgs.stdenv.mkDerivation {
        name = "gust-cursor-theme";
        src = ./cursors/Gust;
        nativeBuildInputs = with pkgs; [ inkscape xorg.xcursorgen bash ];
      
        buildPhase = ''
          # Inkscape will fail writing to the home directory with a permission denied error.. This is just to suppress that error
          export HOME=/tmp
          
          bash ./build.sh
          cp -r Gust/ $out
        '';
      };
      
      bb-wallpaper = pkgs.stdenv.mkDerivation {
        name = "bb-wallpaper";
        src = ./wallpapers/BigBother;
        nativeBuildInputs = with pkgs; [ imagemagick ];

        buildPhase = ''
          mkdir -p $out/contents/images
          mkdir -p $out/contents/images_dark
          #ls -la
          bash crop_wallpaper.sh ./src
          cp -r ./build/* $out/contents/images
          cp -r ./build/* $out/contents/images_dark
          cp ./src/wallpaper.png $out/contents/screenshot.png
          cp ./src/metadata.json $out/metadata.json
        '';
      };
    };
    homeManagerModules.bigbother-theme = import ./modules/theme.nix;
  };
}
