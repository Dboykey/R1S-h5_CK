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

# 调整 wrt 代码【非常重要】
rm -rf friendlywrt
mkdir friendlywrt
cd friendlywrt
git init
git config user.email abc@abc.com
git config user.name abc
git remote add origin https://github.com/friendlyarm/friendlywrt.git
git remote add upstream https://github.com/openwrt/openwrt.git
git pull origin master-v18.06.1
git pull upstream openwrt-18.06 --no-edit

ln -sf /workdir/h5 $GITHUB_WORKSPACE/h5
ln -sf /workdir/h5/friendlywrt $GITHUB_WORKSPACE/openwrt
