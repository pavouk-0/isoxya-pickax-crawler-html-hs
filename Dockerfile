#===============================================================================
# FROMFREEZE docker.io/library/haskell:8.8
FROM docker.io/library/haskell@sha256:3bc35e35a9be4a573d4d7b8dff799e9ee6c57870365629bb1cc0e8e2c4f973b6

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        daemontools \
        happy \
        hlint \
        jq \
        libpcre3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/repo && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo

ENV PATH ${HOME}/.cabal/bin:$PATH

COPY --chown=x:x [ \
    "cabal.config", \
    "*.cabal", \
    "./"]

RUN cabal v1-update && \
    cabal v1-install -j --only-dependencies --enable-tests
#-------------------------------------------------------------------------------
ENV ADDRESS=0.0.0.0 \
    PORT=8000

CMD cabal v1-run isx-plugin-crawler-html -- -b ${ADDRESS} -p ${PORT}

EXPOSE ${PORT}

HEALTHCHECK CMD curl -fs http://${ADDRESS}:${PORT} || false
#===============================================================================
