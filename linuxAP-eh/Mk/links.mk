#----------------------------------------------------------------------
# links.mk
#
# links.tgz and compiler_masq soft-link handling
#----------------------------------------------------------------------
SUBDIR_DISTCLEAN += links-distclean

links-config: links.tgz
	@echo -e "\nRestoring links from links.tgz"
	@tar zxvf links.tgz >> /tmp/links-config
	@mv /tmp/links-config .

compiler_masq:
	@echo -e "\nMasquerading compilers (ccache=$(CONFIG_CCACHE))"
	@rm -Rf $(COMPILER_MASQ_DIR)
ifeq ($(CONFIG_CCACHE),y)
	@if [ -z `which ccache` ]; then \
		echo -e "\nERROR!!! Could NOT find ccache binary in your PATH, please check if it's installed."; \
		.FAIL; \
	fi
	@./scripts/compiler_masq ccache $(COMPILER_MASQ_DIR) $(CROSS_COMPILE) `which ccache`
endif

links-distclean:
	@echo "Removing links from links.tgz"
	@rm -f `tar ztf links.tgz` links-config
	@echo -e "Removing masqueraded compilers"
	@rm -Rf $(TOPDIR)/compiler_masq

