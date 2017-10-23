#!/bin/bash

if [ -z "$DCOS_CORE_URL" ]; then
  echo "Note: You can specify the URL of your DCOS cluster upon startup"
  echo "e.g., docker run -it -e DCOS_CORE_URL=http://yoururlhere/ elubow/docker-dcos-cli"
  echo ""
  exit 1
elif [ ! -z "$DCOS_CORE_URL" ]; then
  echo "Setting core.dcos_url set to ${DCOS_CORE_URL}"
  dcos config set core.dcos_url "$DCOS_CORE_URL"
  echo ""
fi

echo "DCOS CLI Config:"
dcos config show
echo ""
dcos auth login
echo ""
dcos
echo ""
bash
