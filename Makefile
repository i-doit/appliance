BUILD_DIR ?= builds
DIST_DIR ?= dist
CACHE_DIR ?= packer_cache
NAME_PREFIX ?= i-doit-virtual-appliance-debian-9-amd64
DIST_FILES ?= CHANGELOG.md LICENSE README.md

all : build

build :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build packer/packer.json

build-virtualbox :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	packer build --only=virtualbox-iso packer/packer.json

build-vmware :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build --only=vmware-iso packer/packer.json

dist : dist-virtualbox dist-vmware dist-hyper-v

dist-virtualbox :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	cd $(BUILD_DIR)/ && zip -r -9 -v $(NAME_PREFIX)-virtualbox.zip $(NAME_PREFIX)-virtualbox/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox.zip $(DIST_DIR)/

dist-vmware :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	cd $(BUILD_DIR)/ && zip -r -9 -v $(NAME_PREFIX)-vmware.zip $(NAME_PREFIX)-vmware/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-vmware.zip $(DIST_DIR)/

dist-hyper-v :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v/
	cd $(BUILD_DIR)/ && zip -r -9 -v $(NAME_PREFIX)-hyper-v.zip $(NAME_PREFIX)-hyper-v/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v.zip $(DIST_DIR)/

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
	shellcheck bin/appliance-update
	shellcheck etc/network/if-up.d/create-issue-files
	shellcheck packer/prepare-os

test :
	git --version
	packer --version
	packer validate packer/packer.json
	vboxmanage --version
	vmware-installer -t
	ovftool --version
	shellcheck --version
