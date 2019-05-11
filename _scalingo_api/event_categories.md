---
title: Event Categories
layout: default
---

# Event Categories

Event categories is an organisational type used to help organizing the list of
[Event Types](/event_types) on the client side.

--- row ---

**Event Category attributes**

{:.table}
| field        | type   | description                           |
| ------------ | ------ | ------------------------------------- |
| id           | string | unique ID of event type               |
| name         | string | camel case name of the type           |
| display_name | string | fancy name of the type                |
| position     | int    | order of "importance" when displayed  |

||| col |||

Example object:

* App Operations category

```json
{
  "id": "5982f139d48c360021b1eb44",
  "name":	"app_operations",
  "display_name": "App operations",
  "position":	1
}
```

--- row ---

## List the event categories

--- row ---

This provides the list of event categories, usefull to display [Event Types](/event_types) properly.

`GET https://api.scalingo.com/v1/event_categories`

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" https://api.scalingo.com/v1/event_categories
```

Returns 200 OK

Response

```json
{
  "event_categories" : [
    {
      "id" : "5982f139d48c360021b1eb44",
      "name" : "app_operations",
      "position" : 1,
      "display_name" : "App operations"
    },
    {
      "id" : "5982f139d48c360021b1eb45",
      "name" : "addons",
      "position" : 2,
      "display_name" : "Addons"
    }, ...
  ]
}
```
