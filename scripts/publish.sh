#!/bin/bash

DEPLOY_BRANCH="weekly"
DEPLOY_ENVIRONMENT=""
TARGET_S3_BUCKET="s3://developer.okta.com-production"

declare -A branch_environment_map
branch_environment_map[source]=developer-okta-com-prod
branch_environment_map[weekly]=developer-okta-com-preprod

source "${0%/*}/setup.sh"
source "${0%/*}/helpers.sh"

require_env_var "OKTA_HOME"
require_env_var "BRANCH"
require_env_var "REPO"

# Get the Runscope trigger ID
get_secret prod/tokens/runscope_trigger_id RUNSCOPE_TRIGGER_ID

export TEST_SUITE_TYPE="build"

# `cd` to the path where Okta's build system has this repository
cd ${OKTA_HOME}/${REPO}

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

# Check if we are in one of our publish branches
if [[ -z "${branch_environment_map[$BRANCH]+unset}" ]]; then
    echo "Current branch is not a publish branch"
    exit ${SUCCESS}
else
    DEPLOY_ENVIRONMENT=${branch_environment_map[$BRANCH]}
fi

interject "Generating conductor file in $(pwd)"
if ! generate_conductor_file; then
    echo "Error generating conductor file"
    exit ${BUILD_FAILURE}
fi

# ----- Start (Permanent) Deploy to S3 -----
if [[ "${BRANCH}" == "${DEPLOY_BRANCH}" ]]; then
    interject "Uploading HTML from '${GENERATED_SITE_LOCATION}' to '${TARGET_S3_BUCKET}'"
    if ! ./scripts/publish-s3.sh; then
        echo "Error uploading HTML to S3"
        exit ${BUILD_FAILURE}
    fi
fi
# ----- End (Permanent) Deploy to S3 -----

# Trigger Runscope tests
if [[ "${BRANCH}" == "${DEPLOY_BRANCH}" ]]; then
    STAGING_BASE_URL_RUNSCOPE="https://developer.trexcloud.com"
else
    STAGING_BASE_URL_RUNSCOPE="https://developer.okta.com"
fi

curl -I -X GET "https://api.runscope.com/radar/bucket/${RUNSCOPE_TRIGGER_ID}/trigger?base_url=${STAGING_BASE_URL_RUNSCOPE}"

exit ${SUCCESS}
