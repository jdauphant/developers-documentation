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
| size        | int    | backup size                      |
| status      | string | backup status                    |
| database_id | string | database identifier              |


||| col |||

Example object:

```json

```

--- row ---

## List database backups

--- row ---

`GET https://db-api.scalingo.com/api/databases/[:db]/backups`

Display a precise backup

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/databases/my-db-123/backups
```

Returns 200 OK

```json

```

--- row ---

## Get a backup download link

--- row ---

`GET https://db-api.scalingo.com/api/databases/[:db]/backups/[:backup]/archive`

Get a presigned URL to download your backup

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/databases/my-db-123/backups/abcdefabcdefabcdef/archive
```

Returns 200 OK

```json

```

