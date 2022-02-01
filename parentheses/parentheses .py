def check1(s):
    cnt_o = 0
    cnt_c = 0
    cnt = 0
    for c in s:
        if c == '(':
            cnt_o = 1
        elif c == ')':
            cnt_c = 1
        if cnt_c+cnt_o == 1:
            cnt += 1
    print(cnt, cnt_o, cnt_c)
    if cnt>2:
        return False
    else:
        return True


    # if cnt == 0 and s[0] == '(':
    #     return True
    # else:
    #     return False
    #

#  Recursive pairs deleting
def check2(s):
    if s.__len__() > 2 and s[0] == '(':
        s = s.replace('(','',1)
        s = s.replace(')','',1)
        print(s)
        return check2(s)
    elif s == '()':
        return True
    else:
        return False


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

# hr_output(check2, strings)
hr_output(check1, strings)
# check1(strings[2])
