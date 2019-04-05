---
title: Domains
layout: default
---

# Domains

The domains represent the custom domain names defined for your applications.
For instance, the alias `www.example.com` of `example-app.scalingo.io` will
result in the presence of one resource domain.

--- row ---

**Keys attributes**

{:.table}
| field                | type     | description                                                       |
| -------------------- | -------- | ----------------------------------------------------------------- |
| id                   | string   | unique ID of the domain                                           |
| name                 | string   | hostname your want to associate with the app                      |
| tlscert (read)       | string   | subject of the submitted certificate                              |
| tlscert (write)      | string   | content of the SSL certificate you want to use                    |
| tlskey (read)        | string   | private key type and length                                       |
| tlskey (write)       | string   | content of the private key used to generate the certificate       |
| ssl (read-only)      | bool     | flag if SSL with a custom certificate is enabled                  |
| validity (read-only) | datetime | once a certificate has been submitted, display the validity of it |
| canonical            | bool     | the domain is the canonical domain of this application            |
| letsencrypt          | bool     | the domain is using a let's encrypt status                        |
| letsencrypt_status   | string   | let's encrypt certificate generation status                       |
| acme_dns_fqdn        | string   | ACME DNS-01 TXT entry FQDN                                        |
| acme_dns_value       | string   | ACME DNS-01 TXT entry value                                       |
| acme_dns_error       | string   | ACME DNS-01 error                                                 |


The letsencrypt_status field can take different values depending on your certificate state:

- `pending_dns`: Scalingo is waiting for your DNS configuration to be correct
- `new`: The certificate request has been sent to Let's Encrypt
- `created`: The certificate has been created by let's encrypt and is available
- `dns_required`: (wildcard only) we're waiting for DNS update
- `error`: There was an error while creating your certificate

||| col |||

Example object

```json
{
  "id": "541067ec736f7504a5110000",
  "name": "example.com",
  "ssl": true,
  "tlscert": "/C=FR/ST=Some-State/O=Internet Widgits Pty Ltd/CN=example.com",
  "tlskey": "RSA private key - 2048 bytes",
  "validity": "2015-08-05T19:57:21.000+02:00",
  "canonical": false,
  "letsencrypt": false,
  "letsencrypt_status": "created"
}
```

--- row ---

## List all the domains of an application

--- row ---

`GET https://api.scalingo.com/v1/apps/[:app]/domains`

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://api.scalingo.com/v1/apps/example-app/domains
```

Returns 200 OK

```json
{
    "domains": [
        {
            "id": "541067f7736f7504a5140000",
            "name": "example2.com",
            "ssl": false,
            "canonical": true
        },
        {
            "id": "541067ec736f7504a5110000",
            "name": "example.com",
            "ssl": true,
            "tlscert": "/C=FR/ST=Some-State/O=Internet Widgits Pty Ltd/CN=example.com",
            "tlskey": "RSA private key - 2048 bytes",
            "validity": "2015-08-05T19:57:21.000+02:00",
            "canonical": false
        }
    ]
}
```

--- row ---

## Show a specific domain of an application

--- row ---

`GET https://api.scalingo.com/v1/apps/[:app]/domains/[:domain_id]`

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer $BEARER_TOKEN" \
 -X GET https://api.scalingo.com/v1/apps/example-app/domains/541067ec736f7504a5110000
```

Returns 200 OK

```json
{
    "domain": {
        "id": "541067ec736f7504a5110000",
        "name": "example.com",
        "ssl": false,
        "canonical": false
    }
}
```

--- row ---

## Unlink a domain name from an application

--- row ---

`DELETE https://api.scalingo.com/v1/apps/[:app]/domains/[:domain_id]`

Disassociate instantly a domain name with an app. If the domain is still
[CNAME-ed](https://doc.scalingo.com/platform/app/domain), it will respond with
a 404 error.

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X DELETE https://api.scalingo.com/v1/apps/example-app/domains/541067ec736f7504a5110000
```

Returns 204 No Content

--- row ---

## Link a domain name to an application

`POST https://api.scalingo.com/v1/apps/[:app]/domains`

### Parameters

* `domain.name`: Hostname you want to add
* `domain.tlscert` - optional: SSL Certificate you want to associate with the domain
* `domain.tlskey` - optional: Private key used to create the SSL certificate

If the certificate or the key is not valid, a 422 "unprocessable entity" is returned
Otherwise return 201

### Limit

There is a hard limit of 5 custom domains per application, if you need more:
[contact us](mailto:support@scalingo.com)

||| col |||

Request example (without SSL):

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/domains -d \
  '{
    "domain" : {
      "name" : "example.com"
    }
  }'
```

Returns 201 Created

```json
{
    "domain": {
        "id": "541067ec736f7504a5110000",
        "name": "example.com",
        "ssl": false,
        "canonical": false
    }
}
```

Request example (with SSL):

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X POST https://api.scalingo.com/v1/apps/example-app/domains -d \
  '{
    "domain" : {
      "name" : "example.com",
      "tlscert" : "<cert>",
      "tlskey" : "<key>"
     }
   }'
```

Returns 201 Created

```json
{
    "domain": {
        "id": "541067ec736f7504a5110000",
        "name": "example.com",
        "ssl": true,
        "tlscert": "/C=FR/ST=Some-State/O=Internet Widgits Pty Ltd/CN=example.com",
        "tlskey": "RSA private key - 2048 bytes",
        "validity": "2015-08-05T19:57:21.000+02:00",
        "canonical": false
    }
}
```

--- row ---

## Update a domain name

--- row ---

`PATCH https://api.scalingo.com/v1/apps/[:app]/domains/[:domain_id]`

### Parameters

* `domain.tlscert` - optional: SSL Certificate you want to associate with the domain
* `domain.tlskey` - optional: Private key used to create the SSL certificate
* `domain.canonical` - optional: Set this domain as the canonical domain for this application

As you may have noticed you can't update the name itself, instead of modifying it just
create another Domain and delete the one you wanted to modify.

||| col |||

Example request

```sh
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X PATCH https://api.scalingo.com/v1/apps/example-app/domains/541067ec736f7504a5110000 -d \
  '{
    "domain" : {
      "tlscert" : "<cert>",
      "tlskey" : "<key>"
    }
  }'
```

Returns 200 OK

```json
{
    "domain": {
        "id": "541067ec736f7504a5110000",
        "name": "example.com",
        "ssl": true,
        "tlscert": "/C=FR/ST=Some-State/O=Internet Widgits Pty Ltd/CN=example.com",
        "tlskey": "RSA private key - 2048 bytes",
        "validity": "2015-08-05T19:57:21.000+02:00",
        "canonical": false,
    }
}
```
