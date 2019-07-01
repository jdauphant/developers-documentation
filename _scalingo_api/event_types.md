---
title: Event Types
layout: default
---

# Event Types

Event types represent the definition of the events which are published by the service.
They are used by [Notification Platforms](/notification_platforms) and by
[Notifiers](/notifiers) to configure which types of events will be sent to the configured
destinations.

--- row ---

**Event Type attributes**

{:.table}
| field        | type   | description                           |
| ------------ | ------ | ------------------------------------- |
| id           | string | unique ID of event type               |
| category_id  | string | category ID of the type               |
| name         | string | camel case name of the type           |
| display_name | string | fancy name of the type                |
| description  | string | description these events are produced |

||| col |||

Example object:

* Deployed Event

```json
{
  "id": "5982f139d48c360021b1eb4b",
  "category_id": "5982f139d48c360021b1eb44",
  "name": "app_deployed",
  "display_named": "App Deployed",
  "description": "The app was deployed"
}
```

--- row ---

## List the event types

--- row ---

This provides the list of event types to get IDs to create [Notifiers](/notifiers).

`GET https://$SCALINGO_API_URL/v1/event_types`

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" https://$SCALINGO_API_URL/v1/event_types
```

Returns 200 OK

Response

```json
{
  "event_types" : [
    {
      "name" : "app_deployed",
      "id" : "5982f139d48c360021b1eb4b",
      "category_id" : "5982f139d48c360021b1eb44",
      "display_name" : "App deployed",
      "description" : "An app was deployed"
    },
    {
      "display_name" : "App restarted",
      "description" : "An app was restarted",
      "name" : "app_restarted",
      "id" : "5982f139d48c360021b1eb4c",
      "category_id" : "5982f139d48c360021b1eb44"
    }, ...
  ]
}

```
