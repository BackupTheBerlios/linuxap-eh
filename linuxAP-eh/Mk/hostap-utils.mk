#----------------------------------------------------------------------
# hostap-utils / Prism 2/2.5/3 driver
#----------------------------------------------------------------------
SUBDIR_CONFIG   += hostap-utils-config
#SUBDIR_BUILD    += hostap-utils-build
SUBDIR_INSTALL  += hostap-utils-install
SUBDIR_CLEAN    += hostap-utils-clean
SUBDIR_DISTCLEAN+= hostap-utils-distclean
hostap-utils-config:
	@echo -e "\nExtract and Configure hostap-utils version $(HOSTAP_UTILS_VERSION)."
	@scripts/util_config hostap-utils $(HOSTAP_UTILS_VERSION) $(ARCHIVE_DIR)\
		> /tmp/hostap-utils-config
	@mv /tmp/hostap-utils-config .

hostap-utils-build: hostap-utils-config
	@echo -e "\nBuild hostap-utils version $(HOSTAP_UTILS_VERSION)."

hostap-utils-install: hostap-utils-build
	@echo -e "\nInstall hostap-utils version $(HOSTAP_UTILS_VERSION)."
	@cp hostap-utils/prism2_param $(IMAGE_DIR)/sbin

        
hostap-utils-clean:
	@echo -e "\nCleaning hostap-utils version $(HOSTAP_UTILS_VERSION)."
	@rm -f hostap-utils-config
	@rm -f hostap-utils-build
	@-$(MAKE) -C hostap-utils clean > /dev/null 2>&1

hostap-utils-distclean:
	@echo -e "\nPurging hostap-utils version $(HOSTAP_UTILS_VERSION)"
	@rm -f hostap-utils-config
	@rm -f hostap-utils-build
	@rm -rf hostap-utils-$(HOSTAP_UTILS_VERSION) hostap-utils
