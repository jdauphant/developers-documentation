---
title: Log drains
layout: default
---

# Log drains

Log from an application can be redirect to a management service.
You can add multiple log drains from a single application.
You can also remove or list log drains by application.

You will find how to enable this service from the CLI on the <a href="https://doc.scalingo.com/platform/app/log-drain">public documentation</a>

--- row ---

**Supported protocol and logs management services with their parameter**

{:.table}
| Logs management service   | type        | token | host | port | drain_region | url | will format urls:                                    |
| ------------------------- | ------------| ----- | ---- | ---- | ------------ | --- | ---------------------------------------------------- |
| Datadog                   | datadog     | ✓     |      |      | ✓            |     | datadog://`TOKEN`?region=`DRAIN_REGION`              |
| OVH hosted Graylog        | ovh-graylog | ✓     | ✓    |      |              |     | ovh://:`TOKEN`@`HOST`:6514                           |
| Logentries                | logentries  | ✓     |      |      |              |     | https://webhook.logentries.com/noformat/logs/`TOKEN` |
| Papertrail                | papertrail  |       | ✓    | ✓    |              |     | tcp+tls://`HOST`:`PORT`                              |
| Syslog                    | syslog      |       | ✓    | ✓    |              |     | tcp+tls://`HOST`:`PORT`                              |
| Self-hosted ELK stack     | elk         |       |      |      |              | ✓   | `URL`                                                |

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


Note: `type` is mandatory.

||| col |||

--- row ---

## List log drains of an app

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

## Create a new log drain

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/:app/log_drains`

### Parameters

* `type`: can be any supported log management services type (e.g. papertrail, datadog...)
* `token`: used by certain vendor for authentication
* `host`: host of logs management service
* `port`: port of logs management service
* `drain_region`: region used by logs management service to identify their servers (e.g. region provided by datadog)
* `url`: URL of self hosted ELK

||| col |||

Example request

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
