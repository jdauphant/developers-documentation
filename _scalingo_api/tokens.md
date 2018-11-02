---
title: Tokens
layout: default
---

# Tokens

--- row ---

**Token attributes**

{:.table}
| field        | type                                                         |
|--------------|--------------------------------------------------------------|
| id           | unique ID of the token                                       |
| name         | token name                                                   |
| created_at   | token creation date                                          |
| last_used_at | date of the last exchange of this token                      |
| token        | value of this token (this will only be shown once per token) |


||| col |||

Example object

```json
{
  "id": "e061a292-bab4-47fa-bb08-d7f7895ae5b6",
  "name": "Test Token",
  "created_at": "2018-03-28T19:56:09.433Z",
  "last_used_at": null,
  "token": "tk-us-BQ3LRmLGc35pMjdgwjX6kI1IWh7MAYk2uqquYwLDxCd4fhSm"
}
```
--- row ---

## List your tokens

--- row ---

`GET https://auth.scalingo.com/v1/tokens`

List all tokens created for the authenticated user

||| col |||
Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://auth.scalingo.com/v1/tokens
```

Returns 200 OK

```json
{
  "tokens": [
    {
      "id": "7212518c-7eb3-47fd-a6da-a627d767d7eb",
      "name": "test-token",
      "created_at": "2018-03-28T20:13:48.704Z",
      "last_used_at": "2018-03-28T20:14:55.200Z",
    },
    {
      "id": "00ac4742-8ff5-4306-932f-3078e28ecaff",
      "name": "CLI",
      "created_at": "2018-03-28T20:52:59.641Z",
      "last_used_at": null,
    }
  ]
}
```
--- row ---

## Create a token

`POST https://auth.scalingo.com/v1/tokens`

Parameters:

* `token.name`: Name of this token

If 2FA is enabled for this account, the `X-Authorization-OTP` header must be
defined.

As opposed to "Bearer Token", "Token" have an infinite lifetime. However they must
be exchanged with a ""Bearer Token" in order to work.

||| col |||

Example request:

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -u "<your username>:<your password>"
 -H "X-Authorization-OTP: 123456"
 -X POST https://auth.scalingo.com/v1/tokens -d \
 '{
   "token": {
     "name": "Test Token",
   }
 }'
```

Returns 201 Created

```json
{
  "token": {
    "id": "e061a292-bab4-47fa-bb08-d7f7895ae5b6",
    "name": "Test Token",
    "created_at": "2018-03-28T19:56:09.433Z",
    "last_used_at": null,
    "token": "tk-us-BQ3LRmLGc35pMjdgwjX6kI1IWh7MAYk2uqquYwLDxCd4fhSm"
  }
}
```
--- row ---

## Regenerate a token

Regenerating a token will have the same effect as deleting the token and
re-creating one with the same name. The old token won't be able to be exchanged
anymore.

--- row ---

`PATCH https://auth.scalingo.com/v1/tokens/[:token_id]/renew`

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X https://auth.scalingo.com/v1/tokens/7212518c-7eb3-47fd-a6da-a627d767d7eb/renew
```

Returns 200 OK


```json
{
  "token": {
    "id": "00ac4742-8ff5-4306-932f-3078e28ecaff",
    "name": "CLI",
    "created_at": "2018-03-28T20:52:59.641Z",
    "last_used_at": null,
    "token": "tk-us-oW5StXWJ-SEQ1xDr6uyhe4_s4TUYcwWUJ-WWBHaM6sZnnvZs"
  }
}
```

--- row ---

## Exchange a token for a Bearer Token

Tokens are not usable directly against our API. To use a token against our API
you'll need to exchange it first. The generated token will only be usable for
an hour.


--- row ---

`POST https://auth.scalingo.com/v1/tokens/exchange`

||| col |||

Example request:

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -u ":<your token>" \
 -X POST https://auth.scalingo.com/v1/tokens/exchange
```

Returns 200 OK

```json
{
  "token": "your-bearer-token"
}
```

