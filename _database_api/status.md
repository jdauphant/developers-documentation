---
title: Status
layout: default
---

# Logs

--- row ---

## Get Database Instances Status

--- row ---

`GET https://db-api.scalingo.com/dapi/databases/[:database_id]/instances_status`

{:.table}
| field | type   | description                              |
| --    | --     | --                                       |
| id    | string | Instance Id                              |
| type  | string | Instance type                            |
| status| string | Instance status                          |
| healthy| bool   | Instance healthy or not                 |
| role  | string | Instance role in the cluster             |

The request will generate will provide information about the instances of a given database

||| col |||

Example request

```sh
curl -H "Accent: application/json" \
  -H "Authorization: Bearer $DB_BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/my-awesome-db-1234/instances_status
```

Returns 200 OK

```json
[
  {
    "id": "5b8a26d4-160b-484a-be7f-258ae4cad80d",
    "type": "gateway",
    "status": "running",
    "healthy": true,
    "role": ""
  },
  {
    "id": "a541dfb5-1fa6-40d7-87de-159ab721322c",
    "type": "db-node",
    "status": "running",
    "healthy": true,
    "role": "primary"
  },
  {
    "id": "9597fb2e-b3ee-4917-bca8-d7c4333c8cc6",
    "type": "gateway",
    "status": "running",
    "healthy": true,
    "role": "secondary"
  },
  {
    "id": "33067baf-807c-4a9a-a966-25008945968b",
    "type": "gateway",
    "status": "running",
    "healthy": true,
    "role": "secondary"
  }
]
```

