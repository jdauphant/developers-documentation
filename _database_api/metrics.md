---
title: Metrics
layout: default
---

# Metrics

--- row ---

## Get database metrics

`GET https://db-api.scalingo.com/api/databases/[:database_id]/metrics`

### Database metrics

{:.table}
| field            | type                           | description                  |
| --               | --                             | --                           |
| cpu_usage        | Percentage (0-100)             | CPU usage of the database    |
| real_disk_size   | Bytes                          | Size of the database on disk |
| memory           | See Memory Metrics             | Memory usage of the database |
| database_stats   | See Database Stats             | Database specific metrics    |
| instance_metrics | map[instanceID]InstanceMetrics | Instance specific metrics    |

### Memory Metrics

{:.table}
| field            | type  | description                   |
| --               | --    | --                            |
| memory_usage     | Bytes | Total RAM bytes used          |
| swap_usage       | Bytes | Total SWAP bytes used         |
| memory_limit     | Bytes | Max memory allocated          |
| swap_limit       | Bytes | Max SWAP allocated            |
| max_memory_usage | Bytes | highest memory usage recorded |
| max_swap_usage   | Bytes | highest swap usage recorded   |

### Instances Metrics

{:.table}
| field            | type               | description                   |
| --               | --                 | --                            |
| instance_id      | String             | ID of the current instance    |
| instance_address | String             | FQDN of the current instance  |
| real_disk_size   | Bytes              | Size of the instance on disk  |
| memory           | See Memory Metrics | Memory usage of this instance |

### Database stats

The database stats are database dependent

**InfluxDB**

{:.table}
| field     | type | description                           |
| --        | --   | --                                    |
| data_size | Byte | Database size as reported by InfluxDB |

**MongoDB**

{:.table}
| field        | type    | description                                           |
| --           | --      | --                                                    |
| collections  | Integer | Collections count                                     |
| Objects      | Integer | Objects count                                         |
| avg_obj_size | Integer | Average size of an object                             |
| data_size    | Bytes   | Total size of uncompressed data held in this database |
| storage_size | Bytes   | Total amount of space allocated for document storage  |
| num_extents  | Integer | Number of extends in the database                     |
| indexes      | Integer | Count of all the indexes created on every collections |
| index_size   | Integer | Total size of all indexes created on this database    |
| file_size    | Integer | Total size of the data files that hold the database   |


**MySQL**

{:.table}
| field               | type    | description                                               |
| --                  | --      | --                                                        |
| data_size           | Bytes   | Database size as reported by MySQL                        |
| current_connections | Integer | Count of current opened connections to the database       |
| max_connections     | Integer | maximum simultaneous connections accepted by the database |

**PostgreSQL**

{:.table}
| field               | type    | description                                               |
| --                  | --      | --                                                        |
| data_size           | Bytes   | Database size as reported by PostgreSQL                   |
| current_connections | Integer | Count of current opened connections to the database       |
| max_connections     | Integer | maximum simultaneous connections accepted by the database |



||| col |||

Example request

```sh
curl -H "Accent: application/json" -u ':$TOKEN' \
  -X GET https://db-api.scalingo.com/api/my-awesome-db-1234/metrics
```

Returns 200 OK

```json
{
  "cpu_usage": 0,
  "memory": {
    "memory": 156426240,
    "memory_max": 222314496,
    "memory_limit": 536870912,
    "swap": 20480,
    "swap_max": 0,
    "swap_limit": 536870912
  },
  "database_stats": {
    "data_size": 11044896
  },
  "real_disk_size": 37825858,
  "instances_metrics": {
    "9f20c633-3507-4585-8cd0-f9ada91165c0": {
      "instance_id": "9f20c633-3507-4585-8cd0-f9ada91165c0",
      "instance_address": "9f20c633-3507-4585-8cd0-f9ada91165c0.my-awesome-db-1234.influxdb.dbs.scalingo.com:31376",
      "real_disk_size": 37825858,
      "cpu": {
        "usage_in_percents": 0
      },
      "memory": {
        "memory_usage": 156426240,
        "swap_usage": 20480,
        "memory_limit": 536870912,
        "swap_limit": 536870912,
        "max_memory_usage": 222314496,
        "max_swap_usage": 0
      }
    }
  }
}
```

--- row ---

