#!/bin/bash

###############################################################################
# LINT
###############################################################################
export GENERATED_SITE_LOCATION="dist"

###############################################################################
# SETUP
###############################################################################

function generate_html() {
    echo 'Using Jekyll to generate HTML'

    if [ ! -d $GENERATED_SITE_LOCATION ]; then
        bundle exec jekyll build
        local status=$?
        echo 'Done generating HTML'
        return $status
    else
        echo 'HTML already generated'
        return 0
    fi
}

function removeHTMLExtensions() {
    # Removing all generated .html files (excludes the main 'index.html' in the dir) and
    # create 302 redirects to extensionless pages
    find ./dist -type f ! -iname 'index.html' -name '*.html' -print0 | while read -d $'\0' f
    do

        if [ -e `echo ${f%.html}` ] ;
        then
            # Skip if files have already been updated
            continue;
        fi
        cp "$f" "${f%.html}";
        path=`echo ${f%.html} | sed "s/.\/dist//g"`
        sed "s+{{ page.redirect.to | remove: 'index' }}+$path+g" ./_source/_layouts/redirect.html > $f
    done
}
