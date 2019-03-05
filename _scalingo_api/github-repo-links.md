# Github Repo Links

--- row ---

**Github Repo Link attributes**

{:.table}
| field                        | type    | desc                                                                                      |
| -----                        | -----   | -----                                                                                     |
| id                           | string  | unique ID                                                                                 |
| linker                       | object  | description of the user that linked this repository                                       |
| created_at                   | date    | creation data of the repo link                                                            |
| updated_at                   | date    | last time the github repo link was updated                                                |
| github_source                | string  | Github repositoy linked to this application                                               |
| github_branch                | string  | Github branch used for auto deployment                                                    |
| auto_deploy_enabled          | boolean | Trigger a new deployment when the linked branch is updated                                |
| deploy_review_apps_enabled   | boolean | activation of the review app feature                                                      |
| delete_on_close_enabled      | boolean | Review App: Delete the review app when the PR is closed                                   |
| hours_before_delete_on_close | int     | Review App: Time to wait before deleting a review app linked to a closed PR (in hours)    |
| delete_stale_enabled         | boolean | Review App: Delete the review app when there is no activity on the PR                     |
| hours_before_delete_stale    | int     | Review App: Time to wait for activity on the PR before deleting the review app (in hours) |
| last_auto_deploy_at          | date    | Date of the last deployment triggered by this repo link                                   |


||| col |||

Example object:

```json
{
  "id":"1d6e59a0-5377-11e8-90e6-0242ac110052",
  "linker": {
    "id":"us-aa263090-9a23-81f5-8c7c-5fd9a50a8fa8"
    "username":"john",
    "email":"john.doe@example.com",
  },
  "created_at":"2018-05-09T12:52:49.985+02:00",
  "updated_at":"2018-05-30T17:42:03.386+02:00",
  "github_source":"https://github.com/Scalingo/sample-go-martini",
  "github_branch":"master",
  "auto_deploy_enabled": true,
  "deploy_review_apps_enabled":true,
  "delete_on_close_enabled":true,
  "hours_before_delete_on_close":0,
  "delete_stale_enabled":false,
  "hours_before_delete_stale":0,
  "last_auto_deploy_at":"2018-05-30T17:42:03.385+02:00"
}
```

--- row ---

## Create a github repo link

--- row ---

`POST https://api.scalingo.com/v1/apps/:app_id/github_repo_links`

### Parameters

* `github_repo_link.github_source` - required: Github repository to link
* `github_repo_link.github_branch` - optional: Branch used for the auto deploy feature
* `github_repo_link.auto_deploy_enabled` - optional: Trigger a new deployment when changes are pushed to the selected branch
* `github_repo_link.deploy_review_apps_enabled` - optional: Enable the [review app](https://doc.scalingo.com/platform/app/review-apps#top-of-page) feature
* `github_repo_link.delete_on_close_enabled` - optional: Delete review app when the linked PR is closed
* `github_repo_link.hours_before_delete_on_close` - optional: Time to wait before deleting a review with a closed PR
* `github_repo_link.delete_stale_enabled` - optional: Delete review app when the linked PR wasn't updated recently
* `github_repo_link.hours_before_delete_stale` - optional: Time to wait for activity before considering the PR stale

||| col |||

Request example:

```bash
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/github_repo_links -d \
  '{
    "github_repo_link" : {
      "github_source":"https://github.com/Scalingo/sample-go-martini",
      "github_branch":"master",
      "auto_deploy_enabled": true,
      "deploy_review_apps_enabled":true,
      "delete_on_close_enabled":true,
      "hours_before_delete_on_close":0,
    }
  }'
```

--- row ---

## Get the repo link associated to an application

--- row ---

`GET https:/api.scalingo.com/v1/apps/example-app/github_repo_links`

||| col |||

```bash
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  https://api.scalingo.com/v1/apps/example-app/github_repo_links
```
```json
{
  "github_repo_links": [
    {
      "id":"42d04de5-5377-11e8-90e6-0242ac110052",
      "linker": {
        "id":"us-aa263090-9a23-81f5-8c7c-5fd9a50a8fa8",
        "username":"john",
        "email":"john.doe@example.com"
      },
      "created_at":"2018-05-09T12:53:52.276+02:00",
      "updated_at":"2018-06-01T11:45:26.078+02:00",
      "github_source":"https://github.com/Scalingo/sample-go-martini",
      "github_branch":"master",
      "auto_deploy_enabled":true,
      "github_integration_uuid":"42d04de5-5377-11e8-90e6-0242ac110052",
      "deploy_review_apps_enabled":false,
      "delete_on_close_enabled":false,
      "hours_before_delete_on_close":0,
      "delete_stale_enabled":false,
      "hours_before_delete_stale":0,
      "last_auto_deploy_at":"2018-06-01T11:45:26.077+02:00"
    }
  ]
}
```

--- row ---

## Delete a repo link

--- row ---

`DELETE https://api.scalingo.com/v1/apps/example-app/github_repo_links/:id`


||| col |||

```bash
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://api.scalingo.com/v1/apps/example-app/github_repo_links/42d04de5-5377-11e8-90e6-0242ac110052
```

--- row ---

## Manual deploy

--- row ---

`POST https://api.scalingo.com/v1/apps/example-app/github_repo_links/:id/manual-deploy`

### Parameters

* `branch`: The name of the branch that will be deployed

||| col |||

```bash
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/github_repo_links/42d04de5-5377-11e8-90e6-0242ac110052/manual-deploy \
  -d '{
    "branch": "master"
  }'
```

