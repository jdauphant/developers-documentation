---
title: Audit Logs
layout: default
---

# Download an audit log

--- row ---

```
GET https://api.scalingo.com/v1/apps/[:app]/audit_logs/[:audit_log_id]
```


Download an audit log. The audit log id can be found in the run event type data.

||| col |||

```shell
curl -H "Accept: application/json" -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BEARER_TOKEN" \
  -X GET https://api.scalingo.com/v1/apps/my-app/audit_logs/audit_log_id
```

Returns 200 OK

```json
[
  {
    "time": "2019-05-03T17:27:27.819655645+02:00",
    "content": "You are in a \u001b[1;34mone-off container\u001b[0m. This is a copy of your production \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.81982273+02:00",
    "content": "environment. It is destroyed at the end of its execution. Thus, do not expect \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.819998001+02:00",
    "content": "any created file to show up in your production environment. Production is \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.820158581+02:00",
    "content": "immutable.\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.820432466+02:00",
    "content": "\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.821125634+02:00",
    "content": "If you need to interact with a database, you need to download the CLI of this \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.821301619+02:00",
    "content": "database. You can download and install your database CLI with \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.821478586+02:00",
    "content": "\u001b[1;31mdbclient-fetcher \u001b[1;35m<DB type> [<version>]\u001b[0m\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:27.821668224+02:00",
    "content": "\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:28.875210681+02:00",
    "content": "[15:27] \u001b[1;49;94mScalingo\u001b[0m:\u001b[1;49;94mrss-john\u001b[0m \u001b[49;96m~\u001b[0m \u001b[1m$\u001b[0m \n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:32.681685591+02:00",
    "content": "echo \"TEST\"\n",
    "type": "input"
  },
  {
    "time": "2019-05-03T17:27:32.682630706+02:00",
    "content": "\u001b[K[15:27] \u001b[1;49;94mScalingo\u001b[0m:\u001b[1;49;94mrss-john\u001b[0m \u001b[49;96m~\u001b[0m \u001b[1m$\u001b[0m echo \"TEST\"\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:32.683022023+02:00",
    "content": "TEST\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:34.313652729+02:00",
    "content": "exit\n",
    "type": "input"
  },
  {
    "time": "2019-05-03T17:27:34.314714174+02:00",
    "content": "[15:27] \u001b[1;49;94mScalingo\u001b[0m:\u001b[1;49;94mrss-john\u001b[0m \u001b[49;96m~\u001b[0m \u001b[1m$\u001b[0m exit\n",
    "type": "output"
  },
  {
    "time": "2019-05-03T17:27:34.314943454+02:00",
    "content": "exit\n",
    "type": "output"
  }
]
```
