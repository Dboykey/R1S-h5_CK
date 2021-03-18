#!/bin/bash
#
#############################
####  第四部分：编译WRT  ####
#############################

cd openwrt

cd dl
ls naiveproxy* >name1.txt
sed -n '$p' name1.txt >name2.txt
NAME1=$(cat name2.txt)
sed 's/.tar.gz//g' name2.txt >name3.txt
NAME2=$(cat name3.txt)
cd .. && \
cp dl/$NAME1 build_dir/target-aarch64_cortex-a53_musl/ && \
cd build_dir/target-aarch64_cortex-a53_musl/
tar zxvf $NAME1 && \
sleep 20s && \
cd $NAME2/src/base/ && \
sed -i "s|sys/random.h|/usr/include/linux/random.h|g" rand_util_posix.cc && \
cd $GITHUB_WORKSPACE/openwrt
make package/passwall/naiveproxy/compile && \
make -j1 V=s
