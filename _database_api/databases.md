---
title: Databases
layout: default
---

# Databases

--- row ---

**Databases attributes**

{:.table}
| field                         | type    | description                                    |
| ----------------------------  | ------- | ---------------------------------------------- |
| id                            | string  | unique ID                                      |
| resource_id                   | string  | resource reference                             |
| app_name                      | string  | name of the linked application                 |
| created_at                    | date    | creation date of the database                  |
| encryption_at_rest            | boolean | is encryption at rest enabled on this database |
| plan                          | string  | name of the application plan                   |
| status                        | string  | status of the current database                 |
| type_id                       | string  | database type ID                               |
| type_name                     | string  | database type Name                             |
| version_id                    | string  | database version ID                            |
| readable_version              | string  | human readable database version                |
| instances                     | array   | list of all database instances                 |
| features                      | array   | list of all database features                  |
| periodic_backups_enabled      | boolean | true if periodic backups are enabled           |
| periodic_backups_scheduled_at | array   | hours of the day of the periodic backup (UTC)  |

**Instance attributes**

{:.table}
| field    | type    | description                               |
| -------- | ------  | ----------------------------------------- |
| id       | string  | unique ID                                 |
| hostname | string  | FQDN of the instance                      |
| port     | integer | instance port                             |
| status   | string  | status of the current instance            |
| type     | string  | is this node a database node or a gateway |

||| col |||

Example object:

```json
{
  "database": {
    "id": "5c599fd6f18b3202f7ab4e66",
    "resource_id": "lolapp-2107",
    "app_name": "lolapp",
    "created_at": "2019-02-05T15:38:14.343+01:00",
    "encryption_at_rest": true,
    "features": [
      {
        "name": "redis-rdb",
        "status": "ACTIVATED"
      }
    ],
    "plan": "free",
    "status": "running",
    "type_id": "5bf30d1104c87f000161285a",
    "type_name": "redis",
    "version_id": "5bf30d1104c87f000161285b",
    "instances": [
      {
        "id": "a7ecbaf9-7f3c-4324-bf35-975f546718c2",
        "hostname": "a7ecbaf9-7f3c-4324-bf35-975f546718c2.test-db.redis.dbs.scalingo.com",
        "port": 1234,
        "status": "running",
        "type": "db-node"
      }
    ],
    "readable_version": "3.2.9-1",
    "periodic_backups_enabled": true,
    "periodic_backups_scheduled_at": [0]
  }
}
```

--- row ---

## Retrieve Database Information

--- row ---

`GET https://db-api.scalingo.com/api/databases/[:db_id]`

Retrieve information of a specific database.

To find the database ID you must use our [addon API documentation](/addons).
The ID to use correspond to the addon's `id` field.


||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DB_BEARER_TOKEN" \
  -X GET https://db-api.scalingo.com/api/databases/my-db-123
```

Returns 200 OK

```json
{
  "database": {
    "id": "5c599fd6f18b3202f7ab4e66",
    "resource_id": "lolapp-2107",
    "app_name": "lolapp",
    "created_at": "2019-02-05T15:38:14.343+01:00",
    "encryption_at_rest": true,
    "features": [
      {
        "name": "redis-rdb",
        "status": "ACTIVATED"
      }
    ],
    "plan": "free",
    "status": "running",
    "type_id": "5bf30d1104c87f000161285a",
    "type_name": "redis",
    "version_id": "5bf30d1104c87f000161285b",
    "instances": [],
    "readable_version": "3.2.9-1",
    "periodic_backups_enabled": true,
    "periodic_backups_scheduled_at": [0]
  }
}
```

--- row ---

## Update a Database

--- row ---

`PATCH https://db-api.scalingo.com/api/databases/[:db_id]`

or

`PUT https://db-api.scalingo.com/api/databases/[:db_id]`

