#include <unistd.h>
#include <stdio.h>


int main(){
	int a = brk(NULL);
	printf("%p\n",a);
	printf("hello world and how are you\n");
}
