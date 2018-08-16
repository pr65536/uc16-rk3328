include common.mk

all: build

clean:
	if test -d "$(UBOOT_SRC)" ; then $(MAKE) ARCH=arm CROSS_COMPILE=${CC} -C $(UBOOT_SRC) clean ; fi
	rm -f $(UBOOT_BIN)
	#rm -rf $(wildcard $(UBOOT_OUT))
	#rm -rf $(wildcard $(RKBIN_SRC))

distclean: clean
	#rm -rf $(wildcard $(UBOOT_SRC))
	#rm -rf $(wildcard $(RKBIN_SRC))

$(UBOOT_BIN): $(UBOOT_SRC)
	mkdir -p $(UBOOT_OUT)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=${CC} -C $(UBOOT_SRC) $(UBOOT_DEFCONFIG)
	$(MAKE) $(UBOOT_DEFCONFIG) -C $(UBOOT_SRC) -j$(CPUS) all
	cd $(UBOOT_OUT) && ${TOOLPATH}/loaderimage --pack --uboot ./u-boot-dtb.bin uboot.img 0x200000
	cd $(UBOOT_OUT) && ./tools/mkimage -n rk3328 -T rksd -d ../rkbin/rk33/rk3328_ddr_786MHz_v1.06.bin idbloader.img
	cd $(UBOOT_OUT) && cat ../rkbin/rk33/rk3328_miniloader_v2.43.bin >> idbloader.img
	cd $(UBOOT_OUT) && cp ../rkbin/rk33/rk3328_loader_ddr786_v1.06.243.bin ${UBOOT_OUT}
	${TOOLPATH}/trust_merger trust.ini
	mv trust.img ${UBOOT_OUT}/

$(UBOOT_SRC): $(RKBIN_SRC)
	git clone $(UBOOT_REPO) -b $(UBOOT_BRANCH) u-boot

$(RKBIN_SRC):
	git clone $(RKBIN_REPO) -b $(RKBIN_BRANCH) rkbin 

u-boot: $(UBOOT_BIN)

build: u-boot

.PHONY: u-boot build
