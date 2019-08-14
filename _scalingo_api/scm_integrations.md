---
title: 'SCM Integrations'
layout: default
---

# SCM Integrations

SCM Integrations represent a link between your account and a SCM platform like `github.com`. The different supported SCM platforms can be found in the list below.

--- row ---

**Keys attributes**

{:.table}
| field                | type     | description                                                        |
| -------------------- | -------- | ------------------------------------------------------------------ |
| id                   | string   | unique ID of the SCM integration                                   |
| scm_type             | string   | SCM type (github, gitlab, github-enterprise or gitlab-self-hosted) |
| url                  | string   | endpoint URL link of where is hosted the SCM platform              |
| created_at (read)    | datetime | creation date of the SCM integration                               |
| uid (read)           | string   | user id provided by the SCM platform                               |
| username (read)      | string   | username provided by the SCM platform                              |
| avatar_url (read)    | string   | user avatar url provided by the SCM platform                       |
| email (read)         | string   | user email provided by the SCM platform                            |
| profile_url (read)   | string   | user profile url provided by the SCM platform                      |
| owner                | object   | owner of the SCM integration                                       |

The `scm_type` field can take different values:

- `github`: is a GitHub.com integration
- `gitlab`: is a GitLab.com integration
- `github-enterprise`: is a GitHub Enterprise self-hosted instance
- `gitlab-self-hosted`: is a GitLab self-hosted instance

Take note that only `github-enterprise` and `gitlab-self-hosted` integrations can be created from the API.

The `github` and `gitlab` integrations must be created from the profile page of the [Dashboard](https://my.scalingo.com/profile), via OAuth system.

||| col |||

Example object

```json
{
  "scm_integration": {
    "id": "70bf275e-e0ee-483e-9e5c-21e5bb2e877c",
    "scm_type": "github-enterprise",
    "url": "https://ghe.example.com",
    "access_token": "a64fe9744da5e6ce790ca3a9084bd66cf433b24b",
    "created_at": "2019-08-12T11:59:37.298Z",
    "uid": "8",
    "username": "test-user",
    "avatar_url": "https://ghe.example.com/avatars/u/8?",
    "email": "test-user@example.com",
    "profile_url": "https://ghe.example.com/test-user",
    "owner": {
      "id": "us-c4e889d8-9bbc-4dfa-b39f-5d41c888349d",
      "email": "test-user@example.com",
      "username": "test-user",
    }
  }
}
```

--- row ---

## List all the SCM integrations of your account

`GET https://auth.scalingo.com/v1/scm_integrations`

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://auth.scalingo.com/v1/scm_integrations
```

Returns 200 OK

```json
{
  "scm_integrations": [
    {
      "id": "70bf275e-e0ee-483e-9e5c-21e5bb2e877c",
      "scm_type": "github-enterprise",
      "url": "https://ghe.example.com",
      "access_token": "a64fe9744da5e6ce790ca3a9084bd66cf433b24b",
      "created_at": "2019-08-12T11:59:37.298Z",
      "uid": "8",
      "username": "test-user",
      "avatar_url": "https://ghe.example.com/avatars/u/8?",
      "email": "test-user@example.com",
      "profile_url": "https://ghe.example.com/test-user",
      "owner": {
        "id": "us-c4e889d8-9bbc-4dfa-b39f-5d41c888349d",
        "email": "test-user@example.com",
        "username": "test-user",
      }
    },
    {
      "id": "5bb2e877-9e5c-a83f-8e0e-7c75eebf212c",
      "scm_type": "gitlab",
      "url": "https://gitlab.example2.com",
      "access_token": "a64fe9744da5e6ce790ca3a9084bd66cf433b24b",
      "created_at": "2019-08-12T11:59:37.298Z",
      "uid": "42",
      "username": "test_user",
      "avatar_url": "https://secure.gravatar.com/avatar/4d65e90ca34da7a9084b6ce6c?s=80&d=identicon",
      "email": "test-user@example.com",
      "profile_url": "https://gitlab.example2.com/test-user",
      "owner": {
        "id": "us-88c4e9af-f93c-8284-c67a-fa414d49c5de",
        "email": "test-user@example.com",
        "username": "test-user",
      }
    }
  ] 
}
```

--- row ---

## Show a specific SCM integration

--- row ---

`GET https://auth.scalingo.com/v1/scm_integrations/[:id]`

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c
```

Returns 200 OK

```json
{
  "scm_integration": {
    "id": "5bb2e877-9e5c-a83f-8e0e-7c75eebf212c",
    "scm_type": "gitlab",
    "url": "https://gitlab.example2.com",
    "access_token": "a64fe9744da5e6ce790ca3a9084bd66cf433b24b",
    "created_at": "2019-08-12T11:59:37.298Z",
    "uid": "42",
    "username": "test_user",
    "avatar_url": "https://secure.gravatar.com/avatar/4d65e90ca34da7a9084b6ce6c?s=80&d=identicon",
    "email": "test-user@example.com",
    "profile_url": "https://gitlab.example2.com/test-user",
    "owner": {
      "id": "us-88c4e9af-f93c-8284-c67a-fa414d49c5de",
      "email": "test-user@example.com",
      "username": "test-user",
    }
  }
}
```

--- row ---

## Create/Link an SCM integration with your account

--- row ---

`POST https://auth.scalingo.com/v1/scm_integrations`

Link an SCM platform with your account.

Only GitHub Enterprise and GitLab self-hosted types is handled with this route.

### Parameters

* `scm_type`: SCM type (`github-enterprise` or `gitlab-self-hosted`)
* `url`: Endpoint URL of the SCM platform
* `access_token`: Access token provided by your SCM platform

If the `scm_type`, `url` or `access_token` is not valid, a 422 "Unprocessable entity" is returned
Otherwise return 201

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://auth.scalingo.com/v1/scm_integrations -d \
  '{
    "scm_integration": {
      "scm_type":"gitlab-self-hosted",
      "url":"https://gitlab.example.com",
      "access_token": "e9740ca2466cf4da5e6c3a9e79a64f84bdf4b3b2"
    }
  }'
```

Returns 201 Created

```json
{
  "scm_integration": {
    "id": "5bb2e877-9e5c-a83f-8e0e-7c75eebf212c",
    "scm_type": "gitlab-self-hosted",
    "url": "https://gitlab.example.com",
    "created_at": "2019-08-12T11:59:37.298Z",
    "uid": "42",
    "username": "test_user",
    "avatar_url": "https://secure.gravatar.com/avatar/4d65e90ca34da7a9084b6ce6c?s=80&d=identicon",
    "email": "test-user@example.com",
    "profile_url": "https://gitlab.example.com/test-user",
    "owner": {
      "id": "us-88c4e9af-f93c-8284-c67a-fa414d49c5de",
      "email": "test-user@example.com",
      "username": "test-user",
    }
  }
}
```

--- row ---

## Delete/Unlink an SCM integration from your account

--- row ---

`DELETE https://auth.scalingo.com/v1/scm_integrations/[:id]`

Unlink your SCM platform from your account.

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c
```

Returns 204 No Content
