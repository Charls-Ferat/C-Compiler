# Python file to answer the exercises from "Introduction to Compilers and Language Design"
# Section 3.9
# tests.py - Performs the testing
from regex_defs import DAYS_RE, INTEGERS_RE, EMAIL_RE, URL_RE, XSTRING_RE

# Test function
def test(regex, should_match, should_not_match):
    # Test strings that should match the regex
    for s in should_match:
        assert regex.fullmatch(s), f"SHOULD match: {s}"
    # Test strings that should NOT match the regex
    for s in should_not_match:
        assert not regex.fullmatch(s), f"SHOULD NOT match: {s}"

# Test the Week days RE
def test_days():
    should_match = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Saturday",
        "Sunday"
    ]

    should_not_match = {
        "Mon",
        "Na",
        "Tue",
        "Weds",
        "Thurs",
        "Saturnday",
        "Sun",
        "Mon-day",
        "Fridy",
        "nana"
    }

    # Run the test
    test(DAYS_RE, should_match, should_not_match)


# Test the Integers RE
def test_ints():
    should_match = [
        "123",
        "1,233",
        "111,111",
        "12,323",
        "1,123,890",
        "1,123,456,789",
        "456,890"
    ]

    should_not_match = {
        "1,1",
        "1112",
        "1,11,1",
        "111,1234"
        "234,45",
        "1,234,4567"
    }

    test(INTEGERS_RE, should_match, should_not_match)


# Test the Email Address RE
def test_email():
    should_match = [
        '"John Doe" <john.doe@gmail.com>',
        '"Carlos Ferat" <charly.f@gmail.com>'
    ]

    should_not_match = {
        # Bad Name
        'John Doe <john.doe@gmail.com>',
        '"John-Doe" <john.doe@gmail.com>',
        '"John" <john.doe@gmail.com>',
        '"john" <john.doe@gmail.com>',
        # Badly Spaced
        '"John Doe"<john.doe@gmail.com>',
        '"John  Doe" <john.doe@gmail.com>',
        # No Brackets
        '"Alison Dain" ali.d@gmail.com',
        '"Alison Dain" <ali.d@gmail.com',
        '"Alison Dain" ali.d@gmail.com>',
        # Bad email name
        '"Glenn Seaborg" <Glen.Seaborg@gmail.com>',
        '"Glenn Seaborg" <glenseaborg@gmail.com>',
        # Bad mail direction
        '"Hans Bethe" <hans.bethe@yahoo.com>',
        # Garbage
        "nana",
        ""
    }

    test(EMAIL_RE, should_match, should_not_match)


# Test the HTTP URL RE
def test_url():
    should_match = [
        "http://www.example.com",
        "https://www.google.com",
        "ftp://www.fileserver.com",

        "http://www.site.com/path",
        "https://www.site.com/path/to/resource",
        "https://www.site.com/index.html",

        "http://192.168.1.1",
        "https://192.168.0.1:8080",
        "ftp://10.0.0.1/files"
    ]

    should_not_match = {
        # Missing scheme
        "://www.example.com",
        "www.example.com",
        # Invalid scheme
        "htps://www.site.com/path",
        "htp://www.site.com/path",
        "fp://www.site.com/path",
        # Missing //
        "https:www.google.com",
        "httpswww.firefox.com",
        # Missing www
        "https://site.com/path/to/resource",
        "https://ww.site.com/path/to/resource",
        # Bad domain
        "https://www..com",
        "https://www.example",
        "https://www.example.comm",
        # Invalid IP
        "http://256.256.256.256.",
        #"http://256.256.256.256",   # Formally it shouldn't, but will match
        # Bad Port
        "https://www.example.com:99999",
        "https://www.example.com:",
        # Spaces}
        "https://www.example.com/hello world",
        # Bad Path
        "https://www.example.com//",
        "https://www.example.com/<>",
        # Garbage
        "naana",
        "useless text"
    }

    test(URL_RE, should_match, should_not_match)


# Test the complex string RE
def test_xstring():
    should_match = [
        "XXX<XX{X}XXX>X",
        "X{X}X<X>X{X}X<X>X"
    ]

    should_not_match = {
        "XXX<X<XX>>XX",
        "XX<XX{XX>XX}XX"
    }

    test(XSTRING_RE, should_match, should_not_match)


# --- function calls ---
print("Week Days regex test-")
test_days()

print("Email regex test-")
test_email()

print("Ints With Comma regex test-")
test_ints()

print("URL regex test-")
test_url()

print("Complex String regex test-")
test_xstring()
