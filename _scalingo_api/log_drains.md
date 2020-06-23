---
title: Log Drains
layout: default
---

# Log Drains

Logs from an application or addon can be redirected to a log management service.
You can add multiple log drains to a single application or addon. You can also
remove or list log drains of an application or addon.

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
| addon_uuid          | string  | UUID of the addon you want to add it to                          |


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
{
    "drains": [
        {
            "app_id": "5af97be7ff688d0001228ffb",
            "url": "ovh://:5af97be7-34e5-47b6-a016-8d0001228ffb@tag1.logs.ovh.com:6514"
        },
        {
            "app_id": "5af97be7ff688d0001228ffb",
            "url": "syslog://:5af97b34e547b6a016@custom.logs.com:1234"
        }
    ]
}
```

--- row ---

## List Log Drains of an Addon

--- row ---

`GET https://$SCALINGO_API_URL/v1/apps/:app/addons/:addon_uuid/log_drains`

||| col |||

Example request

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
 -X GET "https://$SCALINGO_API_URL/v1/apps/example-app/addons/ad-9be0fc04-bee6-4981-a403-a9dd4981bd1f/log_drains"
```

Returns 200 OK

```json
{
    "drains": [
        {
            "app_id": "5edea403c6f3498189aa4981",
            "url": "ovh://:5af97be7-34e5-47b6-a016-8d0001228ffb@tag1.logs.ovh.com:6514",
        },
        {
            "app_id": "5edea403c6f3498189aa4981",
            "url": "syslog://:5af97b34e547b6a016@custom.logs.com:1234",
        }
    ]
}
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

## Add a new Log Drain to an Addon

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/:app/addons/:addon_uuid/log_drains`

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
  -X POST https://$SCALINGO_API_URL/v1/apps/example-app/addons/ad-9be0fc04-bee6-4981-a403-a9dd4981bd1f/log_drains -d \
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
  -X POST https://$SCALINGO_API_URL/v1/apps/example-app/addons/ad-9be0fc04-bee6-4981-a403-a9dd4981bd1f/log_drains -d \
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

## Delete a Log Drain

--- row ---

`DELETE https://$SCALINGO_API_URL/v1/apps/:app/log_drains`

### Parameter

* `url`: logs drain URL to delete. You can get it by listing the logs drain of
an application.

||| col |||

Example request

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X DELETE https://$SCALINGO_API_URL/v1/apps/example-app/log_drains -d \
  '{
    "url": "ovh://:5af97be7-34e5-47b6-a016-8d0001228ffb@tag1.logs.ovh.com:6514"
   }'
```

Returns 204 No Content


--- row ---
