{ config, pkgs, lib, ... }:
{
  home.activation.pushCache =
    let
      cacherIdentityFile = "~/.ssh/cacher";
      cacheServer = "192.168.1.5";
      cacheURL = "cache.nix.chiliahedron.wtf";
      cacheDir = "/srv/cache/nix";  
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH=$PATH:/usr/bin
      LOCAL_CACHE_LIST_CURR=/tmp/pacman-$(date +%s)-cache-list-curr
      LOCAL_CACHE_LIST_PREV=/tmp/pacman-$(date +%s)-cache-list-prev
      REMOTE_CACHE_DIR=/var/lib/dustman/nix/hosts/$(hostname)

      if ssh -q -o BatchMode=yes -o ConnectTimeout=5 -i ${cacherIdentityFile} cacher@pxe_server true; then
        :
      else
        echo "Cacher server is unreachable"
        exit 0
      fi

      NIX_SSHOPTS="-i ${cacherIdentityFile}" \
      nix copy --substitute-on-destination \
        --no-check-sigs \
        --to https://${cacheURL} \
        ~/.local/state/home-manager/gcroots/current-home
    
      nix path-info --recursive ~/.local/state/home-manager/gcroots/current-home > $LOCAL_CACHE_LIST_CURR
      
      ssh -i ${cacherIdentityFile} \
        cacher@${cacheServer} \
        "mkdir -p $REMOTE_CACHE_DIR"
      
      scp -q -i ${cacherIdentityFile} \
        $LOCAL_CACHE_LIST_CURR \
        cacher@${cacheServer}:$REMOTE_CACHE_DIR/curr
    
      scp -q -i ${cacherIdentityFile} \
        cacher@${cacheServer}:$REMOTE_CACHE_DIR/prev \
        $LOCAL_CACHE_LIST_PREV

      ssh -i ${cacherIdentityFile} cacher@${cacheServer} "nohup dustman 2>&1 | logger --tag 'dustman'"
      
      NUM_CHANGED=$(diff -y --suppress-common-lines $LOCAL_CACHE_LIST_CURR $LOCAL_CACHE_LIST_PREV | wc -l)
      echo "Number of changed packages: $NUM_CHANGED"
      
      rm -f $LOCAL_CACHE_LIST_CURR
      rm -f $LOCAL_CACHE_LIST_PREV
    '';

  home.packages = [
    # Archlinux cache script
    (pkgs.writeShellScriptBin "push-arch-cache"
      (builtins.readFile ./push-arch-cache.sh))
  ];
}
