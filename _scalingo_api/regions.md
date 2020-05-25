---
title: Regions
layout: default
---

# Regions

--- row ---

**Region Attributes**

{:.table}
| field           | type   | description                                    |
| --------------- | ------ | ---------------------------------------------- |
| name            | string | Underscore-cased name of the region            |
| display_name    | string | How the name of the region should be displayed |
| api             | string | URL to the regional API managing apps          |
| dashboard       | string | URL to the dashboard of the region             |
| database_api    | string | URL to the regional API managing databases     |
| ssh             | string | SSH Host to git push application code          |

||| col |||

Example object:

```json
{
   "regions" : [
      {
         "name" : "osc-fr1",
         "display_name" : "Paris - Outscale",
         "api" : "https://api.osc-fr1.scalingo.com",
         "dashboard" : "https://my.osc-fr1.scalingo.com",
         "database_api" : "https://db-api.osc-fr1.scalingo.com",
         "ssh" : "ssh.osc-fr1.scalingo.com:22"
      }
   ]
}
```

--- row ---

## Display Your Referral Statistics

`GET https://$SCALINGO_AUTH_URL/v1/regions`

Display the list of the regions accessible to your account.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_AUTH_URL/v1/regions
```

Returns 200 OK

```json
{
   "regions" : [
      {
         "name" : "osc-fr1",
         "display_name" : "Paris - Outscale",
         "api" : "https://api.osc-fr1.scalingo.com",
         "dashboard" : "https://my.osc-fr1.scalingo.com",
         "database_api" : "https://db-api.osc-fr1.scalingo.com",
         "ssh" : "ssh.osc-fr1.scalingo.com:22"
       }, {
         "name" : "osc-secnum-fr1",
         "display_name" : "Paris - SecNumCloud - Outscale",
         "api" : "https://api.osc-secnum-fr1.scalingo.com",
         "dashboard" : "https://my.osc-secnum-fr1.scalingo.com",
         "database_api" : "https://db-api.osc-secnum-fr1.scalingo.com",
         "ssh" : "ssh.osc-secnum-fr1.scalingo.com:22"
       }
   ]
}
```
