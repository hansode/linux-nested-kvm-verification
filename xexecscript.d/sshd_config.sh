#!/bin/bash
#
# requires:
#  bash
#
set -e

while read param value; do
  config_sshd_config ${chroot_dir}/etc/ssh/sshd_config ${param} ${value}
done < <(cat <<-EOS | egrep -v '^#|^$'
	#
	# "Top 20 OpenSSH Server Best Security Practices"
	# * http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html
	#

	# 02: Only Use SSH Protocol 2
	Protocol 2

	# 03: Limit Users SSH Access
	DenyUsers root

	# 04: Configure Idle Log Out Timeout Interval
	ClientAliveInterval 0
	ClientAliveCountMax 3

	# 05: Disable .rhosts Files
	IgnoreRhosts yes

	# 06: Disable Host-Based Authentication
	HostbasedAuthentication no

	# 07: Disable root Login via SSH
	PermitRootLogin no

	# 09: Change SSH Port and Limit IP Binding
	Port 22

	# 11: Use Public Key Based Authentication
	#PasswordAuthentication no

	# 15: Disable Empty Passwords
	PermitEmptyPasswords no

	# Others
	StrictModes   yes
	X11Forwarding no
	UseDNS        no
	EOS
	)
