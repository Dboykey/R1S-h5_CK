#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

# 编译 OpenWrt
cp config.1806 openwrt/.config
cd openwrt
make defconfig
make download
make tools/compile
make toolchain/compile
make package/feeds/luci/luci-base/compile
