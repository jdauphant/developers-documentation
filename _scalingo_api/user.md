---
title: User Account
layout: default
---

# User Account

--- row ---

**User attributes**

{:.table}
| field                 | type    | description                                         |
| --------------        | ------  | ----------------------------------------------------|
| id                    | string  | unique ID. Prefixed with `us-`.                     |
| uuid                  | string  | unique ID. Same as the `id`.                        |
| email                 | string  | email address                                       |
| username              | string  | username                                            |
| created_at            | date    | creation date of the user account                   |
| free_trial_started_at | date    | starting date of the free trial                     |
| free_trial_end_time   | date    | ending date of the free trial                       |
| suspended_at          | date    | date of the account suspension                      |
| suspension_reason     | string  | reason of the account suspension                    |
| company               | string  | company name                                        |
| location              | string  | user's location                                     |
| fullname              | string  | user's full name (first and last name)              |
| tos_accepted          | boolean | true if the terms of service have been accepted     |
| email_newsletter      | boolean | true if the user subscribed to the newsletter       |
| referral_url          | string  | referral URL for the user referral program          |
| referral_clicks       | integer | number of clicks on the user referral link          |
| flags                 | object  | list of flags associated to the account             |
| limits                | object  | custom limits associated to the account             |

||| col |||

Example object:

```json
{
  "id": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
  "created_at": "2016-06-02T17:07:39.000Z",
  "email": "documentation@scalingo.com",
  "username": "doc-account",
  "uuid": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
  "company": "Scalingo",
  "location": "Strasbourg",
  "fullname": "Étienne Michon",
  "tos_accepted": true,
  "flags": {},
  "limits": {
    "free_trial_apps": "10"
  },
  "referral_url": "https://sclng.io/r/81e5168dadc0bfe0",
  "referral_clicks": 23,
  "free_trial_started_at": "2016-06-02T17:07:39.000Z",
  "free_trial_end_time": "2016-07-02T23:07:00.000Z",
  "suspended_at": null,
  "suspension_reason": null,
  "email_newsletter": false
}
```

--- row ---

## Get Current User Account

--- row ---

`GET https://$SCALINGO_API_URL/v1/users/self`

Get the information associated to the current user account.

||| col |||

Example Request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/users/self
```

Returns 200 OK

```json
{
  "user": {
    "id": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
    "created_at": "2016-06-02T17:07:39.000Z",
    "email": "documentation@scalingo.com",
    "username": "doc-account",
    "uuid": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
    "company": "Scalingo",
    "location": "Strasbourg",
    "fullname": "Étienne Michon",
    "tos_accepted": true,
    "flags": {},
    "limits": {
      "free_trial_apps": "10"
    },
    "referral_url": "https://sclng.io/r/81e5168dadc0bfe0",
    "referral_clicks": 23,
    "free_trial_started_at": "2016-06-02T17:07:39.000Z",
    "free_trial_end_time": "2016-07-02T23:07:00.000Z",
    "suspended_at": null,
    "suspension_reason": null,
    "email_newsletter": false
  }
}
```

--- row ---

## Update User Account

--- row ---

`PATCH https://$SCALINGO_API_URL/v1/users/[:user_id]`

or

`PUT https://$SCALINGO_API_URL/v1/users/[:user_id]`

Updates some user account information.

### Parameters

* `user.email`: new email address.
* `user.username`: new username.

All attributes are optional.

||| col |||

Example Request

```shell

curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X PATCH https://$SCALINGO_API_URL/v1/users/[:user_id] -d \
  '{
     "user": {
       "email":"new-documentation@scalingo.com"
      }
   }'
```

Returns 200 OK

```json
{
  "user": {
    "id": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
    "created_at": "2016-06-02T17:07:39.000Z",
    "email": "new-documentation@scalingo.com",
    "username": "doc-account",
    "uuid": "us-d13d3065-e7fa-4b1a-827a-ce1c92415f9c",
    "company": "Scalingo",
    "location": "Strasbourg",
    "fullname": "Étienne Michon",
    "tos_accepted": true,
    "flags": {},
    "limits": {
      "free_trial_apps": "10"
    },
    "referral_url": "https://sclng.io/r/81e5168dadc0bfe0",
    "referral_clicks": 23,
    "free_trial_started_at": "2016-06-02T17:07:39.000Z",
    "free_trial_end_time": "2016-07-02T23:07:00.000Z",
    "suspended_at": null,
    "suspension_reason": null,
    "email_newsletter": false
  }
}
```

--- row ---

## Delete User Account

--- row ---

`DELETE https://$SCALINGO_API_URL/v1/users`

Deletes the user account.

> This action deletes all the owned applications.

||| col |||

Example Request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://$SCALINGO_API_URL/v1/users
```

Returns 204 No Content
