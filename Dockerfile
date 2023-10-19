FROM ubuntu:20.04

RUN apt-get update && apt-get -y install cron jq curl

COPY entrypoint.sh /entrypoint.sh

RUN chmod 0744 /entrypoint.sh

COPY dyndns.sh /dyndns.sh

RUN chmod 0744 /dyndns.sh

COPY hetzner-dyndns-cron /etc/cron.d/hetzner-dyndns-cron

RUN chmod 0664 /etc/cron.d/hetzner-dyndns-cron

RUN crontab /etc/cron.d/hetzner-dyndns-cron

ENTRYPOINT [ "/entrypoint.sh" ]