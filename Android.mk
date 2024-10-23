#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter miatoll,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# Symlinks

ALL_DEFAULT_INSTALLED_MODULES += \
    $(CNE_SYMLINKS) \
    $(FACTORY_MOUNT_POINT_SYMLINK) \
    $(WLAN_FIRMWARE_SYMLINKS)

# WiFi firmware symlinks
WLAN_FIRMWARE_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld
$(WLAN_FIRMWARE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	mkdir -p $@/qca6390
	@echo "Creating WLAN firmware symlinks: $@"
	$(hide) ln -sf /vendor/etc/wifi/WCNSS_qcom_cfg.ini $@/WCNSS_qcom_cfg.ini
	$(hide) ln -sf /mnt/vendor/persist/wlan_mac.bin $@/wlan_mac.bin

endif
