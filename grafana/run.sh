#!/bin/sh

: "${GF_PATHS_DATA:=/grafana/data}"
: "${GF_PATHS_LOGS:=/grafana/logs}"
: "${GF_PATHS_PLUGINS:=/grafana/plugins}"
: "${GF_PATHS_CONF:=/grafana/conf}"

chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_CONF"

if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then
  OLDIFS=$IFS
  IFS=','
  for plugin in ${GF_INSTALL_PLUGINS}; do
    IFS=$OLDIFS
    grafana-cli  --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${plugin}
  done
fi

exec gosu grafana grafana-server                \
  --homepath=grafana                            \
  --config="$GF_PATHS_CONF/defaults.ini"        \
  cfg:default.paths.data="$GF_PATHS_DATA"       \
  cfg:default.paths.logs="$GF_PATHS_LOGS"       \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS" \
  "$@"