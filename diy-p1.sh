#!/bin/bash
#
##############################
####  第一部分：环境部署  ####
##############################

# 环境部署
sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /opt/ghc
sudo -E apt-get -qq update
sudo -E apt-get -qq install $(curl -fsSL git.io/depends-ubuntu-1804)
sudo -E apt-get -qq autoremove --purge
sudo -E apt-get -qq clean
sudo timedatectl set-timezone "$TZ"
sudo apt-get -y install bc libtinfo5 build-essential asciidoc binutils bzip2 gawk gettext \
  git libncurses5-dev libz-dev unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex \
  uglifyjs git-core gcc-multilib autopoint msmtp libssl-dev texinfo libglib2.0-dev xmlto \
  qemu-utils upx libelf-dev autoconf automake libtool device-tree-compiler patch p7zip \
  p7zip-full curl ne screen htop libxcb-ewmh-dev parted dosfstools gcc-aarch64-linux-gnu 
wget -O - https://raw.githubusercontent.com/friendlyarm/build-env-on-ubuntu-bionic/master/install.sh | bash
sudo mkdir -p /workdir
sudo chown $USER:$GROUPS /workdir

# 安装 Repo
git clone https://github.com/friendlyarm/repo
sudo cp repo/repo /usr/bin/
