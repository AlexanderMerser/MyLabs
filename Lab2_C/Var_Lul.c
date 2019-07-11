/*
 *  Разработал Фатеев А.М. Номер варианта: 5
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_LEN 80
int sort(char**, int);
int main(int argc, char *argv[]){
	char cn[MAX_LEN];
	fgets(cn, MAX_LEN, stdin);
	int n;
	//scanf("%d", &n);
	n = atoi(cn);
	char **mas;
	char buffer[MAX_LEN];
	mas = (char **)malloc(sizeof(char *)*n);
	//printf("Выделено памяти для массива указателей: %d \n", sizeof(char *)*n);
	for (int i = 0; i < n; i++){
		int size = sizeof(char *)*strlen(buffer);
		mas[i] = (char *)malloc(size);
		//printf("Выделено памяти для элементов: %d \n", size);
		fgets(buffer, MAX_LEN, stdin);
		//scanf("%s", buffer);
		strcpy(mas[i], buffer);
	}
	for (int i = 0; i < n; i++){
		printf("mas[%d]=%s", i, mas[i]);
	}
	int k = sort(mas, n);
	printf("\n");
	for (int i = 0; i < n; i++){
		printf("mas[%d] = %s", i, mas[i]);
	}
	printf("\nПервый символ последний строки: %c\n", mas[n-1][0]);
	printf("Число переставлений: %d\n", k);
	for (int i = 0; i < n; i++){
		free(mas[i]);
	}
	free(mas);
	exit(EXIT_SUCCESS);
}
 int sort (char** mas, int n){
	int NP = 0;
	for (int i = 0; i < n - 1; i++) {
		for(int j = 0; j < n - i - 1; j++){
			if (strlen(mas[j]) > strlen(mas[j+1])){
				char *tmp = mas[j];
				mas[j] = mas [j + 1];
				mas [j + 1] = tmp;
				NP++;
			}
		}
	}

	return NP;
}
