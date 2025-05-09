{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

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
