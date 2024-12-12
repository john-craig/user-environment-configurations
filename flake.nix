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

  outputs = { nixpkgs, home-manager, nixpkgs-apocrypha, ... }: {
    # For `nix run .` later
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "evak@workstation" = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          { nixpkgs.overlays = [ nixpkgs-apocrypha.overlays."x86_64-linux" ]; }
          ./hosts/workstation
          ./users/evak/home.nix
        ];
      };
      "evak@laptop" = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          { nixpkgs.overlays = [ nixpkgs-apocrypha.overlays."x86_64-linux" ]; }
          ./hosts/laptop
          ./users/evak/home.nix
        ];
      };
    };
  };
}
