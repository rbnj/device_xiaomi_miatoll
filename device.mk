#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Android Go configurations
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := \
    frameworks/base/boot/boot-image-profile.txt \
    frameworks/base/boot/boot-image-profile-extra.txt

# Audio
PRODUCT_PACKAGES += \
    audio_amplifier.tas2562

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_ODM_PROPERTIES += \
    ro.vendor.audio.sdk.fluencetype=fluence \
    vendor.audio.offload.buffer.size.kb=256

PRODUCT_VENDOR_PROPERTIES += \
    ro.config.vc_call_vol_default=9 \
    ro.config.vc_call_vol_steps=11 \
    ro.hardware.audio_amplifier=tas2562

# Bluetooth
PRODUCT_ODM_PROPERTIES += \
    persist.vendor.bluetooth.modem_nv_support=true

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac-aptxadaptive \
    persist.vendor.qcom.bluetooth.aac_frm_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=false \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.scram.enabled=true \
    persist.vendor.qcom.bluetooth.soc=cherokee \
    ro.vendor.bluetooth.wipower=false \
    vendor.qcom.bluetooth.soc=cherokee

# Camera
$(call inherit-product-if-exists, vendor/xiaomi/camera/miuicamera.mk)

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    libpiex_shim \
    libui-v34

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_SYSTEM_PROPERTIES += \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera

PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1 \
    ro.hardware.camera=xiaomi

# Cutout
PRODUCT_PACKAGES += \
    AvoidAppsInCutoutOverlay \
    NoCutoutOverlay

PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Dex2oat
PRODUCT_VENDOR_PROPERTIES += \
    dalvik.vm.dex2oat-cpu-set=4,5,6,7 \
    dalvik.vm.dex2oat-threads=4 \
    dalvik.vm.image-dex2oat-cpu-set=4,5,6,7 \
    dalvik.vm.image-dex2oat-threads=4

# Dex-preopt/ART
ifeq ($(TARGET_BUILD_VARIANT), user)
ART_BUILD_HOST_DEBUG := false
ART_BUILD_HOST_NDEBUG := false
ART_BUILD_TARGET_DEBUG := false
ART_BUILD_TARGET_NDEBUG := false
DONT_DEXPREOPT_PREBUILTS := true
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_OTHER_JAVA_DEBUG_INFO := false
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed
PRODUCT_SYSTEM_SERVER_DEBUG_INFO := false
USE_DEX2OAT_DEBUG := false
WITH_DEXPREOPT_DEBUG_INFO := false
endif

# Display / Graphics
TARGET_USE_AIDL_QTI_MEMTRACK := true

PRODUCT_PACKAGES += \
    disable_configstore

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.disable_backpressure=1 \
    debug.sf.enable_egl_image_tracker=0 \
    debug.sf.enable_transaction_tracing=false \
    persist.sys.sf.color_mode=9 \
    persist.sys.sf.color_saturation=1.0 \
    persist.sys.sf.native_mode=2 \
    ro.hardware.egl=adreno \
    ro.hardware.vulkan=adreno \
    ro.opengles.version=196610 \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.surface_flinger.has_wide_color_display=true \
    ro.surface_flinger.has_HDR_display=true \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.max_virtual_display_dimension=4096 \
    ro.surface_flinger.protected_contents=true \
    ro.surface_flinger.use_color_management=true \
    ro.surface_flinger.wcg_composition_dataspace=143261696 \
    ro.vendor.display.sensortype=2 \
    ro.vendor.display.svi=1 \
    vendor.display.disable_rotator_downscale=1 \
    vendor.display.svi.config=1 \
    vendor.display.svi.config_path=/vendor/etc/SVIConfig.xml \
    vendor.display.qdcm.disable_factory_mode=1 \
    vendor.display.qdcm.mode_combine=1

# DPM
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.dpmhalservice.enable=1

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey \
    libcrypto-v33 \
    libdrm.vendor

PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi \
    com.fingerprints.extension@1.0.vendor \
    vendor.goodix.hardware.biometrics.fingerprint@2.1.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# FUSE
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# GFX
PRODUCT_VENDOR_PROPERTIES += \
    ro.config.avoid_gfx_accel=true

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti \
    android.hardware.gnss@2.1-service-qti

