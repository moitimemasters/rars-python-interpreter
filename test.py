fib = lambda n: n if n < 3 else fib(n - 1) + fib(n - 2)

fib(8)  # more than 9 is actually too much for heap size
