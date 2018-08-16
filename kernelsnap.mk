include common.mk

KERNEL_SNAP_VERSION := `cat $(KERNEL_SRC)/prime/meta/snap.yaml | grep version: | awk '{print $$2}'`
KERNEL_SNAP := rock64-kernel_$(KERNEL_SNAP_VERSION)_arm64.snap

all: build

clean:
	rm -f rock64-kernel*.snap
	if [ -d $(KERNEL_SRC) ] ; then cd $(KERNEL_SRC); snapcraft clean; fi

distclean: clean
	rm -rf $(wildcard $(KERNEL_SRC))
	
build:
	if [ ! -d $(KERNEL_SRC) ] ; then git clone $(KERNEL_REPO) -b $(KERNEL_BRANCH) kernel; fi
	cp $(KERNEL_SRC)/../kernelsnap.yaml $(KERNEL_SRC)/snapcraft.yaml
	cd $(KERNEL_SRC); snapcraft --target-arch arm64 snap
	cp $(KERNEL_SRC)/$(KERNEL_SNAP) $(OUTPUT_DIR)
	
.PHONY: build
