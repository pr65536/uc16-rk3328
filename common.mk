CPUS := $(shell getconf _NPROCESSORS_ONLN)

include .config 

OUTPUT_DIR := $(PWD)
SCRIPT_DIR := $(OUTPUT_DIR)/scripts
TOOLPATH := ${OUTPUT_DIR}/rkbin/tools
TOOLS_DIR := $(OUTPUT_DIR)/tools
PRELOAD_DIR := $(OUTPUT_DIR)/preloader
CONFIG_DIR := $(OUTPUT_DIR)/config/$(IC_NAME)/$(BOARD_NAME)
OEM_BOOT_DIR := $(OUTPUT_DIR)/gadget

# VENDOR: toolchain from BSP ; DEB: toolchain from deb
TOOLCHAIN := DEB

RKBIN_REPO := https://github.com/rockchip-linux/rkbin.git --depth 1 
RKBIN_BRANCH := master 
RKBIN_SRC := $(PWD)/rkbin

ARCH := arm64
KERNEL_DTS := rk3328-rock64
KERNEL_DEFCONFIG := rockchip_linux_defconfig 
# UBOOT_DEFCONFIG := actduino_bubble_gum_v10_defconfig
UBOOT_DEFCONFIG := evb-rk3328_defconfig

#KERNEL_REPO := https://github.com/xapp-le/kernel.git
#KERNEL_REPO := https://github.com/rockchip-linux/kernel.git --depth 1 
KERNEL_REPO := https://github.com/ayufan-rock64/linux-kernel.git --depth 1
KERNEL_BRANCH := 4.4.132-1062-rockchip-ayufan 
KERNEL_SRC := $(PWD)/kernel
KERNEL_MODULES := $(PWD)/kernel-build
KERNEL_OUT := $(PWD)/kernel-build
KERNEL_UIMAGE := $(KERNEL_OUT)/arch/arm/boot/zImage
KERNEL_DTB := $(KERNEL_OUT)/arch/arm/boot/dts/$(KERNEL_DTS).dtb

#UBOOT_REPO := https://github.com/xapp-le/u-boot.git
UBOOT_REPO := https://github.com/rockchip-linux/u-boot.git --depth 1 
UBOOT_BRANCH := release-20171218
UBOOT_SRC := $(PWD)/u-boot
UBOOT_OUT := $(PWD)/u-boot
UBOOT_BIN := $(UBOOT_OUT)/u-boot-dtb.img
UBOOT_CONF := $(OEM_BOOT_DIR)/uboot.conf

UDF := $(TOOLS_DIR)/ubuntu-device-flash

ifeq ($(TOOLCHAIN),VENDOR)
CC :=
else
# CC := arm-linux-gnueabihf-
CC := aarch64-linux-gnu-
CROSS_COMPILE := aarch64-linux-gnu-
export ARCH
export CROSS_COMPILE

endif
