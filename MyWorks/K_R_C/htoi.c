/*
 * Программа для перевода целого числа из 16 системы в 10.
 * Выполнил: Фатеев А.М.
*/
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int k;
int htoi(char s[]){
	int n = 0, k = 0;
	printf ("Длина = %d\n", strlen(s));
	if (!(s[0] == '0' && s[1] == 'x' || s[1] == 'X'))
		return 0;
	for (int i = 2; (s[i] >= '0' && s[i] <= '9' || s[i] >= 'a' && s[i] <='f' || s[i] >= 'A' && s[i] <= 'F') && i < strlen(s); i ++){
		if (s[i] == 'a' || s[i] == 'A')
			n = 10;
		else if (s[i] == 'b' || s[i] == 'B')
			n = 11;
		else if (s[i] == 'c' || s[i] == 'C')
			n = 12;
		else if (s[i] == 'd' || s[i] == 'D')
			n = 13;
		else if (s[i] == 'e' || s[i] == 'E')
			n = 14;
		else if (s[i] == 'f' || s[i] == 'F')
			n = 15;
		else
			n = s[i] - '0';
		k = k * 16 + n;
	}
	printf ("Перевод числа в 10 СИ = %d \n", k);
	return k;

}
int main (int argv, char ** argc){
	char s[1024];
	printf("Введите число в 16 СИ, в формате 0x или 0X:\n");
	scanf("%s", s);
	htoi(s);
	return 0;
}
