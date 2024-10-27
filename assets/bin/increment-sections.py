
import re
import sys
import os

# Check if the correct number of arguments is provided
if len(sys.argv) != 2:
    print("Usage: python increment.py <file-to-be-incremented>")
    sys.exit(1)

# Get the file path from the command-line argument
file_path = sys.argv[1]

# Check if the file exists
if not os.path.isfile(file_path):
    print(f"Error: The file '{file_path}' does not exist.")
    sys.exit(1)

# Open the HTML file for reading
with open(file_path, 'r', encoding='utf-8') as file:
    content = file.read()

# Initialize the counter
counter = 1

# Function to replace the number incrementally
def replace_numbers(match):
    global counter
    # Create a replacement string with the current counter value
    replacement = f'<a id="en{counter}" href="{match.group(1)}#en{counter}appendix"><sup>{counter}</sup></a>'
    counter += 1
    return replacement

# Regular expression to capture the pattern
pattern = re.compile(r'<a id="en\d+" href="([a-zA-Z0-9_-]+\.xhtml)#en\d+appendix"><sup>\d+</sup></a>', re.DOTALL)

# Function to process and increment numbers within each line
def process_line(line):
    global counter
    # Replace all occurrences in the line with incremented numbers
    return re.sub(pattern, replace_numbers, line)

# Process each line individually
new_content = []
for line in content.splitlines(True):  # Preserve line breaks
    new_content.append(process_line(line))

# Overwrite the original file with the modified content
try:
    with open(file_path, 'w', encoding='utf-8') as file:
        file.writelines(new_content)
    print(f"File renumbered successfully. Changes saved to '{file_path}'.")
except IOError as e:
    print(f"Error writing to file '{file_path}': {e}")
    sys.exit(1)

