---
title: Alerts
layout: default
---

# Alerts

--- row ---

**Alert attributes**

{:.table}
| field                   | type    | description                                  |
| ----------------------- | ------- | -------------------------------------------- |
| id                      | string  | unique ID, starts with "al-"                 |
| app_id                  | string  | ID of the application this alert applies to  |
| created_at              | date    | creation date of the alert                   |
| updated_at              | date    | last time the alert has been updated         |
| container_type          | string  | container type concerned by the alert        |
| disabled                | boolean | is the alert disabled                        |
| metric                  | string  | metric name this alert is about              |
| limit                   | float   | threshold to activate the alert              |
| send_when_below         | boolean | will the alert be sent when the value goes   |
|                         |         | above or below the limit                     |
| duration_before_trigger | int     | alert is triggered if the value is above the |
|                         |         | limit for the specified	duration             |
|                         |         | activated                                    |
| remind_every            | string  | send the alert at regular interval when      |
|                         |         | activated                                    |
| metadata                | object  | various data                                 |

||| col |||

Example object:

```json
{
  "id": "al-297f1134-8576-45ac-ab58-2100b6807683",
  "app_id": "5ab1128fdccb8b0001111963",
  "created_at": "2018-03-20T14:56:06.27014439Z",
  "updated_at": "2018-03-20T14:56:06.27014439Z",
  "container_type": "web",
  "disabled": false,
  "metric": "p95_response_time",
  "limit": 60,
  "send_when_below": false,
  "duration_before_trigger": "3m0s",
  "remind_every": "5m30s",
  "metadata": {
    "recipient": "user"
  }
}
```

--- row ---

## List alerts of an app

--- row ---

`GET https://api.scalingo.com/v1/apps/[:app]/alerts`

||| col |||

Example request

```
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X GET https://api.scalingo.com/v1/apps/example-app/alerts
```

Returns 200 OK

```json
{
	"alerts": [
		{
			"created_at": "2018-05-14T13:19:46.764Z",
			"updated_at": "2018-05-30T13:01:22.257Z",
			"deleted_at": "0001-01-01T00:00:00Z",
			"id": "al-b479b620-08da-460c-a00c-fe271086179d",
			"app_id": "5af97be7ff688d0001228ffb",
			"disabled": false,
			"metric": "cpu",
			"limit": 0.02,
			"container_type": "web",
			"send_when_below": false,
			"duration_before_trigger": "3m0s",
			"metadata": {
				"recipient": "user"
			},
			"notifiers": [
				"no-6d5a1648-3a2d-43ec-a526-12c20ae757d2"
			]
		}
	]
}
```

--- row ---
## Create a new alert

--- row ---

`POST https://api.scalingo.com/v1/apps/[:app]/alerts`

### Parameters

* `container_type`: can be any container type of an application (e.g. web,
  clock...)
* `limit`: Any float value. For any resource consumption, please provide `0.1`
  if you need to be alerted when the consumption goes above `10%`.
* `metric`: e.g. RPM per container, RAM consumption...
* `notifiers`: list of notifier ID that will receive the alerts (optional)
* `send_when_below`: will the alert be sent when the value goes above or below
  the limit (optional)
* `duration_before_trigger`: the alert is triggered if the value is above the
  limit for the specified	duration. Duration is expressed in nanoseconds.
  (optional)
* `remind_every`: send the alert at regular interval when activated (optional)

||| col |||

Example request

```
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/alerts -d \
  '{
    "alert": {
      "container_type": "web",
      "limit": 0.8,
      "metric": "memory",
      "notifiers": ["5a69b83117b2cc001d9f2745"]
    }
  }'
```

Returns 201 Created

```json
{
	"alert": {
		"id": "al-297f1134-8576-45ac-ab58-2100b6807683",
		"app_id": "5ab1128fdccb8b0001111963",
		"created_at": "2018-03-20T14:56:06.27014439Z",
		"updated_at": "2018-03-20T14:56:06.27014439Z",
		"container_type": "web",
		"disabled": false,
		"metric": "memory",
		"limit": 0.8,
		"send_when_below": false,
		"metadata": {
			"recipient": "user"
		}
	}
}
```

--- row ---

## Get an alert

--- row ---

`GET https://api.scalingo.com/v1/apps/[:app]/alerts/[:alert_id]`

Display a specific alert

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X GET https://api.scalingo.com/v1/apps/example-app/alerts/al-297f1134-8576-45ac-ab58-2100b6807683
```

Returns 200 OK

```json
{
	"alert": {
		"id": "al-297f1134-8576-45ac-ab58-2100b6807683",
		"app_id": "5ab1128fdccb8b0001111963",
		"created_at": "2018-03-20T14:56:06.27014439Z",
		"updated_at": "2018-03-20T14:56:06.27014439Z",
		"container_type": "web",
		"disabled": false,
		"metric": "memory",
		"limit": 0.8,
		"send_when_below": false,
		"metadata": {
			"recipient": "user"
		}
	}
}
```

--- row ---

## Update an alert

--- row ---

`PATCH https://api.scalingo.com/v1/apps/[:app]/alerts/[:alert_id]`

or

`PUT https://api.scalingo.com/v1/apps/[:app]/alerts/[:alert_id]`

Updates some alert attributes:

* `container_type`: can be any container type of an application (e.g. web,
  clock...)
* `limit`: Any float value. For any resource consumption, please provide `0.1`
  if you need to be alerted when the consumption goes above `10%`.
* `metric`: e.g. RPM per container, RAM consumption...
* `notifiers`: list of notifier ID that will receive the alerts
* `send_when_below`: will the alert be sent when the value goes above or below
  the limit
* `duration_before_trigger`: the alert is triggered if the value is above the
  limit for the specified	duration. Duration is expressed in nanoseconds.
  (optional)
* `remind_every`: send the alert at regular interval when activated

All attributes are optional.

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X PATCH https://api.scalingo.com/v1/apps/example-app/alerts/al-297f1134-8576-45ac-ab58-2100b6807683 -d \
  '{
    "alert": {
      "limit": 150,
      "metric": "rpm_per_container",
      "notifiers": ["5a69b83117b2cc001d9f2745"]
    }
  }'
```

Returns 200 OK

```json
{
	"alert": {
		"id": "al-297f1134-8576-45ac-ab58-2100b6807683",
		"app_id": "5ab1128fdccb8b0001111963",
		"created_at": "2018-03-20T14:56:06.27014439Z",
		"updated_at": "2018-03-20T15:02:12.98017965Z",
		"container_type": "web",
		"disabled": false,
		"metric": "rpm_per_container",
		"limit": 150,
		"send_when_below": false,
		"metadata": {
			"recipient": "user"
		}
	}
}
```

--- row ---

## Delete an alert

--- row ---

`DELETE https://api.scalingo.com/v1/apps/[:app]/alerts/[:alert_id]`


Delete the given alert

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X DELETE https://api.scalingo.com/v1/apps/example-app/alerts/al-297f1134-8576-45ac-ab58-2100b6807683
```

Returns 204 No Content
