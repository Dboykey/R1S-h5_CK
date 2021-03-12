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
make tools/compile
make toolchain/compile
make package/feeds/luci/luci-base/compile

cd dl
ls naiveproxy* >name.txt
NAME1=$(cat name.txt)
cat name.txt | sed -i 's/.tar.gz//g' name.txt
NAME2=$(cat name.txt)
cd ..
cp dl/$NAME1 build_dir/target-aarch64_cortex-a53_musl/
cd ./build_dir/target-aarch64_cortex-a53_musl/
tar zxvf $NAME1
rm $NAME1
cd ../../
sed -i "s|sys/random.h|/usr/include/linux/random.h|g" build_dir/target-aarch64_cortex-a53_musl/$NAME2/src/base/rand_util_posix.cc
make package/passwall/naiveproxy/compile && \

make -j1
#make -j3
