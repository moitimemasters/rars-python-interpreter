def fib_canonical(var1):
    if var1 < 2:
        return 1
    return fib_canonical(var1 - 1) + fib_canonical(var1 - 2)


def helper(a, b, x):
    return helper(b, a + b, x - 1) if x else a


def optimized_fib(var2):
    return helper(1, 1, var2)


optimized_fib(10) - fib_canonical(9)
