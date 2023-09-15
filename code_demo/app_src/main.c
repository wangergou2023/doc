#include "stdio.h"
#include "lib_shared.h"
#include "lib_static.h"

int main()
{
    printf("hello main ! \r\n");
    helo_static();
    helo_shared();
    return 0;
}