Update database settings.

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DB_BEARER_TOKEN" \
  -X PATCH https://db-api.scalingo.com/api/databases/my-db-123 \
  -d '{
    "database": {
      "periodic_backups_enabled": true,
      "periodic_backups_scheduled_at": 3
    }
  }'
```

Returns 200 OK

```json
{
  "database": {
    "id": "5c599fd6f18b3202f7ab4e66",
    "resource_id": "lolapp-2107",
    "app_name": "lolapp",
    "created_at": "2019-02-05T15:38:14.343+01:00",
    "encryption_at_rest": true,
    "features": [
      {
        "name": "redis-rdb",
        "status": "ACTIVATED"
      }
    ],
    "plan": "free",
    "status": "running",
    "type_id": "5bf30d1104c87f000161285a",
    "type_name": "redis",
    "version_id": "5bf30d1104c87f000161285b",
    "instances": [],
    "readable_version": "3.2.9-1",
    "periodic_backups_enabled": true,
    "periodic_backups_scheduled_at": [3]
  }
}
```

--- row ---

## Point-in-Time Restoration

--- row ---

`POST https://db-api.scalingo.com/api/databases/[:db_id]/pitr/restore`

Restore the database data at a specific point in time. This is currently only
available for PostgreSQL databases.

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DB_BEARER_TOKEN" \
  -X POST https://db-api.scalingo.com/api/databases/my-db-123/pitr/restore \
  -d '{
    "restore_time": "2019-07-18T23:00:00Z"
  }'
```

Returns 201 Created

```json
{
  "operation_id": "5c10e85ca506b701f42f92dc"
}
```

--- row ---

## Actions over Database Management System

--- row ---

`POST https://db-api.scalingo.com/api/databases/[:db_id]/action`

This generic endpoint aims at wrapping direct actions over the running
database. The different possible actions depend on the type of the database,
as well as their parameters and return value.

Generic Parameters:

```json
{
  "action_name": "name-of-the-action",
  "params": {
    "option1": "value1"
  }
}
```

Generic Success response

```json
{
  "ok": 1,
  "result": {"prop1": "value1"}
}
```

Generic Error Response:

```json
{
  "ok": 0,
  "error": "something bad happened"
}
```

### MySQL

#### Logical Database Management

* `list-databases`: List all logical databases of the database deployment

||| col |||

Result:

```json
{
  "ok": 1,
  "result": [
    {
      "name": "database-name-1234",
      "protected": true
    }, {
      "name": "custom-db",
      "protected": false
    }
  ]
}
```

--- row ---

* `create-database`: Create a new logical database

||| col |||

Params:

```json
{
  "action_name": "create-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": {
    "name": "custom-db",
    "protected": false
  }
}
```

--- row ---

* `delete-database`: Delete a logical database

||| col |||

Params:

