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
    new_string = f'<p><a id="en{counter}appendix" href="{match.group(1)}#en{counter}"><sup>{counter}</sup></a>{match.group(2) if match.group(2) else ""}</p>'
    counter += 1
    return new_string

# Regular expression to capture the pattern
pattern = re.compile(r'<p><a id="en\d+appendix" href="([a-zA-Z0-9_-]+\.xhtml)#en\d+"><sup>\d+</sup></a>(.*?)</p>', re.DOTALL)

# Perform the substitution with the replace_numbers function
new_content = re.sub(pattern, replace_numbers, content)

# Save the modified content back to the original file
try:
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(new_content)
    print(f"File renumbered successfully. Changes saved to '{file_path}'.")
except IOError as e:
    print(f"Error writing to file '{file_path}': {e}")
    sys.exit(1)

