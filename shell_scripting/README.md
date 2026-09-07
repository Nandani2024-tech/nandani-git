# Shell Scripting Homework Task

This folder contains a shell script `sys_info.sh` that gathers system information and demonstrates basic shell commands as required by the assignment.

## Task Requirements Met
- [x] Prints the current date (`date`).
- [x] Prints the hostname (`hostname`).
- [x] Prints the username (`whoami`).
- [x] Prints the disk usage (`df`).
- [x] Prints the running processes (`ps`).
- [x] Uses variables to store and use data.
- [x] Takes user input using `read -p`.
- [x] Creates a directory using `mkdir`.
- [x] Creates a file using `touch`.
- [x] Stores the running processes information in the file using `>` output redirection.

## How to Run

1. Open your terminal in a Linux environment.
2. Navigate to this directory.
3. Make the script executable:
   ```bash
   chmod +x sys_info.sh
   ```
4. Run the script:
   ```bash
   ./sys_info.sh
   ```

## Expected Commands Output

Here is a sample of what the commands will output when you run the script:

```text
===================================
     System Information Script     
===================================
Current Date : Mon Sep 07 16:55:20 IST 2026
Hostname     : ubuntu-server
Username     : student
===================================

--- Disk Usage ---
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        50G   20G   28G  42% /
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           774M  1.2M  773M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock

Enter a name for the new directory: my_processes
Enter a name for the output file: ps_output.txt

Creating directory: my_processes...
Creating file: my_processes/ps_output.txt...
Fetching running processes and storing them in my_processes/ps_output.txt...
Script completed successfully! Check the contents of my_processes/ps_output.txt to see the running processes.
```

After the script finishes, you can verify the processes file was created and contains the output by running:
```bash
cat my_processes/ps_output.txt
```
