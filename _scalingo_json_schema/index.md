---
title: scalingo.json Schema
layout: default
---

# scalingo.json Schema

`scalingo.json` is a deployment manifest to let people deploy their software
super easily. This document describe its schema in detail.

--- row ---

## The manifest

This document describes how to write a JSON manifest file which
will be interpreted by our platform when someone wants to deploy a project.
The file must be located at the root of the project and be named either `app.json`
or `scalingo.json`. The latter will always take priority over the first one.

--- row ---

**The manifest attributes**

{:.table}
| field                       | type   | description                                    |
| --------------------------- | ------ | ---------------------------------------------- |
| _name_                      | string | Complete name of the project                   |
| _repository_                | string | Location of the GIT repository of the project  |
| _ref_                       | string | Branch name or commit ID of the code to use    |
| _stack_                     | string | Name of the stack to use                       |
| _description_               | string | Description in one or two sentences of the app |
| _logo_                      | string | URL to the logo of the project                 |
| _website_                   | string | Official website of the application if any     |
| _copy_parent_database_urls_ | bool   | Copy database credentials from parent app      |
| _env_                       | object | Environment of the application, see below      |
| _addons_                    | array  | List of all the addons required to run the app |
| _scripts_                   | object | Optional hook scripts, see below               |
| _formation_                 | object | Formation of containers when an app is created |

Optional arguments are in italics.

**Environment**

The keys of the environment object are the name of the variables you want to
add.

{:.table}
| field          | type   | description                                       |
| -------------- | ------ | ------------------------------------------------- |
| `VAR_NAME`     | string | key of the object is the name of the env variable |

Each of these keys has to respect the following properties:

{:.table}
| field          | type   | description                                                           |
| -------------- | ------ | --------------------------------------------------------------------- |
| description    | string | Description of the variable to explain what it does                   |
| value          | string | (if no generator) Default value of the variable                       |
| generator      | string | (if no value) Use a generator to define a default value               |
| template       | string | (if generator is 'url' or 'template') Template to generate value from |

_Note: supplying `null` or an empty string to `value` will remove the variable from the environment. It can be used to delete environment variables present in the parent app._

Three generators are available `secret`, `template` or `url`:

* `secret`: will generate a unique token as a default value of the variable.
  (Useful for instance when you've to generate a unique encryption seed key),
  example: `90ffea2d3071e8d86cafb89ff5060883`

* `template`: will generate an environment variable based on the content of the
  content of the `template` field, the following tokens will be substituted dynamically
  by the expected values when surrounded by `%`:

  * `APP`
  * `PARENT_APP`
  * `PR_NUMBER`

  Example: If the review app being deployed is `my-app-pr10`:

  * `Pull Request Number %PR_NUMBER%` -> `Pull Request Number 10`

* `url`: will automatically insert the URL of the application will have once
  deployed. When this generator is used, the `template` property is taken into
  account, the token `%URL%` can be used to be replaced by the futur app URL.

||| col |||

scalingo.json example

```json
{
  "name": "Sample Go Martini",
  "stack": "scalingo-18",
  "description": "Sample web application using the Go framework Martini",
  "logo": "https://scalingo.com/logo.svg",
  "repository": "https://github.com/Scalingo/sample-go-martini",
  "website": "https://scalingo.com",
  "env": {
    "VAR_TEST_1": {
      "description": "test variable number 1",
      "value": "1"
    },
    "VAR_SECRET_1": {
      "description": "generated variable 1",
      "generator": "secret"
    },
    "PUBLIC_URL": {
      "description": "URL of the application",
      "generator": "url"
    },
    "ADMIN_URL": {
      "description": "Admin URL of the application",
      "generator": "url",
      "template": "%URL%/admin"
    }
  },
  "addons": [
    {
      "plan": "mongodb:mongo-starter-256",
      "options": {
        "version": "4.0.16-1"
      }
    }
  ],
  "scripts": {
    "first-deploy": "echo 'first deployment'",
    "postdeploy": "echo hello"
  },
  "formation": {
    "web": {
      "amount": 1,
      "size": "S"
    },
    "other": {
      "amount": 1,
      "size": "S"
    }
  }
}
```

--- row ---

**Addons**

If no `addons` key is specified, the default behaviour is to duplicate the
addons from the parent application.

The _addons_ field contains an array of object describing the addons you need to
deploy for your review app. The object must have the following properties:

{:.table}
| field    | type   | description                           |
| -------- | ------ | ------------------------------------- |
| plan     | string | Plan of the addon of the review app   |
| options  | object | Various options regarding the addon   |

The `plan` uses the format `addon-name:plan-id`. E.g.
`mongodb:mongo-starter-256` or `redis:redis-sandbox`.

The only `options` field is `version` which contains the version to deploy (e.g.
`4.0.16-1`).

--- row ---

**Formation**

The formation is the definition of the container which will be started once the
application is deployed. (Either coming from a one-click deployment button, or
a review app from the github integration)

It should be a map of container type definitions, the key should be the type name
and the value should have the following structure:

{:.table}
| field    | type    | description                                                            |
| -------- | ------- | ---------------------------------------------------------------------- |
| amount   | integer | Number of containers to start once the application is deployed         |
| size     | string  | Container size `name` ([get the list of sizes](/container-sizes.html)) |

Get the default list of sizes on the <a target="_blank" href="https://scalingo.com/pricing">pricing page</a>.

||| col |||

Example:

```json
{
  "formation": {
    "web": {
      "amount": 2,
      "size": "L"
    },
    "worker": {
      "amount": 1,
      "size": "XL"
    }
  }
}
```

--- row ---

**Scripts**

> The `scripts.postdeploy` key is now deprecated in favor of postdeploy hook in the `Procfile`. More information
> on the [dedicated page](https://doc.scalingo.com/platform/app/postdeploy-hook).

{:.table}
| field          | type   | description                                                                                     |
| -------------- | ------ | ----------------------------------------------------------------------------------------------- |
| postdeploy     | string | Command and arguments of the script you want to execute after each deployment.                  |
| first-deploy   | string | Job to run as postdelpoy hook at the first deployment of a reivew app or one-click deployed app |

You can get more information on this feature on the [dedicated page](https://doc.scalingo.com/platform/app/postdeploy-hook#workflow).

## Example

This example comes from a concrete project located [on Github](https://github.com/Scalingo/sample-go-martini/tree/dev-oneclick).

With the `scalingo.json` in the above-mentioned project, the example will:

* Define the name of the project.
* Describe in a sentence the purpose of the project.
* Location of the logo.
* URL of the GIT repository.
* Official website of the project.
* List of the environment variables with their description and optional generator `VAR_TEST_1` and `VAR_SECRET_1`.
These environment variables will be available for your application.
* Ask for the provisioning of a Redis addon.
* Execute the provided script after the container booted.
