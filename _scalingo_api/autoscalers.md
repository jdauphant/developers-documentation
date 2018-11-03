---
title: Autoscalers
layout: default
---

# Autoscalers

--- row ---

**Autoscaler attributes**

{:.table}
| field               | type    | description                                   |
| ------------------- | ------  | --------------------------------------------- |
| id                  | string  | unique ID, starts with "au-"                  |
| created_at          | date    | creation date of the autoscaler               |
| updated_at          | date    | last time the autoscaler has been updated     |
| last_scale          | date    | date of the last scale operation              |
| container_type      | string  | container type affected by the autoscaling    |
| min_containers      | int     | lower limit of containers                     |
| max_containers      | int     | upper limit of containers                     |
| metric              | string  | metric name this autoscaler is about          |
| target              | float   | metric value the autoscaler aims to reach     |
| disabled            | boolean | is the autoscaler disabled                    |
| alert_id_scale_up   | string  | alert triggered when needed to scale up       |
| alert_id_scale_down | string  | alert triggered when needed to scale down     |

||| col |||

Example object:

```json
{
  "id": "au-297f1134-8576-45ac-ab58-2100b6807683",
  "created_at": "2018-01-25T10:57:53.822973091Z",
  "updated_at": "2018-02-12T09:22:12.485973091Z",
  "last_scale": "2018-04-11T18:22:12.485973091Z",
  "container_type": "web",
  "min_containers": 3,
  "max_containers": 7,
  "metric": "rpm_per_container",
  "target": 150,
  "alert_id_scale_up": "al-9817cecc-a69c-436c-aacf-9b93d7f313c2",
  "alert_id_scale_down": "al-3eaaa1eb-9687-49b3-a6a4-f00d9e724f8a"
}
```

--- row ---

## List autoscalers of an app

--- row ---

`GET https://api.scalingo.com/v1/apps/:app/autoscalers`

||| col |||

Example request

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X GET https://api.scalingo.com/v1/apps/example-app/autoscalers
```

Returns 200 OK

```json
{
  "autoscalers": [
    {
      "id": "au-297f1134-8576-45ac-ab58-2100b6807683",
      "created_at": "2018-01-25T10:57:53.822973091Z",
      "updated_at": "2018-01-25T10:57:53.822973091Z",
      "app_id": "5af97be7ff688d0001228ffb",
      "alert_id_scale_up": "al-9817cecc-a69c-436c-aacf-9b93d7f313c2",
      "alert_id_scale_down": "al-3eaaa1eb-9687-49b3-a6a4-f00d9e724f8a",
      "last_scale": "0001-01-01T00:00:00Z",
      "container_type": "web",
      "min_containers": 3,
      "max_containers": 7,
      "metric": "rpm_per_container",
      "target": 150,
      "disabled": false,
    }
  ]
}
```

--- row ---

## Create a new autoscaler

--- row ---

`POST https://api.scalingo.com/v1/apps/:app/autoscalers`

### Parameters

* `container_type`: can be any container type of an application (e.g. web, clock...)
* `min_containers`: lower limit of containers
* `max_containers`: upper limit of containers
* `metric`: e.g. RPM per container, RAM consumption. The list of available metrics is <a
href="/metrics.html">here</a>.
* `target`: the autoscaler will keep the metric value as close to the target as possible by scaling
the application

||| col |||

Example request

```shell
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -u ":$AUTH_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/autoscalers -d \
  '{
    "autoscaler": {
      "container_type": "web",
      "min_containers": 3,
      "max_containers": 7,
      "metric": "rpm_per_container",
      "target": 150
    }
  }'
```

Returns 201 Created

```json
{
  "autoscaler": {
    "id": "au-297f1134-8576-45ac-ab58-2100b6807683",
    "created_at": "2018-01-25T10:57:53.822973091Z",
    "updated_at": "2018-01-25T10:57:53.822973091Z",
    "last_scale": "0001-01-01T00:00:00Z",
    "container_type": "web",
    "min_containers": 3,
    "max_containers": 7,
    "metric": "rpm_per_container",
    "target": 150,
    "alert_id_scale_up": "al-9817cecc-a69c-436c-aacf-9b93d7f313c2",
    "alert_id_scale_down": "al-3eaaa1eb-9687-49b3-a6a4-f00d9e724f8a"
  }
}
```

--- row ---

## Get an autoscaler

--- row ---

`GET https://api.scalingo.com/v1/apps/:app/autoscalers/:autoscaler_id`

Display a specific autoscaler

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X GET https://api.scalingo.com/v1/apps/example-app/autoscalers/au-297f1134-8576-45ac-ab58-2100b6807683
```

Returns 200 OK

```json
{
  "autoscaler": {
    "id": "au-297f1134-8576-45ac-ab58-2100b6807683",
    "created_at": "2018-01-25T10:57:53.822973091Z",
    "updated_at": "2018-01-25T10:57:53.822973091Z",
    "last_scale": "0001-01-01T00:00:00Z",
    "container_type": "web",
    "min_containers": 3,
    "max_containers": 7,
    "metric": "rpm_per_container",
    "target": 150,
    "alert_id_scale_up": "al-9817cecc-a69c-436c-aacf-9b93d7f313c2",
    "alert_id_scale_down": "al-3eaaa1eb-9687-49b3-a6a4-f00d9e724f8a"
  }
}
```

--- row ---

## Update an autoscaler

--- row ---

`PATCH https://api.scalingo.com/v1/apps/[:app]/autoscalers/[:autoscaler_id]`

or

`PUT https://api.scalingo.com/v1/apps/[:app]/autoscalers/[:autoscaler_id]`

Updates the autoscaler attributes.

### Parameters

All parameters are optional.

* `metric:
* `target`
* `min_containers`
* `max_containers`
* `disabled`

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X PATCH https://api.scalingo.com/v1/apps/example-app/autoscalers/au-297f1134-8576-45ac-ab58-2100b6807683 -d \
  '{
    "autoscaler": {
      "min_containers": 1,
      "max_containers": 10,
    }
  }'
```

Returns 200 OK

```json
{
  "autoscaler": {
    "id": "au-297f1134-8576-45ac-ab58-2100b6807683",
    "created_at": "2018-01-25T10:57:53.822973091Z",
    "updated_at": "2018-01-25T10:57:53.822973091Z",
    "last_scale": "0001-01-01T00:00:00Z",
    "container_type": "web",
    "min_containers": 1,
    "max_containers": 10,
    "metric": "rpm_per_container",
    "target": 150,
    "alert_id_scale_up": "al-9817cecc-a69c-436c-aacf-9b93d7f313c2",
    "alert_id_scale_down": "al-3eaaa1eb-9687-49b3-a6a4-f00d9e724f8a"
  }
}
```

--- row ---

## Delete an autoscaler

--- row ---

`DELETE https://api.scalingo.com/v1/apps/[:app]/autoscalers/[:autoscaler_id]`


Delete the given autoscaler

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" -u :$AUTH_TOKEN \
  -X DELETE https://api.scalingo.com/v1/apps/example-app/autoscalers/au-297f1134-8576-45ac-ab58-2100b6807683
```

Returns 204 No Content
