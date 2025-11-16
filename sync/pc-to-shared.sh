rsync \
    -avh \
    --delete \
    --exclude-from=rsync-exclude.txt \
    ~/York \
    /mnt/shared/

rsync \
    -avh \
    --delete \
    --exclude-from=rsync-exclude.txt \
    ~/Programming \
    /mnt/shared/

rsync \
    -avh \
    --delete \
    --exclude-from=rsync-exclude.txt \
    ~/Resume \
    /mnt/shared/
