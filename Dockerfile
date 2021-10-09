FROM debian:stretch-slim
MAINTAINER alexej.bondarenko@ersocon.net

RUN apt-get update && apt-get -y install cron s3cmd wget gnupg

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch"-pgdg main | tee  /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get -y install postgresql-13

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/backup-cron

ADD backup.sh backup.sh
ADD entrypoint.sh entrypoint.sh

RUN chmod +x backup.sh
RUN chmod +x entrypoint.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/backup-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

ENTRYPOINT ["/entrypoint.sh"]

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log

