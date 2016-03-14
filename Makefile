# Makefile
#
# Dan Wilder
# 11 March 2016

CC=gcc
CFLAGS=-Wall -g

C_SOURCE=tree.c driver.c 
HEADER=tree.h lex_yacc.h
FLEX_SOURCE=tokens.l
BISON_SOURCE=cfg.y

FLEX_OUT=lex.yy.c
BISON_OUT=y.tab.c
OBJS=$(C_SOURCE:.c=.o) lex.yy.o y.tab.o

EXEC=ada

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $(EXEC)

$(FLEX_OUT): $(FLEX_SOURCE) $(BISON_OUT) $(HEADER)
	flex $(FLEX_SOURCE)

$(BISON_OUT) y.tab.h: $(BISON_SOURCE) $(HEADER)
	bison -d -v -y $(BISON_SOURCE)

%.o: %.c $(HEADER)
	$(CC) -c $(CFLAGS) $*.c -o $*.o

.PHONY: clean
.PHONY: realclean

clean:
	rm *.o y.tab.h y.output $(FLEX_OUT) $(BISON_OUT)
realclean:
	rm *.o y.tab.h y.output $(FLEX_OUT) $(BISON_OUT) $(EXEC)