```json
{
  "action_name": "delete-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `reset-database`: Delete all data inside a logical database

||| col |||

Params:

```json
{
  "action_name": "delete-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

#### SQL Mode Configuration

* `get-sqlmode`: Get the current SQL Mode of the database

||| col |||

Params:

```json
{
  "action_name": "get-sqlmode",
  "params":  null
}
```

Response:

```json
{
  "ok": 1,
  "result": "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
}
```

--- row ---

* `set-sqlmode`: Set the SQL Mode of the database

||| col |||

```json
{
  "action_name": "set-sqlmode",
  "params":  "NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO"
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

[MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

### PostgreSQL

#### Extensions Management

* `list-extensions`: List enabled PostgreSQL extensions and their version

||| col |||

```json
{
  "action_name": "list-extensions",
  "params": null
}
```

Response:

```json
{
  "ok": 1,
  "result": [
    {
      "name": "plpgsql",
      "version": "v1.0"
    }, {
      "name": "postgis",
      "version": "v2.5.0"
    }
  ]
}
```

--- row ---

#### Running Query Management

* `pg-list-queries`: List running and idle queries of the database

||| col |||

Params:

```json
{
  "action_name": "pg-list-queries"
}
```

Response:

```javascript
{
  "ok": 1,
  "result": [
    {
      "query": "SELECT * FROM users",
      "state": "active",
      "username": "username_1234",
      "query_start": "2020-05-10T09:00:00Z",
      "pid": 2000,
      "query_duration": 1000000000
    }, {
      // ...
    }
  ]
}
```

*`query_duration` is in nanoseconds*

--- row ---

* `pg-cancel-query`: Ask PostgreSQL to cancel: (`pg_cancel_backend` method)

||| col |||

Params:

```json
{
  "action_name": "pg-cancel-query",
  "params": {
    "pid": 2000
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `pg-terminate-query`: Force stop a running query (`pg_terminate_backend` method)

||| col |||

Params:

```json
{
  "action_name": "pg-terminate-query",
  "params": {
    "pid": 2000
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

[PostgreSQL documentation](https://www.postgresql.org/docs/12/functions-admin.html#FUNCTIONS-ADMIN-SIGNAL)

#### Query Stats

* `pg-stat-statements-enable`: Enable the collect of stats using the extension pg-stat-statements.

||| col |||

Params:

```json
{
  "action_name": "pg-stat-statements-enable"
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `pg-stat-statements-reset`: Reset stats collect

||| col |||

Params:

```json
{
  "action_name": "pg-stat-statements-reset"
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `pg-stat-statements-list`: List current stats

||| col |||

Params:

```json
{
  "action_name": "pg-stat-statements-list"
}
```

Response:

```javascript
{
  "ok": 1,
  "result": [
    {
      "user_id": 1000,
      "query": "SELECT * FROM users",
      "calls": 24512,
      "rows": 500,
      "total_time": 1837.1,
      "min_time": 0.2,
      "max_time": 3.5,
      "mean_time": 0.6,
      "std_dev": 0.1
    }, {
       // ...
    }
  ]
}
```

--- row ---

[PostgreSQL documentation](https://www.postgresql.org/docs/12/pgstatstatements.html)

### MongoDB

#### Logical Database Management

* `list-databases`: List all logical databases of the database deployment

||| col |||

Result:

```json
{
  "ok": 1,
  "result": [
    {
      "name": "database-name-1234",
      "protected": true
    }, {
      "name": "custom-db",
      "protected": false
    }
  ]
}
```

--- row ---

* `create-database`: Create a new logical database

||| col |||

Params:

```json
{
  "action_name": "create-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": {
    "name": "custom-db",
    "protected": false
  }
}
```

--- row ---

* `delete-database`: Delete a logical database

||| col |||

Params:

```json
{
  "action_name": "delete-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `reset-database`: Delete all data inside a logical database

||| col |||

Params:

```json
{
  "action_name": "delete-database",
  "params":  {
    "database_name": "custom-db"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

### InfluxDB

#### Retention Policy Management

* `list-retention-policies`: List existing retention policies

||| col |||

Params:

```json
{
  "action_name": "list-retention-policies"
}
```

Response:

```json
{
  "ok": 1,
  "result":  [
    {
      "name": "autogen",
      "duration": "0",
      "default": true
    }, {
      "name": "30-days",
      "duration": "30d",
      "default": false
    }
  ]
}
```

--- row ---

* `add-retention-policy`: Create a new retention policy

||| col |||

Params:

```json
{
  "action_name": "add-retention-policy",
  "params":  {
    "name": "30-days",
    "duration": "30d",
    "default": true
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

* `del-retention-policy`: Delete an existing retention policy

||| col |||

Params:

```json
{
  "action_name": "del-retention-policy",
  "params":  {
    "name": "30-days"
  }
}
```

Response:

```json
{
  "ok": 1,
  "result": null
}
```

--- row ---

[InfluxDB documentation](https://docs.influxdata.com/influxdb/v1.8/query_language/manage-database/)
