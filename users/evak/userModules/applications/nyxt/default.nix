{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nyxt
  ];

  home.file= {
    # nyxt configuration file
    ".config/nyxt/config.lisp".source = pkgs.writeText "config.lisp" ''
      ;; Change the keybinding for visual mode to Ctrl+Space
      ;; and for execute-command to Ctrl+Return.
      (define-configuration input-buffer
        ((override-map
          (let ((map (make-keymap "override-map")))
            (define-key map 
              "C-return" 'execute-command
              "C-space" 'visual-mode)))))


      ;; Load search-engines.lisp after loading nx-search-engines.
      #+nyxt-2
      (load-after-system :nx-search-engines (nyxt-init-file "search-engines.lisp"))
      #+nyxt-3
      (define-nyxt-user-system-and-load "nyxt-user/search-engines"
        :depends-on (:nx-search-engines) :components ("search-engines.lisp"))
    '';

    ".config/nyxt/search-engines.lisp".source = pkgs.writeText "search-engines.lisp" ''
      (in-package #:nyxt-user)
      ;; Define buffer search-engines slot to be a list of several
      ;; nx-search-engines-provided ones.
      (define-configuration (buffer web-buffer)
        ((search-engines (list (engines:google :shortcut "gmaps"
                                              :object :maps)
                              (engines:wordnet :shortcut "wn"
                                                :show-word-frequencies t)
                              (engines:google :shortcut "g"
                                              :safe-search nil)
                              (engines:duckduckgo :theme :terminal
                                                  :help-improve-duckduckgo nil
                                                  :homepage-privacy-tips nil
                                                  :privacy-newsletter nil
                                                  :newsletter-reminders nil
                                                  :install-reminders nil
                                                  :install-duckduckgo nil)))))
    '';
    
    # nx-search-engines extension
    ".local/share/nyxt/extensions/nx-search-engines" = {
      source = pkgs.fetchFromGitHub {
        owner = "aartaka";
        repo = "nx-search-engines";
        rev = "f81f47df82f8e322f0a8919d05fc513297095a0b";
        hash = "sha256-Q+6B3lDzlhfHnS306yLh5LpxdIXESdH/Y2D3GJodbXs=";
      };
    };
  };
}
