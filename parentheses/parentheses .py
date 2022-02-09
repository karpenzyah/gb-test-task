#  Recursive pairs deleting
def check1(s):
    if s.__len__() > 2 and s[0] == '(':
        s = s.replace('(', '', 1)
        s = s.replace(')', '', 1)
        return check1(s)
    elif s == '()':
        return True
    else:
        return False


def check2(s):
    mid = int(len(s)/2)
    o_l = s.count('(', 0, mid)
    c_l = s.count(')', 0, mid)
    c_r = s.count(')', mid, len(s))
    if (len(s) % 2) != 0 or s[0] == ')' or s[len(s)-1] == '(':
        return False
    elif o_l == c_r and o_l >= c_l:
        return True
    else:
        return False


#  Repetitive pairs deleting
def check3(s):
    while len(s) > 0:
        i = s.find('()')
        if i != -1:
            s = s[:i]+s[i+2:]
        else:
            return False
    return True


# Human-readable output
def hr_output(func, strs):
    print(f'\n---Function "{func.__name__}" output---\n')
    for s in strs:
        neg = ' not'
        if func(''.join(s.split())): neg = ''
        print(f'"{s}" is{neg} a normal string')


with open('test_strings.txt') as test_file:
    strings = test_file.read().split('\n')
    strings.remove('')


# hr_output(check1, strings)
# hr_output(check2, strings)
hr_output(check3, strings)
