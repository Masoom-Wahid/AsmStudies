#!/usr/bin/env python3

import sys

BUFFER_SIZE = 500

def convert_to_upper(buffer):
    result = ""
    for char in buffer:
        # Check if character is lowercase (between 'a' and 'z')
        if 'a' <= char <= 'z':
            # Convert to uppercase by subtracting 32 from ASCII value
            result += chr(ord(char) - 32)
        else:
            result += char
    return result

def main():
    # Check if correct number of command line arguments
    if len(sys.argv) != 3:
        print("Usage: python3 script.py input_file output_file")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        # Open input file for reading
        with open(input_file, 'r') as fin:
            # Open output file for writing
            with open(output_file, 'w') as fout:
                while True:
                    # Read buffer_size characters at a time
                    buffer = fin.read(BUFFER_SIZE)
                    
                    # Check for end of file
                    if not buffer:
                        break
                    
                    # Convert to upper case and write to output file
                    upper_text = convert_to_upper(buffer)
                    fout.write(upper_text)

    except IOError as e:
        print(f"Error processing files: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
