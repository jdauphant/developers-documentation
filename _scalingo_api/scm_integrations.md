---
title: 'SCM Integrations'
layout: default
---

# SCM Integrations

SCM Integrations represent a link between your account and an SCM platform like
`github.com`. The different supported SCM platforms can be found in the list
below.

--- row ---

**Keys attributes**

{:.table}
| field                | type     | description                                                                |
| -------------------- | -------- | ------------------------------------------------------------------         |
| id                   | string   | unique ID of the SCM integration                                           |
| scm_type             | string   | SCM type (`github`, `gitlab`, `github-enterprise` or `gitlab-self-hosted`) |
| url                  | string   | URL where the SCM platform is hosted                                       |
| created_at (read)    | date     | creation date of the SCM integration                                       |
| uid (read)           | string   | user ID provided by the SCM platform                                       |
| username (read)      | string   | username provided by the SCM platform                                      |
| avatar_url (read)    | string   | user avatar URL provided by the SCM platform                               |
| email (read)         | string   | user email provided by the SCM platform                                    |
| profile_url (read)   | string   | user profile URL provided by the SCM platform                              |
| owner                | object   | owner of the SCM integration                                               |

The `scm_type` field can take the following values:

- `github`: is a GitHub.com integration
- `gitlab`: is a GitLab.com integration
- `github-enterprise`: is a GitHub Enterprise self-hosted instance
- `gitlab-self-hosted`: is a GitLab self-hosted instance

Note that only `github-enterprise` and `gitlab-self-hosted` integrations can be
created from the API.

The `github` and `gitlab` integrations must be created from the profile page of
the [Dashboard](https://my.scalingo.com/profile), via OAuth system.

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

## List All the SCM Integrations of Your Account

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

## Show a Specific SCM Integration

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

## Create/Link an SCM Integration With Your Account

--- row ---

`POST https://auth.scalingo.com/v1/scm_integrations`

Link an SCM platform with your account.

Only GitHub Enterprise and GitLab self-hosted types is handled with this route.

### Parameters

* `scm_type`: SCM type (`github-enterprise` or `gitlab-self-hosted`)
* `url`: Endpoint URL of the SCM platform
* `access_token`: Access token provided by an SCM platform

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

## Delete/Unlink an SCM Integration From Your Account

--- row ---

`DELETE https://auth.scalingo.com/v1/scm_integrations/[:id]`

Unlink an SCM platform from your account.

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c
```

Returns 204 No Content

--- row ---

## Import SSH Keys From an SCM Platform

--- row ---

`POST https://auth.scalingo.com/v1/scm_integrations/[:id]/import_keys`

Import SSH keys directly from an SCM platform in your account

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c/import_keys
```

Returns 201 Created

```json
{
  "keys": [
    {
      "id": "4d0ab8fc-e201-beba-494a-b09bf85f2149",
      "name": "gitlab-self-hosted-Dev key",
      "content": "ssh-rsa ...",
      "fingerprint": "56:ba:e5:8c:4b:14:df:c8:bb:78:74:26:2c:99:26:61",
      "created_at": "2019-07-30T14:26:17.271Z",
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

## Search Repositories From an SCM Platform

--- row ---

`GET https://auth.scalingo.com/v1/scm_integrations/[:id]/search_repos?query=XXX`

Search repositories from an SCM platform

**Query Qualifiers**

The format of the search query is: `?query=SEARCH_KEYWORD_1+SEARCH_KEYWORD_N+QUALIFIER_1+QUALIFIER_N`

A query can contain theses supported search qualifiers, separated by `+` character:

{:.table}
| field                | type     | description                            |
| -------------------- | -------- | -------------------------------------- |
| fork                 | boolean  | Include fork project in the result     |
| user                 | string   | Search within this user                |

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c/search_repos?query=example+fork:true+user:john-diggle
```

Returns 200 OK

```json
{
  "repositories": [
    {
      "id": 89341704,
      "name": "example-repository",
      "fullName": "john-diggle/example-repository",
      "url": "https://github.com/john-diggle/example-repository",
      "description": "Example Repository"
    },
    {
      "id": 275241792,
      "name": "project-docs-example",
      "fullName": "john-diggle/project-docs-example",
      "url": "https://github.com/john-diggle/project-docs-example",
      "description": "Project documentation example"
    }
  ]
}
```

--- row ---

## Get Your Organizations/Groups From an SCM Platform

--- row ---

`GET https://auth.scalingo.com/v1/scm_integrations/[:id]/orgs`

Get your organizations (GitHub) or groups (GitLab) from an SCM platform

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c/orgs
```

Returns 200 OK

```json
{
  "organizations": [
    {
      "id": 4698196,
      "login": "Test",
      "avatarUrl": "https://avatars1.githubusercontent.com/u/4698196?v=4",
      "url": "https://api.github.com/orgs/Test",
      "description": "This is a test GitHub Organization."
    },
    {
      "id": 56149608,
      "login": "Another Organization",
      "avatarUrl": "https://avatars3.githubusercontent.com/u/56149608?v=4",
      "url": "https://api.github.com/orgs/another-org",
      "description": "This is an another Organization."
    }
  ]
}
```

--- row ---

## Search Pull Requests/Merge Requests From an SCM Platform

--- row ---

`GET https://auth.scalingo.com/v1/scm_integrations/[:id]/search_pull_requests?query=XXX`

Search pull requests (GitHub) or merge requests (GitLab) from an SCM platform

**Query Qualifiers**

The format of the search query is: `?query=QUALIFIER_1+QUALIFIER_N`

A query can contain theses supported search qualifiers, separated by `+` character:

{:.table}
| field                | type     | description                                           |
| -------------------- | -------- | ----------------------------------------------------- |
| is                   | string   | State: `open` or `closed`                             |
| repo                 | string   | Search within a user's or organization's repositories |

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://auth.scalingo.com/v1/scm_integrations/5bb2e877-9e5c-a83f-8e0e-7c75eebf212c/search_pull_requests?query=is:open+repo:john-diggle/example-repository
```

Returns 200 OK

```json
{
  "pull_requests": [
    {
      "title": "Add logo",
      "number": 3,
      "html_url": "https://github.com/john-diggle/example-repository/pull/3"
    },
    {
      "title": "Add feature",
      "number": 8,
      "html_url": "https://github.com/john-diggle/example-repository/pull/8"
    }
  ]
}
```
