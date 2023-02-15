# Hetzner API DynDNS

A container to dynamically update DNS records using the Hetzner DNS-API.

**Hetzner DNS API Doc:**

https://dns.hetzner.com/api-docs/

# Setup

## 1. (optional) Build the Docker container

Clone the repository.

```bash
git clone https://github.com/DeLachs/hetzner-api-dyndns-docker.git
```

Build the container.

```bash
docker build -t hetzner-dyndns .
```

## 2. Run the container

First copy the ``example.env`` and name it ``.env`` and fill in your informations.

You can either use the provided ``docker-compose.yml`` or use the ``docker run`` command.

### Docker Compose

For Docker compose you simple need to run the following command.

```bash
docker-compose up -d
```

### Docker Run

```bash
docker run --env-file .env --restart unless-stopped ghcr.io/delachs/hetzner-dyndns:latest
```

# OS Environment Variables

You can use the following environment variables.

| NAME                   | Value                            | Description                                                     |
| :--------------------- | -------------------------------- | :-------------------------------------------------------------- |
| HETZNER_AUTH_API_TOKEN | 925bf046408b55c313740eef2bc18b1e | Your Hetzner API access token                                   |
| HETZNER_ZONE_NAME      | example.com                      | The zone name                                                   |
| HETZNER_ZONE_ID        | DaGaoE6YzDTQHKxrtzfkTx           | The zone ID. Use either the zone name or the zone ID. Not both. |
| HETZNER_RECORD_NAME    | dyn                              | The record name. '@' to set the record for the zone itself.     |
| HETZNER_RECORD_TTL     | 120                              | The TTL of the record. Default(60)                              |
| HETZNER_RECORD_TYPE    | AAAA                             | The record type. Either A for IPv4 or AAAA for IPv6. Default(A) |

# Additional stuff

## Get all Zones
If you want to get all zones in your account and check the desired zone ID.
```
curl "https://dns.hetzner.com/api/v1/zones" -H \
'Auth-API-Token: ${apitoken}' | jq
```
## Get a record ID
If you want to get a record ID manually you may use the following curl command.
```
curl -s --location \
    --request GET 'https://dns.hetzner.com/api/v1/records?zone_id='${zone_id} \
    --header 'Auth-API-Token: '${apitoken} | \
    jq --raw-output '.records[] | select(.type == "'${record_type}'") | select(.name == "'{record_name}'") | .id'
```
## Add Record manually
Use the previously obtained zone ID to create a dns record. 
In the output you get the record ID. This is needed for the script and should therefore be noted.
```
curl -X "POST" "https://dns.hetzner.com/api/v1/records" \
     -H 'Content-Type: application/json' \
     -H 'Auth-API-Token: ${apitoken}' \
     -d $'{
  "value": "${yourpublicip}",
  "ttl": 60,
  "type": "A",
  "name": "dyn",
  "zone_id": "${zoneID}"
}'
```
