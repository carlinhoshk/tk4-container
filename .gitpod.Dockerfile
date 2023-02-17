
FROM gitpod/workspace-full

ENV RETRIGGER=1

ENV BUILDKIT_VERSION=0.9.3
ENV BUILDKIT_FILENAME=buildkit-v${BUILDKIT_VERSION}.linux-amd64.tar.gz

# Install custom tools, runtime, etc.
RUN sudo su -c "cd /usr; curl -L https://github.com/moby/buildkit/releases/download/v${BUILDKIT_VERSION}/${BUILDKIT_FILENAME} | tar xvz"

RUN apt-get install -y gnucobol 

# lembrar que a vm azure da erro de certificado http
RUN wget --no-check-certificate https://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip
ADD . /tk4-/
RUN unzip tk4-_v1.00_current.zip && \
    rm -rf /tk4-/tk4-_v1.00_current.zip

# daqui para baixo automatiza e abre porta web    
#RUN echo "CONSOLE">/tk4-/unattended/mode
RUN rm -rf /tk4-/hercules/darwin && \
    rm -rf /tk4-/hercules/windows && \
    rm -rf /tk4-/hercules/source 

LABEL version="1.00"
LABEL description="OS/VS2 MVS 3.8j Service Level 8505, Tur(n)key Level 4- Version 1.00"
WORKDIR /tk4-/
COPY . .
VOLUME [ "/tk4-/conf","/tk4-/local_conf","/tk4-/local_scripts","/tk4-/prt","/tk4-/dasd","/tk4-/pch","/tk4-/jcl","tk4-/log" ]
CMD ["/tk4-/mvs"]
EXPOSE 3270 8038   
