FROM centos:centos7

RUN yum -y update && yum clean all

RUN yum install -y tar which && yum clean all && \
  gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
  curl -L get.rvm.io | bash

RUN source /etc/profile.d/rvm.sh && \
  bash -l -c "rvm requirements && \
  rvm install ruby"
  
RUN echo "gem: --no-document" > ~/.gemrc && \
  bash -l -c "gem update --system && gem update"
  
RUN bash -l -c "gem install passenger --pre"

VOLUME ["/app"]

CMD bash -l -c "cd /app && bundle install && passenger start --user nobody &" && bash
