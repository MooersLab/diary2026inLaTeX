#!/bin/bash
#
# generate_year_diary.sh
#
# Generate LaTeX chapter files for all 12 months of a given year.
# This script calls generate_month.py for each month, automatically
# handling leap years for February.
#
# Usage:
#     ./generate_year_diary.sh <year> [output_directory]
#
# Examples:
#     ./generate_year_diary.sh 2026
#     ./generate_year_diary.sh 2024 ./diary_chapters
#
# The script will create files named <Month><Year>.tex for each month.

set -e  # Exit on any error

# Check for required argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <year> [output_directory]"
    echo ""
    echo "Arguments:"
    echo "  year              The year for which to generate diary files"
    echo "  output_directory  Optional directory for output files (default: current directory)"
    echo ""
    echo "Examples:"
    echo "  $0 2026"
    echo "  $0 2024 ./diary_chapters"
    exit 1
fi

YEAR=$1
OUTPUT_DIR="${2:-.}"

# Validate year is a reasonable number
if ! [[ "$YEAR" =~ ^[0-9]{4}$ ]]; then
    echo "Error: Year must be a 4-digit number."
    exit 1
fi

# Find the Python script (look in same directory as this script, then current directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/generate_month.py" ]; then
    PYTHON_SCRIPT="$SCRIPT_DIR/generate_month.py"
elif [ -f "./generate_month.py" ]; then
    PYTHON_SCRIPT="./generate_month.py"
else
    echo "Error: Cannot find generate_month.py"
    echo "Please ensure it is in the same directory as this script or the current directory."
    exit 1
fi

# Create output directory if it does not exist
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

# Function to check if a year is a leap year
is_leap_year() {
    local year=$1
    if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
        return 0  # true (leap year)
    else
        return 1  # false (not a leap year)
    fi
}

# Determine February days based on leap year
if is_leap_year "$YEAR"; then
    FEBRUARY_DAYS=29
    echo "Year $YEAR is a leap year. February will have 29 days."
else
    FEBRUARY_DAYS=28
    echo "Year $YEAR is not a leap year. February will have 28 days."
fi

echo ""
echo "Generating diary chapter files for $YEAR..."
echo "Output directory: $OUTPUT_DIR"
echo ""

# Define months and their days
# Format: "MonthName:Days"
MONTHS=(
    "January:31"
    "February:$FEBRUARY_DAYS"
    "March:31"
    "April:30"
    "May:31"
    "June:30"
    "July:31"
    "August:31"
    "September:30"
    "October:31"
    "November:30"
    "December:31"
)

# Generate each month
for month_info in "${MONTHS[@]}"; do
    # Split the string on ':'
    MONTH_NAME="${month_info%%:*}"
    NUM_DAYS="${month_info##*:}"
    
    # Define the month subdirectory and output file
    MONTH_SUBDIR="$OUTPUT_DIR/$MONTH_NAME"
    OUTPUT_FILE="$MONTH_SUBDIR/${MONTH_NAME}${YEAR}.tex"
    
    # Create the month subdirectory if it does not exist
    if [ ! -d "$MONTH_SUBDIR" ]; then
        echo "Creating subdirectory: $MONTH_SUBDIR"
        mkdir -p "$MONTH_SUBDIR"
    fi
    
    echo "Generating $MONTH_NAME $YEAR ($NUM_DAYS days)..."
    python3 "$PYTHON_SCRIPT" "$YEAR" "$MONTH_NAME" "$NUM_DAYS" -o "$OUTPUT_FILE"
done

echo ""
echo "Complete! Generated 12 monthly chapter files for $YEAR."
echo ""
echo "Files created:"
for month_info in "${MONTHS[@]}"; do
    MONTH_NAME="${month_info%%:*}"
    ls -1 "$OUTPUT_DIR/$MONTH_NAME/${MONTH_NAME}${YEAR}.tex" 2>/dev/null
done
