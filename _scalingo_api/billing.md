---
title: Billing
layout: default
---

# Billing

--- row ---

**Billing operation attributes**

{:.table}
| field               | type    | description                                 |
| ------------------- | ------- | ------------------------------------------- |
| id                  | string  | unique ID                                   |
| created_at          | float   | price of this invoice                       |
| amount              | float   | price of this invoice including VAT         |
| source              | date    | this invoice is related to this month       |
| description         | string  | URL to download the PDF invoice             |
| invoice_id          | string  | the invoice number                          |
| invoice_url         | string  | state of this invoice (new, paid or failed) |

||| col |||

Example object:

```json
```

--- row ---

## List your billing operations

`GET https://api.scalingo.com/v1/account/billing/operations`

List all your billing operations.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://api.scalingo.com/v1/account/billing/operations
```

Returns 200 OK

```json
{
	"billing-operations": [
		{
			"id": "deada621-e5be-47dd-bf64-85b06b99a0ea",
			"created_at": "2016-09-01T15:02:09.013+02:00",
			"amount": 0.0,
			"source": "invoicing",
			"description": "Invoice for August 2016",
			"invoice_id": "23d2c27f-bab0-4038-b3d7-2e6f06f3d27a",
			"invoice_url": "http://download.scalingo.com/invoices/23d2c27f-bac0-4038-b3d7-2e6f06f3d27a/download"
		},
		{
			"id": "e11a0069-9c40-4655-bea2-269929e484eb",
			"created_at": "2016-07-01T15:00:37.716+02:00",
			"amount": 0.0,
			"source": "invoicing",
			"description": "Invoice for June 2016",
			"invoice_id": "5a422237-2442-4cce-b682-cafd418c12f9",
			"invoice_url": "http://download.scalingo.com/invoices/5a422237-2452-4cce-b682-cafd418c12f9/download"
		}
	],
	"meta": {
		"pagination": {
			"current_page": 1,
			"next_page": null,
			"previous_page": null,
			"total_pages": 1,
			"total_count": 2
		}
	}
}
```

--- row ---

## Billing Profile

`GET https://api.scalingo.com/v1/account/billing/profile`

Display your billing profile.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://api.scalingo.com/v1/account/billing/profile
```

Returns 200 OK

```json
{
	"billing_profile": {
		"id": "576ba47261d7b200157d9973",
		"name": "John Doe",
		"email": "john.doe@example.com",
		"address_line1": "15 avenue du Rhin",
		"address_line2": "",
		"address_city": "Strasbourg",
		"credit": 15.0,
		"address_zip": "67100",
		"address_state": null,
		"address_country": "France",
		"vat_number": "",
		"company": "Scalingo",
		"payment_method": "stripe",
		"stripe_payment_method": {
			"id": "576ba474fb0df6011805a681",
			"default_card_last4": "3935",
			"default_card_exp": "10/2020",
			"default_card_brand": "Visa",
			"default_card_name": "Doe",
			"sepa_bank_code": null,
			"sepa_country": null,
			"sepa_last4": null,
			"sepa_mandate_reference": null,
			"sepa_mandate_url": null
		},
		"paypal_payment_method": null
	}
}
```
