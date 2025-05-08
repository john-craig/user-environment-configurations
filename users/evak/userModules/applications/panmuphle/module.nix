{ pkgs, lib, config, ... }: let
  mergeWorkspaceScreens = (
    workspaces: workspaceScreens: globalDefaultScreen:
      map (workspace:
        let
          wsName = workspace.name;
          wsScreenConf = lib.attrByPath [wsName] null workspaceScreens;
          defaultScreen = if wsScreenConf != null
                          then wsScreenConf.default_screen
                          else globalDefaultScreen;

          updatedWindows = lib.imap0 (i: win:
            let
              preferredScreen = if wsScreenConf != null
                                then lib.attrByPath ["windows" (toString i) "preferred_screen"] defaultScreen wsScreenConf
                                else defaultScreen;
            in
              win // { preferred_screen = preferredScreen; }
          ) workspace.windows;

        in
          workspace // {
            default_screen = defaultScreen;
            windows = updatedWindows;
          }
      ) workspaces
  );
in {
  options = {
    panmuphle = {
      enable = lib.mkEnableOption "configuration Panmuphle window organizer";

      globalDefaultScreen = lib.mkOption {
        type = lib.types.str;
        description = "Default screen to use for all workspaces";
      };

      initialWorkspaces = lib.mkOption {
        type = lib.types.listOf lib.types.str; # Define it as a list of strings
        default = [ ]; # Default to an empty list
        description = "Initial workspaces to start when Panmuphle begins";
      };

      screens = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Name of the monitor as it appears in `hyprctl monitors`";
            };
            alias = lib.mkOption {
              type = lib.types.str;
              description = "Alias to use for referring to the monitor";
            };
          };
        });
        default = [ ];
        description = "Screens available to Panmuphle";
      };

      workspaces = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                description = "Name of the workspaces";
              };

              windows = lib.mkOption {
                description = "Windows within this workspace";
                type = lib.types.listOf (lib.types.submodule {
                  options = {
                    displayed_default = lib.mkOption {
                      type = lib.types.bool;
                      description = "Whether this window is displayed when the workspace is focused";
                    };

                    applications = lib.mkOption {
                      description = "Applications present in this window";
                      type = lib.types.listOf (lib.types.submodule {
                        options = {
                          name = lib.mkOption {
                            type = lib.types.str;
                            description = "Name of the application";
                          };

                          exec = lib.mkOption {
                            type = lib.types.str;
                            description = "Executable to start application";
                          };

                          focused_default = lib.mkOption {
                            type = lib.types.bool;
                            description = "Whether this application is focused when the window is focused";
                          };
                        };
                      });
                    };
                  };
                });
              };
            };
        });
        default = [ ];
        description = "Workspaces for Panmuphle";
      };

      workspaceScreens = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              default_screen = lib.mkOption {
                type = lib.types.str;
                description = "Screen name or alias where workspace windows are opened by default";
              };

              windows = lib.mkOption {
                description = "Windows within this workspace";
                type = lib.types.attrsOf (lib.types.submodule {
                  options = {
                    preferred_screen = lib.mkOption {
                      type = lib.types.str;
                      description = "Screen name or alias this window will occupy until another window is focused there";
                    };
                  };
                });
              };
            };
        });
      };
    };
  };

  config = (lib.mkIf config.panmuphle.enable) {
    home.packages = with pkgs; [
      faustroll
    ];

    home.file.".panmuphled.json".text = builtins.toJSON {
      initial_workspaces = config.panmuphle.initialWorkspaces;

      screens = config.panmuphle.screens;

      workspaces = mergeWorkspaceScreens
        config.panmuphle.workspaces
        config.panmuphle.workspaceScreens
        config.panmuphle.globalDefaultScreen;
    };
  };
}