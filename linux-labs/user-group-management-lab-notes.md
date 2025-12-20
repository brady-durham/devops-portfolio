# Linux User and Group Management Lab - Lab 1

**Date:** December 14, 2024  
**System:** Ubuntu 24 home lab

## Commands Mastered
- `useradd` - create new users
- `usermod` - modify existing users
- `userdel` - delete users
- `groupadd` - create new groups
- `groupmod` - modify groups
- `gpasswd` - manage group membership
- `id` - view user and group information
- `passwd` - set user passwords
- `su` - switch user context

---

## Key Concepts

### User Management
**Users** are individual accounts on the system with unique UIDs (User IDs). Each user has:
- Username
- UID (unique identifier)
- Primary group
- Home directory
- Shell (command interpreter)

### Group Management
**Groups** organize users for permission management. Each group has:
- Group name
- GID (Group ID)
- Member list

**Primary vs Secondary Groups:**
- **Primary group:** Default group for files created by user
- **Secondary groups:** Additional groups for access control

---

## Real-World Scenario Practiced

### Company Structure Simulation

Created a team structure similar to a software development company:

**Teams Created:**
1. **Developers** - Software development team
2. **QA** - Quality assurance team
3. **Management** - Leadership team

**Users Created:**
- alice (Developer)
- bob (Developer)
- charlie (QA Engineer)
- diana (QA Engineer)
- eve (Manager)

---

## Lab Exercises Completed

### Exercise 1: Create Groups
```bash
# Create development team group
sudo groupadd developers

# Create QA team group
sudo groupadd qa

# Create management group
sudo groupadd management
```

**Verify groups created:**
```bash
getent group developers
getent group qa
getent group management
```

---

### Exercise 2: Create Users with Primary Groups
```bash
# Create developer users
sudo useradd -m -g developers -s /bin/bash alice
sudo useradd -m -g developers -s /bin/bash bob

# Create QA users
sudo useradd -m -g qa -s /bin/bash charlie
sudo useradd -m -g qa -s /bin/bash diana

# Create manager
sudo useradd -m -g management -s /bin/bash eve
```

**Flags explained:**
- `-m` = Create home directory
- `-g GROUP` = Set primary group
- `-s /bin/bash` = Set login shell

**Verify users:**
```bash
id alice
id bob
id charlie
```

---

### Exercise 3: Set User Passwords
```bash
sudo passwd alice
sudo passwd bob
sudo passwd charlie
sudo passwd diana
sudo passwd eve
```

**Best practice:** Use strong passwords in production environments

---

### Exercise 4: Add Secondary Groups
```bash
# Add alice to management (cross-functional role)
sudo usermod -aG management alice

# Add eve to developers and qa (manager oversight)
sudo usermod -aG developers eve
sudo usermod -aG qa eve
```

**Verify group membership:**
```bash
groups alice
groups eve
```

**Result:**
- alice: developers (primary), management (secondary)
- eve: management (primary), developers, qa (secondary)

---

### Exercise 5: Test User Switching
```bash
# Switch to alice
su - alice

# Verify identity
whoami
id

# Check what groups alice belongs to
groups

# Exit back to original user
exit
```

---

### Exercise 6: Modify User Properties
```bash
# Change alice's shell
sudo usermod -s /bin/zsh alice

# Verify change
getent passwd alice

# Change back to bash
sudo usermod -s /bin/bash alice
```

---

### Exercise 7: View User Information
```bash
# View alice's user details
id alice

# View all group memberships
groups alice

# View user database entry
getent passwd alice

# View group database entry
getent group developers
```

**Sample output interpretation:**
```
id alice
uid=1001(alice) gid=1001(developers) groups=1001(developers),1003(management)
```
- UID: 1001
- Primary GID: 1001 (developers)
- Secondary groups: management

---

### Exercise 8: Remove Users (Cleanup)
```bash
# Remove user but keep home directory
sudo userdel charlie

# Remove user and home directory
sudo userdel -r diana

# Verify removal
id diana  # Should show "no such user"
```

---

## User and Group Files

### Important System Files
- `/etc/passwd` - User account information
- `/etc/shadow` - Encrypted passwords (sudo access required)
- `/etc/group` - Group information
- `/etc/gshadow` - Secure group information

**View user database:**
```bash
cat /etc/passwd | grep alice
```

**View group database:**
```bash
cat /etc/group | grep developers
```

---

## Commands Reference

### User Management
| Command | Purpose | Example |
|---------|---------|---------|
| `useradd -m -g GROUP USER` | Create user with home dir and primary group | `sudo useradd -m -g developers alice` |
| `usermod -aG GROUP USER` | Add user to secondary group | `sudo usermod -aG management alice` |
| `userdel USER` | Delete user (keep home) | `sudo userdel bob` |
| `userdel -r USER` | Delete user and home | `sudo userdel -r bob` |
| `passwd USER` | Set user password | `sudo passwd alice` |

### Group Management
| Command | Purpose | Example |
|---------|---------|---------|
| `groupadd GROUP` | Create new group | `sudo groupadd developers` |
| `groupdel GROUP` | Delete group | `sudo groupdel oldgroup` |
| `gpasswd -a USER GROUP` | Add user to group | `sudo gpasswd -a alice management` |
| `gpasswd -d USER GROUP` | Remove user from group | `sudo gpasswd -d alice management` |

### Information Commands
| Command | Purpose | Example |
|---------|---------|---------|
| `id USER` | Show user ID and groups | `id alice` |
| `groups USER` | Show user's groups | `groups alice` |
| `whoami` | Show current user | `whoami` |
| `getent passwd USER` | Show user database entry | `getent passwd alice` |
| `getent group GROUP` | Show group database entry | `getent group developers` |

---

## Key Learnings

1. **Primary groups** determine default ownership of created files
2. **Secondary groups** provide additional access without changing primary group
3. **useradd -m** is essential - creates home directory for user
4. **usermod -aG** APPENDS to groups (without -a, it REPLACES all groups)
5. **Groups enable team-based permissions** - better than individual user permissions
6. **su - USER** provides full user environment (- flag important)

---

## Real-World Applications

1. **Onboarding new employees:** Create user accounts with appropriate team groups
2. **Cross-functional teams:** Use secondary groups for collaboration
3. **Access control:** Groups manage who can access shared resources
4. **Security:** Principle of least privilege - users only in groups they need
5. **Azure AD/LDAP:** Same concepts apply in enterprise directory services

---

## Team Structure Created
```
Company Organization:
├── developers (alice, bob, eve)
│   ├── alice (also in management)
│   └── bob
├── qa (charlie, diana, eve)
│   ├── charlie
│   └── diana
└── management (alice, eve)
    ├── alice (also in developers)
    └── eve (also in developers, qa)
```

---

## Next Steps
- Lab 2: Apply file permissions to team directories
- Lab 3: Manage processes running under different users
- Practice in Azure: Create users in Azure AD
- Explore PAM (Pluggable Authentication Modules)
