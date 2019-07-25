#include <stdio.h>
#include <dlfcn.h>

int main (int argc, char *argv[]){
	if(NULL == argv[1]) {
		printf("Введите параметр\n");
		return(1);
	}
	
	void *calc;	// хандлер внешней библиотеки

	//загрузка библиотеки
	calc = dlopen("/home/autdan/Labs/Lab2_C/LAB5/dinamic_2/libcalcdyn.so",RTLD_LAZY);
	if (!calc){
		//если ошибка, то вывести ее на экран
		fprintf(stderr,"dlopen() error: %s\n", dlerror());
		return 1;
	};

	//загружаем из библиотеки требуемую процедуру
	double (*three_degree)(double x) = dlsym(calc, "three_degree");
	double (*four_degree)(double x) = dlsym(calc, "four_degree");
	
	//выводим результат работы процедуры

	printf("%f\n", (*three_degree)(atoi(argv[1])));
	printf("%f\n", (*four_degree)(atoi(argv[1])));
	
	//закрываем библиотеку
	dlclose(calc);
	
	return 0;
}
