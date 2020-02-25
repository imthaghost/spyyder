"""JSON Sanitization"""


# clean takes in some string and eleminates escape characters
def clean(someString):
    # check if the string is alphanumeric
    if str(someString).isalpha():
        return True
    # check if the string are numbers
