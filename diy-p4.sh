#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

# 编译 OpenWrt
cd h5/friendlywrt
#cp ../../config.1806 ./.config
cp $GITHUB_WORKSPACE/$CONFIG_FILE ./.config
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
sed 's/.tar.gz//g' name2.txt >name3.txt
NAME2=$(cat name3.txt)
cd ..
cp dl/$NAME1 build_dir/target-aarch64_cortex-a53_musl/
cd ./build_dir/target-aarch64_cortex-a53_musl/
tar zxvf $NAME1
rm $NAME1
cd ../../
sed -i "s|sys/random.h|/usr/include/linux/random.h|g" build_dir/target-aarch64_cortex-a53_musl/$NAME2/src/base/rand_util_posix.cc

make tools/compile
make toolchain/compile
make package/feeds/luci/luci-base/compile
#make package/passwall/naiveproxy/compile

make -j1
#make -j3
