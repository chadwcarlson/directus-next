#!/usr/bin/env bash

curl -X POST \
    -H 'Content-Type: application/json' \
    -d '{
        "client_id": "platform-api-user",
        "grant_type": "api_token",
        "api_token": "API_TOKEN"
    }' \
    https://accounts.platform.sh/oauth2/token