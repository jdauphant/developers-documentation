---
title: Global information
layout: default
collection: scalingo_api
---

# Global information

--- row ---

## Introduction

The Scalingo V1 API is a publicly available interface allowing developers to
control Scalingo's entire cloud computing platform and access to the rich
Scalingo dataset. The interface is stable and currently used by the Scalingo
[command line client](https://cli.scalingo.com) (written in Go) and
[dashboard](https://my.scalingo.com) (an Ember.js app). However, changes are
occasionally made to improve performance and enhance features. See the
changelog for more details.

If you're an addon provider, you'd better go to [our addon provider
API](/addon-provider-api) for you to interface
your service with Scalingo's platform.

The current API version is the __v1__. All the endpoints are prefixed by `/v1`.
It's only available through HTTPS: it's TLS, or nothing.

The API has been tagged __v1__. However it is not a frozen API. We may and we
will update endpoints and create new ones. But you can be sure we won't break
the existing. If any major change about the way JSON is structured, we will
keep the right to release a __v2__ and so forth.

When any change is applied to the API, it will be displayed in the [changelog
section](/#changelog) of this documentation and on our [changelog
website](https://doc.scalingo.com/changelog).

||| col |||

Base URL:

```
https://$SCALINGO_API_URL/v1/
```

--- row ---

## Endpoints

Scalingo being available on multiple regions, the API endpoint depends on the
region your application is hosted on. It's designated by `SCALINGO_API_URL` in
this documentation and must be replaced with one of the following value:

- Agora Calycé Paris: https://api.agora-fr1.scalingo.com
- 3DS Outscale Paris: https://api.osc-fr1.scalingo.com

## HTTP Verbs

The API is not perfectly RESTful, it is more REST-ish. It has been developed to
be easy to use and instinctive, we'll probably normalize it, in a second version.

* HEAD		Can be issued against any resource to get just the HTTP header info.
* GET		Get resources, nullipotent operation (no matter how many times you call it, there is no side effect).
* POST		Used for creating resources. (creation of a new app, or to create an environment variable)
* PATCH		Update part of resources, as the value of an environment variable.
* PUT		Update complete resources.
* DELETE	Used for deleting items.

--- row ---

## Parameters

--- row ---

### GET and DELETE endpoints

Parameters for GET and DELETE requests are known as _query parameters_, they are declared in the resource URL.

||| col |||

Example request:

```shell
curl -X GET https://$SCALINGO_API_URL/v1/apps/name/events?page=2
```

--- row ---

### POST/PUT/PATCH

For these types of request, parameters are not included as query parameters,
they should be encoded as JSON with the following header: `Content-Type:
'application/json'`.

||| col |||

Example request:

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps -d \
  '{
    "app": {
      "name": "example-app"
    }
  }'
```

--- row ---

# Authentication

The authentication to the API is done thanks to an authentication token and
Bearer HTTP Auth. The API is HTTPS only, so credentials are always sent
encrypted.

--- row ---

## Create an API token from your dashboard

You can create an API token from your Profile page on the dashboard:

[Create your API Token](https://my.scalingo.com/profile)

--- row ---

## Create your API token with the authentication API

Otherwise you can create an API token with the authentication API directly:

--- row ---

`POST https://auth.scalingo.com/v1/tokens`

Parameters:

* `token.name`: Name of this token

||| col |||

Example request:

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -u "<your username>:<your password>"
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
    "issued_at": "2018-03-28T19:56:09.422Z",
    "token": "tk-us-BQ3LRmLGc35pMjdgwjX6kI1IWh7MAYk2uqquYwLDxCd4fhSm"
  }
}
```

--- row ---

## Exchange this token for a Bearer Token

Scalingo's API only accept Bearer Tokens so you'll need to exchange your token
for a Bearer Token.

Bearer tokens are only valid for an hour.

The token exchange is done by the authentication API:

--- row ---

`POST https://auth.scalingo.com/v1/tokens/exchange`

More informations available on the [token page](/tokens.html).

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
  "token": "the-bearer-token"
}
```

--- row ---

## Make an authenticated request

HTTP requests have to be authenticated with HTTP basic authentication, with the
authentication token as password, the username can be empty.

||| col |||

Example request:

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://$SCALINGO_API_URL/v1/apps
```

--- row ---

# Data format

--- row ---

## JSON

--- row ---

The API sends and receives JSON, XML is not accepted, please ensure JSON is used. All the
returned object are `object`, there is never an `array` as root element.

Resources are rooted, it means that they have a parent key corresponding to its name. This
key may be plural if a collection of items is returned.

||| col |||

```js
{
  "app": {
    // application
  }
}
```

```js
{
  "apps": [
    {
      // application
    }, {
      // application
    }
  ]
}
```

