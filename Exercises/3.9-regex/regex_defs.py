# regex.py - Implements Regular Expressions (RE)
# Python file to answer the exercises from "Introduction to Compilers and Language Design"
# Section 3.9
import re

# Days of the week
DAYS_RE = re.compile(
    r"""
        ^(
            ((Tue|Wedne|Thur)s)     # e & s days
            |
            (Mon|Satur|Sun|Fri)     # non s days
        )
        day$                    # sufix: day
        """, re.X
)

# All integers, every 3 digits separated by comma
INTEGERS_RE = re.compile(
    r"""
        ^
        ([0-9]{1,3})    # Optional up to 3 digits, left-most part
        (,[0-9]{3})*    # Fixed comma plus 3 digits
        $
        """, re.X
)

# Internet Email addresses with specific format
EMAIL_RE = re.compile(
    r"""
    "([A-Za-z]+[ ][A-Za-z]+)"    # Full name
    \s+<                         # Space and <
    ([a-z]+\.[a-z]+@gmail\.com)  # Email
    >                            # >
    """, re.X
)

# HTTP uniform resource locations
URL_RE = re.compile(
    r"""
    ^(https?|ftp|file|mailto)://        # Scheme
    (
        www\.[a-zA-Z0-9]+\.com          # Domain
        |
        ([0-9]{1,3}\.){3}[0-9]{1,3}     # IP
    )
    (:[0-9]{1,4})?                      # Port - optional
    (/[a-zA-Z0-9._~%-]+)*$              # Path
    """, re.X
)

# String containing <> {} and X nested but not interleaved
XSTRING_RE = re.compile(
    r"""
        (X*
        (
            (<X*({X*})? X*>)
            |
            ({X*(<X*>)? X*})
        )*
        X*)+
        """, re.X
)
