CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar
CFLAGS = -Wall -static
LIBNAME = libstatic.a
SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c,%.o,$(SRCS))

all: $(LIBNAME)

$(LIBNAME): $(OBJS)
	$(info "OBJS_C:"$(OBJS))
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS) $(LIBNAME)