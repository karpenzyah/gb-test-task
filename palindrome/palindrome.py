# Comparing string with itself reversed
def is_palindrome_1(s):
    if s == s[::-1]:
        return True
    else:
        return False


# Recursive dropping endings
def is_palindrome_2(s):
    if s == '':
        return True
    if s[0] == s[len(s)-1]:
        return is_palindrome_2(s[1:len(s)-1])
    else:
        return False


# Comparing endings
def is_palindrome_3(s):
    ln = len(s)
    for i in range(ln//2):
        if s[i] != s[ln-i-1]:
            return False
    return True


# Human-readable output
def hr_output(func, strs):
    print(f'\n---Function "{func.__name__}" output---\n')
    for s in strs:
        neg = ' not'
        if func(''.join(s.split()).lower()): neg = ''
        print(f'"{s}" is{neg} a palindrome')


with open('palindrome/test_strings.txt') as test_file:
    strings = test_file.read().split('\n')
    strings.remove('')

hr_output(is_palindrome_1, strings)
hr_output(is_palindrome_2, strings)
hr_output(is_palindrome_3, strings)
