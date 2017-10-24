# DCOS CLI docker container

A simple Docker image based on [Alpine](https://registry.hub.docker.com/_/alpine/) for running [Mesosphere DCOS command-line interface (CLI) to remotely manage your mesos cluster](https://docs.mesosphere.com/using/cli/).

## Usage

### Running DCOS CLI

```bash
$ docker run -e DCOS_CORE_URL=http://master.url -it elubow/docker-dcos-cli
```

### How To SSH
In the case that you may want to SSH around the dcos nodes, you'll need to have the ssh-agent running and with your key available. You can do that like this:

```bash
$ mkdir ~/.ssh
$ echo '$MYKEY' > ~/.ssh/mesos.pem
$ chmod 600 ~/.ssh/mesos.pem
$ ssh-agent
SSH_AUTH_SOCK=/tmp/ssh-JjyVT7p5GSjd/agent.199; export SSH_AUTH_SOCK;
SSH_AGENT_PID=200; export SSH_AGENT_PID;
echo Agent pid 200;
$ SSH_AUTH_SOCK=/tmp/ssh-JjyVT7p5GSjd/agent.199; export SSH_AUTH_SOCK;
$ SSH_AGENT_PID=200; export SSH_AGENT_PID;
$ ssh-add ~/.ssh/mesos.pem
Identity added: /home/dcoscli/.ssh/mesos.pem (/home/dcoscli/.ssh/mesos.pem)
$ dcos node ssh --master-proxy --mesos-id=12def92f-385a-439a-adbd-c52c0e61cf4d-S0
```

## Older Versions
* dcoscli - version 0.5.5 | elubow/docker-dcos-cli:0.5.5
* dcoscli - version 0.4.17 | elubow/docker-dcos-cli:0.4.17
* dcoscli - version 0.4.14 | elubow/docker-dcos-cli:0.4.14
