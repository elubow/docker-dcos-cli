#!/bin/bash

if [ -z "$DCOS_CORE_URL" ]; then
  echo "Note: You can specify the URL of your DCOS cluster upon startup"
  echo "e.g., docker run -i -t elubow/docker-dcos-cli http://dcos.elb.amazonaws.com"
  source bin/env-setup
  echo ""
elif [ ! -z "$DCOS_CORE_URL" ]; then
  echo "Setting core.dcos_url set to ${DCOS_CORE_URL}"
  source bin/env-setup && dcos config set core.dcos_url "$DCOS_CORE_URL"
  echo ""
fi

echo "DCOS CLI Config:"
dcos config show
echo ""
dcos
echo ""
bash

