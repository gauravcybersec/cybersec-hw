## Week 4 Homework Submission File: Linux Systems Administration

### Step 1: Ensure/Double Check Permissions on Sensitive Files

1. Permissions on `/etc/shadow` should allow only `root` read and write access.

    - Command to inspect permissions: ls -l /etc/shadow

    - Command to set permissions (if needed): sudo chmod 600 /etc/shadow

2. Permissions on `/etc/gshadow` should allow only `root` read and write access.

    - Command to inspect permissions:  ls -l /etc/gshadow

    - Command to set permissions (if needed): sudo chmod 600 /etc/gshadow

3. Permissions on `/etc/group` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions: ls -l /etc/group

    - Command to set permissions (if needed): sudo chmod 644 /etc/group

4. Permissions on `/etc/passwd` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions: ls -l /etc/passwd

    - Command to set permissions (if needed): sudo chmod 644 /etc/passwd

### Step 2: Create User Accounts

1. Add user accounts for `sam`, `joe`, `amy`, `sara`, and `admin`.

    - Command to add each user account (include all five users): 
	sudo adduser sam
	sudo adduser joe
	sudo adduser amy
	sudo adduser sara
	sudo adduser admin

2. Force users to create 16-character passwords incorporating numbers and symbols.

    - Command to edit `pwquality.conf` file: sudo vi /etc/security/pwquality.conf

    - Updates to configuration file: 
	minlen = 16
	dcredit = -1
	ocredit = -1
	minclass = 2

3. Force passwords to expire every 90 days.

    - Command to to set each new user's password to expire in 90 days (include all five users): 
	sudo chage -M 90 sam
	sudo chage -M 90 joe
	sudo chage -M 90 amy
	sudo chage -M 90 sara
	sudo chage -M 90 admin
	
	- To verify use : sudo chage -l joe

4. Ensure that only the `admin` has general sudo access.

    - Command to add `admin` to the `sudo` group: sudo usermod -aG sudo admin

### Step 3: Create User Group and Collaborative Folder

1. Add an `engineers` group to the system.

    - Command to add group: sudo addgroup engineers

2. Add users `sam`, `joe`, `amy`, and `sara` to the managed group.

    - Command to add users to `engineers` group (include all four users):
	sudo usermod -aG engineers sam
	sudo usermod -aG engineers joe
	sudo usermod -aG engineers amy
	sudo usermod -aG engineers sara

3. Create a shared folder for this group at `/home/engineers`.

    - Command to create the shared folder: sudo mkdir -p /home/engineers
 
4. Change ownership on the new engineers' shared folder to the `engineers` group.

    - Command to change ownership of engineer's shared folder to engineer group:
	sudo chown root:engineers /home/engineers/ 
	OR
	sudo chgrp engineers /home/engineers/

### Step 4: Lynis Auditing

1. Command to install Lynis: sudo apt-get install lynis -y

2. Command to see documentation and instructions:  man lynis
	sudo lynis show commands

3. Command to run an audit: sudo lynis audit system

4. Provide a report from the Lynis output on what can be done to harden the system.

    - Screenshot of report output:

