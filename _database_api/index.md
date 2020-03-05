---
layout: default
---

# Database API

--- row ---

The Scalingo v1 Database API is a publicly available interface allowing
developers to control Scalingo's database as a service platform and the
interface is stable and currently used by the Scalingo database dashboard (an
Ember.js app). However, changes are occasionally made to improve performance
and enhance features. See the changelog for more details.

--- row ---

# Endpoints

Scalingo being available on multiple regions, the Database API hostname depends
on the region your database is hosted on. It's designated by `DB_API_URL`
in this documentation and must be replaced with one of the following value:

- Agora Calycé Paris: https://db-api.agora-fr1.scalingo.com
- 3DS Outscale Paris: https://db-api.osc-fr1.scalingo.com

--- row ---

# Authentication

--- row ---

Our Database API uses Bearer Token authentication. Those tokens are not
delivered by the database API but by our main API. To learn how to get this
token check our [main API documentation](/addons#get-addon-token).

--- row ---


# Make an authenticated request

HTTP requests have to be authenticated with HTTP bearer auth, with the
authentication token as password, the username can be empty.

||| col |||

Example request:

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $DB_BEARER_TOKEN" \
 -X GET https://$DB_API_URL/api/databases/my-db-123
```

--- row ---

# Get the database ID

To find the database ID you must use our [addon API documentation](/addons).
The ID to use correspond to the addon's `id` field.

--- row ---

# Data format

--- row ---

## JSON

--- row ---

The API sends and receives JSON, XML is not accepted, please ensure JSON is used. All the
returned object are `object`, there is never an `array` as root element.

Resources are rooted, it means that they have a parent key corresponding to its name. This
key may be plural if a collection of items is returned.

||| col |||

```js
{
  "database": {
    // database
  }
}
```

```js
{
  "backups": [
    {
      // backup
    }, {
      // backup
    }
  ]
}
```

--- row ---

## Dates

All the dates are sent with the ISO 8601: YYYY-MM-DDThh:mm:ss.μμμZ

Example:

__2015-01-13T09:20:31.123+01:00__

This format is commonly understood, here are some examples:

||| col |||

Javascript:

```js
var date = new Date("2015-01-13T09:20:31.123+01:00")
Tue Jan 13 2015 09:20:31 GMT+0100 (CET)
```

Ruby:

```ruby
require 'date'
DateTime.iso8601("2015-01-13T09:20:31.123+01:00")
=> #<DateTime: 2015-01-13T09:20:31+01:00 ((2457036j,30031s,123000000n),+3600s,2299161j)>
```

Go:

```go
/*
 * go run iso8601.go
 * 2015-01-13 09:20:31.123 +0100 CET
 */
date, _ := time.Parse(time.RFC3339Nano, "2015-01-13T09:20:31.123+01:00")
fmt.Println(date)
```
