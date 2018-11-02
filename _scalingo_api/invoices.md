---
title: Invoices
layout: default
---

# Invoices

--- row ---

**Invoice attributes**

{:.table}
| field                | type    | description                                 |
| -------------------  | ------- | ------------------------------------------- |
| id                   | string  | unique ID                                   |
| total_price          | float   | price of this invoice                       |
| total_price_with_vat | float   | price of this invoice including VAT         |
| billing_month        | date    | this invoice is related to this month       |
| pdf_url              | string  | URL to download the PDF invoice             |
| invoice_number       | string  | the invoice number                          |
| state                | string  | state of this invoice (new, paid or failed) |
| vat_rate             | float   | the VAT rate applied to this invoice        |
| items                | object  | the list of item to pay                     |

||| col |||

Example object:

```json
{
	"invoice": {
			"id": "23d2c27f-bac0-4038-b3d7-2e6f06f3d27a",
			"total_price": 0.0,
			"total_price_with_vat": 0.0,
			"billing_month": "2016-08-01",
			"pdf_url": "https://download.scalingo.com/invoices/23d2c27f-bac0-4038-b3d7-2e6f06f3d27a/download",
			"invoice_number": "2016-09-1442",
			"state": "paid",
			"vat_rate": 0.2,
			"items": [
				{
					"id": "57c826d022fcfa0012ae9ae9",
					"label": "Containers Runtime",
					"price": 22.0
				},
				{
					"id": "57c826d022fcfa0012ae9aea",
					"label": "Addons",
					"price": 0.0
				},
				{
					"id": "57c826d022fcfa0012ae9aeb",
					"label": "Free Trial 2016-06-02 15:07 -> 2016-09-30 15:07",
					"price": -22.0
				}
			],
			"detailed_items": [
				{
					"id": "57c826d022fcfa0012ae9aec",
					"label": "Containers - type: web- size: M",
					"price": 0.0,
					"app": "example-app"
				},
				{
					"id": "57c826d022fcfa0012ae9aed",
					"label": "Containers - type: web- size: S",
					"price": 7.25,
					"app": "example-app"
				},
				// …
			]
		}
}
```

--- row ---

## List your invoices

`GET https://api.scalingo.com/v1/account/invoices`

List all your invoices.

||| col |||

Example

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://api.scalingo.com/v1/account/invoices
```

Returns 200 OK

```json
{
	"invoices": [
		{
			"id": "23d2c27f-bac0-4038-b3d7-2e6f06f3d27a",
			"total_price": 0.0,
			"total_price_with_vat": 0.0,
			"billing_month": "2016-08-01",
			"pdf_url": "https://download.scalingo.com/invoices/23d2c27f-bac0-4038-b3d7-2e6f06f3d27a/download",
			"invoice_number": "2016-09-1442",
			"state": "paid",
			"vat_rate": 0.2,
			"items": [
				{
					"id": "57c826d022fcfa0012ae9ae9",
					"label": "Containers Runtime",
					"price": 22.0
				},
				{
					"id": "57c826d022fcfa0012ae9aea",
					"label": "Addons",
					"price": 0.0
				},
				{
					"id": "57c826d022fcfa0012ae9aeb",
					"label": "Free Trial 2016-06-02 15:07 -> 2016-09-30 15:07",
					"price": -22.0
				}
			],
			"detailed_items": [
				{
					"id": "57c826d022fcfa0012ae9aec",
					"label": "Containers - type: web- size: M",
					"price": 0.0,
					"app": "example-app"
				},
				{
					"id": "57c826d022fcfa0012ae9aed",
					"label": "Containers - type: web- size: S",
					"price": 7.25,
					"app": "example-app"
				},
				// …
			]
		},
		{
			// …
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

## Get a precise invoice

--- row ---

`GET https://api.scalingo.com/v1/account/invoices/[:invoice_id]`

Display a precise invoice

||| col |||

Example request

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://api.scalingo.com/v1/account/invoices/23d2c27f-bab0-4038-b3d7-2e6f06f3d27a
```

Returns 200 OK

```json
{
	"invoice": {
			"id": "23d2c27f-bac0-4038-b3d7-2e6f06f3d27a",
			"total_price": 0.0,
			"total_price_with_vat": 0.0,
			"billing_month": "2016-08-01",
			"pdf_url": "https://download.scalingo.com/invoices/23d2c27f-bac0-4038-b3d7-2e6f06f3d27a/download",
			"invoice_number": "2016-09-1442",
			"state": "paid",
			"vat_rate": 0.2,
			"items": [
				{
					"id": "57c826d022fcfa0012ae9ae9",
					"label": "Containers Runtime",
					"price": 22.0
				},
				{
					"id": "57c826d022fcfa0012ae9aea",
					"label": "Addons",
					"price": 0.0
				},
				{
					"id": "57c826d022fcfa0012ae9aeb",
					"label": "Free Trial 2016-06-02 15:07 -> 2016-09-30 15:07",
					"price": -22.0
				}
			],
			"detailed_items": [
				{
					"id": "57c826d022fcfa0012ae9aec",
					"label": "Containers - type: web- size: M",
					"price": 0.0,
					"app": "example-app"
				},
				{
					"id": "57c826d022fcfa0012ae9aed",
					"label": "Containers - type: web- size: S",
					"price": 7.25,
					"app": "example-app"
				},
				// …
			]
		}
}
```

--- row ---

## Download a precise invoice

--- row ---

`GET https://api.scalingo.com/v1/account/invoices/[:invoice_id]/download`

This request downloads the invoice's PDF.

||| col |||

Example request

```sh
curl -H "Accept: application/pdf,application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET 'https://api.scalingo.com/v1/account/invoices/23d2c27f-bac0-4038-b3d7-2e6f06f3d27a/download'
```

Returns 302 Found
