BUILD_DIR ?= builds
DIST_DIR ?= dist
CACHE_DIR ?= packer_cache
NAME_PREFIX ?= i-doit-virtual-appliance-debian-9-amd64
DIST_FILES ?= CHANGELOG.md LICENSE README.md

all : build

build :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build --only=virtualbox,vmware packer/packer.json

build-virtualbox :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	packer build --only=virtualbox packer/packer.json

build-vmware :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build --only=vmware packer/packer.json

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

prepare-host :
	sudo apt install git build-essential shellcheck ruby ruby-dev wget curl lsb-release zip unzip quemu-utils libdigest-sha-perl
	wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip
	wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_SHA256SUMS
	wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_SHA256SUMS.sig
	curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import
	gpg --verify packer_1.3.1_SHA256SUMS.sig packer_1.3.1_SHA256SUMS
	shasum -a 256 -c packer_1.3.1_SHA256SUMS
	unzip packer_1.3.1_linux_amd64.zip
	sudo mv packer /usr/local/bin/
	rm packer_1.3.1_linux_amd64.zip packer_1.3.1_SHA256SUMS packer_1.3.1_SHA256SUMS.sig
	echo "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -c -s) contrib" > /etc/apt/sources.list.d/virtualbox.list
	wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
	apt-get update
	apt-get install virtualbox-5.2
	sudo gem install inspec
	git clone https://github.com/bheisig/i-doit-appliance.git

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
	bash --version
	git --version
	packer --version
	packer validate packer/packer.json
	vboxmanage --version
	vmware-installer -t
	ovftool --version
	shellcheck --version
	inspec --version
