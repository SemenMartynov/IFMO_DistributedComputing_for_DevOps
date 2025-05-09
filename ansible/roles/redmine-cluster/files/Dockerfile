FROM postgres:17.4

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        # python3-etcd \
        python3-consul \
        # python3-kazoo \
        # python3-kubernetes \
        # python3-pysyncobj \
        patroni \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /data/patroni \
    && chown -R postgres:postgres /data \
    && chmod -R 700 /data 

COPY --chown=postgres:postgres --chmod=600 patroni.yml /etc/patroni.yml
COPY --chown=postgres:postgres --chmod=755 patroni-entrypoint.sh /entrypoint.sh

USER postgres

ENTRYPOINT ["/entrypoint.sh"]
