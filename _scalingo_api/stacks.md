---
title: Stacks
layout: default
---

# Stacks

--- row ---

**Stack attributes**

{:.table}
| field       | type    | description                             |
| ---         | ---     | ---                                     |
| id          | string  | unique ID, starts with 'st-'            |
| name        | string  | stack display name                 |
| base_image  | string  | docker image used to build your app     |
| default     | boolean | is this the default stack for new app   |
| created_at  | date    | creation date of the stack              |
| description | string  | human readable description of the stack |

||| col |||

```json
{
  "id": "st-44b8ae3c-db5d-4e17-9344-65dcbfab095e",
  "name": "scalingo-18",
  "base_image": "scalingo/builder-18:v7",
  "default": true,
  "created_at": "2019-04-15T16:15:00.147Z",
  "description": "Runtime stack based on Ubuntu 18:04"
}
```

--- row ---

## List available stacks

--- row ---

`GET https://$SCALINGO_API_URL/v1/features/stacks`

||| col |||

Example request

```
curl -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -X GET https://$SCALINGO_API_URL/v1/features/stacks
```

Returns 200 OK

```json
{
  "stacks": [
    {
      "id": "st-44b8ae3c-db5d-4e17-9344-65dcbfab095e",
      "name": "scalingo-18",
      "base_image": "scalingo/builder-18:v7",
      "default": true,
      "created_at": "2019-04-15T16:15:00.147Z",
      "description": "Runtime stack based on Ubuntu 18:04"
    },
    {
      "id": "st-28835645-48b4-4c09-a4da-07aa411724c5",
      "name": "scalingo-14",
      "base_image": "scalingo/builder:v28",
      "default": false,
      "created_at": "2019-01-16T12:26:42.016Z",
      "description": "Stack based on Ubuntu 14:04"
    }
  ]
}
```
