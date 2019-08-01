//--- fork_many.c
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <signal.h>
#include <string.h>
#define MINING 10

uint mine = 1100;
uint prev = 1100;
int i, fd;
int num;
void mywrite(void);
void myread(void);
void miner();

int main(int argc, char *argv[]) {
    int min = 0, stat;
    
    int *pid;
    if (argc != 2) {
        printf("Используйте: ./WarCraft число \n");
        exit(-1);
    }
    fd = creat("Mine.conf", 0644);
	write(fd, &mine, sizeof(int));
	close(fd);
    
	
    num = atoi(argv[1]);
    pid = (int *)malloc(sizeof(num)*num);
    for (i = 1; i <= num; i++) {
        // запускаем дочерний процесс 
        pid[i] = fork();
        //srand(getpid());
        srand(getpid());

        if (-1 == pid[i]) {
            perror("fork"); // произошла ошибка
            exit(1); //выход из родительского процесса
        } else if (0 == pid[i]) {
			
			printf(" CHILD:Рабочий %d начал добычу золота СТАРТ!\n", i);
			//signal(SIGINT,miner);
			while (1) {
				mywrite();
				sleep(i+rand()%4);
				myread();
				//signal(SIGINT,miner);
				//printf("Mine = %d", mine);
				mine-= MINING;

			}
			printf(" CHILD:Рабочий %d закончил добычу золота СТАРТ!\n", i);
            exit(1); // выход из процесса-потомока 
        }
	}
    
    // если выполняется родительский процесс
    //printf("PARENT: Это процесс-родитель!\n");
    
    for (i = 1; i <= num; i++) {
		//kill(pid[i], SIGINT);
        waitpid(pid[i], &stat, WUNTRACED);
        //printf("процесс-потомок %d done,  result=%d\n", i, WIFSTOPPED(status));
        /*if (pid[i] == status) {
            printf("процесс-потомок %d done,  result=%d\n", i, WIFSTOPPED(status));
        }*/
    }
    // ожидание окончания выполнения всех запущенных процессов
    return 0;
}
void mywrite(void){
	fd = creat("Mine.conf", 0644);
	//fd = open("Mine.conf", O_WRONLY);
	
	if ( lockf(fd, F_TLOCK, (off_t) 10000) >= 0 ){
		//printf(" Write Bufmine = %s\n", bufmine);
		write(fd, &mine, sizeof(int));
		if (prev != mine)
			printf("Рабочий %d, добывает золото, в шахте осталось %d\n", i, mine);
	}
	if ( lockf(fd, F_ULOCK, (off_t) 10000) < 0 )
		perror("SETLOCK");
	close(fd);
}
void myread(void){
	fd = open("Mine.conf", O_RDONLY);
	lockf(fd, F_LOCK, 0);
	read(fd, &mine, sizeof(int));
	if (mine <= 0) {
		//printf("WORKING\n");
		printf(" CHILD:Рабочий %d закончил добычу золота СТАРТ!\n", i);
		exit(1);
	}
	lockf(fd, F_ULOCK, 0);
	close(fd);
}

