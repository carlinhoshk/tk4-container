FROM ubuntu:18.04 as builder

RUN apt-get update && apt-get install -yq unzip
WORKDIR /tk4-/

# lembrar que a vm azure da erro de certificado http
ADD . /tk4-/
RUN unzip tk4-_v1.00_current.zip && \
    rm -rf /tk4-/tk4-_v1.00_current.zip
