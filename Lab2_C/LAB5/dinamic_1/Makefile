MAIN = main
LIBS = ../libs
CF = -c -Wall -std=c99
DCALC = libcalcdyn
all : $(DCALC) $(MAIN)
$(DCALC) : $(LIBS)/lib_four.c $(LIBS)/lib_three.c $(LIBS)/lib_four.h $(LIBS)/lib_three.h
	gcc -fPIC $(CF) $(LIBS)/lib_three.c
	gcc -fPIC $(CF) $(LIBS)/lib_four.c
	gcc -shared -o $(DCALC).so lib_three.o lib_four.o
$(MAIN) : $(MAIN).c
	gcc $(CF) -Wall -std=c99 main.c
	gcc $(MAIN).o -L. -lcalcdyn -o $(MAIN)
	rm *.o

clean :
	rm main libcalcdyn.so
