#!/bin/bash
#
# update_contents_year.sh
#
# Update the year in 0AAAcontents.tex file.
# This script replaces year references in \include statements and
# the header comment with the specified year.
#
# Usage:
#     ./update_contents_year.sh <year> [input_file]
#
# Examples:
#     ./update_contents_year.sh 2026
#     ./update_contents_year.sh 2028 ./0AAAcontents.tex
#
# The script modifies 0AAAcontents.tex in place (or the specified input file).

set -e  # Exit on any error

# Check for required argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <year> [input_file]"
    echo ""
    echo "Arguments:"
    echo "  year        The 4-digit year to set in the contents file"
    echo "  input_file  Optional path to the contents file (default: ./0AAAcontents.tex)"
    echo ""
    echo "Examples:"
    echo "  $0 2026"
    echo "  $0 2028 ./Content/0AAAcontents.tex"
    exit 1
fi

NEW_YEAR=$1
INPUT_FILE="${2:-./0AAAcontents.tex}"

# Validate year is a 4-digit number
if ! [[ "$NEW_YEAR" =~ ^[0-9]{4}$ ]]; then
    echo "Error: Year must be a 4-digit number."
    exit 1
fi

# Check that input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File not found: $INPUT_FILE"
    exit 1
fi

echo "Updating $INPUT_FILE to year $NEW_YEAR..."

# Create a temporary file for the modifications
TEMP_FILE=$(mktemp)

# Use sed to replace:
# 1. The header comment: 750words<YEAR>.tex -> 750words<NEW_YEAR>.tex
# 2. The include statements: /January/January<YEAR> -> /January/January<NEW_YEAR>
#    This pattern handles all months by matching the month name twice
sed -E \
    -e "s/(750words)[0-9]{4}(\.tex)/\1${NEW_YEAR}\2/g" \
    -e "s/(\\\\include\{\.\/Content\/)(January|February|March|April|May|June|July|August|September|October|November|December)\/(January|February|March|April|May|June|July|August|September|October|November|December)[0-9]{4}(\})/\1\2\/\3${NEW_YEAR}\4/g" \
    "$INPUT_FILE" > "$TEMP_FILE"

# Replace the original file with the modified version
mv "$TEMP_FILE" "$INPUT_FILE"

echo "Successfully updated $INPUT_FILE to year $NEW_YEAR."
echo ""
echo "Updated lines:"
grep -n "\\\\include{./Content/" "$INPUT_FILE" | head -12