{
  description = "Home Manager configuration of user";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixgl.url = "github:nix-community/nixGL";
  };

  outputs =
    {
      # nixgl,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # pkgs = import nixpkgs {
      #   system = "x86_64-linux";
      #   overlays = [ nixgl.overlay ];
      # };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."user" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        # extraSpecialArgs = { inherit nixgl; };
      };
    };
}
