CACHER_ID_PATH="${1:-$HOME/.ssh/cacher}"
LOCAL_CACHE_LIST=/tmp/pacman-$(date +%s)-cache-list
LOCAL_CACHE_DIR=/var/cache/pacman/pkg/
REMOTE_CACHE_DIR=/var/lib/dustman/pacman/hosts/$(hostname)

rsync -av \
    --include='*.pkg.tar.zst' \
    --exclude='*' \
    --out-format='%n' \
    --no-perms \
    --omit-dir-times \
    $LOCAL_CACHE_DIR \
    -e 'ssh -i ~/.ssh/cacher' \
    cacher@pxe_server:/srv/cache/pacman/

ls $LOCAL_CACHE_DIR > $LOCAL_CACHE_LIST
ssh -i $CACHER_ID_PATH cacher@pxe_server "mkdir -p $REMOTE_CACHE_DIR"
scp -i $CACHER_ID_PATH $LOCAL_CACHE_LIST cacher@pxe_server:$REMOTE_CACHE_DIR/curr

rm $LOCAL_CACHE_LIST
