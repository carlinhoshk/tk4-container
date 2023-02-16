FROM ubuntu:latest as builder

RUN apt-get update && apt-get install -yq unzip gnucobol
WORKDIR /tk4-/

# lembrar que a vm azure da erro de certificado http
#RUN wget --no-check-certificate https://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip
#ADD . /tk4-/
RUN unzip tk4-_v1.00_current.zip && \
    rm -rf /tk4-/tk4-_v1.00_current.zip

# daqui para baixo automatiza e abre porta web    
RUN echo "CONSOLE">/tk4-/unattended/mode
RUN rm -rf /tk4-/hercules/darwin && \
    rm -rf /tk4-/hercules/windows && \
    rm -rf /tk4-/hercules/source 

    
FROM ubuntu:latest
RUN apt-get update && apt-get install -yq \
    git \
    git-lfs \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod


LABEL version="1.00"
LABEL description="OS/VS2 MVS 3.8j Service Level 8505, Tur(n)key Level 4- Version 1.00"
WORKDIR /tk4-/
COPY --from=builder /tk4-/ .
VOLUME [ "/tk4-/conf","/tk4-/local_conf","/tk4-/local_scripts","/tk4-/prt","/tk4-/dasd","/tk4-/pch","/tk4-/jcl","tk4-/log" ]
CMD ["/tk4-/mvs"]

EXPOSE 3270 8038   



