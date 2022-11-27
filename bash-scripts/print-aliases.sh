#!/bin/bash

echo 'My Aliases'
echo '=========='

echo 'My aliases with a short description of each one.'

echo ''

# Viewing and editing my aliases (this file)
echo '.bash_aliases file'
echo '------------------'
#alias myaliases="cat ~/.bash_aliases"
echo 'myaliases           view the contents of the .bash_aliases file'
#alias myaliases-edit="vim ~/.bash_aliases"
echo 'myaliases-edit      edit the .bash_aliases file'

echo ''

# Navigating to important Windows directories
echo 'Important Windows directories'
echo '-----------------------------'
#alias winhome="cd /mnt/c/Users/Daniel"
echo 'winhome             navigate to Windows home directory (/mnt/c/Users/Daniel/)'
#alias winc="cd /mnt/c"
echo 'winc                navigate the Windows C drive (/mnt/c/)'
#alias windocs="cd /mnt/c/Users/Daniel/Documents"
echo 'windocs             naviagte to the Windows documents directory (/mnt/c/Users/Daniel/Docmuents/)'
#alias windocuments="cd /mnt/c/Users/Daniel/Documents"
echo 'windocuments        naviagte to the Windows documents directory (/mnt/c/Users/Daniel/Docmuents/)'
#alias winprog="cd /mnt/c/Users/Daniel/Documents/Programming"
echo 'winprog             navigate to the programming directory (in Windows) (/mnt/c/Users/Daniel/Documents/Programming/)'
#alias windown="cd /mnt/c/Users/Daniel/Downloads"
echo 'windown             navigate to the Windows downloads directory (/mnt/c/Users/Daniel/Downloads/)'
#alias windownloads="cd /mnt/c/Users/Daniel/Downloads"
echo 'windownloads        navigate to the Windows downloads directory (/mnt/c/Users/Daniel/Downloads/)'

echo ''

# Open Google Chrome.
echo 'Google Chrome'
echo '-------------'
# Only works when BROWSER environment variable is set to the location
# of Google Chrome, which is:
# /mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe
#alias chrome="sensible-browser"
echo 'chrome              opens a broswer window (can also provide a URL to open the browser to a specific page) (this is just an alias for the `sensible-browser` command)'

echo ''

# Navigating to and viewing the location of the directory where my
# scripts are stored.
echo 'My bash scripts'
echo '---------------'
#alias myscripts="cd /usr/local/bin"
echo 'myscripts           navigate to the location of my bash scripts (/usr/local/bin/)'
#alias myscripts-location="echo /usr/local/bin/"
echo 'myscripts-location  print the location of my bash scripts (/usr/local/bin/)'

