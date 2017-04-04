# Alpine Docker Image with Telegraf (StatsD), InfluxDB and Grafana

## Versions

* Alpine:            3.5
* Telegraf (StatsD): 1.2.1
* InfluxDB:          1.2.2
* Grafana:           4.2.0


## Quick Start

To start the container the first time launch:

```sh
docker run -d \
  --name docker-statsd-influxdb-grafana \
  -p 3000:3000 \
  -p 8083:8083 \
  -p 8086:8086 \
  -p 8125:8125/udp \
  entelo/docker-statsd-influxdb-grafana:latest
```

You can replace `latest` with the desired version listed in changelog file.

To stop the container launch:

```sh
docker stop docker-statsd-influxdb-grafana
```

To start the container again launch:

```sh
docker start docker-statsd-influxdb-grafana
```


## Ports

```
Container		Service

3000			grafana
8083			influxdb-admin
8086			influxdb
8125			statsd
```


## Grafana

Open <http://localhost:3000>

```
Username: admin
Password: admin
```

### Add data source on Grafana

1. Using the wizard click on `Add data source`
2. Choose a `name` for the source and flag it as `Default`
3. Choose `InfluxDB` as `type`
4. Choose `direct` as `access`
5. Fill remaining fields as follows and click on `Add` without altering other fields

```
Url: http://localhost:8086
Database:	telegraf
User: <empty>
Password:	<empty>
```

Basic auth and credentials must be left unflagged. Proxy is not required.

Now you are ready to add your first dashboard and launch some query on database.


## InfluxDB

### Web Interface

Open <http://localhost:8083> and use database `telegraf`.


### InfluxDB Shell (CLI)

Run influx in the container to open InfluxDB Shell (CLI)
