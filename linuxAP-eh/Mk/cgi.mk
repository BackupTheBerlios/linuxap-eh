#----------------------------------------------------------------------
# cgi
#----------------------------------------------------------------------
# SUBDIR_CONFIG   += cgi-config
SUBDIR_BUILD    += cgi-build
SUBDIR_INSTALL	+= cgi-install
SUBDIR_CLEAN    += cgi-clean
SUBDIR_DISTCLEAN+= cgi-distclean

ifneq ($(BUSYBOX_VERSION),0.60.5)
CGI_ENVIRONMENT=y
endif

cgi-build:
	@echo -e "\nBuilding cgi."
	@$(MAKE) -C cgi CROSS_COMPILE=$(CROSS_COMPILE)   \
		CONFIG_CIPE=$(CONFIG_CIPE)               \
		CONFIG_OPENVPN=$(CONFIG_OPENVPN)         \
		CONFIG_KERNEL_AODV=$(CONFIG_KERNEL_AODV) \
		CGI_ENVIRONMENT=$(CGI_ENVIRONMENT)       \
		> /tmp/cgi-build 2>&1
	@mv /tmp/cgi-build .

cgi-install: cgi-build
	@echo -e "\nInstalling cgi."
	@$(MAKE) -C cgi CROSS_COMPILE=$(CROSS_COMPILE) install > /tmp/cgi-install 2>&1

cgi-clean:
	@echo -e "\nCleaning cgi directory."
	@$(MAKE) -C cgi CROSS_COMPILE=$(CROSS_COMPILE) clean
	rm -f cgi-build /tmp/cgi-install

cgi-distclean: cgi-clean

