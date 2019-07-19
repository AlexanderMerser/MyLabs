//--- fputc.c
#include <stdio.h>
#include <stdlib.h>
#define MAX_SIZE 128

int mod_string(char *str1, char *str, FILE *fp){
	char buf[MAX_SIZE];
	char name[10];
	int i = 0;
	while (*str != '.')
		name[i++] = *str++;
	name[i++] = '.';
	name[i] = 'c';
	
	FILE *ff;
	ff = fopen(name, "w");
	
	int count = atoi(str1);

	int n_p = 0;
	
	
	while (fgets(buf, 100, fp) != NULL) {
		//printf("%c\n", ch);
		for (int i = 0; i < strlen(buf); i++){
			if (buf[i] == ' ')
				n_p++;
		}
		if (n_p < count){
			fputs(buf, ff);
		}
		n_p = 0;
	}
	
	if(fclose(ff)){
		printf("Ошибка при закрытии файла.\n");
		exit(1);
	}
}

int main(int argc, char *argv[]){
	FILE *fp;
	if (argc < 3){
		fprintf (stderr, "Мало аргументов. Используйте <имя файла> <число пробелов>\n");
		exit (1);
	}
	if((fp=fopen(argv[1], "r"))==NULL) {
		printf("Не удается открыть файл.\n");
		exit(1);
	}
	mod_string(argv[2], argv[1], fp);
	if(fclose(fp)){
		printf("Ошибка при закрытии файла.\n");
		exit(1);
	}
   return 0;
}
//---------------
