FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
    apt install fontconfig wget cabextract xfonts-utils unzip ttf-mscorefonts-installer -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

###################################################################################################
### Fonts #########################################################################################
###################################################################################################
RUN mkdir -p /root/fonts
RUN mkdir -p /usr/share/fonts/custom

WORKDIR /root/fonts

# Install France font
COPY ./fonts/france.zip ./france.zip
RUN mkdir -p ./france && unzip france.zip -d ./france
RUN cp -r ./france /usr/share/fonts/custom

WORKDIR /root
RUN fc-cache -f -v

###################################################################################################
### Inkscape ######################################################################################
###################################################################################################
RUN apt update -y && \
    apt install software-properties-common -y && \
    add-apt-repository ppa:inkscape.dev/stable && \
    apt update -y && \
    apt install inkscape -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["inkscape", "--version"]
