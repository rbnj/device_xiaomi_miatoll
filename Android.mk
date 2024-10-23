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
    $(FACTORY_MOUNT_POINT_SYMLINK)

endif
