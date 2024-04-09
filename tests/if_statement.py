a = 0
if 1 > 2:
    a += 0
elif 1 >= 2:
    a += 2
elif 1 <= 2:
    a += 3
else:
    a += 100

if a > 0:
    a += 100

if a == 0:
    a -= 100
else:
    a += 100

a
