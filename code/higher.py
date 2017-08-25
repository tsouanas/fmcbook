def succ(n):
    return n + 1

def pred(n):
    return n - 1

def double(n):
    return n * 2

def triple(n):
    return n * 3
  
def add(x,y):
    return x + y

def add5(x):
    return add(5,x)

# before running the following, guess what the output should be: 
# higher(succ, double, min)
# higher(succ, triple, add)
# higher(lambda x: x + 5, lambda x: 5 * x, max)
# higher(pred, triple, lambda x,y: 2 * x * y )
def higher(x, y, z):
    return x(10) + y(20) + z(3,4)


def adder(c):

    def addtmp(x):
        return x + c

    return addtmp


def compose(f,g):
    # replace "pass" with a definition that returns gof
    pass

