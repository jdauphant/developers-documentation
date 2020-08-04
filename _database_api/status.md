---
title: Instance Status
layout: default
---

# Instance Status

--- row ---

## Get Database Instances Status

--- row ---

`GET https://$DB_API_URL/api/databases/[:database_id]/instances_status`

{:.table}
| field | type   | description                              |
| --    | --     | --                                       |
| id    | string | Instance ID                              |
| type  | string | Instance type                            |
| status| string | Instance status                          |
| role  | string | Instance role in the cluster             |

The request provides information about the instances of a given database.
Type is about the instance type, so either `db-node` or `gateway` node. An additional service type `utility` can exist.
Status is about the instance current status. The functional status is `running`. Others possibilities are `booting`, `restarting`, `migrating`, `upgrading`, `stopped`, `removing`.
Role is about the instance role in the cluster. For DB nodes, it will depends of the DB type. Generic values are `leader` and `follower`.

||| col |||

Example request

```sh
curl -H "Accent: application/json" \
  -H "Authorization: Bearer $DB_BEARER_TOKEN" \
  -X GET https://$DB_API_URL/api/my-awesome-db-1234/instances_status
```

Returns 200 OK

```json
[
  {
    "id": "5b8a26d4-160b-484a-be7f-258ae4cad80d",
    "type": "gateway",
    "status": "running",
    "role": ""
  },
  {
    "id": "a541dfb5-1fa6-40d7-87de-159ab721322c",
    "type": "db-node",
    "status": "running",
    "role": "leader"
  },
  {
    "id": "9597fb2e-b3ee-4917-bca8-d7c4333c8cc6",
    "type": "gateway",
    "status": "running",
    "role": "follower"
  },
  {
    "id": "33067baf-807c-4a9a-a966-25008945968b",
    "type": "gateway",
    "status": "running",
    "role": "follower"
  }
]
```
