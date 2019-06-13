#!/bin/bash

DEPLOY_BRANCH="source"
TARGET_S3_BUCKET="s3://developer.okta.com-production"

source "${0%/*}/setup.sh"
source "${0%/*}/helpers.sh"

# Get the Runscope trigger ID
get_secret prod/tokens/runscope_trigger_id RUNSCOPE_TRIGGER_ID

interject "Building HTML in $(pwd)"
if ! generate_html;
then
    echo "Error building site"
    exit ${BUILD_FAILURE}
fi

# Run markdown lint checker
if ! npm run markdown-lint;
then
    echo "Failed markdown lint"
    exit ${BUILD_FAILURE}
fi

# Run /dist lint checker
if ! npm run post-build-lint;
then
    echo "Failed post-build-lint"
    exit ${BUILD_FAILURE}
fi

# ----- Start (Permanent) Deploy to S3 -----
if [[ "${TRAVIS_BRANCH}" == "${DEPLOY_BRANCH}" ]]; then
    interject "Uploading HTML from '${GENERATED_SITE_LOCATION}' to '${TARGET_S3_BUCKET}'"
    if ! ./scripts/publish-s3.sh; then
        echo "Error uploading HTML to S3"
        exit ${BUILD_FAILURE}
    fi
fi
# ----- End (Permanent) Deploy to S3 -----

# Trigger Runscope tests
if [[ "${TRAVIS_BRANCH}" == "${DEPLOY_BRANCH}" ]]; then
    STAGING_BASE_URL_RUNSCOPE="https://developer.trexcloud.com"
else
    STAGING_BASE_URL_RUNSCOPE="https://developer.okta.com"
fi

curl -I -X GET "https://api.runscope.com/radar/bucket/${RUNSCOPE_TRIGGER_ID}/trigger?base_url=${STAGING_BASE_URL_RUNSCOPE}"

exit ${SUCCESS}
