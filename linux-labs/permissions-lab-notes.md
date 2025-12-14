# Linux File Permissions Lab - Lab 2

**Date:** December 14, 2024  
**System:** Ubuntu 24 home lab

## Commands Mastered
- `chmod` (numeric: 755, 644, 770; symbolic: u+x, g-w, g+s)
- `chown user:group` (change ownership)
- `ls -l` and `ls -ld` (view permissions)
- Special permissions: sticky bit (1777), SGID (g+s)

---

## Key Scenarios Tested

### 1. Sticky Bit on Logs Directory
**Setup:** `/projects/webapp/logs` with permissions `1777` (drwxrwxrwt)

**Results:**
- ✅ Alice CANNOT delete Bob's files (Operation not permitted)
- ✅ Alice CAN delete her own files
- ✅ Directory owner (sudo) can delete any file

**Real-world use:** Prevents users from deleting each other's files in shared temp/log directories

---

### 2. Manager-Only Releases Directory
**Setup:** `/projects/webapp/releases` with permissions `755` (drwxr-xr-x)

**Results:**
- ✅ Bob (developer) can READ releases
- ✅ Bob CANNOT create new releases (Permission denied)
- ✅ Only Brady (managers group) can write

**Real-world use:** Production releases controlled by specific team

---

### 3. SGID on Source Directory
**Setup:** `/projects/webapp/src` with SGID bit set (drwxrws---)

**Test Results:**
- WITH SGID: Bob's file owned by `bob:developers` ✅
- WITHOUT SGID: Bob's file owned by `bob:bob` ❌

**Why it matters:** Files automatically inherit directory group, enabling seamless team collaboration without manual chown

---

## Permission Quick Reference

### Numeric Permissions
- 4 = read (r)
- 2 = write (w)
- 1 = execute (x)

**Common patterns:**
- `755` = rwxr-xr-x (scripts, directories)
- `644` = rw-r--r-- (regular files)
- `700` = rwx------ (private files)
- `770` = rwxrwx--- (team directories)
- `660` = rw-rw---- (team files, no public access)

### Special Permissions
- **Sticky bit (1xxx):** Users can only delete files they own
- **SGID (2xxx or g+s):** New files inherit directory's group
- **SUID (4xxx or u+s):** Execute with file owner's permissions

---

## Team Structure Used

| User | Groups | Role |
|------|--------|------|
| Brady | managers | Project owner/manager |
| Kerry | developers | Developer |
| Bob | developers | Developer |
| Alice | developers, qa_team | Developer & QA |
| Outsider | (none) | External user (test) |

---

## Real-World Takeaways

1. **Always use SGID on shared team directories** - saves manual chown work
2. **Sticky bit for collaborative temp/log spaces** - prevents accidental deletions
3. **Group-based access control** - easier than managing individual permissions
4. **Test with actual users** - "outsider" user proved permission restrictions work
5. **660/770 for team files** - no "others" access for sensitive projects

---

## Next Steps
- Practice these scenarios on real projects
- Document permission standards for future team projects
- Review /tmp directory to see sticky bit in production use: `ls -ld /tmp`
