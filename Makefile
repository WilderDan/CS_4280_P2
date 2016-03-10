# Makefile
#
# Dan Wilder
# 10 March 2016

CC=gcc
CFLAGS=-Wall -g

SOURCE=tree.c driver.c
HEADER=tree.h
OBJS=$(SOURCE:.c=.o)

EXEC=ada

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $(EXEC)

%.o: %.c $(HEADER)
	$(CC) -c $(CFLAGS) $*.c -o $*.o

.PHONY: clean
.PHONY: realclean

clean:
	rm *.o 
realclean:
	rm *.o $(EXEC)
