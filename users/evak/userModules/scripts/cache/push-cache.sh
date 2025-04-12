#!/bin/bash
LOCAL_CACHE_LIST=/tmp/pacman-$(date +%s)-cache-list
LOCAL_CACHE_DIR=/var/cache/pacman/pkg/
REMOTE_CACHE_DIR=/var/lib/dustman/pacman/hosts/$(hostname)


rsync -av --include='*.pkg.tar.zst' --exclude='*' --out-format='%n' $LOCAL_CACHE_DIR -e 'ssh -i ~/.ssh/cacher' cacher@pxe_server:/srv/cache/pacman/

ls $LOCAL_CACHE_DIR > $LOCAL_CACHE_LIST
ssh -i ~/.ssh/cacher cacher@pxe_server "mkdir -p $REMOTE_CACHE_DIR"
scp -i ~/.ssh/cacher $LOCAL_CACHE_LIST cacher@pxe_server:$REMOTE_CACHE_DIR/curr

rm $LOCAL_CACHE_LIST
