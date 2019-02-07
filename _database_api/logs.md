---
title: Logs
layout: default
---

# Logs

--- row ---

## Get database logs

--- row ---

`GET https://db-api.scalingo.com/dapi/databases/[:database_id]/logs`

{:.table}
| field | type   | description                              |
| --    | --     | --                                       |
| url   | string | Authenticated logs URL for this database |

The request will generate an URL you can use to access the logs of your database.

How to use this endpoint: [more information here](/logs.html)

||| col |||

Example request

```sh
curl -H "Accent: application/json" -u ':$TOKEN' \
  -X GET https://db-api.scalingo.com/api/my-awesome-db-1234/metrics
```

Returns 200 OK

```json
{
  "url": "https://logs.scalingo.com/apps/59e6641ab8c6f11f89d0b950/logs?token=authentication_token"
}
```


