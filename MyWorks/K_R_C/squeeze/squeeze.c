/*
 * Программа для удаление введенных символов из исходной строки
 * Выполнил: Фатеев А.М.
*/
#include <stdio.h>
#include <ctype.h>
#include <string.h>

void squeeze(char * s1, char * s2){
	int i, j, k, check;
	for (i = j = 0; i < strlen(s1); i++){
		for (check = k = 0; k < strlen(s2); k ++){
			if (s1[i] == s2[k])
				check = 1;
		}
		if (check != 1)
			s1[j++] = s1[i];
	}
	s1[j] = '\0';
}
int main (int argv, char ** argc){
	char s1[1024], s2[256];
	printf("Введите исходную строку:\n");
	scanf("%s", s1);
	printf("Введите строку символов, которые хотите удалить из исходной строки:\n");
	scanf("%s", s2);
	squeeze(s1, s2);
	printf("Конечная строка : %s\n", s1);
	return 0;
}
