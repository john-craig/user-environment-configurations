{ config, pkgs, lib, ... }:
let 
  synthwave-vscode = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "synthwave-vscode";
      publisher = "robbowen";
      version = "0.1.18";
      hash = "sha256-me5aPVAyOAhP+Iy1ACkoBpCfS1LlsZmk8CAjNuZyojg=";
    };
  });

  neonCSSPatch = pkgs.writeText "synthwave84-neon.css" ''
    /* BEGIN Synthwave84 Neon Patch */
    ${builtins.readFile "${synthwave-vscode}/share/vscode/extensions/robbowen.synthwave-vscode/synthwave84.css"}
    /* END Synthwave84 Neon Patch */
  '';

  vscodium = pkgs.vscodium.overrideAttrs (old: rec {
    version = "1.100.2";
    src = builtins.fetchurl {
      url = "https://github.com/VSCodium/vscodium/releases/download/1.100.23258/VSCodium-linux-x64-1.100.23258.tar.gz";
      sha256 = "sha256:0fa8bk110jad8hh33517zqj4k1wcla9h50df4c5bxvp50s0h5wgb";
    };

    postInstall = old.postInstall or "" + ''
      echo "Patching workbench.desktop.main.css for Synthwave '84 neon..."
      cssFile=$out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css
      cp $cssFile $cssFile.bak
      cat ${neonCSSPatch} >> $cssFile
    '';
  });
in 
{
  programs.vscode = {
    enable = true;
    package = vscodium;

    profiles.default = {
      keybindings = [
        {
          key = "ctrl+shift+x";
          command = "-workbench.view.extensions";
          when = "viewContainer.workbench.view.extensions.enabled";
        }
        {
          key = "ctrl+shift+left";
          command = "-workbench.action.terminal.resizePaneLeft";
          when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
        }
        {
          key = "ctrl+shift+right";
          command = "-workbench.action.terminal.resizePaneRight";
          when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
        }
      ];

      userSettings = {
        "workbench.colorTheme" = "SynthWave '84";
        "security.workspace.trust.untrustedFiles" = "open";
        "terminal.integrated.allowChords" = false;
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "sshfs.configs" = [
          {
            name = "homeserver1-homepage";
            host = "192.168.1.8";
            root = "/srv/container/hompage/config";
            username = "service";
            privateKeyPath = "\${env:HOME}/.ssh/homeserver1";
            sftpSudo = true;
          }
        ];
        "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
        "editor.fontLigatures" = true;
      };

      extensions = [
        pkgs.vscode-extensions.wholroyd.jinja
        # pkgs.vscode-extensions.wakatime.vscode-wakatime
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.jnoortheen.nix-ide
        synthwave-vscode
      ];
    };
  };


  home.file = {
    # ".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
    # ".config/VSCodium/User/settings.json".source = ./settings.json;
  };
}
