SHELL := /bin/bash
BUILD_DIR ?= builds
DIST_DIR ?= dist
CACHE_DIR ?= packer_cache
INSPEC_CACHE_DIR ?= inspec_cache
NAME_PREFIX ?= i-doit-virtual-appliance-debian-10-amd64
DIST_FILES ?= CHANGELOG.md LICENSE README.md
PACKER_VERSION ?= 1.4.1

all : build

build :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build --only=virtualbox,vmware packer.json

build-virtualbox :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	packer build --only=virtualbox packer.json

build-vmware :
	test ! -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	packer build --only=vmware packer.json

dist : dist-virtualbox dist-vmware dist-hyper-v

dist-virtualbox :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox/
	cd $(BUILD_DIR)/ && \
		zip -r -9 -v \
		$(NAME_PREFIX)-virtualbox.zip \
		$(NAME_PREFIX)-virtualbox/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-virtualbox.zip $(DIST_DIR)/

dist-vmware :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-vmware/
	cd $(BUILD_DIR)/ && \
		zip -r -9 -v \
		$(NAME_PREFIX)-vmware.zip \
		$(NAME_PREFIX)-vmware/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-vmware.zip $(DIST_DIR)/

dist-hyper-v :
	test -d $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v/
	cp $(DIST_FILES) $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v/
	cd $(BUILD_DIR)/ && \
		zip -r -9 -v \
		$(NAME_PREFIX)-hyper-v.zip \
		$(NAME_PREFIX)-hyper-v/
	mkdir -p $(DIST_DIR)/
	mv $(BUILD_DIR)/$(NAME_PREFIX)-hyper-v.zip $(DIST_DIR)/

install : install-packages install-packer install-virtualbox install-vmware install-shellcheck install-inspec

install-packages :
	apt-get update
	apt-get install -y --no-install-recommends \
		apt-transport-https curl gnupg2 libdigest-sha-perl \
		lsb-release qemu-utils unzip wget zip

install-packer :
	wget https://releases.hashicorp.com/packer/$(PACKER_VERSION)/packer_$(PACKER_VERSION)_linux_amd64.zip
	wget https://releases.hashicorp.com/packer/$(PACKER_VERSION)/packer_$(PACKER_VERSION)_SHA256SUMS
	wget https://releases.hashicorp.com/packer/$(PACKER_VERSION)/packer_$(PACKER_VERSION)_SHA256SUMS.sig
	curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import
	gpg --verify \
		packer_$(PACKER_VERSION)_SHA256SUMS.sig \
		packer_$(PACKER_VERSION)_SHA256SUMS
	sha256sum --ignore-missing --strict --check \
		packer_$(PACKER_VERSION)_SHA256SUMS
	unzip packer_$(PACKER_VERSION)_linux_amd64.zip
	mv packer /usr/local/bin/
	rm \
		packer_$(PACKER_VERSION)_linux_amd64.zip \
		packer_$(PACKER_VERSION)_SHA256SUMS \
		packer_$(PACKER_VERSION)_SHA256SUMS.sig

install-virtualbox :
	echo "deb https://download.virtualbox.org/virtualbox/debian stretch contrib" > \
		/etc/apt/sources.list.d/virtualbox.list
	wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | \
		apt-key add -
	rm oracle_vbox_2016.asc
	apt-get update
	apt-get install -y --no-install-recommends \
		virtualbox-6.0

install-vmware :
	wget https://www.vmware.com/go/getworkstation-linux
	yes "" | sh getworkstation-linux --console --required --eulas-agreed
	rm getworkstation-linux

install-shellcheck :
	apt-get install -y --no-install-recommends \
		haskell-platform
	cabal update
	cabal install --global --force-reinstalls cabal-install
	cabal update
	cabal install --global ShellCheck

install-inspec :
	curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
	curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
	curl -sSL https://get.rvm.io | bash -s stable
	source /etc/profile.d/rvm.sh && rvm install ruby-head
	source /etc/profile.d/rvm.sh && rvm use 2.6
	source /etc/profile.d/rvm.sh && gem install inspec-bin

update :
	apt-get update
	apt-get upgrade -y
	apt-get autoremove -y
	apt-get clean -y
	cabal update
	cabal install --global cabal-install
	cabal install --global ShellCheck
	rvm get stable
	gem update

clean :
	test -n $(BUILD_DIR) && \
		test -d $(BUILD_DIR)/ && \
		rm -r $(BUILD_DIR)/
	test -n $(DIST_DIR) && \
		test -d $(DIST_DIR)/ && \
		rm -r $(DIST_DIR)/
	test -n $(CACHE_DIR) && \
		test -d $(CACHE_DIR)/ && \
		rm -r $(CACHE_DIR)/
	test -n $(INSPEC_CACHE_DIR) && \
		test -d $(INSPEC_CACHE_DIR)/ && \
		rm -r $(INSPEC_CACHE_DIR)/

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
	shellcheck deploy

test :
	bash --version
	packer --version
	packer validate packer.json
	qemu-img --version
	vboxmanage --version
	vmware-installer -t
	vmware-installer --list-products
	cabal --version
	shellcheck --version
	ruby --version
	rvm --version
	gem --version
	inspec --version
	sha256sum --version
	lsmod | grep -i -E "vmnet|vmmon"
	cat /proc/cpuinfo | grep -i -E "vmx|svm"

list-binaries :
	which bash
	which cabal
	which curl
	which gem
	which gpg
	which inspec
	which packer
	which ruby
	which rvm
	which sha256sum
	which shellcheck
	which unzip
	which vboxmanage
	which vmware-installer
	which wget
	which zip
