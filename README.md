# DCOS CLI docker container

A simple Docker image based on [Alpine](https://registry.hub.docker.com/_/alpine/) for running [Mesosphere DCOS command-line interface (CLI) to remotely manage your mesos cluster](https://docs.mesosphere.com/using/cli/).

## Usage

### Running DCOS CLI

```bash
docker run -e DCOS_CORE_URL=http://master.url -it elubow/docker-dcos-cli
```

### Older Versions
* dcoscli - version 0.4.17 | elubow/docker-dcos-cli:0.4.17
* dcoscli - version 0.4.14 | elubow/docker-dcos-cli:0.4.14
