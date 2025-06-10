{ config, pkgs, lib, ... }:
{
  home.activation.pushCache =
    let
      cacherIdentityFile = "~/.ssh/cacher";
      cacheServer = "192.168.1.5";
      cacheURL = "cache.nix.chiliahedron.wtf";
      cacheDir = "/srv/cache/nix";  
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      LOCAL_CACHE_LIST=/tmp/nix-$(date +%s)-cache-list
      REMOTE_CACHE_DIR=/var/lib/dustman/nix/hosts/$(/usr/bin/hostname)

      NIX_SSHOPTS="-i ${cacherIdentityFile}" \
      /usr/bin/nix copy --substitute-on-destination \
        --no-check-sigs \
        --to https://${cacheURL} \
        ~/.local/state/home-manager/gcroots/current-home
    
      /usr/bin/nix path-info --recursive ~/.local/state/home-manager/gcroots/current-home > $LOCAL_CACHE_LIST
      /usr/bin/ssh -i ${cacherIdentityFile} \
        cacher@${cacheServer} \
        "mkdir -p $REMOTE_CACHE_DIR"
      /usr/bin/scp -i ${cacherIdentityFile} \
        $LOCAL_CACHE_LIST \
        cacher@${cacheServer}:$REMOTE_CACHE_DIR/curr
    
      rm $LOCAL_CACHE_LIST
      /usr/bin/ssh -i ${cacherIdentityFile} cacher@${cacheServer} "nohup dustman 2>&1 | logger --tag 'dustman'"
    '';

  home.packages = [
    # Archlinux cache script
    (pkgs.writeShellScriptBin "push-arch-cache"
      (builtins.readFile ./push-arch-cache.sh))
  ];
}
