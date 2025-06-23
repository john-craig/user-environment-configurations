CACHER_ID_PATH="${1:-$HOME/.ssh/cacher}"
LOCAL_CACHE_LIST_CURR=/tmp/pacman-$(date +%s)-cache-list-curr
LOCAL_CACHE_LIST_PREV=/tmp/pacman-$(date +%s)-cache-list-prev
LOCAL_CACHE_DIR=/var/cache/pacman/pkg/
REMOTE_CACHE_DIR=/var/lib/dustman/pacman/hosts/$(hostname)

if ssh -q -o BatchMode=yes -o ConnectTimeout=5 -i $CACHER_ID_PATH cacher@pxe_server true; then
  :
else
  echo "Cacher server is unreachable"
  exit 0
fi

rsync -av \
    --include='*.pkg.tar.zst' \
    --exclude='*' \
    --out-format='%n' \
    --no-perms \
    --omit-dir-times \
    $LOCAL_CACHE_DIR \
    -e 'ssh -i ~/.ssh/cacher' \
    cacher@pxe_server:/srv/cache/pacman/

ls $LOCAL_CACHE_DIR > $LOCAL_CACHE_LIST_CURR
ssh -i $CACHER_ID_PATH cacher@pxe_server "mkdir -p $REMOTE_CACHE_DIR; touch $REMOTE_CACHE_DIR/prev"

# Copy the current cache list to the remote server
scp -i $CACHER_ID_PATH $LOCAL_CACHE_LIST_CURR cacher@pxe_server:$REMOTE_CACHE_DIR/curr 2>&1 > /dev/null

# Copy the previous cache list from the remote server
scp -i $CACHER_ID_PATH cacher@pxe_server:$REMOTE_CACHE_DIR/prev $LOCAL_CACHE_LIST_PREV 2>&1 > /dev/null

# Start the dustman service on the remote server
ssh -i $CACHER_ID_PATH cacher@pxe_server "nohup dustman | logger --tag dustman"

# Compare the current and previous cache lists
NUM_CHANGED=$(diff -y --suppress-common-lines $LOCAL_CACHE_LIST_CURR $LOCAL_CACHE_LIST_PREV | wc -l)
echo "Number of changed packages: $NUM_CHANGED"

# Clean up temporary files
rm $LOCAL_CACHE_LIST_CURR
rm $LOCAL_CACHE_LIST_PREV
