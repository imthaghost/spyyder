"""server"""

__author__ = "Gary Frederick"
__version__ = "1.0"

from application import app
import os
import sys

if __name__ == '__main__':
    app.run(host="127.0.0.1", port=5001, debug=True)
