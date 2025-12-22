#!/bin/bash

# User Activity Reporter
# Author: Brady Durham
# Date: December 23, 2024
# Purpose: Generate report on user accounts and their activity

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

clear
echo "=========================================="
echo "  User Activity Report"
echo "  Generated: $(date)"
echo "=========================================="

# 1. Currently Logged In Users
print_header "CURRENTLY LOGGED IN USERS"
who | awk '{printf "%-15s %-12s %s %s\n", $1, $2, $3, $4}'
echo ""
echo "Total active sessions: $(who | wc -l)"

# 2. All User Accounts
print_header "SYSTEM USER ACCOUNTS"
echo "Regular users (UID >= 1000):"
awk -F: '$3 >= 1000 && $3 < 65534 {printf "  %-15s UID: %-6s Shell: %s\n", $1, $3, $7}' /etc/passwd | sort
echo ""
regular_users=$(awk -F: '$3 >= 1000 && $3 < 65534' /etc/passwd | wc -l)
echo "Total regular users: $regular_users"

# 3. User Groups Membership
print_header "USER GROUP MEMBERSHIPS"
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | sort); do
    groups_list=$(groups $user 2>/dev/null | cut -d: -f2)
    echo -e "${GREEN}$user:${NC}$groups_list"
done

# 4. Home Directory Sizes
print_header "HOME DIRECTORY DISK USAGE"
echo "User             Size    Directory"
echo "----             ----    ---------"
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | sort); do
    home_dir=$(eval echo ~$user)
    if [ -d "$home_dir" ]; then
        size=$(du -sh "$home_dir" 2>/dev/null | awk '{print $1}')
        printf "%-15s  %-6s  %s\n" "$user" "$size" "$home_dir"
    fi
done

# 5. Last Login Information
print_header "LAST LOGIN TIMES"
echo "User             Last Login"
echo "----             ----------"
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | sort); do
    last_login=$(lastlog -u $user 2>/dev/null | tail -1 | awk '{if ($2 == "**Never") print "Never logged in"; else print $4, $5, $6, $7}')
    printf "%-15s  %s\n" "$user" "$last_login"
done

# 6. Users with sudo privileges
print_header "SUDO PRIVILEGES"
if [ -f /etc/sudoers ]; then
    echo "Users with sudo access:"
    grep -Po '^sudo.+:\K.*$' /etc/group 2>/dev/null | tr ',' '\n' | sed 's/^/  /'
else
    echo "Unable to check sudo privileges (requires elevated access)"
fi

# 7. Password Status
print_header "PASSWORD STATUS"
echo "User             Status"
echo "----             ------"
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | sort); do
    status=$(passwd -S $user 2>/dev/null | awk '{print $2}')
    case $status in
        P) status_text="${GREEN}Active (password set)${NC}" ;;
        L) status_text="${YELLOW}Locked${NC}" ;;
        NP) status_text="No password set" ;;
        *) status_text="Unknown" ;;
    esac
    echo -e "$(printf '%-15s' $user)  $status_text"
done

# Summary
print_header "SUMMARY"
total_users=$(awk -F: '$3 >= 1000 && $3 < 65534' /etc/passwd | wc -l)
active_sessions=$(who | wc -l)
echo "Total user accounts: $total_users"
echo "Active sessions: $active_sessions"
echo "Report generated: $(date)"
echo ""
