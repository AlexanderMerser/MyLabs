/*
 *  Разработал Фатеев А.М. Номер варианта: 5
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_LEN 1024
int NUM;
int nmax(int [], int);
int sort(char**, int);
void print(char **, int n);
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
		fgets(buffer, MAX_LEN, stdin);
		int size = sizeof(char *)*strlen(buffer);
		mas[i] = (char *)malloc(size);
		//printf("Выделено памяти для элементов: %d \n", size);
		//scanf("%s", buffer);
		strcpy(mas[i], buffer);
	}
	print(mas, n);
	int k = sort(mas, n);
	printf("\n");
	print(mas, n);
	printf("\nПервый символ последней строки: %c\n", mas[n-1][0]);
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
			int prevmax = 0;
			for(int j = 0; j < n - i; j++){
				int k = 0, nmax = 0;
				while (mas[j][k] != '\0'){
					if ((mas[j][k] == ' ')||(mas[j][k] == '\0')){
						nmax++;
					}
					k++;
				}
				if ((nmax < prevmax)){
					char* tmp = mas[j];
					mas[j] = mas [j - 1];
					mas[j - 1] = tmp;
					NP++;
				}
				prevmax = nmax;
			}
		}

	return NP;
}
void print(char ** mas, int n){
	for (int i = 0; i < n; i++){
		printf("mas[%d]=%s", i, mas[i]);
	}
}
int nmax (int mas[], int size){
	int max = 0, imax;
	for (int i = 0; i < size+1; i++){
		if (max < mas[i]){
			max = mas[i];
			imax = i;
		}
	}
	return imax;
}
