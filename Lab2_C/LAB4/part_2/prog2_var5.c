
#include <stdio.h>
#include <stdlib.h>
#define MAX_SIZE 128

int mod_string(int count, char *str, FILE *fp){
	
	char name[20];
	int i = 0;
	while (*str != '.')
		name[i++] = *str++;
	name[i++] = '.';
	name[i] = 'c';
	FILE *ff;
	ff = fopen(name, "w");
	
	char ch;
	int n_p = 0;
	while ((ch=fgetc(fp)) != EOF) {
		//printf("%c\n", ch);
		if (ch == ' ' && n_p < count) {
			n_p++;
			printf("%d\n", n_p);
			fputc(ch, ff);
		}
		fputc(ch, ff);
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
	int count = atoi(argv[2]);
	mod_string(count, argv[1], fp);
	if(fclose(fp)){
		printf("Ошибка при закрытии файла.\n");
		exit(1);
	}
   return 0;
}
//---------------