--- row ---

## Dates

All the dates are sent with the ISO 8601: YYYY-MM-DDThh:mm:ss.μμμZ

Example:

__2015-01-13T09:20:31.123+01:00__

This format is commonly understood, here are some examples:

||| col |||

JavaScript:

```js
var date = new Date("2015-01-13T09:20:31.123+01:00")
Tue Jan 13 2015 09:20:31 GMT+0100 (CET)
```

Ruby:

```ruby
require 'date'
DateTime.iso8601("2015-01-13T09:20:31.123+01:00")
=> #<DateTime: 2015-01-13T09:20:31+01:00 ((2457036j,30031s,123000000n),+3600s,2299161j)>
```

Go:

```go
/*
 * go run iso8601.go
 * 2015-01-13 09:20:31.123 +0100 CET
 */
date, _ := time.Parse(time.RFC3339Nano, "2015-01-13T09:20:31.123+01:00")
fmt.Println(date)
```

--- row ---

# Errors

## Client errors - Status codes: 4xx

--- row ---

### Invalid JSON - 400 Bad Request

--- row ---

The JSON you've sent in the payload is is wrongly formatted.

||| col |||

```shell
curl -H 'Content-Type: application/json' -H 'Accept: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/users/sign_in -d '{"user": {'
```

Returns HTTP/1.1 400 Bad Request

```json
{
  "error" : "There was a problem in the JSON you submitted: 795: unexpected token at '{\"user\": {'"
}
```

--- row ---

### Exceeding free trial - 402 Payment Required

--- row ---

If you try to do an action unauthorized in the free trial, you will get an error
402 Payment Required.

||| col |||

```shell
curl -H 'Content-Type: application/json' -H 'Accept: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps -d \
  '{
    "app" : {
      "name" : "my-new-app"
    }
  }'
```

Returns 402 Payment Required if user is not allowed to create a new app.

```json
{
    "error": "Sorry, you need to verify your account (billing profile and payment card) to create a new app",
    "url": "https://my.scalingo.com/apps/billing"
}
```

--- row ---

### Resource not found - 404 Not found

--- row ---

When you're doing a request to an invalid resource

||| col |||

```shell
curl -H 'Content-Type: application/json' -H 'Accept: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/apps/123
```

Returns HTTP/1.1 404 Not Found

```json
{
  "resource": "app",
  "error" : "not found"
}
```

--- row ---

### Invalid field - 422 Unprocessable Entity

--- row ---

There is an invalid field in the JSON payload.

||| col |||

```shell
curl -H 'Content-Type: application/json' -H 'Accept: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps -d '{}'
```

Returns HTTP/1.1 422 Unprocessable Entity

```json
{
  "errors" : {
    "app": [ "missing field" ]
  }
}
```

--- row ---

### Invalid data - 422 Unprocessable Entity

--- row ---

Invalid data were sent in the payload.

||| col |||

```shell
curl -H 'Content-Type: application/json' -H 'Accept: application/json' \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps -d \
  '{
    "app" : {
      "name" : "AnotherApp"
    }
  }'
```

Returns HTTP/1.1 422 Unprocessable Entity

```json
{
  "errors": {
    "name": [ "should contain only lowercap letters, digits and hyphens" ]
  }
}
```

--- row ---

### Server errors - 50x

--- row ---

If the server returns a 50x status code, something wrong happened on our side.
You can't do anything about it, you can be sure that our team got notifications
for it and that it will be fixed really quickly.

||| col |||

Example of error 500:

```json
{
  "error": "Internal error occured, we're on it!"
}
```

--- row ---

# Pagination

Some resources provided by the platform API are paginated. To
ensure you can correctly handle it, metadata are added to the JSON of the
response.

--- row ---

## Request parameters

* `page`: Requested page number
* `per_page`: Number of entries per page.
  Each resource has a maximum for this value to avoid oversized requests

## Response meta values

The returned JSON object will include a `meta` key including pagination
metadata:

```json
{
  "meta": {
    "pagination": {
      "prev_page": "<previous page number>",
      "current_page": "<requested page number>",
      "next_page": "<next page number>",
      "total_pages": "<total amount of pages>",
      "total_count": "<total amount of items in the collection>"
    }
  }
}
```

> `prev_page` and/or `next_page` are equal to `null` if there is no previous
> or next page.

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET 'https://$SCALINGO_API_URL/v1/apps/example-app/events?page=4&per_page=20'
```

Returns 200 OK

This request returns the events 40 to 60.

```json
{
  "events": [
    { ... }
  ],
  "meta": {
    "pagination": {
      "current_page": 4,
      "prev_page": 3,
      "next_page": 5,
      "total_pages": 12,
      "total_count": 240
    }
  }
}
```
