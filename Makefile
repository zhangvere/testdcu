include $(TOPDIR)/rules.mk

PKG_NAME:=dcu_test
PKG_VERSION:=1.5
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/dcu_test
	SECTION:=base
	CATEGORY:=Utilities
	TITLE:=test mode script and app in DCU
	#DEPENDS:= +libstdc++.so.6 +libusb-1.0.so.0 +libuuid.so.1
	URL:=www.szclou.com
endef

define Package/dcu_test/description
	CL752C1 hardware test application
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

TARGET_CFLAGS += '-DAPPVER=\"$(PKG_VERSION)\"'

define Package/dcu_test/install
	$(INSTALL_DIR) $(1)/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dcu_test $(1)/sbin/
	
	$(INSTALL_BIN) ./script/usb.sh $(1)/sbin/
	$(INSTALL_BIN) ./script/button.sh $(1)/sbin/
	$(INSTALL_BIN) ./script/cover.sh $(1)/sbin/
	$(INSTALL_BIN) ./script/ethernet.sh $(1)/sbin/
	
	$(INSTALL_BIN) ./script/setdcuaddr.sh $(1)/sbin/
	$(INSTALL_BIN) ./script/getdcuaddr.sh $(1)/sbin/
	$(INSTALL_BIN) ./script/setmacaddr.sh $(1)/sbin/
	
	#$(INSTALL_DIR) $(1)/cp2108/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/dcu_test $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/cp210xsmt $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/cp2108.data $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/cp2108_send_high.data $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/cp2108_send_low.data $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/libcp210xmanufacturing.so.1.0 $(1)/cp2108/
	#$(INSTALL_BIN) ./cp2108/upgrade $(1)/cp2108/
	
	
	
endef

$(eval $(call BuildPackage,dcu_test))