Output:
sysadmin@UbuntuDesktop:/home$ sudo less /var/log/lynis-report.dat | grep "suggestion"
suggestion[]=CUST-0280|Install libpam-tmpdir to set $TMP and $TMPDIR for PAM sessions|-|-|
suggestion[]=CUST-0285|Install libpam-usb to enable multi-factor authentication for PAM sessions|-|-|
suggestion[]=CUST-0810|Install apt-listbugs to display a list of critical bugs prior to each APT installation.|-|-|
suggestion[]=CUST-0811|Install apt-listchanges to display any significant changes prior to any upgrade via APT.|-|-|
suggestion[]=CUST-0830|Install debian-goodies so that you can run checkrestart after upgrades to determine which services are using old versions of libraries and need restarting.|-|-|
suggestion[]=CUST-0831|Install needrestart, alternatively to debian-goodies, so that you can run needrestart after upgrades to determine which daemons are using old versions of libraries and need restarting.|-|-|
suggestion[]=CUST-0870|Install debsecan to generate lists of vulnerabilities which affect this installation.|-|-|
suggestion[]=CUST-0875|Install debsums for the verification of installed package files against MD5 checksums.|-|-|
suggestion[]=DEB-0880|Install fail2ban to automatically ban hosts that commit multiple authentication errors.|-|-|
suggestion[]=BOOT-5122|Set a password on GRUB bootloader to prevent altering boot configuration (e.g. boot in single user mode without password)|-|-|
suggestion[]=AUTH-9228|Run pwck manually and correct any errors in the password file|-|-|
suggestion[]=AUTH-9262|Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc|-|-|
suggestion[]=AUTH-9286|Configure minimum password age in /etc/login.defs|-|-|
suggestion[]=AUTH-9286|Configure maximum password age in /etc/login.defs|-|-|
suggestion[]=AUTH-9308|Set password for single user mode to minimize physical access attack surface|-|-|
suggestion[]=AUTH-9328|Default umask in /etc/login.defs could be more strict like 027|-|-|
suggestion[]=FILE-6310|To decrease the impact of a full /home file system, place /home on a separated partition|-|-|
suggestion[]=FILE-6310|To decrease the impact of a full /tmp file system, place /tmp on a separated partition|-|-|
suggestion[]=FILE-6310|To decrease the impact of a full /var file system, place /var on a separated partition|-|-|
suggestion[]=STRG-1840|Disable drivers like USB storage when not used, to prevent unauthorized storage or data theft|-|-|
suggestion[]=NAME-4028|Check DNS configuration for the dns domain name|-|-|
suggestion[]=PKGS-7308|Check RPM database as RPM binary available but does not reveal any packages|-|-|
suggestion[]=PKGS-7346|Purge old/removed packages (7 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts.|-|-|
suggestion[]=PKGS-7370|Install debsums utility for the verification of packages with known good database.|-|-|
suggestion[]=PKGS-7392|Update your system with apt-get update, apt-get upgrade, apt-get dist-upgrade and/or unattended-upgrades|-|-|
suggestion[]=PKGS-7394|Install package apt-show-versions for patch management purposes|-|-|
suggestion[]=NETW-2705|Check your resolv.conf file and fill in a backup nameserver if possible|-|-|
suggestion[]=NETW-3032|Consider running ARP monitoring software (arpwatch,arpon)|-|-|
suggestion[]=PRNT-2307|Access to CUPS configuration could be more strict.|-|-|
suggestion[]=MAIL-8818|You are advised to hide the mail_name (option: smtpd_banner) from your postfix configuration. Use postconf -e or change your main.cf file (/etc/postfix/main.cf)|-|-|
suggestion[]=MAIL-8820:disable_vrfy_command|Disable the 'VRFY' command|disable_vrfy_command=no|text:run postconf -e disable_vrfy_command=yes to change the value|
suggestion[]=FIRE-4513|Check iptables rules to see which rules are currently not used|-|-|
suggestion[]=HTTP-6640|Install Apache mod_evasive to guard webserver against DoS/brute force attempts|-|-|
suggestion[]=HTTP-6643|Install Apache modsecurity to guard webserver against web application attacks|-|-|
suggestion[]=HTTP-6710|Add HTTPS to nginx virtual hosts for enhanced protection of sensitive data and privacy|-|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|AllowTcpForwarding (YES --> NO)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|ClientAliveCountMax (3 --> 2)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|Compression (YES --> (DELAYED|NO))|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|LogLevel (INFO --> VERBOSE)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|MaxAuthTries (6 --> 2)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|MaxSessions (10 --> 2)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|PermitRootLogin (WITHOUT-PASSWORD --> NO)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|Port (22 --> )|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|TCPKeepAlive (YES --> NO)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|X11Forwarding (YES --> NO)|-|
suggestion[]=SSH-7408|Consider hardening SSH configuration|AllowAgentForwarding (YES --> NO)|-|
suggestion[]=LOGG-2190|Check what deleted files are still in use and why.|-|-|
suggestion[]=BANN-7126|Add a legal banner to /etc/issue, to warn unauthorized users|-|-|
suggestion[]=BANN-7130|Add legal banner to /etc/issue.net, to warn unauthorized users|-|-|
suggestion[]=ACCT-9622|Enable process accounting|-|-|
suggestion[]=ACCT-9626|Enable sysstat to collect accounting (no results)|-|-|
suggestion[]=ACCT-9628|Enable auditd to collect audit information|-|-|
suggestion[]=CONT-8104|Run 'docker info' to see warnings applicable to Docker daemon|-|-|
suggestion[]=KRNL-6000|One or more sysctl values differ from the scan profile and could be tweaked||Change sysctl value or disable test (skip-test=KRNL-6000:<sysctl-key>)|
suggestion[]=HRDN-7222|Harden compilers like restricting access to root user only|-|-|
sysadmin@UbuntuDesktop:/home$ 


### Bonus
1. Command to install chkrootkit: 
	sudo apt-get update
	sudo apt install chkrootkit
	

2. Command to see documentation and instructions:
	man chkrootkit

3. Command to run expert mode: 
	sudo chkrootkit -x

4. Provide a report from the chrootkit output on what can be done to harden the system.
    	sudo chkrootkit -q > /tmp/output.log
	sysadmin@UbuntuDesktop:/home$ cat /tmp/output.log | grep -i "infected"
	INFECTED: Possible Malicious Linux.Xor.DDoS installed


	
	
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
