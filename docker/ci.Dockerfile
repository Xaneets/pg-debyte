ARG BASE_IMAGE=pg-debyte-ci-base
FROM ${BASE_IMAGE}

WORKDIR /workspace
COPY . /workspace
USER root
RUN chown -R postgres:postgres /workspace /usr/local/rustup /usr/local/cargo
USER postgres

CMD ["bash", "-lc", "env -u PG_VERSION -u PG_MAJOR /usr/local/cargo/bin/cargo pgrx test -p pg_debyte_ext --features pg17"]
