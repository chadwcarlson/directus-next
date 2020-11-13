# Platform.sh API Fleet Demo

## Requirements

- An API token, which can be [created from your Platform.sh account settings](https://docs.platform.sh/development/cli/api-tokens.html#obtaining-a-token), copied into a local file called `token`. This file will not be committed.
- [`jq`](https://stedolan.github.io/jq/download/)

## Purpose

This demo wraps around the Platform.sh API to manage a fleet of projects more easily. Here, a "fleet" is defined by an upstream repository, it's profile name, and the prefix string that each project on Platform.sh will have as the first part of its `project_title`. In this way, it could very well be modified to allow you to manage multiple fleets, but it is a simple "one fleet demo" for now. 

All of the above attributes are defined in `config.json`.

```json
// config.json
{
    "region": "us-4.platform.sh",
    "plan": "development",
    "project_prefix": "Directus demo | ",
    "upstream": {
        "repository": "https://github.com/chadwcarlson/directus-next.git",
        "profile": "Directus Demo"
    },
    "activity_scripts": [
        "slack.js"
    ],
    "updates": {
        "environment_name": "directus-updates",
        "title": "Directus updates"
    }
}
```

## Using the demo

### Getting started

- First, retrieve an API Token [from your Platform.sh account settings](https://docs.platform.sh/development/cli/api-tokens.html#obtaining-a-token). Copy and paste that token into a file called `demo/token`. This file is not committed, but the key will be used in multiple places across the demo. 
- Take a look at `config.json`. This object controls how each new project in the fleet will be initialized. 
- Run `./fleet.sh list`. You should see no projects in your fleet. 

### Setting up projects in the fleet

- Run `./fleet.sh new "Client 1"` to create a project in the fleet. This will only take a moment. 
- Run `./fleet.sh list`. You should now see the project listed for your fleet. Visit the management console url listed for that command. 
- Run `./fleet.sh init SUBSCRIPTIONID`. Initialize Master environment on the current project with the upstream repository and profile name.
- Run `./fleet.sh initVars SUBSCRIPTIONID`. Initialize *project*-wide environment variables according to the fleet configuration.
- Run `./fleet.sh redeploy SUBCRIPTIONID`. This will redeploy the Master environment, giving you a freshly initialized project now with access to fleet.
- Run `./fleet.sh createUpdatesBranch SUBSCRIPTIONID`. This sets up a dedicated branch for dependency and upstream updates on the project.

> **Note:** 
>
> Repeat the steps above for each additional project you want to add to the fleet.

## Goals

## Features

- Source Operations
- Activity scripts (slack.js)
- crons

## Limitations

### Project ownership and client customization

In this demo, *your* API token is used to create new projects, and by default those projects will be created on your account (rather than, say, a client's account). In order to enable source operations (which contain CLI commands to sync data & code or take backups prior to the main operation itself), *your* API token is added as an environment variable at the project level. This combination of choices covers a "fully managed" fleet use case, where clients manage their API entirely through the UI, and do not have a separate repository that they push updates to, nor are they assumed to have access to the project via the management console or through SSH.  

### A backend without a frontend

In this demo, the upstream repository is a simple, single application Directus site. That is, it's only the backend API. 

## API

Running `./fleet.sh`:

- `list`: Lists all projects in the fleet.
- `new PROJECT_TITLE`: Will create a new project with the name `Directus | PROJECT_TITLE`.
- `delete SUBSCRIPTION_ID`: Deletes project from the fleet, first providing a list to retrieve `SUBSCRIPTION_ID`.
- `init SUBSCRIPTION_ID`: Initializes project with "Fleet template", first providing a list to retrieve `SUBSCRIPTION_ID`.
- `initVars SUBSCRIPTION_ID`: Adds fleet environment variables to a project.
- `redeploy SUBSCRIPTION_ID`: Saves changes from the initialization steps, completing a new running project.


