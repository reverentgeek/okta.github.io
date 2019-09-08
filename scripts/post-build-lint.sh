#!/bin/bash

source "${0%/*}/helpers.sh"

if ! removeHTMLExtensions;
then
    echo "Failed removing .html extensions"
    exit 1;
else
    echo -e "\xE2\x9C\x94 Removed .html extensions and setup redirects"
fi
