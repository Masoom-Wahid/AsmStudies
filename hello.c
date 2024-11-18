#include<stdio.h>

int add_2(int a,int b){
	int c = a+b;
	return c; 
}

int main(){
	int result = add_2(10,20);	
	printf("hello world %d\n",result);
	return 0;
}
