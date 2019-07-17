//--- sort.c
#include <stdio.h>
#include <stdlib.h>
#define YEAR0 1950
struct buy{
	char name[50];
	int day;
	int mounth;
	int year;
	int value, number;
};
typedef struct buy buys;
void readBuy(buys *st){
    printf("Введите имя покупки:");
    scanf("%s", st->name);
    printf("Введите дату в формате DD.MM.YEAR:");
    scanf("%d.%d.%d", &st->day, &st->mounth, &st->year);
    printf("Введите стоимость одного товара:");
    scanf("%d", &st->value);
    printf("Введите число покупок:");
    scanf("%d", &st->number);
}
void printBuys(buys **st, int count){
	for (int i =0; i < count; i++){
		printf("Имя покупки: %s\n", st[i]->name);
		printf("Дата покупки: %d.%d.%d\n", st[i]->day, st[i]->mounth, st[i]->year);
		printf("Стоимость товара: %d\n", st[i]->value);
		printf("Число покупок: %d\n", st[i]->number);
	}
}
static int cmp(const void *p1, const void *p2){
    buys * st1 = *(buys**)p1;
    buys * st2 = *(buys**)p2;
    return st1->mounth - st2->mounth;
}
int main(int argc, char ** argv){
	int count=1;
	printf("Введите число покупок:");
	scanf("%d", &count);
	buys ** st = (buys **)malloc(sizeof(buys*)*count);
	for (int i = 0; i < count; i++){
		st[i] = (buys*)malloc(sizeof(buys));
		readBuy(st[i]);
	}
	printBuys(st, count);
	qsort(st, count, sizeof(buys*), cmp);
	printBuys(st, count);
	for (int i = 0; i < count; i++){
		free(st[i]);
	}
	free(st);
	return 0;
}
