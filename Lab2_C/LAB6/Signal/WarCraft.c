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

int mine = 11000;
int i, fd;
int num;
int *pid;
sigset_t base_mask;
static void signal_handler(int);

int main(int argc, char *argv[]) {
    int min = 0, stat, status = 1;
    if( signal( SIGUSR1, signal_handler) == SIG_ERR  )
    {
        printf("Pærent: Unable to create handler for SIGUSR1\n");
    }
    
    
    if (argc != 2) {
        printf("Используйте: ./WarCraft число \n");
        exit(-1);
    }
	signal(SIGUSR1, signal_handler);
	
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

			
			while (1) {
			
				sleep(rand() % 6);
				kill(getppid(), SIGUSR1);
				//pause();
			}
			printf(" CHILD:Рабочий %d закончил добычу золота СТАРТ!\n", i);
            exit(status); // выход из процесса-потомока 
        }
	}
    
    // если выполняется родительский процесс
    //printf("PARENT: Это процесс-родитель!\n");
    
    for (i = 1; i <= num; i++) {
		//kill(pid[i], SIGINT);
        waitpid(pid[i], &stat, WUNTRACED);
        printf("CHILD:Рабочий %d закончил добычу золота,  result=%d\n", i, WIFSTOPPED(status));
        /*if (pid[i] == status) {
            printf("процесс-потомок %d done,  result=%d\n", i, WIFSTOPPED(status));
        }*/
    }
    // ожидание окончания выполнения всех запущенных процессов
    return 0;
}
static void signal_handler(int signo){
	//printf("%d", signo);
	switch( signo )
    {
        /* Signal is a SIGUSR1 */
        
        case SIGUSR1:

			mine -= MINING;

			if (mine >= 0)
				printf("Рабочий добывает золото из шахты, в шахте осталось %d \n", mine);
			else {
				for (int i = 1; i <= num; i++){
					kill(pid[i], SIGKILL);
				}
			}
			
			
			break;
	}
}
