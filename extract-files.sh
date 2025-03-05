#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2024 Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=miatoll
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/etc/camera/camxoverridesettings.txt)
            sed -i "s/0x10080/0/g" "${2}"
            sed -i "s/0x1F/0x0/g" "${2}"
            ;;
        vendor/lib64/camera/components/com.qti.node.watermark.so)
            [ "$2" = "" ] && return 0
            grep -q "libpiex_shim.so" "${2}" || "${PATCHELF}" --add-needed "libpiex_shim.so" "${2}"
            ;;
        vendor/etc/seccomp_policy/atfwd@2.0.policy)
            [ "$2" = "" ] && return 0
            grep -q "gettid: 1" "${2}" || echo "gettid: 1" >> "${2}"
            ;;
        vendor/lib64/libwvhidl.so)
            [ "$2" = "" ] && return 0
            grep -q "libcrypto-v33.so" "${2}" || "${PATCHELF}" --replace-needed "libcrypto.so" "libcrypto-v33.so" "$2"
            ;;
        vendor/lib64/libalAILDC.so | vendor/lib64/libalhLDC.so | vendor/lib64/libalLDC.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --clear-symbol-version "AHardwareBuffer_allocate" "$2"
            "${PATCHELF}" --clear-symbol-version "AHardwareBuffer_describe" "$2"
            "${PATCHELF}" --clear-symbol-version "AHardwareBuffer_lock" "$2"
            "${PATCHELF}" --clear-symbol-version "AHardwareBuffer_release" "$2"
            "${PATCHELF}" --clear-symbol-version "AHardwareBuffer_unlock" "$2"
            ;;
        vendor/lib64/libhvx_interface.so | vendor/lib64/libmialgo_rfs.so | vendor/lib64/libVDSuperPhotoAPI.so | vendor/lib64/libsnpe_dsp_domains_v2.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --clear-symbol-version "remote_handle_close" "$2"
            "${PATCHELF}" --clear-symbol-version "remote_handle_invoke" "$2"
            "${PATCHELF}" --clear-symbol-version "remote_handle_open" "$2"
            "${PATCHELF}" --clear-symbol-version "remote_register_buf_attr" "$2"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
