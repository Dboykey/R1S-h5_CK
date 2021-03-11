#!/bin/bash
#
##############################
####  第三部分：调整代码  ####
##############################

cd h5

# 调整 lede 的插件
git clone https://github.com/coolsnowwolf/lede 5.4
cd 5.4
./scripts/feeds update -a
cd ..
git clone https://github.com/coolsnowwolf/openwrt 4.14
cd 4.14
./scripts/feeds update -a
#cd ..
#git clone https://github.com/Lienol/openwrt Lienol
#cd Lienol
#./scripts/feeds update -a

cp -r package/lean/ ../friendlywrt/package/
cd ../friendlywrt/package/lean
rm -rf baidupcs-web
rm -rf luci-app-baidupcs-web
rm -rf luci-theme-netgear
rm -rf luci-theme-argon
rm -rf samba4
rm -rf luci-app-samba4
rm -rf luci-app-docker
rm -rf luci-lib-docker 
rm -rf luci-app-n2n_v2
rm -rf n2n_v2
rm -rf luci-app-openvpn-server
rm -rf luci-app-qbittorrent
rm -rf qBittorrent
rm -rf luci-app-softethervpn
rm -rf softethervpn5
rm -rf luci-app-vsftpd
rm -rf vsftpd-alt
rm -rf qt5
rm -rf luci-app-webadmin
rm -rf dns2socks
rm -rf ipt2socks
rm -rf kcptun
rm -rf microsocks
rm -rf pdnsd-alt
rm -rf shadowsocksr-libev
rm -rf simple-obfs
rm -rf trojan
rm -rf v2ray-plugin
rm -rf k3*
rm -rf luci-app-ssrserver-python
rm -rf luci-app-cifsd
rm -rf automount
rm -rf ksmbd-tools
rm -rf ksmbd

# 更新下载 feed 前代码微调
cd ../../
mv feeds.conf.default feeds.conf.default.bak
touch feeds.conf.default
echo "src-git packages https://git.openwrt.org/feed/packages.git;openwrt-18.06" >>feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git;openwrt-18.06" >>feeds.conf.default
echo "src-git luci https://github.com/coolsnowwolf/luci" >>feeds.conf.default
git clone https://github.com/Dboykey/CKdiy.git package/CKdiy
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone -b master https://github.com/vernesong/OpenClash.git ../add/OpenClash
cp -r ../add/OpenClash/luci-app-openclash ./package/lean/
git clone https://github.com/rosywrt/luci-theme-rosy.git ../add/Rosy
cp -r ../add/Rosy/luci-theme-rosy ./package/lean/
git clone https://github.com/linkease/ddnsto-openwrt.git ../add/ddnsto
cp -r ../add/ddnsto/luci-app-ddnsto ./package/lean/
cp -r ../add/ddnsto/ddnsto ./package/network/services/

# 更新下载 feeds
./scripts/feeds update -a

# 下载后删除有冲突又没用的部分
rm -rf feed/luci/collections/luci-app-unbound
rm -rf feed/luci/collections/luci-app-nginx
rm -rf feed/luci/collections/luci-app-ssl-nginx
rm -rf package/feeds/luci/luci-ssl-nginx
rm -rf feeds/luci/collections/luci-nginx
rm -rf feeds/luci/collections/luci-ssl-nginx
rm -rf package/feeds/luci/luci-app-unbound
rm -rf feeds/luci/applications/luci-app-unbound
rm -rf package/feeds/luci/luci-app-transmission
rm -rf feeds/luci/applications/luci-app-transmission

# 安装 feed 前代码微调
mv package/CKdiy/packr feeds/packages/devel/
cp -r ../4.14/feeds/packages/libs/nss package/CKdiy/
cp -r ../4.14/feeds/packages/libs/nspr package/CKdiy/
cp -r ../4.14/feeds/packages/devel/ninja package/CKdiy/
rm -rf feeds/packages/lang/golang
cp -r ../5.4/feeds/packages/lang/golang ./feeds/packages/lang/
rm -rf feeds/packages/admin/ipmitool
cp -r ../5.4/feeds/packages/admin/ipmitool ./feeds/packages/admin/
rm -rf package/libs/openssl
cp -r ../4.14/package/libs/openssl ./package/libs/
rm -rf package/libs/libevent2
cp -r ../4.14/package/libs/libevent2 ./package/libs/
rm -rf feeds/packages/libs/glib2
cp -r ../4.14/feeds/packages/libs/glib2 ./feeds/packages/libs
cp -r ../4.14/tools/upx ./tools/
cp -r ../4.14/tools/ucl ./tools/
rm tools/Makefile
cp -r package/CKdiy/upx/Makefile tools/

echo -e '\nDboykey Build\n'  >> package/base-files/files/etc/banner
ln -s package/lean/default-settings/files/zzz-default-settings
sed -i '/uci commit luci/i\\uci set luci.main.mediaurlbase=/luci-static/rosy' package/lean/default-settings/files/zzz-default-settings
sed -i -e '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit luci/a\\uci commit network" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit luci/a\\uci set network.lan.netmask='255.255.255.0'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit luci/a\\uci set network.lan.ipaddr='192.168.3.1'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit luci/a\\ " package/lean/default-settings/files/zzz-default-settings
sed -i '/exit/i\chown -R root:root /usr/share/netdata/web' package/lean/default-settings/files/zzz-default-settings
cp -r ../5.4/feeds/luci/applications/luci-app-advanced-reboot/po/zh-cn feeds/luci/applications/luci-app-advanced-reboot/po/
sed -i 's/高级重启/关机/' feeds/luci/applications/luci-app-advanced-reboot/po/zh-cn/advanced-reboot.po
sed -i 's/双分区启动切换/关机/' package/lean/default-settings/i18n/more.zh-cn.po
sed -i '9,12d' feeds/luci/applications/luci-app-diag-core/luasrc/controller/luci_diag.lua

cp feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm.bak
sed -i '/Load Average/i\<tr><td width="33%"><%:CPU Temperature%></td><td><%=luci.sys.exec("cut -c1-2 /sys/class/thermal/thermal_zone0/temp")%></td></tr>' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/pcdata(boardinfo.system or "?")/"ARMv8"/' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 安装 feeds
./scripts/feeds install -a
