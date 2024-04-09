def foo():
    def bar():
        return 1

    return 1 + bar()


def rec_foo(x):
    return x + (0 if x == 0 else rec_foo(x - 1))


lambda_foo = lambda x, y, z: (x + y + z) / 3

rec_foo(10) + foo() + lambda_foo(1, 2, 3)
