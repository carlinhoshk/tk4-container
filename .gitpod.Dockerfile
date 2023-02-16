FROM carlinhoshk/tk4-container-web

ENV RETRIGGER=1

ENV BUILDKIT_VERSION=0.9.3
ENV BUILDKIT_FILENAME=buildkit-v${BUILDKIT_VERSION}.linux-amd64.tar.gz

# Install custom tools, runtime, etc.
RUN sudo su -c "cd /usr; curl -L https://github.com/moby/buildkit/releases/download/v${BUILDKIT_VERSION}/${BUILDKIT_FILENAME} | tar xvz"

RUN apt-get update 
LABEL version="1.00"
LABEL description="OS/VS2 MVS 3.8j Service Level 8505, Tur(n)key Level 4- Version 1.00"
WORKDIR /tk4-/
VOLUME [ "/tk4-/conf","/tk4-/local_conf","/tk4-/local_scripts","/tk4-/prt","/tk4-/dasd","/tk4-/pch","/tk4-/jcl","tk4-/log" ]
CMD ["/tk4-/mvs"]

EXPOSE 3270 8038