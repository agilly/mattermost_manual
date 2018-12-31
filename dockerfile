FROM ubuntu:latest
MAINTAINER Arthur Gilly "ag15@sanger.ac.uk"

RUN apt-get update
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
RUN apt-get install -y postgresql postgresql-contrib wget nano sudo sponge

RUN service postgresql restart
COPY sql.commands /
RUN chmod a+r /sql.commands
COPY pg_hba.conf /etc/postgresql/10/main/pg_hba.conf
RUN chmod a+r /etc/postgresql/10/main/pg_hba.conf
COPY conf_psql.sh /
RUN chmod a+x /conf_psql.sh
RUN /conf_psql.sh

COPY postgresql.conf /etc/postgresql/10/main/postgresql.conf

RUN service postgresql restart

RUN wget https://releases.mattermost.com/5.6.2/mattermost-5.6.2-linux-amd64.tar.gz && tar -xvzf mattermo*gz && mv mattermost /opt && mkdir /opt/mattermost/data && useradd --system --user-group mattermost && chown -R mattermost:mattermost /opt/mattermost && chmod -R g+w /opt/mattermost

COPY set_config.sh /
RUN chmod a+x /set_config.sh
RUN /set_config.sh
RUN chmod a+rw,o+rw /opt/mattermost/config/config.json

RUN chown mattermost:mattermost /opt/mattermost/config/config.json && chmod g+w /opt/mattermost/config/config.json
WORKDIR /opt/mattermost
COPY start_server.sh /opt/mattermost/start_server.sh
RUN chmod a+x,o+x /opt/mattermost/start_server.sh

