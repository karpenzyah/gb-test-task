# Comparing string with itself reversed
def is_palindrome_1(s):
    if s == s[::-1]:
        return True
    else:
        return False

# Recursive deleting edges
def is_palindrome_2(s):
    if s == '':
        return True
    if s[0] == s[len(s)-1]:
        return is_palindrome_2(s[1:len(s)-1])
    else:
        return False

# Human readable output
def hr_output(func, strs):
    print(f'\n---Function "{func.__name__}" output---\n')
    for s in strs:
        neg = ' not'
        if func(''.join(s.split()).lower()): neg = ''
        print(f'"{s}" is{neg} a palindrome')


with open('palindrome/test_strings.txt') as test_file:
    strings = test_file.read().split('\n')

hr_output(is_palindrome_1, strings)
hr_output(is_palindrome_2, strings)

