{
  description = "User Environment Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-apocrypha.url = "git+https://gitea.chiliahedron.wtf/chiliahedron/nixpkgs-apocrypha";
  };

  outputs = { self, nixpkgs, nixGL, home-manager, nixpkgs-apocrypha, ... }: 
    let 
      mkUserConfig = username: {
        imports = [ 
          ./modules
          ./users/${username}/home.nix
        ];
      };
      mkHomeConfig = homeDef: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { 
          system = "${homeDef.arch}"; 
          overlays = [ nixGL.overlay ];
        };

        modules = [
          { nixpkgs.overlays = [ nixpkgs-apocrypha.overlays."${homeDef.arch}" ]; }
          self.nixosModules.${homeDef.user}
          ./hosts/${homeDef.host}
        ];
      };
    in {
      nixosModules = {
        "display" = mkUserConfig "display";
        "service" = mkUserConfig "service";
        "evak" = mkUserConfig "evak";
      };

      homeConfigurations = {
        "evak@workstation" = mkHomeConfig {
          user = "evak";
          host = "workstation";
          arch = "x86_64-linux";
        };
        "evak@laptop" = mkHomeConfig {
          user = "evak";
          host = "laptop";
          arch = "x86_64-linux";
        };
      };
  };
}
