{ config, pkgs, lib, ... }: {
  home.packages = [

  ];

  # Idle detection and tracking
  services.hypridle.settings.listener = (let
    timeoutScript = (pkgs.writeScriptBin "onIdleTimeout" ''
      #!/bin/sh
      
    '');
    resumeScript = (pkgs.writeScriptBin "onIdleResume" ''
      #!/bin/sh
      
    '');
    idleTimeout = 300; # 5 minutes
  in [ {
      timeout = idleTimeout;
      on-timeout = "${timeoutScript}/bin/onIdleTimeout";
      on-resume = "${resumeScript}/bin/onIdleResume";
    } ]);
}
