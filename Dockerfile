FROM ubuntu:24.04

RUN apt update -y && \
    apt install fontconfig wget cabextract xfonts-utils unzip ttf-mscorefonts-installer -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN apt update -y && \
    apt install software-properties-common -y && \
    add-apt-repository ppa:inkscape.dev/stable && \
    apt update -y && \
    apt install inkscape -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
