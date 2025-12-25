#!/bin/bash

# Infrastructure Testing Suite
# Author: Brady Durham
# Date: December 25, 2025
# Purpose: Automated validation of Azure infrastructure components

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to print test header
print_header() {
    echo ""
    echo "=========================================="
    echo "  Infrastructure Test Suite"
    echo "  Date: $(date)"
    echo "=========================================="
    echo ""
}

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    echo -n "Testing: $test_name ... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to print test results
print_results() {
    echo ""
    echo "=========================================="
    echo "  Test Results Summary"
    echo "=========================================="
    echo "Total Tests: $TOTAL_TESTS"
    echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
    echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "\n${GREEN}✓ All tests passed! Infrastructure is healthy.${NC}"
    else
        echo -e "\n${RED}✗ Some tests failed. Review and fix issues.${NC}"
    fi
    echo ""
}

# Main test execution
print_header

echo "=== Local System Tests ==="
echo ""

# Test 1: Check if Azure CLI is installed
run_test "Azure CLI Installation" "command -v az"

# Test 2: Check UFW firewall is active
run_test "Firewall Status (UFW Active)" "sudo ufw status | grep -q 'Status: active'"

# Test 3: Check SSH is allowed in firewall
run_test "Firewall Rule (SSH Allowed)" "sudo ufw status | grep -q '22/tcp.*ALLOW'"

# Test 4: Check system disk usage is healthy (less than 90%)
run_test "Disk Space (< 90% used)" "[ \$(df / | tail -1 | awk '{print \$5}' | sed 's/%//') -lt 90 ]"

# Test 5: Check memory is available (at least 100MB free)
run_test "Memory Available (> 100MB)" "[ \$(free -m | grep Mem | awk '{print \$7}') -gt 100 ]"

echo ""
echo "=== Network Tests ==="
echo ""

# Test 6: Check internet connectivity
run_test "Internet Connectivity" "ping -c 1 8.8.8.8"

# Test 7: Check DNS resolution
run_test "DNS Resolution" "ping -c 1 google.com"

# Test 8: Check localhost web server (if you have one running)
if command -v curl &> /dev/null; then
    run_test "Localhost Response" "curl -s http://localhost > /dev/null"
fi

# Print final results
print_results

# Exit with appropriate code
if [ $FAILED_TESTS -eq 0 ]; then
    exit 0
else
    exit 1
fi
