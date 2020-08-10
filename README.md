# docker-slimta

[Slimta](https://www.slimta.org/) provides a MTA (Mail Transfer Agent) [docker](http://www.docker.com) image with no local authentication enabled (to be run in a secure LAN or as sidecar).

### Build instructions

Clone this repo and then:

    cd docker-slimta
    docker build -t slimta .

Or you can use the provided [docker-compose](https://github.com/juanluisbaptiste/docker-postfix/blob/master/docker-compose.dev.yml) files:

    docker-compose build

You can also find a prebuilt docker image from [Docker Hub](https://registry.hub.docker.com/u/iconoeugen/slimta/), which can be pulled with this command:

    docker pull iconoeugen/slimta:latest

### How to run it

The following env variables need to be passed to the container:

* `SMTP_DOMAIN` Server address of the SMTP server.
* `SMTP_PORT` (Optional, Default value: 2525) Port address of the slimta server for SMTP relay.
* `SMTP_RELAY_HOST` Host name of the SMTP server.
* `SMTP_RELAY_PORT` (Optional, Default value: 25) Port address of the SMTP server.
* `SMTP_REGEX_SENDER` Emails allowed to be relayed.

To use this container from anywhere, the 25 port or the one specified by `SMTP_PORT` needs to be exposed to the docker host server:

    docker run -d --name postfix -p "25:2525"  \ 
           -e SMTP_SERVER=smtp.bar.com \
           -e SMTP_USERNAME=foo@bar.com \
           -e SMTP_PASSWORD=XXXXXXXX \
           -e SERVER_HOSTNAME=helpdesk.mycompany.com \
           iconoeugen/slimta

If you are going to use this container from other docker containers then it's better to just publish the port:

    docker run -d --name slimta -P \
           -e SMTP_SERVER=smtp.bar.com \
           -e SMTP_USERNAME=foo@bar.com \
           -e SMTP_PASSWORD=XXXXXXXX \
           -e SERVER_HOSTNAME=helpdesk.mycompany.com \
           iconoeugen/slimta

Or if you can start the service using the provided [docker-compose](https://github.com/iconoeugen/docker-slimta/blob/master/docker-compose.yml) file for production use:

    docker-compose up -d

To see the email logs in real time:

    docker logs -f slimta

### Debugging

If you need troubleshooting the container you can set the environment variable DEBUG=1 for a more verbose output.
