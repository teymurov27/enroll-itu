#!/bin/bash

# Define the base URL for the API
base_url="https://kepler-beta.itu.edu.tr/api"

# Define the API endpoints
test_endpoint="/TaslakKontrolAPI/v1/"
prod_endpoint="/ders-kayit/v21/"

# Define the token
token="$token"

# Define the CRN list
crn_list=("23169" "24546")

# Function to create a JSON array from the CRN list
json_array() {
  echo -n '['
  for crn in "$@"; do
    echo -n \"${crn//\"/\\\"}\"
    [ "$crn" != "${@: -1}" ] && echo -n ', '
  done
  echo ']'
}

# Create the JSON array
arr=$(json_array "${crn_list[@]}")

# Define the URL (uncomment the one you want to use)
url="${base_url}${test_endpoint}"
# url="${base_url}${prod_endpoint}"

# Make the API request
curl -H "$token" -H "Content-Type: application/json" \
  --request POST --data-raw "{\"ECRN\": $arr, \"SCRN\":[]}"\
  $url | json_pp
