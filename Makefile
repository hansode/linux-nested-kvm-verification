SHELL=/bin/bash

all:
	git submodule update --init --recursive
update:
	git submodule foreach git pull origin master

box: test

test: common

common:
	time sudo ./vmbuilder/kvm/rhel/6/vmbuilder.sh \
	--config-path ./vmbuilder.conf

i686:
	time sudo setarch $@ ./vmbuilder/kvm/rhel/6/vmbuilder.sh \
	--config-path ./vmbuilder.conf

x86_64:
	time sudo setarch $@ ./vmbuilder/kvm/rhel/6/vmbuilder.sh \
	--config-path ./vmbuilder.conf

runvm:
	sudo ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh start --image-path box-disk1.raw --cpu-num 4 --mem-size 16384 --cpu-type qemu64,+vmx \
	--config-path ./vmbuilder.conf
