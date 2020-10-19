---
title: Metrics
layout: default
---

# Metrics

--- row ---

**Metric attributes**

{:.table}
| field            | type    | description                                        |
| ---------------- | ------- | -------------------------------------------------- |
| id               | string  | unique identifier                                  |
| label            | string  | human readable string explaining this metric       |
| suffix           | string  | symbol used as a suffix after this metric value    |
| type             | string  | type of metric. Can be either `global` or `router` |

||| col |||

Example object:

```json
{
  "id": "cpu",
  "label": "CPU",
  "suffix": "%",
  "type": "global"
}
```

--- row ---

## List the metrics available

--- row ---

This endpoint can be reached unauthenticated.

`GET https://$SCALINGO_API_URL/v1/features/metrics`

List all the metrics available on the platform. These metrics are useful with the alert and the
autoscaling features.

||| col |||

Example Request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -X GET https://$SCALINGO_API_URL/v1/features/metrics
```

Returns 200 OK

```json
{
	"metrics": [
		{
			"id": "cpu",
			"label": "CPU",
			"suffix": "%",
			"type": "global"
		},
		{
			"id": "memory",
			"label": "RAM",
			"suffix": "%",
			"type": "global"
		},
		{
			"id": "swap",
			"label": "Swap",
			"suffix": "%",
			"type": "global"
		},
		{
			"id": "p95_response_time",
			"label": "Response Time",
			"suffix": "ms",
			"type": "router"
		},
		{
			"id": "5XX",
			"label": "5xx Errors",
			"suffix": "",
			"type": "router"
		},
		{
			"id": "all",
			"label": "Requests per Minute",
			"suffix": "rpm",
			"type": "router"
		},
		{
			"id": "rpm_per_container",
			"label": "RPM per Container",
			"suffix": "rpm",
			"type": "router"
		}
	]
}
```
