BUILD_DIR ?= builds
DIST_DIR ?= dist
CACHE_DIR ?= packer_cache
NAME_PREFIX ?= i-doit-virtual-appliance-debian-9-amd64
DIST_FILES ?= CHANGELOG.md LICENSE README.md

all : build

build :
	mkdir -p $(BUILD_DIR:?)/
	test ! -d $(BUILD_DIR:?)/$(NAME_PREFIX)-virtualbox/
	test ! -d $(BUILD_DIR:?)/$(NAME_PREFIX)-vmware/
	packer build --only=virtualbox-iso packer/packer.json
	packer build --only=vmware-iso packer/packer.json

dist :
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	cd $(BUILD_DIR)/ && zip -r -9 -v $(NAME_PREFIX)-virtualbox.zip $(NAME_PREFIX)-virtualbox/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/*.zip $(DIST_DIR)/

clean :
	test -n $(BUILD_DIR)
	test -n $(DIST_DIR)
	test -n $(CACHE_DIR)
	test -d ./$(BUILD_DIR)/ && rm -r ./$(BUILD_DIR)/
	test -d ./$(DIST_DIR)/ && rm -r ./$(DIST_DIR)/
	test -d ./$(CACHE_DIR)/ && rm -r ./$(CACHE_DIR)/

shellcheck :
	shellcheck bin/appliance-about
	shellcheck bin/appliance-cleanup
	shellcheck bin/appliance-menu
	shellcheck bin/appliance-menu-configuration
	shellcheck bin/appliance-menu-idoit
	shellcheck bin/appliance-menu-network
	shellcheck bin/appliance-menu-proxy
	shellcheck bin/appliance-menu-tools
	shellcheck etc/network/if-up.d/create-issue-files
	shellcheck packer/prepare-os

test :
	git --version
	packer --version
	packer validate packer/packer.json
	vboxmanage --version
	vmware-installer -t
	shellcheck --version
