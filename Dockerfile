FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
    apt install fontconfig -y && \
    apt install wget -y && \
    apt install cabextract -y && \
    apt install xfonts-utils -y

###################################################################################################
### Fonts #########################################################################################
###################################################################################################
RUN apt install unzip -y

RUN wget http://ftp.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
RUN dpkg -i ttf-mscorefonts-installer_3.6_all.deb

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
RUN apt install software-properties-common -y && \
    add-apt-repository ppa:inkscape.dev/stable && \
    apt update -y && \
    apt install inkscape -y

CMD ["inkscape", "--version"]