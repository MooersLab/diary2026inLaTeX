#!/usr/bin/env python3
"""
Generate a LaTeX chapter file for a monthly diary.

This script creates a LaTeX file with a chapter for the specified month,
containing sections for each day with input commands pointing to daily
content files.

Usage:
    python generate_month.py <year> <month_name> <num_days>
    
Example:
    python generate_month.py 2026 January 31
"""

import argparse
import sys
from pathlib import Path


def generate_month_file(year: int, month_name: str, num_days: int) -> str:
    """
    Generate the LaTeX content for a monthly diary chapter.
    
    Args:
        year: The year (e.g., 2026)
        month_name: The full name of the month (e.g., "January")
        num_days: The number of days in the month (28-31)
    
    Returns:
        A string containing the complete LaTeX file content.
    """
    # Build the header comment block
    lines = [
        "%!TeX options=--shell-escape",
        "%%%%%%%%%%%%%%%%%%%%% chapter.tex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
        "%",
        "% sample chapter",
        "%",
        "% Use this file as a template for your own input.",
        "%",
        "%%%%%%%%%%%%%%%%%%%%%%%% Springer-Verlag %%%%%%%%%%%%%%%%%%%%%%%%%%",
        "",
        f"\\chapter{{{month_name} {year}}}",
        f"\\label{{{month_name.lower()}{year}}} % Always give a unique label",
        ""
    ]
    
    # Generate sections for each day
    for day in range(1, num_days + 1):
        section_title = f"{month_name} {day}"
        input_path = f"./Content/{month_name}/{day}{month_name}{year}"
        lines.append(f"\\section{{{section_title}}}")
        lines.append(f"\\input{{{input_path}}}")
    
    return "\n".join(lines) + "\n"


def is_leap_year(year: int) -> bool:
    """
    Determine whether a given year is a leap year.
    
    A year is a leap year if it is divisible by 4, except for century years,
    which must be divisible by 400.
    
    Args:
        year: The year to check
    
    Returns:
        True if the year is a leap year, False otherwise.
    """
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)


def get_days_in_month(year: int, month_name: str) -> int:
    """
    Return the number of days in a given month, accounting for leap years.
    
    Args:
        year: The year (needed for February leap year calculation)
        month_name: The full name of the month
    
    Returns:
        The number of days in the specified month.
    
    Raises:
        ValueError: If the month name is not recognized.
    """
    days_map = {
        "January": 31,
        "February": 29 if is_leap_year(year) else 28,
        "March": 31,
        "April": 30,
        "May": 31,
        "June": 30,
        "July": 31,
        "August": 31,
        "September": 30,
        "October": 31,
        "November": 30,
        "December": 31
    }
    
    if month_name not in days_map:
        raise ValueError(f"Unknown month: {month_name}")
    
    return days_map[month_name]


def main():
    """Parse command line arguments and generate the month file."""
    parser = argparse.ArgumentParser(
        description="Generate a LaTeX chapter file for a monthly diary.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    %(prog)s 2026 January 31
    %(prog)s 2024 February 29  # Leap year
    %(prog)s 2025 February 28  # Non-leap year
    %(prog)s 2026 March        # Auto-detect days
        """
    )
    
    parser.add_argument(
        "year",
        type=int,
        help="The year (e.g., 2026)"
    )
    
    parser.add_argument(
        "month_name",
        type=str,
        help="The full name of the month (e.g., January)"
    )
    
    parser.add_argument(
        "num_days",
        type=int,
        nargs="?",
        default=None,
        help="The number of days in the month (optional; auto-detected if omitted)"
    )
    
    parser.add_argument(
        "-o", "--output",
        type=str,
        default=None,
        help="Output file path (default: <MonthYear>.tex in current directory)"
    )
    
    args = parser.parse_args()
    
    # Validate and normalize month name
    month_name = args.month_name.capitalize()
    valid_months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    if month_name not in valid_months:
        print(f"Error: '{args.month_name}' is not a valid month name.", file=sys.stderr)
        print(f"Valid months: {', '.join(valid_months)}", file=sys.stderr)
        sys.exit(1)
    
    # Determine number of days
    if args.num_days is None:
        num_days = get_days_in_month(args.year, month_name)
        print(f"Auto-detected {num_days} days for {month_name} {args.year}")
    else:
        num_days = args.num_days
        if num_days < 28 or num_days > 31:
            print(f"Warning: {num_days} days is unusual for a month.", file=sys.stderr)
    
    # Generate the content
    content = generate_month_file(args.year, month_name, num_days)
    
    # Determine output path
    if args.output:
        output_path = Path(args.output)
    else:
        output_path = Path(f"{month_name}{args.year}.tex")
    
    # Write the file
    output_path.write_text(content)
    print(f"Generated: {output_path}")


if __name__ == "__main__":
    main()
