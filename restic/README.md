# Using Restic

First, install Restic on the computer that has the files to backup:

```bash
sudo apt install restic
```

If this is a new system to back up, then you must initialize the repository. The following assumes using [Backblaze B2](https://www.backblaze.com/cloud-storage) as a cloud repository for the backup.

1. Create a bucket on B2.

2. Create application key on the bucket.

3. Save the credentials:

    ```bash
    export B2_ACCOUNT_ID="<BUCKET_KEY_ID>"
    export B2_ACCOUNT_KEY="<BUCKET_KEY>"
    ```
4. Initialize the repo:

    ```bash
    restic -r b2:<bucket-name>:<repo-name> init
    ```

    Note that `<repo-name>` can be anything, it is just a prefix in the B2 bucket.

Once the repo is initialized, you can start backing up the filesystem with the [backup-pc.sh](./backup-pc.sh) script. It already includes the directory paths that I backup on my PC.

After the system is backed up you can:

- Check to ensure the files in the repo are correct:

  ```bash
  restic -r b2:<bucket-name>:<repo-name> check
  ```

- Check the files that are present in the repo:

  ```bash
  restic -r b2:<bucket-name>:<repo-name> ls latest
  ```

- Check the snapshots that have been saved in the repo:

  ```bash
  restic -r b2:<bucket-name>:<repo-name> snapshots
  ```

To restore files:

```bash
restic restore latest \
  --target /tmp/restore-test \
  --include "/home/daniel/Documents/some-small-file.txt"
```

To do a full restore:

```bash
restic restore latest --target /tmp/full-restore
```
