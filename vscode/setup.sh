#!/bin/bash

# Sets up the VSCode updater tool so that it can be executed from any location.

# Copy update-code to /usr/local/bin/
sudo cp vscode/update-code /usr/local/bin

# Make update-code executable
sudo chmod +x /usr/local/bin/update-code

