# assume that f is given
def f(x,y):
    pass

# without lambdas
def F(x):
    def tmp(y):
        return f(x,y)
    return tmp

# with lambdas
def F(x):
    return lambda y: f(x,y)
