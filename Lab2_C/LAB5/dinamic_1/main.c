#include <stdio.h>
#include "/home/autdan/Labs/Lab2_C/LAB5/libs/lib_three.h"
#include "/home/autdan/Labs/Lab2_C/LAB5/libs/lib_four.h"

int main (int argc, char *argv[]){
	if(NULL == argv[1]) {
		printf("Введите параметр\n");
		return(1);
	}
	printf("%f\n", three_degree(atoi(argv[1])));
	printf("%f\n", four_degree(atoi(argv[1])));
	return 0;
}
