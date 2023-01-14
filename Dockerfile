FROM python:3.9-buster

ENV SCDL_VERSION=2.4.0
ENV SCDL_SRC_URL=https://github.com/flyingrub/scdl/archive/refs/tags/v${SCDL_VERSION}.tar.gz
ENV SCDL_INSTALL_FILE=/tmp/scdl-${SCDL_VERSION}.tar.gz
ENV SCDL_INSTALL_DIR=/opt/app
ENV SCDL_DIR=${SCDL_INSTALL_DIR}/scdl-${SCDL_VERSION}

RUN apt-get update && apt-get install -y ffmpeg
RUN mkdir -p ${SCDL_INSTALL_DIR} && mkdir -p /music
RUN wget ${SCDL_SRC_URL} -O ${SCDL_INSTALL_FILE}
RUN tar -xvzf ${SCDL_INSTALL_FILE} -C ${SCDL_INSTALL_DIR}
RUN rm ${SCDL_INSTALL_FILE}

VOLUME /music

WORKDIR ${SCDL_DIR}

RUN python setup.py install

ENTRYPOINT ["scdl", "--path", "/music"]
