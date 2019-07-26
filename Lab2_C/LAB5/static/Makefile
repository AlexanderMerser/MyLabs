MAIN = main
LIBS = ../libs
CF = -c -Wall -std=c99
CALC = libcalc
all : $(CALC) $(MAIN)
$(CALC) : $(LIBS)/lib_four.c $(LIBS)/lib_three.c $(LIBS)/lib_four.h $(LIBS)/lib_three.h
	gcc $(CF) $(LIBS)/lib_four.c -o lib_four.o
	gcc $(CF) $(LIBS)/lib_three.c -o lib_three.o
	ar rc $(CALC).a lib_four.o lib_three.o
	ranlib $(CALC).a
	rm *.o
$(MAIN) : $(MAIN).c
	gcc $(CF) -Wall -std=c99 main.c
	gcc $(MAIN).o -L$(LIBS) -lcalc -o $(MAIN)
	rm *.o
clean :
	rm main libcalc.a
