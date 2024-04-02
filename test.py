def helper(x, a, b):
    return x if x + a > b else helper(x + a, a, b)


def mod(a, b):
    return a - helper(0, b, a)


mod(51, 2)
