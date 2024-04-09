def fib_canonical(n):
    if n < 2:
        return 1
    return fib_canonical(n - 1) + fib_canonical(n - 2)


def helper(a, b, x):
    return helper(b, a + b, x - 1) if x else a


def optimized_fib(n):
    return helper(1, 1, n)


optimized_fib(10) - fib_canonical(10)