PRODUCT_PACKAGES += \
    libbatching \
    libgeofencing \
    libgnss

PRODUCT_PACKAGES += \
    flp.conf \
    gnss_antenna_info.conf \
    gps.conf \
    izat.conf

PRODUCT_PACKAGES += \
    libjsoncpp.vendor \
    libsqlite.vendor \
    libpng.vendor

# GPS libshims
PRODUCT_PACKAGES += \
    liblbs_core_shim \
    libloc_api_shim

# GSI
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Health
TARGET_USE_HIDL_QTI_HEALTH := true

PRODUCT_PACKAGES += \
    android.hardware.health@2.1.vendor \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery \
    vendor.lineage.health-service.default

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor

# HVDCP
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.cp.fcc_main_ua=400000 \
    persist.vendor.cp.taper_term_mv=6500 \
    persist.vendor.cp.vbus_offset_mv=1040

# Incremental FS
PRODUCT_VENDOR_PROPERTIES += \
    ro.incremental.enable=1

# Init scripts
PRODUCT_PACKAGES += \
    init.miatoll.rc \
    init.miatoll.perf.rc \
    init.qti.dcvs.sh \
    init.sensors_fix.sh \
    init.target.rc \
    ueventd.miatoll.rc

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir-service.example

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_PRODUCT_PROPERTIES += \
    ro.bpf.kver_override=5.4.299

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.keymaster@4.1.vendor

PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.options=::v2 \
    ro.hardware.keystore_desede=true

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.xiaomi

# LMK
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.lmk.force_inkernel_lmk=true

# Logging
SPAMMY_LOG_TAGS := \
    AiAiEcho \
    AiAiTextClassifier \
    AppLinksAsyncVerifierV2 \
    BaseDepthController \
    GraphicsEnvironment \
    Diag_Lib \
    CCodec \
    CCodecBufferChannel \
    CCodecConfig \
    Codec2Client \
    LazyLogger \
    PackageCacher \
    PackageSettings \
    QtiLinkBandwidthEstimator-0 \
    SDM \
    SRE \
    WifiHAL \
    WifiService \
    cnss-daemon \
    CameraService \
    ForegroundUtils \
    sensors \
    sensors-hal \
    a2dp_offload \
    bluetooth-a2dp \
    BluetoothMetrics \
    DisplayManagerService \
    DisplayModeController \
    FrameTracker

ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_VENDOR_PROPERTIES += \
    $(foreach tag,$(SPAMMY_LOG_TAGS),log.tag.$(tag)=E)
endif

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2.vendor \
    libavservices_minijail \
    libavservices_minijail.vendor \
    libcodec2.vendor \
    libcodec2_hal_common.so.vendor \
    libcodec2_hidl@1.0.vendor \
    libcodec2_hidl_plugin.so.vendor \
    libcodec2_vndk.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/media/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_c2.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

PRODUCT_SYSTEM_PROPERTIES += \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    ro.media.recorder-max-base-layer-fps=60 \
    persist.mm.enable.prefetch=true \
    vendor.mm.enable.qcom_parser=16777199

PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \
    vendor.video.disable.ubwc=1

# Enable QC2 bufferqueue block-pool
PRODUCT_PROPERTY_OVERRIDES += vendor.qc2.use.bqpool=1

# Memory tagging
PRODUCT_SYSTEM_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.system_server=off

# Neural Networks
PRODUCT_SYSTEM_PROPERTIES += \
    ro.nnapi.extensions.deny_on_product=true

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    libnfc-nci \
    libnfc_nci_jni \
    Tag \
    libnfc_vendor_extn_sys

TARGET_NFC_SKU := joyeuse

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf

# Namespaces
AB_OTA_UPDATER := false
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    bootable/deprecated-ota \
    hardware/xiaomi

# Netflix
PRODUCT_VENDOR_PROPERTIES += \
    ro.netflix.bsp_rev=Q6250-19132-1

# OMX
PRODUCT_PACKAGES += \
    libstagefright_softomx_plugin.vendor

# Overlays
PRODUCT_PACKAGES += \
    aptxalsOverlay \
    NeotericMiatollFrameworksOverlay \
    MiatollApertureOverlay \
    MiatollCarrierConfigOverlay \
    MiatollDeviceAsWebcamOverlay \
    MiatollFrameworksOverlay \
    MiatollNfcOverlay \
    MiatollSettingsOverlay \
    MiatollSystemUIOverlay \
    MiatollWifiOverlay \
    MiatollWifiMainlineOverlay

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    fstab.qcom

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

