{ pkgs, lib, config, ... }: let
  mergeWindowLists = a: b:
    # assertMsg (builtins.length a == builtins.length b)
    #   "Arrays to merge must be of equal length.";
    lib.imap0 (i: x: x // (builtins.elemAt b i)) a;

  mergeWorkspaceAttrs = a: b:
    lib.attrsets.mergeAttrsList [
      a b 
      {
        windows = mergeWindowLists
          (lib.lists.optionals
            (builtins.hasAttr "windows" a) a.windows)
          (lib.lists.optionals
            (builtins.hasAttr "windows" b) b.windows);
      }
    ];

  mergeWorkspaceLists = a: b:
    # assertMsg (builtins.length a == builtins.length b)
    #   "Arrays to merge must be of equal length.";
    lib.imap0 (i: x: (mergeWorkspaceAttrs x (builtins.elemAt b i))) a;
in {
  options = {
    panmuphle = {
      enable = lib.mkEnableOption "configuration Panmuphle window organizer";

      initial_workspaces = lib.mkOption {
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
          type = lib.types.listOf (lib.types.submodule {
            options = {
              default_screen = lib.mkOption {
                type = lib.types.str;
                description = "Screen name or alias where workspace windows are opened by default";
              };

              windows = lib.mkOption {
                description = "Windows within this workspace";
                type = lib.types.listOf (lib.types.submodule {
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
      initial_workspaces = config.panmuphle.initial_workspaces;

      screens = config.panmuphle.screens;

      workspaces = mergeWorkspaceLists
        config.panmuphle.workspaces
        config.panmuphle.workspaceScreens;
    };
  };
}