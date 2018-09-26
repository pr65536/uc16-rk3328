include common.mk

SNAPPY_VERSION := `date +%Y%m%d`-0
SNAPPY_IMAGE := uc16-rock64-${SNAPPY_VERSION}.img
# yes for latest version; no for the specific revision of edge/stable channel
SNAPPY_CORE_NEW := no
SNAPPY_CORE_VER ?=
SNAPPY_CORE_CH := stable #beta
GADGET_VERSION := `cat gadget/meta/snap.yaml | grep version: | awk '{print $$2}'`
GADGET_SNAP := rock64_$(GADGET_VERSION)_arm64.snap
KERNEL_SNAP_VERSION := `cat $(KERNEL_SRC)/prime/meta/snap.yaml | grep version: | awk '{print $$2}'`
KERNEL_SNAP := rock64-kernel_$(KERNEL_SNAP_VERSION)_arm64.snap
REVISION ?=
SNAPPY_WORKAROUND := no
SNAP_UBUNTU_IMAGE=/snap/bin/ubuntu-image

all: build

clean:
	rm -f $(OUTPUT_DIR)/*.img.xz
distclean: clean

build-snappy:
ifeq ($(SNAPPY_CORE_NEW),no)
		@echo "build core version..."
		$(eval REVISION = --revision $(SNAPPY_CORE_VER))
endif
	@echo "build snappy..."
	sudo $(SNAP_UBUNTU_IMAGE) \
		--channel $(SNAPPY_CORE_CH) \
		--image-size 4G \
		--extra-snaps snapweb \
		--extra-snaps bluez \
		--extra-snaps modem-manager \
		--extra-snaps network-manager \
		--extra-snaps $(GADGET_SNAP) \
		--extra-snaps $(KERNEL_SNAP) \
		-o $(SNAPPY_IMAGE) \
		rock64.model

#fix-bootflag:
#	sudo dd conv=notrunc if=boot_fix.bin of=$(SNAPPY_IMAGE) seek=440 oflag=seek_bytes

workaround:
ifeq ($(SNAPPY_WORKAROUND),yes)
	@echo "workaround something..."
endif

pack:
	sudo xz -0 $(SNAPPY_IMAGE)

build: build-snappy workaround
#build: build-snappy fix-bootflag workaround pack 

#.PHONY: build-snappy fix-bootflag workaround pack build
.PHONY: build-snappy workaround build
