#!/bin/bash

###############################################################################
# LINT
###############################################################################
export GENERATED_SITE_LOCATION="dist"

###############################################################################
# SETUP
###############################################################################

# Print an easily visible line, useful for log files.
function interject() {
    echo "----- ${1} -----"
}

function check_for_npm_dependencies() {
    interject 'Checking NPM dependencies'
    command -v npm > /dev/null 2>&1 || { echo "This script requires 'npm', which is not installed"; exit 1; }
    npm install
    interject 'Done checking NPM dependencies'
}

function generate_html() {
    interject 'Using Jekyll to generate HTML'

    if [ ! -d $GENERATED_SITE_LOCATION ]; then
        check_for_npm_dependencies
        bundle exec jekyll build
        local status=$?
        interject 'Done generating HTML'
        return $status
    else
        interject 'HTML already generated'
        return 0
    fi
}

function generate_conductor_file() {
    pushd $GENERATED_SITE_LOCATION
    CONDUCTOR_FILE=conductor.yml
    find -type f -iname 'index.html' | xargs dirname | sed -s "s/^\.//" | while read -r line ; do
        if [ ! -z "${line}" ]; then
            echo "  - from: ${line}" >> ${CONDUCTOR_FILE}
            echo "    to: ${line}/" >> ${CONDUCTOR_FILE}
        fi
    done
    popd
}

function require_env_var() {
    local env_var_name=$1
    eval env_var=\$$env_var_name
    if [[ -z "${env_var}" ]]; then
        echo "Environment variable '${env_var_name}' must be defined, but isn't.";
        exit 1
    fi
}

function fold() {
    local name=$1
    local command="${@:2}"
    echo -en "travis_fold:start:${name}\\r"
    echo "\$ ${command}"
    ${command}
    echo -en "travis_fold:end:${name}\\r"
}

function send_promotion_message() {
    curl -H "Authorization: Bearer ${TESTSERVICE_SLAVE_JWT}" \
      -H "Content-Type: application/json" \
      -X POST -d "[{\"artifactId\":\"$1\",\"repository\":\"npm-okta\",\"artifact\":\"$2\",\"version\":\"$3\",\"promotionType\":\"ARTIFACT\"}]" \
      -k "${APERTURE_BASE_URL}/v1/artifact-promotion/createPromotionEvent"
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
