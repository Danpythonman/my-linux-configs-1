#!/bin/bash

# Opens a browser window to a Google search results page given the
# search query provided.
#
# The `BROWSER` environment variable must be set (so that the
# `sensible-browser` command used below can properly open the browser
# window).

if [ -z "$*" ]; then
	# Make sure a search query was provided
	echo 'search: please provide a search term'
	echo 'Try search --help for more information.'

	exit 1

elif [ "x$*" == "x--help" -o "x$*" == "x-h" ]; then
	# Check if help flag was raised.
	# The "x" in the conditional statements are to handle
	# undefined strings.
	echo 'Usage: search SEARCH-QUERY'
	echo 'Opens a browser window to a Google search results page for the given search query.'
	echo ''
	echo 'The SEARCH-QUERY argument should be exactly like a search query you would enter into Google Search.'
	echo ''
	echo 'Note that the `BROWSER` environment variable must be set so that the browser can be opened. This command makes use of the `sensible-browser` command, so `sensible-browser` must be installed for the browser window to open.'
	echo ''
	echo 'Example usage:'
	echo ' search how to exit vim'
	echo ' search "what is a segmentation fault"'
	echo ''
	echo 'Exit status:'
	echo ' 0 if OK'
	echo ' 1 if error (like if no search query was provided)'

	exit 0;
fi

base_url='https://www.google.com/search'

# Convert query into Google search URL (spaces replaced with plus signs)
url_query="?q=`sed 's/\s\+/+/g' <<< $*`"

search_url="$base_url$url_query"

# Open browser to search results page
sensible-browser "$search_url"
