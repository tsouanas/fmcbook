int a;
int i;

a = 8;
i = 4;

int foo(int x, int a)
{
    if (x < a) {
        return x + i;
    } else {
        for (i = 0; i < x; i++) {
            a = a + i;
        }
    }
    return a + i;
}
