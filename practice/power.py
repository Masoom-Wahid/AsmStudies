a = 15 


def power(a,b=1):
    mul = b*b
    if mul == a:
        return b
    if mul > a:
        return None
    return power(a,b+1)


result = power(a)

print(result)
