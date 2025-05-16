# 🗃️ File Management Tools – Bash Script Collection

A collection of **Bash scripts** to automate common file management tasks. These tools help organize, rename, analyze, back up, encrypt, and synchronize files on Unix-like systems. Ideal for system administrators and power users.

---

## 📁 1. Automatic File Sorter

**Description:**  
Sorts files in a directory based on their file types. Files are moved into subfolders like `Documents`, `Images`, `Videos`, etc.

**How to Run:**

```bash
./fileSorter.sh
```

---

## 📝 2. Bulk File Renamer

**Description:**
Renames multiple files using a specified pattern. Supports prefixes, suffixes, date stamps, and counters.

**How to Run:**

```bash
./bulkFileRenamer.sh
```

---

## 🧭 3. Duplicate File Finder

**Description:**
Scans a directory for duplicate files based on size and content. Allows you to review, delete, or move duplicates.

**How to Run:**

```bash
./duplicateFileFinder.sh
```

---

## 💾 4. File Backup System

**Description:**
Creates a backup of specified files or folders. Supports compression and can be scheduled with `cron`.

**How to Run:**

```bash
./fileBuckup.sh
```

---

## 📊 5. Disk Space Analyzer

**Description:**
Displays disk usage in a tree structure and helps identify large files and directories.

**How to Run:**

```bash
./diskSpaceAnalyzer.sh
```

---

## 🔐 6. File Encryption Tool

**Description:**
Encrypts and decrypts files using a password with `gpg`.

**How to Run to Encrypt and Decrypt, follow the prompts:**

```bash
./fileEncryption.sh
```

---

## 🔄 7. File Sync Utility

**Description:**
Synchronizes two directories, keeping both updated. Supports two-way sync with basic conflict detection.

**How to Run:**

```bash
./fileSync.sh
```

---

## 🛠️ Getting Started

1. Clone this repository:

```bash
   git clone https://github.com/Delvin-Yamoah/File-Management-Projects.git
   cd File-Management-Projects
```

2. Make scripts executable:

   ```bash
   chmod +x *.sh
   ```

3. Run any script using:

   ```bash
   ./script_name.sh
   ```

---

## 📌 Requirements

- Unix/Linux-based OS
- Bash (v4+ recommended)
- Core Unix tools: `find`, `grep`, `awk`, `md5sum`, `rsync`, `du`, `tar`, `gpg`
  Install missing tools with:

```bash
sudo apt install coreutils rsync gpg
```

---

```

```
