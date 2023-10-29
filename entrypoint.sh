#!/bin/sh

set -e

######## Check for required/optional inputs. ########

# Check if the Api Token is set.
if [ -z "$DEPLOYBOT_API_TOKEN" ]; then
  echo "DEPLOYBOT_API_TOKEN is not set. Quitting."
  exit 1
fi

# Check if DeployBot subdomain is set.
if [ -z "$DEPLOYBOT_SUBDOMAIN" ]; then
  echo "DEPLOYBOT_SUBDOMAIN is not set. Quitting."
  exit 1
fi

# Check if Environment ID is set.
if [ -z "$ENVIRONMENT_ID" ]; then
  echo "ENVIRONMENT_ID is not set. Quitting."
  exit 1
fi

# Check if Deploy From Scratch is set.
if [ -z "$DEPLOY_FROM_SCRATCH" ]; then
  echo "$DEPLOY_FROM_SCRATCH is not set. Setting to false."
  DEPLOY_FROM_SCRATCH='false'
fi

# Check if Trigger Notifications is set.
if [ -z "$TRIGGER_NOTIFICATIONS" ]; then
  echo "$TRIGGER_NOTIFICATIONS is not set. Setting to true."
  TRIGGER_NOTIFICATIONS='true'
fi

set -- --data '{"environment_id":'"${PURGE_URLS}"',"deploy_from_scratch":'"${DEPLOY_FROM_SCRATCH}"',"trigger_notifications":'"${TRIGGER_NOTIFICATIONS}"',"comment":"Deploy via Github Action"}'

######## Call the API and store the response for later. ########
# API docs: https://deploybot.com/api/deployments#trigger-deployment
HTTP_RESPONSE=$(curl -sS "https://${DEPLOYBOT_SUBDOMAIN}.deploybot.com/api/v1/deployments" \
                    -H "Content-Type: application/json" \
                    -H "X-Api-Token: ${DEPLOYBOT_API_TOKEN}" \
                    -w "HTTP_STATUS:%{http_code}" \
                    "$@")

######## Format response for a pretty command line output. ########

# Store result and HTTP status code separately to appropriately throw CI errors.
# https://gist.github.com/maxcnunes/9f77afdc32df354883df
HTTP_BODY=$(echo "${HTTP_RESPONSE}" | sed -E 's/HTTP_STATUS\:[0-9]{3}$//')
HTTP_STATUS=$(echo "${HTTP_RESPONSE}" | tr -d '\n' | sed -E 's/.*HTTP_STATUS:([0-9]{3})$/\1/')

# Fail pipeline and print errors if API doesn't return an OK status.
if [ "${HTTP_STATUS}" -eq "200" ]; then
  echo "Successfully triggered deployment on DeployBot!"
  echo "${HTTP_BODY}"
  exit 0
else
  echo "Trigger deployment failed. API response was: "
  echo "${HTTP_BODY}"
  exit 1
fi