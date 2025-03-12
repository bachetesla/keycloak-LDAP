FROM docker.arvancloud.ir/docker/jboss/keycloak:latest

ADD cli/TCPPING.cli /opt/jboss/tools/cli/jgroups/discovery/
ADD cli/JDBC_PING.cli /opt/jboss/tools/cli/jgroups/discovery/