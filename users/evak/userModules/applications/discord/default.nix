{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    discord 
    betterdiscordctl
  ];

  home.activation.betterdiscord = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo ">> Installing BetterDiscord..."

      # Make sure XDG paths or Discord path are correctly defined
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"

      # Install or reinstall BetterDiscord into Discord
      if command -v betterdiscordctl >/dev/null; then
        ${pkgs.betterdiscordctl}/bin/betterdiscordctl install || true
      else
        echo "betterdiscordctl not found in PATH!"
      fi
  '';

  home.file = {
    ".config/discord/settings.json".source = ./settings.json;
    ".config/BetterDiscord/themes/DarkNeon.theme.css".source = ./DarkNeon.theme.css;
  };
}
