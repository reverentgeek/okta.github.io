#!/bin/bash

source "${0%/*}/helpers.sh"

if ! duplicate_slug_in_url ;
then
    echo "Duplicate slugs: /api/v1 exist"
    exit 1
else
    echo -e "\xE2\x9C\x94 Passed duplicate slug checker"
fi

if ! removeHTMLExtensions;
then
    echo "Failed removing .html extensions"
    exit 1;
else
    echo -e "\xE2\x9C\x94 Removed .html extensions and setup redirects"
fi
