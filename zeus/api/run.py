"""Initialization"""

__author__ = "Gary Frederick"
__version__ = "1.0"

from server import app
import os
import sys

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
