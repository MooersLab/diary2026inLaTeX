#!/bin/bash
#
# generate_diary_year.sh
#
# Master script to generate a complete diary for a given year.
# This script runs all three component scripts in sequence:
#   1. generate_daily.sh   - Creates daily entry files
#   2. generate_month.sh   - Creates monthly chapter files
#   3. update_contents_year.sh - Updates the main contents file
#
# Usage:
#     ./generate_diary_year.sh <year>
#
# Example:
#     ./generate_diary_year.sh 2026

set -e  # Exit on any error

# Check for required argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <year>"
    echo ""
    echo "This script generates a complete diary structure for the specified year."
    echo ""
    echo "Example:"
    echo "  $0 2026"
    exit 1
fi

YEAR=$1

# Validate year is a 4-digit number
if ! [[ "$YEAR" =~ ^[0-9]{4}$ ]]; then
    echo "Error: Year must be a 4-digit number."
    exit 1
fi

# Find the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "Generating complete diary for year $YEAR"
echo "=============================================="
echo ""

# Step 1: Generate daily entry files
echo "Step 1: Generating daily entry files..."
echo "----------------------------------------------"
if [ -f "$SCRIPT_DIR/generate_daily.sh" ]; then
    "$SCRIPT_DIR/generate_daily.sh" "$YEAR"
elif [ -f "./generate_daily.sh" ]; then
    ./generate_daily.sh "$YEAR"
else
    echo "Error: generate_daily.sh not found."
    exit 1
fi
echo ""

# Step 2: Generate monthly chapter files
echo "Step 2: Generating monthly chapter files..."
echo "----------------------------------------------"
if [ -f "$SCRIPT_DIR/generate_month.sh" ]; then
    "$SCRIPT_DIR/generate_month.sh" "$YEAR"
elif [ -f "./generate_month.sh" ]; then
    ./generate_month.sh "$YEAR"
else
    echo "Error: generate_month.sh not found."
    exit 1
fi
echo ""

# Step 3: Update the contents file
echo "Step 3: Updating contents file..."
echo "----------------------------------------------"
if [ -f "$SCRIPT_DIR/update_contents_year.sh" ]; then
    "$SCRIPT_DIR/update_contents_year.sh" "$YEAR"
elif [ -f "./update_contents_year.sh" ]; then
    ./update_contents_year.sh "$YEAR"
else
    echo "Error: update_contents_year.sh not found."
    exit 1
fi
echo ""

echo "=============================================="
echo "Diary generation complete for year $YEAR"
echo "=============================================="