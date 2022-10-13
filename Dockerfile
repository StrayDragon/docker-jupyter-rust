FROM rust:slim

RUN apt install apt-transport-https ca-certificates

COPY config/mirrors/cargo_config /.cargo/config
COPY config/mirrors/debian_config /etc/apt/sources.list 
COPY config/mirrors/pypi_config /etc/pip.conf

RUN rm -Rf /var/lib/apt/lists/* && \
  apt-get update  && \
  apt-get install -y \
  python3 python3-pip \
  cmake
RUN cargo install evcxr_jupyter
RUN evcxr_jupyter --install
RUN python3 -m pip install jupyterlab

COPY config /config
COPY scripts /scripts
RUN chmod +x scripts/*
WORKDIR /scripts

CMD ./start_jupyter.sh
