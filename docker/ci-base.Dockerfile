FROM postgres:17

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        clang \
        curl \
        git \
        llvm-dev \
        libclang-dev \
        build-essential \
        pkg-config \
        bison \
        flex \
        libicu-dev \
        libreadline-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        liblz4-dev \
        libzstd-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:$PATH
ENV USER=postgres
ENV LOGNAME=postgres
ENV HOME=/var/lib/postgresql

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
RUN cargo install cargo-pgrx --version 0.16.1 --locked

USER postgres
RUN cargo pgrx init --pg17 download
RUN cargo pgrx init --pg15 download
