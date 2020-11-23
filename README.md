Current Directus offering:

- Self-Hosted
    - Not considered part of the fleet
    - Would be the equivalent of Platform.sh’s current DoP button. Client initializes their own Directus project from a template.
- Basic
    - Is a part of a Basic fleet. Receives upstream and dependency updates.
    - No integrated repository from the client, all updates occur in Directus UI.
    - Internal limit for 10 collections/5000 items
- Standard
    - Is a part of a Standard fleet. Receives upstream and dependency updates.
    - No integrated repository from the client, all updates occur in Directus UI.
    - Internal limit for 25 collections/10000 items
- Professional
    - Is a part of a Pro fleet. Receives upstream and dependency updates.
    - No integrated repository from the client, all updates occur in Directus UI.
    - Internal limit for 50 collections/25000 items
- Enterprise
    - Is a part of a Enterprise fleet. Receives upstream and dependency updates.
    - No limit on Collections and items.
    - External integration to their own repository for project overrides by client


Demo Timeline.

So, when we last spoke I tried to convey the ways in which 

- You could use the API to manage a "Fleet" of projects. 
- This didn't seem to necessarily address your current fleet offering, or segregate between your other offerings. 

Your current offering:

- Basic/Standard/Professional: hosting, basic support, limited items & collections at tiers. No extensions available. 
- Enterprise: hosting + white-glove support. Unlimited items & collections. Extensions available, added by account manager/support staff. 

Replicating the SaaS on Platform.sh

- SaaS offering
- comprised of 2 fleets: Standard & Enterprise 
- Each project on Platform.sh 
  - uses the same "upstream", which in this case is the result of the base `yarn create directus-project`, with no custom anything defined for a specific version of directus. 
  - It contains source operations for
    - updating dependencies
    - updating the upstream. Since directus itself is a dependency. You could accomplish this easily with a updating-dependencies. Otherwise, https://platform.sh/blog/2019/website-fleet/three-ways-to-manage-a-fleet/ to pull from what we used to initialize the project. 
  - The projects in each fleet are identical, with the same upstream. 
- Simple upgrades to plan: simple as renaming to a different fleet:
  - These are identical, but equipped to have additional endpoints available for enterprise clients. (switching then would be as easy as updating the projects name to use a new prefix)

* List the fleet for standard
* List the fleet for enterprise

* Standard tier has the same source operation points available. Cron updates and merges
* Enterprise has source operation points available. Cron updates and merges. 
* Account manager can log in to Enterprise project, add custom extensions, test, and merge. 

Options for moving to PaaS - levels of Client configuration/code visiblity

- Option 1: separate config - quick preview, some work to integrate, full config repo client side
  * User supplies a remote repository in a field, used as initialization repo
  * This gets combined with a separate `config` directory, that sets everything else up for them. 
  * The project will launch, giving them a full repo they can work with. 
  * They can then clone, modify their own repo, setup the integration, and be on their way.

- Option 2: DoP button - quick demo preview, some work to integration, full config repo client side to migrate their app (migration instructions needed for data)
  * template, complete with upstreams, is given as a marketplace starter kit. 
  * After that, same as option 1. Users clone the project and set up the integration to override it. 

- Option 3: submodules to extensions directory 
  * Approached via either Option 1 or 2
  * Not a valid option without allowing client to edit config files. Config validation, then validate submodules.

- Option 4: Setting up the integration for the client
  * Problem 1: GitHub authentication
  * Problem 2: No good way to retrieve an API_token via api, which you need to get and OAuth token. 
  * That is, unless, you still want everything to be under a Directus account, under a "Self-service" fleet. Here the client is in charge of everything to do with 
  their configuration post-initial install AND they don't get the benefit of viewing project-level variables in management console. 
  * Is there a way to use Augustins Registry checker to at least give self-service clients a notification that their configuration is out of date? Like a deployment-checker submodule?
  * This couldn't be the main configuration, BUT it could simply be a checker that notified the user that the upstream configuration had changed and to update it. 

- Option 5: Tier-based upstream scripts (i.e. definining builds, deploys, and source operations from the upstream)
  * Clients get an error if the empty scripts are missing. 
  * Can be initialized at build time specific to the tier, customizable by the upstream, yet not visible to the client. 


https://next.docs.directus.io/reference/environment-variables.html#database


# directus-next for Platform.sh 


In reality, this needs to be 

1) split off into its own repository 
2) needs to support a full-service (no external integration) and enterprise (white glove w/ development access via integrations)
3) tests
4) control.

Managing multiple fleets at different "tiers":
  - no integrated repository 
  - enterprise with integrated repository


This repo acts as a demo upstream for running Directus on Platform.sh. Updates to this repository will be accessible to any other project using it via Source Operations



- Resources:

  - They had mentioned having control over individual projects
  - API Docs
  - Direct to the POC demo
  - within there is a subdir called `demo` with a script called `fleet.sh` -> contains all the API calls to manage a group of projects


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