---
title: Addons
layout: default
---

# Addons

--- row ---

**Addon attributes**

{:.table}
| field            | type   | description                                   |
| ---------------- | ------ | --------------------------------------------- |
| id               | string | unique ID identifying the addon               |
| provisioned_at   | date   | when the addon has been created               |
| deprovisioned_at | date   | when the addon has been removed/upgraded      |
| app_id           | string | ID of the application which owns the addon    |
| resource_id      | string | resource reference                            |
| status           | string | current status of the addon                   |
| plan             | object | embedded reference to Plan resource           |
| addon_provider   | object | embedded reference to AddonProvider resource  |

||| col |||

Example object:

```json
{
  "id" : "5415beca646173000b015000",
  "app_id": "54100930736f7563d5030000",
  "provisioned_at": "2015-02-22T18:55:02.766+01:00",
  "deprovisioned_at": null,
  "status": "running",
  "plan" : {
    "id": "599c1a2121276700011caadc",
    "name": "redis-sandbox",
    "display_name": "Sandbox",
    "price": 0,
    "description" : "[Markdown description]",
    "position": 1,
    "on_demand": false,
    "disabled": false,
    "disabled_alternative_plan_id": null,
    "sku": "osc-fr1-redis-sandbox"
  },
  "resource_id" : "example_app_3083",
  "addon_provider" : {
    "id" : "scalingo-redis",
    "name" : "Scalingo Redis",
    "logo_url" : "//storage.sbg1.cloud.ovh.net/v1/AUTH_be65d32d71a6435589a419eac98613f2/scalingo/redis.png"
  }
}
```

--- row ---

## List Application Addons

--- row ---

`GET https://$SCALINGO_API_URL/v1/apps/[:app]/addons`

List all the provisioned addons for a given application.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/apps/example-app/addons
```

Returns 200 OK

```json
{
  "addons": [{
    "id" : "5415beca646173000b015000",
    "app_id": "54100930736f7563d5030000",
    "resource_id" : "example_app_3083",
    "provisioned_at": "2015-02-22T18:55:02.766+01:00",
    "deprovisioned_at": null,
    "status": "running",
    "plan" : {
      "id": "599c1a2121276700011caadc",
      "name": "redis-sandbox",
      "display_name": "Sandbox",
      "price": 0,
      "description" : "[Markdown description]",
      "position": 1,
      "on_demand": false,
      "disabled": false,
      "disabled_alternative_plan_id": null,
      "sku": "osc-fr1-redis-sandbox"
    },
    "addon_provider" : {
      "id" : "scalingo-redis",
      "name" : "Scalingo Redis",
      "logo_url" : "//storage.sbg1.cloud.ovh.net/v1/AUTH_be65d32d71a6435589a419eac98613f2/scalingo/redis.png"
    }
  }]
}
```

--- row ---

## Provision an Addon

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/[:app]/addons`

Provision the addon defined by the `addon_provider` at the given plan.
The resource should be instantly available, it modifies environment
variables.

### Parameters

* `addon.addon_provider_id`
* `addon.plan_id`

Free usage limit:

You can only use free addons without having defined [a payment
method](https://my.scalingo.com/apps/billing).

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps/[:app]/addons \
  -d '{"addon":{"plan_id": "1234", "addon_provider_id": "1234"}}'
```

--- row ---

## Upgrade an Addon

--- row ---

`PATCH https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]`

Change your addon plan. The endpoint will query the addon provider to
upgrade your plan to a new one.

Be cautious though, the operation might fail. The provider may refuse to
downgrade an addon if the operation is invalid. Example: You have a 3GB
database and you want to return to the free tier database at 512MB.

### Parameters

* `addon.plan_id`

Free usage limit:

You can only use free addons without having defined [a payment
method](https://my.scalingo.com/apps/billing).


||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X PATCH https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id] \
  -d '{"addon": {"plan_id": "2"}}'
```

Returns 200 OK

```json
{
  "vars": ["VAR1", "VAR2"],
  "message": "<custom message from the addon provider>"
}
```

