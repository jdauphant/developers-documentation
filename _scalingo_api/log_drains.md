---
title: Log Drains
layout: default
---

# Log Drains

Logs from an application can be redirected to a log management service.
You can add multiple log drains to a single application.
You can also remove or list log drains of an application.

You will find how to enable this service using the CLI on the
<a href="https://doc.scalingo.com/platform/app/log-drain">public documentation</a>.

--- row ---

**Supported protocol and logs management services with their parameter**

{:.table}
| Logs management service   | type        | token | host | port | drain_region | url |
| ------------------------- | ------------| ----- | ---- | ---- | ------------ | --- |
| Datadog                   | datadog     | ✓     |      |      | ✓            |     |
| OVH hosted Graylog        | ovh-graylog | ✓     | ✓    |      |              |     |
| Logentries                | logentries  | ✓     |      |      |              |     |
| Papertrail                | papertrail  |       | ✓    | ✓    |              |     |
| Syslog                    | syslog      |       | ✓    | ✓    |              |     |
| Self-hosted ELK stack     | elk         |       |      |      |              | ✓   |

--- row ---

**log drain attributes**

{:.table}
| field               | type    | description                                                      |
| ------------------- | ------  | ---------------------------------------------------------------- |
| type                | string  | Communication protocol with the logs management service          |
| token               | string  | Token used by logs management service for authentication         |
| host                | string  | Host of logs management service                                  |
| port                | string  | Port of logs management service                                  |
| drain-region        | string  | Region used by logs management service to identify their servers |
| url                 | string  | URL of self hosted ELK                                           |


Note: `type` is mandatory. Mandatory attributes will depend on the chosen type, please
refer to the first table.

||| col |||

--- row ---

## List Log Drains of an App

--- row ---

`GET https://$SCALINGO_API_URL/v1/apps/:app/log_drains`

||| col |||

Example request

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/apps/example-app/log_drains
```

Returns 200 OK

```json
[
    {
        "app_id": "5af97be7ff688d0001228ffb",
        "url": "ovh://:id@tag1.logs.ovh.com:6514"
    },
    {
        "app_id": "5af97be7ff688d0001228ffb",
        "url": "syslog://:id@custom.logs.com:port"
    }
]
```

--- row ---

## Add a new Log Drain

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/:app/log_drains`

### Parameters

* `type`: can be any supported log management services type (e.g. papertrail,
datadog...)
* `token`: used by certain vendor for authentication (optional)
* `host`: host of logs management service (optional)
* `port`: port of logs management service (optional)
* `drain_region`: region used by logs management service to identify their
servers (e.g. region provided by datadog) (optional)
* `url`: URL of self hosted ELK (optional)

||| col |||

Example requests

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps/example-app/log_drains -d \
  '{
    "drain": {
        "type": "ovh-graylog",
        "token": "5af97be7-34e5-47b6-a016-8d0001228ffb",
        "host": "tag1.logs.ovh.com"
    }
  }'
```

Returns 201 Created

```json
{
  "drain":
    {
      "url": "ovh://:5af97be7-34e5-47b6-a016-8d0001228ffb@tag1.logs.ovh.com:6514"
    }
}
```



```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps/example-app/log_drains -d \
  '{
    "drain": {
        "type": "datadog",
        "token": "5af97be7-34e5-47b6-a016-8d0001228ffb",
        "drain_region": "eu-west-2"
    }
  }'
```

Returns 201 Created

```json
{
  "drain":
    {
      "url": "datadog://5af97be7-34e5-47b6-a016-8d0001228ffb?region=eu-west-2"
    }
}
```

--- row ---
