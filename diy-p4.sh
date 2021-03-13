#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

# 编译 OpenWrt
#cp ../../config.1806 ./.config
cp $CONFIG_FILE openwrt/.config
cd openwrt
make defconfig
make download

mkdir -p build_dir/target-aarch64_cortex-a53_musl/
cd dl
ls naiveproxy* >name1.txt
##添加只取最后一行内容
sed -n '$p' name1.txt >name2.txt
#或
#cat name1.txt | awk 'END {print}' >name2.txt
NAME1=$(cat name2.txt)
##删除“.tar.gz”字符串
sed 's/.tar.gz//g' name2.txt >name3.txt
NAME2=$(cat name3.txt)
cd ..
cp dl/$NAME1 build_dir/target-aarch64_cortex-a53_musl/
cd build_dir/target-aarch64_cortex-a53_musl/
tar zxvf $NAME1
rm $NAME1
cd $NAME2/src/base/
sed -i "s|sys/random.h|/usr/include/linux/random.h|g" rand_util_posix.cc

cd $GITHUB_WORKSPACE/openwrt
make tools/compile
make toolchain/compile
make package/feeds/luci/luci-base/compile
#make package/passwall/naiveproxy/compile

#make -j1
make -j3 V=s
