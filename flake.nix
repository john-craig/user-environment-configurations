{
  description = "User Environment Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-apocrypha.url = "git+https://gitea.chiliahedron.wtf/chiliahedron/nixpkgs-apocrypha";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-apocrypha, ... }: rec {
    nixosModules = {
      "display@generic" = {
        imports = [ 
          ./modules
          ./users/display/home.nix
        ];
      };
      "service@generic" = {
        imports = [ 
          ./modules
          ./users/service/home.nix
        ];
      };
      "evak" = {
        imports = [
          ./modules
          ./users/evak/home.nix
        ];
      };
    };

    homeConfigurations = {
      "evak@workstation" = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          { nixpkgs.overlays = [ nixpkgs-apocrypha.overlays."x86_64-linux" ]; }
          nixosModules.evak
          ./hosts/workstation
        ];
      };
      "evak@laptop" = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          { nixpkgs.overlays = [ nixpkgs-apocrypha.overlays."x86_64-linux" ]; }
          nixosModules.evak
          ./hosts/laptop
        ];
      };
    };
  };
}
