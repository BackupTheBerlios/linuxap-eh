#----------------------------------------------------------------------
# links.mk
#
# links.tgz soft-link handling
#----------------------------------------------------------------------
SUBDIR_DISTCLEAN += links-distclean

links-config: links.tgz
	@echo -e "\nRestoring links from links.tgz"
	@tar zxvf links.tgz >> /tmp/links-config
	@mv /tmp/links-config .

links-distclean:
	@echo "Removing links from links.tgz"
	@rm -f `tar ztf links.tgz`

