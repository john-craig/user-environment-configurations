{ config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    package = pkgs.vscodium.overrideAttrs (old: rec {
      version = "1.100.2";
      src = builtins.fetchurl {
        url = "https://github.com/VSCodium/vscodium/releases/download/1.100.23258/VSCodium-linux-x64-1.100.23258.tar.gz";
        sha256 = "sha256:0fa8bk110jad8hh33517zqj4k1wcla9h50df4c5bxvp50s0h5wgb";
      };
    });

    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.wholroyd.jinja
        # pkgs.vscode-extensions.wakatime.vscode-wakatime
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.jnoortheen.nix-ide
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "synthwave-vscode";
            publisher = "robbowen";
            version = "0.1.18";
            hash = "sha256-me5aPVAyOAhP+Iy1ACkoBpCfS1LlsZmk8CAjNuZyojg=";
          };
        })
      ];
    };
  };

  home.file = {
    ".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
    ".config/VSCodium/User/settings.json".source = ./settings.json;
  };
}
