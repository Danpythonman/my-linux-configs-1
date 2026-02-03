# My Linux Configurations

This is what I use in my Linux machines.

## Setting up a New Machine

These are the steps I take when I set up a new Linux (Debian) machine:

1. **Update and Upgrade**

    ```bash
    sudo apt update
    sudo apt upgrade
    ```

2. **Install Useful Libraries**

    ```bash
    sudo apt install -y \
        build-essential make \
        curl wget ca-certificates \
        libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev \
        libsqlite3-dev libffi-dev \
        liblzma-dev xz-utils \
        libncursesw5-dev tk-dev \
        libgdbm-dev libnss3-dev \
        uuid-dev libmpdec-dev \
        libexpat1-dev
    ```

3. **Install Git and GitHub CLI**

    ```bash
    sudo apt install git
    ```

    Then follow these instructions to install GitHub CLI: [https://github.com/cli/cli#installation](https://github.com/cli/cli#installation).

    Then authenticate GitHub CLI with:

    ```bash
    gh auth login
    ```

4. **Clone this Repository**

    ```bash
    git clone https://github.com/Danpythonman/my-linux-configs-1.git my-linux-configs
    ```

5. **(Optional if SSH is Needed) Configure SSH**

    If you need to SSH into remote or remote needs to SSH into other servers.

    1. Install SSH server on remote.

        ```bash
        sudo apt install openssh-server
        sudo systemctl enable ssh
        sudo systemctl start ssh
        ```

    2. Copy SSH public keys to remote.

        From the main PC or laptop:

        ```bash
        ssh-copy-id user@remote_host
        ```

        where `user` is the user in the new machine and `remote_host` is the hostname/IP address of the new machine.

    3. Copy SSH config from this repository into remote (be careful not to overwrite anything already there!).

        ```bash
        cat ssh/config >> ~/.ssh/config
        ```

    4. Make sure remote has its own keys:

        ```bash
        ssh-keygen
        ```

        Note that you need to get this public key (`~/.ssh/keyname.pub`) into any server that the remote needs SSH access to.

6. **Install NVM and Pyenv**

    [Node Version Manager](https://github.com/nvm-sh/nvm) is useful for managing multiple versions of Node.js and Npm. [Pyenv](https://github.com/pyenv/pyenv) does the same thing for Python. Install them from their public GitHub repositories.

    Then install the latest version of Node.js:

    ```bash
    nvm install node
    ```

    And the latest version of Python:

    ```bash
    pyenv install 3.13
    ```

7. **Install Neovim**

    If you're on Ubuntu, just use Snap. Otherwise:

    1. Make sure `/opt` exists (Neovim will go there):

        ```bash
        sudo mkdir -p /opt
        ```

    2. Install the Neovim Tarball.

        Get it from [https://github.com/neovim/neovim/releases](https://github.com/neovim/neovim/releases). For example, if installing the nightly release:

        ```bash
        curl -L -O https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-arm64.tar.gz
        ```

    3. Then extract it to `/opt/nvim`:

        ```bash
        sudo tar -xzf nvim-linux-arm64.tar.gz -C /opt
        sudo mv /opt/nvim-linux-arm64 /opt/nvim
        ```

    4. Add the Neovim binary to the path in the machine-specific bashrc:

        ```bash
        echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.bashrc.local
        ```

    5. Copy configs (from this repository):

        ```bash
        mkdir -p ~/.config/nvim
        cp -r nvim/* ~/.config/nvim
        ```

    6. Get the [Lazy](https://github.com/folke/lazy.nvim) Neovim plugin manager:

        ```bash
        git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
        ```

    7. Install plugins:

        ```bash
        nvim --headless "+Lazy! sync" +qa
        ```

8. **Install and Configure tmux**

    [tmux](https://github.com/tmux/tmux/wiki) is very useful. Install it with:

    ```bash
    sudo apt install tmux
    ```

    Copy tmux configs from this repository:

    ```bash
    cp tmux/.tmux.conf ~/.tmux.conf
    ```

9. **Set up Tailscale**

    [Tailscale](https://tailscale.com/) sets up a virtual private network so that all my devices can connect to each other easily. Very cool and user-friendly tool, should be able to install and configure from the instructions on the Tailscale website.

## Folders Overview

The following is an overview of each of the folders in this project.

### `bash/`

Contains `.bashrc`, `.bash_aliases`, and the Bash prompt I use.

### `bash-scripts/`

These are Bash scripts that I used to use a lot, but I don't use them much anymore. `print-aliases.sh` prints the aliases that I have defined, and `search.sh` searches Google from the command line, automatically opening a browser window.

### `cbwc/`

Stands for "ClipBoard Word Count". Counts the number of words in the text that is copied in the clipboard. I used this a lot when writing discussion posts in school :P.

`cbwc` is the Python file with the script, and `setup.sh` installs it.

### `dolphin/`

Contains the configs I use for the [Dolphin file manager](https://apps.kde.org/dolphin/). `dolphin.qss` turns the background dark (makeshift dark mode) and `Dolphin_icon.png` is...the Dolphin icon.

`setup.sh` installs Dolphin and KDE theme configs and edits the Dolphin desktop entry and bashrc to make dark mode work and have the proper Dolphin icon.

### `emacs/`

[Emacs](https://www.gnu.org/software/emacs/tour/) configs for when I used Emacs. But now I use Vim so....

Contains a cheat sheet in markdown (`emacs_cheat_sheet.md`) and txt (`emacs.txt`) formats, and the `init.el` that holds my Emacs configs. I also have a theme (`vscode-dark-plus-theme.el`) that comes directly from [https://github.com/ianyepan/vscode-dark-plus-emacs-theme](https://github.com/ianyepan/vscode-dark-plus-emacs-theme).

### `git/`

Contains `git-aliases`, which are the aliases I use to print Git trees nicely.

### `intellij/`

`new_ui_scheme.icls` is my color scheme for the new IntelliJ UI, and `old_ui_scheme.icls` is for the old one.

### `lines/`

Prints the lines X to Y of a given file. `lines` is the Bash script that does this, `lines.completions.sh` is the Bash autocomplete for it, and `setup.sh` installs both the script and the autocompletions.

### `nvim/`

Contains my [Neovim](https://neovim.io/) configs.

### `pdb/`

Configs for Python debugger use. Currently I'm using [pdb++](https://github.com/pdbpp/pdbpp).

I haven't used it much so it may be a bit buggy!

### `pdftools/`

My custom tools to extract pages from PDF files and merge PDF files. The source code for it is in a separate repository ([https://github.com/Danpythonman/pdfextract](https://github.com/Danpythonman/pdfextract)), and the `setup.sh` script installs it.

### `restic/`

[Restic](https://restic.readthedocs.io/en/stable/) is used to efficiently backup filesystems. It saves snapshots of files so that only updates are added after the files are initially backed up, saving a lot of space.

Read [restic/README.md](./restic/README.md) for instructions on how to set up Restic.

### `ssh/`

Contains the SSH configs that I use for various remote virtual machines and Raspberry Pis. Should be copied to `~/.ssh/config`.

### `sync/`

Rsync scripts and configs for syncing filesystems efficiently. `pc-to-backup.sh` is the big guns that syncs important directories to my external hard drive. `pc-to-shared.sh` syncs files that I use on both Ubuntu and Windows hard drives to a shared internal hard drive at `/mnt/shared/`. `rsync-exclude.txt` is an exclude file for files that don't need to be synced.

### `task/`

This contains My old syncing method for TaskWarrior. I used to have a Git repository that I would use to sync tasks between machines. But this is obsolete now because I now just invoke TaskWarrior commands on a remote single-source-of-truth server via ssh.

### `tmux/`

Contains my tmux configs (`.tmux.conf`). Should be copied to `~/.tmux.conf`.

### `vim/`

My [Vim](https://www.vim.org/) configs for when I used Vim instead of Neovim. (So, this is now obsolete since I use Neovim.) It contains my `.vimrc`, plugins (`.vimrc.plug`), and a cheat sheet (`vim_cheat_sheet.txt`) for commands I use a lot.

The Vim directory also includes a `Vimh/` subdirectory, containing a script that shows Vim command descriptions from within Vim.

### `vscode/`

`update-code` is a Bash script that updates VSCode without having to download the `.deb` file from a browser. `setup.sh` installs the script.

### `wsl/`

My old WSL configs. I just use Ubuntu now so this is kind of obsolete.
