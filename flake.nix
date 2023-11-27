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
    packages.${system}.gust-cursor-theme = pkgs.stdenv.mkDerivation {
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

    homeManagerModules.gust-cursor-theme = import ./modules/cursor-theme.nix;
    
  };
}
