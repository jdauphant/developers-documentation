---
title: Notification Platforms
layout: default
---

# Notifications Platform

Scalingo lets you use different platforms to send your notifications.

--- row ---

**Notification platform attributes**

{:.table}
| field               | type     | description                                        |
| ------------------- | -------- | -------------------------------------------------- |
| id                  | string   | unique ID identifying the notification platform    |
| name                | string   | name of the notification platform                  |
| display_name        | string   | human readable name for this notification platform |
| logo_url            | string   | URL to a logo for this notification platform       |
| available_event_ids | []string | list of event IDs accepted by this platform        |
| description         | string   | description of the platform                        |

||| col |||

Example object:

```json
{
  "id": "5982f145d48c3600273ef089",
  "name": "slack",
  "display_name": "Slack",
  "logo_url": "https://cdn2.scalingo.com/dashboard/assets/images/notification/slack-831fd1b21576dbb3e0037b7211ecfd93.svg",
  "available_event_ids": [
    "5982f139d48c360021b1eb69",
    "59c52a9c7651ce001f62f578",
    "5b28be8e85232200126f373c",
    "5b28bf02aa9a340012832362",
    "5b28bf2485232200126f373e"
  ],
  "description": "Send events to your team thanks to Slack Incoming WebHooks."
}
```

--- row ---

## List All Notification Platforms

--- row ---

`GET https://$SCALINGO_API_URL/v1/notification_platforms`

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -X GET https://$SCALINGO_API_URL/v1/notification_platforms
```

Returns 200 OK

```json
{
  "notification_platforms": [
    {
      "id": "5982f145d48c3600273ef089",
      "name": "slack",
      "display_name": "Slack",
      "logo_url": "https://cdn2.scalingo.com/dashboard/assets/images/notification/slack-831fd1b21576dbb3e0037b7211ecfd93.svg",
      "available_event_ids": [
        "5982f139d48c360021b1eb69",
        "59c52a9c7651ce001f62f578",
        "5b28be8e85232200126f373c",
        "5b28bf02aa9a340012832362",
        "5b28bf2485232200126f373e"
      ],
      "description": "Send events to your team thanks to Slack Incoming WebHooks."
    }, {
      "id": "5982f145d48c3600273ef08a",
      "name": "webhook",
      "display_name": "Webhook",
      "logo_url": "https://cdn2.scalingo.com/dashboard/assets/images/notification/webhook-1f16734c1d9b61dff4460d067ab980ec.svg",
      "available_event_ids": [
        "5982f139d48c360021b1eb69",
        "59c52a9c7651ce001f62f578",
        "5b28bf2485232200126f373e"
      ],
      "description": "Send HTTP requests to any target when events happen."
    }
  ]
}
```

--- row ---

## Get a Notification Platform

--- row ---

`GET https://$SCALINGO_API_URL/v1/notification_platforms/[:id]`

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -X GET https://$SCALINGO_API_URL/v1/notification_platforms/5982f145d48c3600273ef089
```

Returns 200 OK

```json
{
  "notification_platform": {
    "id": "5982f145d48c3600273ef089",
    "name": "slack",
    "display_name": "Slack",
    "logo_url": "https://cdn2.scalingo.com/dashboard/assets/images/notification/slack-831fd1b21576dbb3e0037b7211ecfd93.svg",
    "available_event_ids": [
      "5982f139d48c360021b1eb69",
      "59c52a9c7651ce001f62f578",
      "5b28be8e85232200126f373c",
      "5b28bf02aa9a340012832362",
      "5b28bf2485232200126f373e"
    ],
    "description": "Send events to your team thanks to Slack Incoming WebHooks."
  }
}
```

--- row ---

## Search a Notification Platform

--- row ---

`GET https://$SCALINGO_API_URL/v1/notification_platforms/search?name=[:platform_name]`

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -X GET https://$SCALINGO_API_URL/v1/notification_platforms/search?name=slack
```

Returns 200 OK

```json
{
  "notification_platforms": [
    {
      "id": "5982f145d48c3600273ef089",
      "name": "slack",
      "display_name": "Slack",
      "logo_url": "https://cdn2.scalingo.com/dashboard/assets/images/notification/slack-831fd1b21576dbb3e0037b7211ecfd93.svg",
      "available_event_ids": [
        "5982f139d48c360021b1eb69",
        "59c52a9c7651ce001f62f578",
        "5b28be8e85232200126f373c",
        "5b28bf02aa9a340012832362",
        "5b28bf2485232200126f373e"
      ],
      "description": "Send events to your team thanks to Slack Incoming WebHooks."
    }
  ]
}
```