--- row ---

## Get an Addon

--- row ---

`GET https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]`

Get a specific addon of an application.

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]
```

Returns 200 OK

```json
{
  "addon": {
    "id" : "5415beca646173000b015000",
    "app_id": "54100930736f7563d5030000",
    "resource_id" : "example_app_3083",
    "provisioned_at": "2015-02-22T18:55:02.766+01:00",
    "deprovisioned_at": null,
    "status": "running",
    "plan" : {
      "id": "599c1a2121276700011caadc",
      "name": "redis-sandbox",
      "display_name": "Sandbox",
      "price": 0,
      "description" : "[Markdown description]",
      "position": 1,
      "on_demand": false,
      "disabled": false,
      "disabled_alternative_plan_id": null,
      "sku": "osc-fr1-redis-sandbox"
    },
    "addon_provider" : {
      "id" : "scalingo-redis",
      "name" : "Scalingo Redis",
      "logo_url" : "//storage.sbg1.cloud.ovh.net/v1/AUTH_be65d32d71a6435589a419eac98613f2/scalingo/redis.png"
    }
  }
}
```

--- row ---

## Remove an Addon

--- row ---

`DELETE https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]`

Request deprovisionning of the addon. This may be a dangerous operation as the
addon provider will certainly erase all the data related to your application.
Be cautious when deleting addons, be sure of what you're doing.

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]
```

Returns 204 No Content

--- row ---

## Get Addon Token

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]/token`

Request a token usable against the addon API. This token will only be valid for
an hour.


||| col |||

```json
{
  "addon": {
    "id" : "5415beca646173000b015000",
    "app_id": "54100930736f7563d5030000",
    "resource_id" : "example_app_3083",
    "provisioned_at": "2015-02-22T18:55:02.766+01:00",
    "deprovisioned_at": null,
    "status": "running",
    "plan" : {
      "id": "599c1a2121276700011caadc",
      "name": "redis-sandbox",
      "display_name": "Sandbox",
      "price": 0,
      "description" : "[Markdown description]",
      "position": 1,
      "on_demand": false,
      "disabled": false,
      "disabled_alternative_plan_id": null,
      "sku": "osc-fr1-redis-sandbox"
    },
    "addon_provider" : {
      "id" : "scalingo-redis",
      "name" : "Scalingo Redis",
      "logo_url" : "//storage.sbg1.cloud.ovh.net/v1/AUTH_be65d32d71a6435589a419eac98613f2/scalingo/redis.png"
    }
    "token": "[REDACTED]"
  }
}
```

--- row ---

## Get Dashboard Addon Authenticated URL

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/[:app]/addons/[:addon_id]/sso`

Get an authenticated URL to connect to the web dashboard of your addon. This URL expires after one hour.

||| col |||

```json
{
  "addon": {
    "id" : "5415beca646173000b015000",
    "app_id": "54100930736f7563d5030000",
    "resource_id" : "example_app_3083",
    "provisioned_at": "2015-02-22T18:55:02.766+01:00",
    "deprovisioned_at": null,
    "status": "running",
    "plan" : {
      "id": "599c1a2121276700011caadc",
      "name": "redis-sandbox",
      "display_name": "Sandbox",
      "price": 0,
      "description" : "[Markdown description]",
      "position": 1,
      "on_demand": false,
      "disabled": false,
      "disabled_alternative_plan_id": null,
      "sku": "osc-fr1-redis-sandbox"
    },
    "addon_provider" : {
      "id" : "scalingo-redis",
      "name" : "Scalingo Redis",
      "logo_url" : "//storage.sbg1.cloud.ovh.net/v1/AUTH_be65d32d71a6435589a419eac98613f2/scalingo/redis.png"
    }
    "sso_url": "https://db-osc-fr1.scalingo.com/sso?id=example_app_3083&token=b4ffb0d1139f23629b44aadf6700eb45c411df25&timestamp=1600073910"
  }
}
```
