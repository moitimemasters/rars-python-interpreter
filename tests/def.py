def foo(y):
    def bar(x):
        return x
    return y + bar(1)


def rec_foo(x):
    return x + (0 if x == 0 else rec_foo(x - 1))


lmbda_foo = lambda x, y, z: (x + y + z) / 3

rec_foo(10) + foo(1) + lmbda_foo(1, 2, 3)