# Perf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml \
    $(LOCAL_PATH)/configs/perf/perfconfigstore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfconfigstore.xml

# Phantom process monitoring
PRODUCT_PRODUCT_PROPERTIES += \
    sys.fflag.override.settings_enable_monitor_phantom_procs=false

# Platform
TARGET_BOARD_PLATFORM := atoll

# Power
PRODUCT_PACKAGES += \
    android.hardware.power.stats@1.0-service.mock

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# QC common
TARGET_COMMON_QTI_COMPONENTS := \
    alarm \
    audio \
    av \
    bt \
    display \
    gps \
    init \
    nfc \
    overlay \
    perf \
    usb \
    vibrator \
    wfd \
    wlan

TARGET_GPS_COMPONENT_VARIANT := gps

# QMI
PRODUCT_PACKAGES += \
    libjson \
    libqti_vndfwk_detect.vendor \
    libvndfwk_detect_jni.qti.vendor

# RIL
PRODUCT_PACKAGES += \
    librmnetctl \
    libxml2

PRODUCT_PACKAGES += \
    libsqlite.vendor

PRODUCT_PACKAGES += \
    android.hardware.radio@1.6.vendor \
    android.hardware.radio.config@1.3.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.secure_element@1.2.vendor \
    android.hardware.wifi.hostapd@1.0.vendor \
    android.system.net.netd@1.1.vendor \
    vendor.qti.hardware.systemhelperaidl-V1-ndk.vendor

PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor \
    android.hardware.tetheroffload.control@1.0.vendor

PRODUCT_SYSTEM_PROPERTIES += \
    persist.vendor.cne.feature=1 \
    persist.vendor.dpm.feature=11 \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.dbg.wfc_avail_ovr=1

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.radio.add_power_save=1 \
    persist.radio.multisim.config=dsds \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.data_con_rprt=1 \
    persist.vendor.radio.enableadvancedscan=true \
    persist.vendor.radio.procedure_bytes=SKIP \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.snapshot_enabled=1 \
    persist.vendor.radio.snapshot_timer=5 \
    ro.telephony.default_network=22,20

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml

# RIL -  Data Services
SOONG_CONFIG_NAMESPACES += rmnetctl
SOONG_CONFIG_rmnetctl += \
    old_rmnet_data
SOONG_CONFIG_rmnetctl_old_rmnet_data := true

$(call inherit-product, vendor/qcom/opensource/dataservices/dataservices_vendor_product.mk)

# RIL - IPACM
PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/data-ipa-cfg-mgr-legacy
$(call inherit-product, vendor/qcom/opensource/data-ipa-cfg-mgr-legacy/ipacm_vendor_product.mk)

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.xiaomi-multihal \
    libsensorndkbridge

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 29

# Skia tracing
PRODUCT_PRODUCT_PROPERTIES += \
    debug.hwui.skia_tracing_enabled=false \
    debug.hwui.skia_use_perfetto_track_events=false

# SoC
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.model=SM7125

# Thermal
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/thermal/,$(TARGET_COPY_OUT_VENDOR)/etc)

# USB
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.usb.config=mtp,adb
endif

PRODUCT_VENDOR_PROPERTIES += \
    ro.usb.uvc.enabled=true

PRODUCT_HAS_GADGET_HAL := true

PRODUCT_ODM_PROPERTIES += \
    sys.usb.mtp.batchcancel=1 \
    vendor.usb.use_ffs_mtp=1

# Vendor blobs
$(call inherit-product, vendor/xiaomi/miatoll/miatoll-vendor.mk)

# Vibrator
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# ViPER4Android FX
$(call inherit-product-if-exists, packages/apps/ViPER4AndroidFX/config.mk)

# VSync
PRODUCT_VENDOR_PROPERTIES += \
    debug.cpurend.vsync=false

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# WiFi Firmware Symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink

# ZRAM
PRODUCT_VENDOR_PROPERTIES += \
    ro.zram.mark_idle_delay_mins=60 \
    ro.zram.first_wb_delay_mins=180 \
    ro.zram.periodic_wb_delay_hours=24
