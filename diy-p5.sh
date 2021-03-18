#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

## 编译 OpenWrt - naiveproxy
#cd openwrt
##mkdir -p build_dir/target-aarch64_cortex-a53_musl/
#cd dl
#ls naiveproxy* >name1.txt
###添加只取最后一行内容
#sed -n '$p' name1.txt >name2.txt
##或
##cat name1.txt | awk 'END {print}' >name2.txt
#NAME1=$(cat name2.txt)
###删除“.tar.gz”字符串
#sed 's/.tar.gz//g' name2.txt >name3.txt
#NAME2=$(cat name3.txt)
#cd ..
#cp dl/$NAME1 build_dir/target-aarch64_cortex-a53_musl/
#cd build_dir/target-aarch64_cortex-a53_musl/
#tar zxvf $NAME1
##rm $NAME1
#cd $NAME2/src/base/
#sed -i "s|sys/random.h|/usr/include/linux/random.h|g" rand_util_posix.cc

#cd $GITHUB_WORKSPACE/openwrt
#cd openwrt
#make package/passwall/naiveproxy/compile

#make -j1 V=s
