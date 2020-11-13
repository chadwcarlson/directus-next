# directus-next for Platform.sh 

This repo acts as a demo upstream for running Directus on Platform.sh. Updates to this repository will be accessible to any other project using it via Source Operations


0. Get token - ./demo/get-token.sh



1. Initialize
  - create project - `./demos/01_create.sh`
  - initialize with template
  - create `update-directus` environment

2. Do some things with Directus

3. `npm update`
  - source operation: `npm-update` (sync from master first)
  - Upon success merge on project (take a backup first)
4. Updates from upstream
  - source operation: `upstream-update` (sync from master first)
  - Upon success merge on project (take a backup first)


  in order to setup cli commands (backup, sync) - an api token would need to be provided (security concern when more access - like ssh access - is given to the customers)

  show off cron running on previously initialized environment
  customer api_url adding activity script -> provide env var, show update in slack when update is run
    - this is the question if you want to have updates be managed entirely by directus
    - or by customer (in which case during onboarding they give you a slack key to have updates in the channel)
  trigger test pipeline -> automatic merge on pass?



gatsby/next preffered front end; react?
rob note: marketing opps - DF, blog posts, template prior to white label 

environment variables:
- API_TOKEN (to run sync and backup commands in the container when cron operations are run)
- SLACK_TOKEN & channel - for notifications on diff
- UPSTREAM_REPO for source op updates

files:
- slack.js