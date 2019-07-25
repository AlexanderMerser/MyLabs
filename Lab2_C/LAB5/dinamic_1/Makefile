main : main.o
	gcc main.o -L. -lcalcdyn -o main
main.o : main.c
	gcc -c -Wall -std=c99 main.c
clean :
	rm main.o main
