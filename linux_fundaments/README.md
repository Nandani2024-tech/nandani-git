# Linux Homework Tasks

## Task 1: Soft Link vs. Hard Link

**Difference:**
- **Soft Link (Symbolic Link):** A soft link is essentially a shortcut to the original file. It points to the file's path. If the original file is deleted, the soft link becomes broken (a "dangling link"). Soft links can point to files on different file systems and can link to directories.
- **Hard Link:** A hard link acts as an additional name for an existing file, pointing directly to the file's inode (the physical data on the disk). It cannot link across different file systems and generally cannot link to directories. If the original file is deleted, the hard link still retains the data as long as at least one hard link to the inode exists.

**Commands to Create:**
- **Soft Link:** `ln -s <target_file> <link_name>`
- **Hard Link:** `ln <target_file> <link_name>`

**Interview Prep Summary:** 
A hard link is an identical copy of the file pointing to the same inode. Deleting the original doesn't affect the hard link. A soft link is a pointer to the file path; deleting the original breaks the link.

---

## Task 2: `adduser` vs `useradd`

**Difference:**
- `useradd`: This is a low-level, native binary utility provided by the system. It creates the user but might not set up the home directory or prompt for a password or other details by default unless specific flags are passed.
- `adduser`: This is a high-level, interactive Perl script (especially on Debian/Ubuntu) acting as a front-end to `useradd`. It automatically creates the home directory, prompts for a password, and copies default skeleton files (from `/etc/skel`).

**Which is preferred on Ubuntu/Linux and why?**
`adduser` is preferred on Ubuntu/Debian because it is interactive and user-friendly. It handles all the standard user setup tasks automatically (home directory, password setup, user information), reducing the chance of human error compared to the more manual `useradd` command.

**Action: Create a Test User**
The recommended command to create a test user is:
```bash
sudo adduser testuser
```

---

## Task 3: `journalctl`

**What is it used for?**
`journalctl` is a command-line utility used to query and read the logs collected by `systemd` (specifically the `systemd-journald` service). It centralizes logs for the system, kernel, and various services/applications.

**How to view logs:**
- View all system logs: `journalctl`
- View logs continuously (like `tail -f`): `journalctl -f`
- View logs from the current boot: `journalctl -b`

**Practice checking logs for a specific service:**
To check logs for a specific service, use the `-u` (unit) flag:
```bash
journalctl -u sshd.service
# or for nginx
journalctl -u nginx.service
```

---

## Task 4: Linux Command Cheat Sheet

Here is a quick review of some of the most important Linux commands and their basic usage:

* **Navigation & Directories:**
  * `pwd`: Print Working Directory (shows where you are).
  * `ls`: List directory contents (`ls -la` for hidden files and detailed info).
  * `cd`: Change directory.
  * `mkdir`: Make a new directory.

* **File Operations:**
  * `touch`: Create a new empty file or update timestamps.
  * `cp`: Copy files or directories (`cp -r` for recursive).
  * `mv`: Move or rename files/directories.
  * `rm`: Remove files (`rm -r` for directories, `rm -f` to force).

* **Viewing & Editing Files:**
  * `cat`: Concatenate and print file contents.
  * `less` / `more`: View file contents page by page.
  * `nano` / `vim`: Command-line text editors.
  * `head` / `tail`: View the beginning / end of a file.

* **System & Processes:**
  * `top` / `htop`: View real-time system processes and resource usage.
  * `ps`: Report a snapshot of current processes.
  * `kill`: Terminate a process by its PID.
  * `df -h`: View disk space usage in human-readable format.

* **Permissions:**
  * `chmod`: Change file access permissions.
  * `chown`: Change file owner and group.

* **Searching & Filtering:**
  * `grep`: Search text for patterns (`grep "error" file.txt`).
  * `find`: Search for files in a directory hierarchy (`find . -name "*.txt"`).
