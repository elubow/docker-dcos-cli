# DCOS CLI docker container

A Docker image for running [Mesosphere DCOS command-line interface (CLI) to remotely manage your mesos cluster](https://docs.mesosphere.com/using/cli/). This is also intended to be a toolkit for troubleshooting and getting status information.

## Usage

### Running DCOS CLI

```bash
$ docker run -e DCOS_CORE_URL=http://master.url -it elubow/docker-dcos-cli
```

## Getting Stuff Done
This DCOS toolbox is intended to be a Swiss Army knife that if needed, you can drop the container in to a working cluster and access many common systems using the the tools within the container.

If you are working in the Mesos cluster, ensure you run the container using the mesos runtime and run the command `tail -f /dev/null`. This will keep the container running in perpatuity. Now you can find the `task_id` and connect to the container using `dcos task exec -it $task_id /bin/bash`. Note that you will connect as root. You can then export the proper path: `export PATH=$PATH:/home/dcoscli/bin` and connect the cluster `dcos cluster setup $cluster_url`.

### SSHing to nodes
In the case that you may want to SSH around the dcos nodes, you'll need to have the ssh-agent running and with your key available. You can do that like this:

```bash
$ mkdir ~/.ssh
$ echo '$MYKEY' > ~/.ssh/mesos.pem
$ chmod 600 ~/.ssh/mesos.pem
$ eval `ssh-agent -s`
echo Agent pid 200;
$ ssh-add ~/.ssh/mesos.pem
Identity added: /home/dcoscli/.ssh/mesos.pem (/home/dcoscli/.ssh/mesos.pem)
$ dcos node ssh --master-proxy --mesos-id=12def92f-385a-439a-adbd-c52c0e61cf4d-S0
```

Alternatively, you can specify the key using the `MESOS_PEM` environment variable prior to startup.

### Using console JMX
For those times when you just can't get jconsole close enough to the network and need something more command line ish. The jar file included here is for command line JMX. For more information, check out the repo (https://github.com/cjmx/cjmx). Here is how to use the application.
```
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
java -cp $JAVA_HOME/lib/tools.jar:/home/dcoscli/jars/cjmx_2.12-2.6.0-app.jar cjmx.Main $pid
```

### Accessing HDFS
Assuming that you have an HDFS cluster stood up and the container is inside the DCOS environment, you can do the following. You first need to ensure that you have the CLI tools for HDFS installed and then download the XML configuration files:

```bash
$ dcos package install hdfs --cli
$ mkdir hadoop
$ dcos hdfs endpoints hdfs-site.xml > hadoop/hdfs-site.xml
$ dcos hdfs endpoints core-site.xml > hadoop/core-site.xml
```

## Shell Scripts
There is a collection of shell scripts in the `$PATH` and located in `~/mesos_bin`. These scripts are put together to help debug problems and run queries for information that might not be available via the UIs.

## Environment Variables
If you are launching this a docker container, environment variables are passed in via the command line (`-e`). If launching through Mesos, specify the variables and their values prior to launching the container.

|Variable|Default|Description|
|--------|-------|-----------|
|CDH_VERSION|5.11.0|Cloudera version to install in the container|
|MESOS_PEM| - | Text of the PEM key to SSH around the nodes in the mesos cluster|

## Older Versions
There are older images available corresponding to older versions of dcos-cli.

|mesos version|cli version|docker tag|
|-------------|-----------|----------|
|1.10|0.5.5|elubow/docker-dcos-cli:0.5.5|
|1.9|0.4.17|elubow/docker-dcos-cli:0.4.17|
|1.8|0.4.14|elubow/docker-dcos-cli:0.4.14|

## Contributing
If you'd like to contribute (and contributions are welcome), create a pull request that includes documentation updates to the README for how to use your changes.
