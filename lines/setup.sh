#!/bin/bash

# Sets up the lines tool so that it can be executed from any location.

# Copy lines to /usr/local/bin/
sudo cp lines/lines /usr/local/bin

# Make lines executable
sudo chmod +x /usr/local/bin/lines

# Copy completion to Bash completions directory
cp lines/lines.completion.sh /etc/bash_completion.d
