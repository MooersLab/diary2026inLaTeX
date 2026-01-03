#!/usr/bin/env python3
import sys
import os

def ensure_tex_root_declaration(filename):
    """
    Ensure file has TEX root declaration, adding it if missing.
    Returns True if file was modified, False otherwise.
    """
    tex_root = '%!TEX root = ../../main.tex\n'
    
    # Read existing content
    content = []
    if os.path.exists(filename):
        with open(filename, 'r') as file:
            content = file.readlines()
    
    # Check if declaration already exists
    if content and content[0].strip() == tex_root.strip():
        return False
    
    # Add declaration if needed
    with open(filename, 'w') as file:
        file.write(tex_root)
        if content:
            # If first line was blank, skip it
            if content[0].strip() == '':
                content = content[1:]
            file.writelines(content)
        else:
            file.write('\n')  # Add blank line for new files
    return True

def process_tex_pages(year, month, start_day, end_day):
    """
    Process TEX pages for a range of dates, ensuring proper TEX root declaration.
    
    Args:
        year (str): The year
        month (str): The month name
        start_day (int): First day of the range
        end_day (int): Last day of the range
    """
    # Validate inputs
    if start_day > end_day:
        raise ValueError("Start day must be less than or equal to end day")
    if start_day < 1 or end_day > 31:
        raise ValueError("Days must be between 1 and 31")
    
    modified_count = 0
    created_count = 0
    
    # Process each page
    for day in range(start_day, end_day + 1):
        filename = f"{day}{month}{year}.tex"
        
        # Track if file existed before
        file_existed = os.path.exists(filename)
        
        # Ensure TEX root declaration
        was_modified = ensure_tex_root_declaration(filename)
        
        if file_existed:
            if was_modified:
                print(f"Modified {filename}")
                modified_count += 1
            else:
                print(f"Skipped {filename} (already had TEX root)")
        else:
            print(f"Created {filename}")
            created_count += 1
    
    return created_count, modified_count

def main():
    # Check command line arguments
    if len(sys.argv) != 5:
        print("Usage: ./makeDaily750Pages.py year month startday endday")
        print("Example: ./makeDaily750Pages.py 2017 'November' 6 30")
        sys.exit(1)
    
    try:
        # Parse command line arguments
        year = sys.argv[1]
        month = sys.argv[2]
        start_day = int(sys.argv[3])
        end_day = int(sys.argv[4])
        
        # Process the TEX pages
        created, modified = process_tex_pages(year, month, start_day, end_day)
        
        # Print summary
        print(f"\nSummary:")
        print(f"Created: {created} new files")
        print(f"Modified: {modified} existing files")
        print(f"Total files processed: {end_day - start_day + 1}")
        
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)
    except IOError as e:
        print(f"File error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()