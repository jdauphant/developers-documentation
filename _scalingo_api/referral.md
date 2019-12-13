---
title: Referral
layout: default
---

# Referral Stats

--- row ---

**Referral Stats Attributes**

{:.table}
| field               | type    | description                                       |
| ------------------- | ------- | -------------------------------------------       |
| clicks              | integer | Number of people who have clicked on the link     |
| signups             | integer | Number of people who have signed up from the link |
| amount_earned       | float   | How much credit has been added to the account     |
| url                 | string  | User's referral link                              |

||| col |||

Example object:

```json
{
	"referral_stats": {
		"clicks": "165",
		"signups": 23,
		"amount_earned": 10.5,
		"url": "https://sclng.io/r/81e0166feda0efe0"
	}
}
```

--- row ---

## Display Your Referral Statistics

`GET https://$SCALINGO_API_URL/v1/account/referrals/stats`

Display the statistics of your referral link.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://$SCALINGO_API_URL/v1/account/referrals/stats
```

Returns 200 OK

```json
{
	"referral_stats": {
		"clicks": "165",
		"signups": 23,
		"amount_earned": 10.5,
		"url": "https://sclng.io/r/81e0166feda0efe0"
	}
}
```
