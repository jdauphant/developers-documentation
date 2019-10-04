---
title: Notifiers
layout: default
---

# Notifier

--- row ---

**Notifier attributes**

{:.table}
| field              | type     | description                                     |
| ----------------   | -------  | ---------------------------------------------   |
| id                 | string   | unique ID identifying the notifier              |
| created_at         | date     | date of creation of the notifier                |
| updated_at         | date     | when was the notifier updated                   |
| name               | string   | name of the notifier                            |
| active             | boolean  | is the notifier active or not                   |
| type               | string   | notifier type                                   |
| app_id             | string   | app reference                                   |
| platform_id        | string   | notification platform used by this notifer      |
| send_all_alerts    | bool     | should the notifier accept all alerts           |
| send_all_events    | bool     | should the notifier accept all events           |
| selected_event_ids | []string | list of events accepted by this notifier        |
| type_data          | object   | notitication platform dependant additional data |

The *`type_data` Object* depends of the platform_id which is used.

### Email Platform

{:.table}
| field              | type     | description                            |
| ----------------   | -------  | -------------------------------------  |
| user_ids           | []string | IDs of users (owner and collaborators) |
| emails             | []string | Additional email addresses             |

### Slack/Webhook/RocketChat Platforms

{:.table}
| field              | type     | description                    |
| ----------------   | -------  | -----------------------------  |
| webhook_url        | string   | URL to send the event payloads |

||| col |||

Example object:

```json
{
  "id": "no-824fd8bb-0efe-4b7b-9605-1b98110abeef",
  "name": "My notifier",
  "active": true,
  "type": "slack",
  "platform_id": "5982f145d48c3600273ef089",
  "created_at": "2018-05-14T11:46:42.077+02:00",
  "updated_at": "2019-04-10T20:51:32.298+02:00",
  "send_all_alerts": false,
  "send_all_events": false,
  "selected_event_ids": [],
  "app_id": "53e45e576461730a0c021817",
  "app": "my-app",
  "type_data": {
    "webhook_url": "https://hooks.slack.com/services/AAAAAAAAAAA/BBBBBBBBBBB/cccccddddeeeefffff"
  }
}
```

--- row ---

## Data sent to the webhook endpoint (non-Slack)

--- row ---

Notifications are app events sent to a custom HTTP endpoint. You can refer to
our ['Events' documentation](/events) to
know the notification JSON format.

At the moment only `deployment` events are sent.

||| col |||

Example of a deployment notification:

```json
{
  "id": "54dcdd4a73636100011a0000",
  "created_at" : "2015-02-12T18:05:14.226+01:00",
  "user" : {
    "username" : "johndoe",
    "email" : "john@doe.com",
    "id" : "51e6bc626edfe40bbb000001"
  },
  "app_id" : "5343eccd646173000a140000",
  "app_name": "appname",
  "type": "deployment",
  "type_data": {
    "deployment_id" : "5343eccd646aa3012a140230",
    "pusher": "johndoe",
    "git_ref" : "0123456789abcdef",
    "status": "success",
    "duration": 40
  }
}
```
--- row ---

## List application notifiers

--- row ---

`GET https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers`

List all the provisioned notifiers for a given application.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/apps/example-app/notifiers
```

Returns 200 OK

```json
{
  "notifiers": [
    {
      "id": "no-824fd8bb-0efe-4b7b-9605-1b98110abeef",
      "name": "My notifier",
      "active": true,
      "type": "slack",
      "platform_id": "5982f145d48c3600273ef089",
      "created_at": "2018-05-14T11:46:42.077+02:00",
      "updated_at": "2019-04-10T20:51:32.298+02:00",
      "send_all_alerts": false,
      "send_all_events": false,
      "selected_event_ids": [],
      "app_id": "53e45e576461730a0c021817",
      "app": "my-app",
      "type_data": {
        "webhook_url": "https://hooks.slack.com/services/AAAAAAAAAAA/BBBBBBBBBBB/cccccddddeeeefffff"
      }
    },
    {
      "id": "no-253ea554-bfe3-419c-aaaa-0bfc5bf51beef",
      "name": "Default 'myapp' notifier",
      "active": true,
      "type": "email",
      "platform_id": "59c52ac27651ce002c1d4620",
      "created_at": "2017-10-30T14:43:15.777+01:00",
      "updated_at": "2018-11-09T14:51:56.515+01:00",
      "send_all_alerts": false,
      "send_all_events": false,
      "selected_event_ids": [
        "59c52a9c7651ce001f62f578"
      ],
      "app_id": "59f72c73fb0de600aaa1234aaa",
      "app": "myapp",
      "type_data": {
        "user_ids": [
          "us-07c2180c-b4b4-123a-1234-fabcdbea"
        ],
        "emails": []
      }
    }
  ]
}
```

--- row ---

## Add a notifier

--- row ---

`POST https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers`

Add a notifier to the application.

### Parameters

* `notifer.platform_id`
* `notifer.name`
* `notifer.send_all_alerts` (optional)
* `notifer.send_all_events` (optional)
* `notifer.type_data` (optional)
* `notifer.selected_event_ids` (optional)
* `notifer.active` (optional)

#### Deprecated

* `notifier.selected_events`: arrays of event names

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers \
  -d '{"notifiers":{"platform_id": "5982f145d48c3600273ef08a", "active": true, "name": "My Custom Webhook", "type_data": {"webhook_url": "https://myapp.fr/webhook/scalingo"}}}'
```

Returns 201 Created

--- row ---

## Update a notification

--- row ---

`PATCH https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id]`

Change notifier attributes

### Parameters

* `notification.active`
* `notification.name`
* `notification.send_all_alerts`
* `notification.send_all_events`
* `notification.type_data`
* `notification.selected_event_ids`

#### Deprecated

* `notifier.selected_events`: arrays of event names

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X PATCH https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id] \
  -d '{"notifier": {"type_data": { "webhook_url": "https://myendpoint.com" }, active: "false"}}}'
```

Returns 200 OK

--- row ---

## Test a notifier

`POST https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id]/test`

Send a test notification to the notifier

||| col |||

```shell
curl -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id]/test
```

--- row ---

## Remove a notifier

--- row ---

`DELETE https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id]`

Request deprovisionning of the notifier.

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://$SCALINGO_API_URL/v1/apps/[:app]/notifiers/[:notifier_id]
```

Returns 204 No Content
