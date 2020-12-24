## Week 5 Homework Submission File: Archiving and Logging Data

Please edit this file by adding the solution commands on the line below the prompt.

Save and submit the completed file for your homework submission.

---

### Step 1: Create, Extract, Compress, and Manage tar Backup Archives

1. Command to **extract** the `TarDocs.tar` archive to the current directory:
	cd ~
	mkdir Projects
	cd Projects 
	tar -xvf TarDocs.tar

2. Command to **create** the `Javaless_Doc.tar` archive from the `TarDocs/` directory, while excluding the `TarDocs/Documents/Java` directory:
	tar -zcvf ~/Projects/Javaless_Docs.tar --exclude='/home/sysadmin/Projects/TarDocs/Documents/Java' ~/Projects/TarDocs

3. Command to ensure `Java/` is not in the new `Javaless_Docs.tar` archive:
	tar -tvf Javaless_Docs.tar | grep Java

**Bonus** 
- Command to create an incremental archive called `logs_backup_tar.gz` with only changed files to `snapshot.file` for the `/var/log` directory:
	 sudo tar --create --file=logs_backup_tar.gz --listed-incremental=/home/snapshot.file /var/log


#### Critical Analysis Question

- Why wouldn't you use the options `-x` and `-c` at the same with `tar`?
-x option means "extract an archive" and -c means "create an archive", we cannot extract and create an archive file because they are contradicting options, thus they can't be used simultaneously.

---

### Step 2: Create, Manage, and Automate Cron Jobs

1. Cron job for backing up the `/var/log/auth.log` file:
0 6 * * 3 tar -cvf /auth_backup_$(date +"%Y%m%d").tgz /var/log/auth.log 

---

### Step 3: Write Basic Bash Scripts

1. Brace expansion command to create the four subdirectories:
	mkdir -p  ~/backups/{freemem,diskuse,openlist,freedisk}

2. Paste your `system.sh` script edits below:

    ```bash
    #!/bin/bash

	# Free memory output to a free_mem.txt file
	free -h > ~/backups/freemem/free_mem.txt

	# Disk usage output to a disk_usage.txt file
	du -h > ~/backups/diskuse/disk_usage.txt

	# List open files to a open_list.txt file
	lsof > ~/backups/openlist/open_list.txt

	# Free disk space to a free_disk.txt file
	df -h > ~/backups/freedisk/free_disk.txt
    ```

3. Command to make the `system.sh` script executable:
	 chmod +x ~/system.sh

**Optional**
- Commands to test the script and confirm its execution:
	sudo ./system.sh
	ls -ltr ~/backups/*
	cat ~/backups/freemem/free_mem.txt
	cat ~/backups/diskuse/disk_usage.txt
	cat ~/backups/openlist/open_list.txt
	cat ~/backups/freedisk/free_disk.txt

**Bonus**
- Command to copy `system` to system-wide cron directory:
	sudo cp ~/system.sh /etc/cron.weekly/
---

### Step 4. Manage Log File Sizes
 
1. Run `sudo nano /etc/logrotate.conf` to edit the `logrotate` configuration file. 

    Configure a log rotation scheme that backs up authentication messages to the `/var/log/auth.log`.

    - Add your config file edits below:

    ```bash
    /var/log/auth.log {
           rotate 7
           weekly
 	   notifempty
           compress
           delaycompress
	   missingok 
       }
    ```
---

### Bonus: Check for Policy and File Violations

1. Command to verify `auditd` is active:
	systemctl status auditd

2. Command to set number of retained logs and maximum log file size:

    - Add the edits made to the configuration file below:

    ```bash
    	max_log_file = 35
	num_logs = 7

    ```

3. Command using `auditd` to set rules for `/etc/shadow`, `/etc/passwd` and `/var/log/auth.log`:


    - Add the edits made to the `rules` file below:

    ```bash
    	-w /etc/shadow -p wra -k hashpass_audit
    	-w /etc/passwd -p wra -k userpass_audit
	-w /var/log/auth.log -p wra -k authlog_audit
    ```

4. Command to restart `auditd`: 
	systemctl restart auditd

5. Command to list all `auditd` rules:
	sudo auditctl -l

6. Command to produce an audit report:
	aureport -au

7. Create a user with `sudo useradd attacker` and produce an audit report that lists account modifications:
	sudo useradd attacker 
	sysadmin@UbuntuDesktop:/etc/logrotate.d$ sudo aureport -k | grep useradd
	4452. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5126
	4454. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5128
	4456. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5131
	4457. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5132
	4458. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5133
	4465. 10/13/2020 16:58:19 userpass_audit yes /usr/sbin/useradd 1000 5141


8. Command to use `auditd` to watch `/var/log/cron`:
	sudo auditctl -w /var/log/cron -p wra -k cron_audit

9. Command to verify `auditd` rules:
	sysadmin@UbuntuDesktop:/etc/logrotate.d$ sudo auditctl -l
	-w /etc/passwd -p wa -k passwd
	-w /etc/shadow -p wa -k shadow
	-w /usr -p wa -k usr
	-w /etc/shadow -p rwa -k hashpass_audit
	-w /etc/passwd -p rwa -k userpass_audit
	-w /var/log/auth.log -p rwa -k authlog_audit
	-w /var/log/cron -p rwa -k cron_audit

---

### Bonus (Research Activity): Perform Various Log Filtering Techniques

1. Command to return `journalctl` messages with priorities from emergency to error:
	journalctl -b  -p "emerg".."err"

1. Command to check the disk usage of the system journal unit since the most recent boot:
	journalctl -b -u systemd-journald
	sysadmin@UbuntuDesktop:/etc/logrotate.d$ journalctl -b -u systemd-journald
	-- Logs begin at Sat 2020-09-19 13:22:05 EDT, end at Tue 2020-10-13 17:27:01 EDT. --
	Oct 13 16:30:23 UbuntuDesktop systemd-journald[284]: Journal started
	Oct 13 16:30:23 UbuntuDesktop systemd-journald[284]: Runtime journal (/run/log/journal/e5853fe375964d39b27025eb6608e969) is 4.9M, max 39.4M, 34.4M free.
	Oct 13 16:30:23 UbuntuDesktop systemd-journald[284]: Time spent on flushing to /var is 1.759ms for 459 entries.
	Oct 13 16:30:23 UbuntuDesktop systemd-journald[284]: System journal (/var/log/journal/e5853fe375964d39b27025eb6608e969) is 896.1M, max 3.9G, 3.0G free.


1. Comand to remove all archived journal files except the most recent two:
	sudo journalctl --vacuum-files=2

1. Command to filter all log messages with priority levels between zero and two, and save output to `/home/sysadmin/Priority_High.txt`:
	journalctl -p 0..2 >> /home/sysadmin/Priority_High.txt

1. Command to automate the last command in a daily cronjob. Add the edits made to the crontab file below:

    ```bash
    0 0 * * * journalctl -p 0..2 > /home/sysadmin/Priority_High.txt
    ```

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
