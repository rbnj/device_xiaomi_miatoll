# Inherit framework first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, vendor/hentai/build/product/hentai_product.mk)

#
# All components inherited here go to vendor image
#
# TODO(b/136525499): move *_vendor.mk into the vendor makefile later
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_vendor.mk)

# Inherit from miatoll device
$(call inherit-product, device/xiaomi/miatoll/atoll.mk)

# Inherit some common hentai stuff.
$(call inherit-product, vendor/hentai/config/common.mk)

# Device identifier
PRODUCT_NAME := hentai_miatoll
PRODUCT_DEVICE := miatoll
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := miatoll
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
