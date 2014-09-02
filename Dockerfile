FROM ruby:2

ADD . /
VOLUME /data
RUN gem install --no-ri --no-rdoc fpm

EXPOSE 2812
ENTRYPOINT ["/build.sh"]
