FROM ubuntu:18.04


# Fix MY timezone. 
ARG TZ=America/Sao_Paulo
RUN ln -sfv "/usr/share/zoneinfo/$TZ" /etc/localtime &&\
    echo "$TZ" > /etc/timezone

# A non root user for compile packages
RUN useradd -m -s /bin/bash pascal


# Install all needed packages
RUN apt-get update -y
RUN apt install make binutils build-essential gdb vim wget gcc subversion zip unzip libx11-dev libgtk2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev mingw-w64 openjdk-8-jre-headless libxslt1-dev libxml2-dev libssl-dev nfs-common rename -y

# Install fpc-laz - fpc-src - lazarus 2.0.12 - jsign
WORKDIR /tmp
RUN wget https://sinalbr.dl.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.2.6/fpc-laz_3.2.2-210709_amd64.deb
RUN wget https://sinalbr.dl.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.2.6/fpc-src_3.2.2-210709_amd64.deb
RUN wget https://sinalbr.dl.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.2.6/lazarus-project_2.2.6-0_amd64.deb
RUN wget https://github.com/ebourg/jsign/releases/download/4.2/jsign_4.2_all.deb

RUN chmod +x *
RUN dpkg -i fpc-laz_3.2.2-210709_amd64.deb
RUN dpkg -i fpc-src_3.2.2-210709_amd64.deb
RUN dpkg -i lazarus-project_2.2.6-0_amd64.deb
RUN dpkg -i jsign_4.2_all.deb
RUN rm -f fpc* lazarus-project* jsign_4*

# Creates the machine-id file needed by boss
# https://github.com/HashLoad/boss
RUN dbus-uuidgen > /etc/machine-id

# Fix the "windres" not found problem
RUN ln -s /usr/bin/x86_64-w64-mingw32-windres /usr/bin/windres

# ACBr project use these symlinks 
WORKDIR /lib64
RUN test -e libxmlsec1.so \
    || ln -s libxmlsec1.so.1 libxmlsec1.so
RUN test -e libxmlsec1-openssl.so \
    || ln -s libxmlsec1-openssl.so.1 libxmlsec1-openssl.so
RUN test -e libxslt.so \
    || ln -s libxslt.so.1 libxslt.so
RUN test -e libxml2.so \
    || ln -s libxml2.so.2 libxml2.so
RUN test -e libexslt.so \
    || ln -s libexslt.so.0 libexslt.so
RUN test -e libssl.so \
    || ln -s libssl.so.1.1 libssl.so
RUN test -e libcrypto.so \
    || ln -s libcrypto.so.1.1 libcrypto.so
RUN /sbin/ldconfig

# Build compilers for another archtecture
WORKDIR /usr/share/fpcsrc/3.2.2
#Windows32
RUN make clean all OS_TARGET=win32 CPU_TARGET=i386
RUN make crossinstall OS_TARGET=win32 CPU_TARGET=i386 INSTALL_PREFIX=/usr
RUN ln -sf /usr/lib/fpc/3.2.2/ppcross386 /usr/bin/ppcross386
#Windows64
RUN make clean all OS_TARGET=win64 CPU_TARGET=x86_64
RUN make crossinstall OS_TARGET=win64 CPU_TARGET=x86_64 INSTALL_PREFIX=/usr
RUN ln -s /usr/lib/fpc/3.2.2/ppcrossx64 /usr/bin/ppcrossx64
RUN sed -i '161i\-Fu/usr/lib64/fpc/$fpcversion/units/$fpctarget/*' /etc/fpc.cfg

WORKDIR /home/pascal

USER pascal
