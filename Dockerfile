FROM andrius/asterisk:debian-stretch-slim-16-current

ENV LANG en_US.utf8
ENV NOTVISIBLE "in users profile"

RUN apt-get update -y \
    && apt-get install -y python2.7-minimal python-psycopg2 bash odbc-postgresql openssh-server less python-pyst wget gnupg lame \
    && echo "deb http://packages.irontec.com/debian stretch main" >> /etc/apt/sources.list \
    && wget http://packages.irontec.com/public.key -q -O - | apt-key add - \
    && apt-get update -y \
    && apt-get install sngrep -y \
    && cd /var/lib/asterisk/ \
    && wget https://freetech.com.ar:20851/sounds/sounds.tar.gz --no-check-certificate \
    && tar xzvf sounds.tar.gz \
    && rm -rf /var/lib/asterisk/sounds.tar.gz \
    && mkdir /var/lib/asterisk/sounds/oml/ \
    && mkdir /run/sshd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22