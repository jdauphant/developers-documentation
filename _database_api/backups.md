---
title: Backups
layout: default
---

# Backups

--- row ---

**Backup attributes**

{:.table}
| field       | type   | description                      |
| ----------- | ------ | -------------------------------- |
| id          | string | unique ID identifying the backup |
| created_at  | date   | when the database was created at |
| name        | string | name of the backup               |
| size        | int    | backup size in bytes             |
| status      | string | backup status                    |
| database_id | string | database identifier              |


||| col |||

Example object:

```json
{
  "id": "5b8b36104ffb090be1ac3ce1",
  "created_at": "2018-09-02T03:00:00.178+02:00",
  "name": "20180902010000_kibana-3938",
  "size": 17484513608,
  "status": "done",
  "database_id": "597601234ffb097af4f3099b",
}
```

--- row ---

## List database backups

--- row ---

`GET https://db-api.scalingo.com/api/databases/[:db]/backups`

List all backups for a database

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/databases/my-db-123/backups
```

Returns 200 OK

```json
{
  "database_backups": [
    {
      "id": "5bde44904ffb096c714be89c",
      "created_at": "2018-11-04T02:00:00.154+01:00",
      "name": "20181104010000_kibana-3938",
      "size": 0,
      "status": "pending",
      "database_id": "597601234ffb097af4f3099b",
    },
    {
      "id": "5bb95a904ffb096e9a2831b8",
      "created_at": "2018-10-07T03:00:00.150+02:00",
      "name": "20181007010000_kibana-3938",
      "size": 0,
      "status": "error",
      "database_id": "597601234ffb097af4f3099b",
    },
    {
      "id": "5b8b36104ffb090be1ac3ce1",
      "created_at": "2018-09-02T03:00:00.178+02:00",
      "name": "20180902010000_kibana-3938",
      "size": 17484513608,
      "status": "done",
      "database_id": "597601234ffb097af4f3099b",
    }
  ]
}

```

--- row ---

## Get a backup download link

--- row ---

`GET https://db-api.scalingo.com/api/databases/[:db]/backups/[:backup]/archive`

Get a pre-signed URL to download your backup

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/databases/my-db-123/backups/abcdefabcdefabcdef/archive
```

Returns 200 OK

```json
{
  "download_url": "https://db-api.scalingo.com/api/databases/my-db-123/backups/5b8a36104ffb090be1ac3ce1/download?token=token1234"
}
```

