#----------------------------------------------------------------------
# hostap / Prism 2/2.5/3 driver
#----------------------------------------------------------------------
SUBDIR_CONFIG   += hostap-config
SUBDIR_BUILD    += hostap-build
SUBDIR_INSTALL  += hostap-install
SUBDIR_CLEAN    += hostap-clean
SUBDIR_DISTCLEAN+= hostap-distclean
hostap-config:
	@echo -e "\nExtract and Configure hostap version $(HOSTAP_VERSION)."
	@scripts/util_config hostap $(HOSTAP_VERSION) $(ARCHIVE_DIR)\
		> /tmp/hostap-config
	@mv /tmp/hostap-config .

hostap-build: hostap-config
	@echo -e "\nBuild hostap version $(HOSTAP_VERSION)."
	@$(MAKE) -C hostap pccard \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		KERNEL_PATH=$(KERNEL_DIR) \
		EXTRA_CFLAGS="-DPRISM2_NO_DEBUG -DPRISM2_NO_PROCFS_DEBUG" \
		> /tmp/hostap-build 2>&1
	@mv /tmp/hostap-build .

hostap-install: hostap-build
	@echo -e "\nInstall hostap version $(HOSTAP_VERSION)."
	@$(MAKE) -C hostap \
		KERNEL_DIR=$(KERNEL_DIR) \
		IMAGE_DIR=$(IMAGE_DIR) \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		install_pccard \
		install_hostap \
		install_crypt \
		> /tmp/hostap-install 2>&1
	@cp -va hostap/utils/prism2_param $(IMAGE_DIR)/sbin > /dev/null 2>&1
	@$(STRIP) --strip-debug $(IMAGE_DIR)/lib/modules/$(KERNEL_VERSION)/net/hostap.o
	@$(STRIP) --strip-debug $(IMAGE_DIR)/lib/modules/$(KERNEL_VERSION)/net/hostap_crypt.o
	@$(STRIP) --strip-debug $(IMAGE_DIR)/lib/modules/$(KERNEL_VERSION)/net/hostap_crypt_wep.o
	@$(STRIP) --strip-debug $(IMAGE_DIR)/lib/modules/$(KERNEL_VERSION)/pcmcia/hostap_cs.o

hostap-clean:
	@rm -f hostap-config
	@rm -f hostap-build
	@-$(MAKE) -C hostap clean >/dev/null 2>&1

hostap-distclean:
	@echo -e "\nPurging hostap version $(HOSTAP_VERSION)"
	@rm -f hostap-config
	@rm -f hostap-build
	@rm -rf hostap-$(HOSTAP_VERSION) hostap
