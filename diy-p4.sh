#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

# 编译 OpenWrt
cd h5/friendlywrt
#cp ../../config.1806 ./.config
cp $GITHUB_WORKSPACE/$CONFIG_FILE $GITHUB_WORKSPACE/openwrt/.config
make defconfig
make download
make tools/compile && \
make toolchain/compile && \
make package/feeds/luci/luci-base/compile && \
cp dl/naiveproxy-*.tar.gz build_dir/target-aarch64_cortex-a53_musl/ && \
cd ./build_dir/target-aarch64_cortex-a53_musl/ && \
tar zxvf naiveproxy-*.tar.gz && \
rm naiveproxy-*.tar.gz && \
cd ../../ && \
sed -i "s|sys/random.h|/usr/include/linux/random.h|g" build_dir/target-aarch64_cortex-a53_musl/naiveproxy-*/src/base/rand_util_posix.cc && \
#make -j1 V=s
make -j3 V=s
