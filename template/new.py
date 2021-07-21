#!/usr/bin/env python3
"""
Module documentation.
"""

# Imports
import sys
#import os

def main():
    args = sys.argv[1:]

    if not args:
        print('usage: [--flags options] [inputs] ')
        sys.exit(1)

# Main body
if __name__ == '__main__':
    main()
