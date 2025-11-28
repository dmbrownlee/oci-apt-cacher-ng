FROM debian:bookworm-slim

VOLUME ["/var/cache/apt-cacher-ng","/var/log/apt-cacher-ng"]
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install --no-install-recommends -y apt-cacher-ng \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN echo 'PassThroughPattern: ^(.*):443$' >> /etc/apt-cacher-ng/acng.conf

EXPOSE 3142
CMD    chmod 777 /var/cache/apt-cacher-ng /var/log/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
