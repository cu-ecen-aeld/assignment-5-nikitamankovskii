LDD_VERSION = 5207149e2a1b3ecffb5b16055d76a06d69aa3ee2
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-nikitamankovskii.git
LDD_SITE_METHOD = git

LDD_MODULE_SUBDIRS = scull misc-modules

# define LDD_BUILD_CMDS
# 	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules modules
#     $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull modules
# endef
define LDD_BUILD_CMDS
	$(MAKE) KERNELDIR=$(LINUX_DIR) ARCH="$(KERNEL_ARCH)" CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/misc-modules modules
	$(MAKE) KERNELDIR=$(LINUX_DIR) ARCH="$(KERNEL_ARCH)" CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/scull modules
endef

# Install helper scripts for starting drivers and modules
	# $(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/sbin/
	# $(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/sbin/
	# $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/sbin/
	# $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/sbin/
define LDD_INSTALL_TARGET_CMDS


	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/ldd/misc-modules
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/ldd/scull
	$(INSTALL) -m 0644 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0644 $(@D)/scull/scull.ko $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/sbin/
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/sbin/

	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/init.d
	# $(INSTALL) -m 0755 $(@D)/S98lddmodules $(TARGET_DIR)/etc/init.d
endef

# define LDD_INSTALL_TARGET_CMDS
#     # Copy misc-modules and scull components to target filesystem
#     $(INSTALL) -D -m 0755 $(@D)/misc-modules/* $(TARGET_DIR)/lib/modules/
#     $(INSTALL) -D -m 0755 $(@D)/scull/* $(TARGET_DIR)/usr/bin/
# endef

$(eval $(generic-package))