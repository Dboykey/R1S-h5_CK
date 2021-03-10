#!/bin/bash
#
##############################
####  第二部分：源码下载  ####
##############################

# 下载 friendlywrt-h5 源码
cd /workdir
mkdir h5
cd h5
repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b master -m h5.xml --repo-url=https://github.com/friendlyarm/repo  --no-clone-bundle
repo sync -c --no-clone-bundle -j8

# 替换 wrt 代码为 lede 版
rm -rf friendlywrt
git clone https://github.com/coolsnowwolf/openwrt friendlywrt

ln -sf /workdir/h5 $GITHUB_WORKSPACE/h5
ln -sf /workdir/h5/friendlywrt $GITHUB_WORKSPACE/openwrt
