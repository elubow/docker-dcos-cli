#!/bin/bash

# add PEM key if available
mkdir -p $HOME/.ssh
if [ -n "$MESOS_PEM" ]; then
  echo "PEM: $MESOS_PEM"
  __MESOS_PEM_FILE="${HOME}/.ssh/mesos.pem"
  echo $MESOS_PEM > ${__MESOS_PEM_FILE}
  chmod 600 ${__MESOS_PEM_FILE}
  eval `ssh-agent -s`
  ssh-add ${__MESOS_PEM_FILE} </dev/null &>/dev/null
  echo "PEM file added"
fi

if [ -z "$DCOS_CORE_URL" ]; then
  echo "Note: You can specify the URL of your DCOS cluster upon startup"
  echo "e.g., docker run -it -e DCOS_CORE_URL=http://yoururlhere/ elubow/docker-dcos-cli"
  echo ""
  echo "Begin by setting your cluster parameters and authenticating:"
  echo 'dcos config set core.dcos_url $master_url'
elif [ ! -z "$DCOS_CORE_URL" ]; then
  echo "Setting core.dcos_url set to ${DCOS_CORE_URL}"
  dcos config set core.dcos_url "$DCOS_CORE_URL"
  echo ""
  echo "DCOS CLI Config:"
  dcos config show
  echo ""
  dcos auth login
  echo ""
  dcos
fi

echo ""
/bin/bash
