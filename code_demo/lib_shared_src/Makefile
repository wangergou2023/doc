CC = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -shared -fPIC
LIBNAME = libshared.so
SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c,%.o,$(SRCS))

all: $(LIBNAME)

$(LIBNAME): $(OBJS)
	$(info "OBJS_C:"$(OBJS))
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS) $(LIBNAME)


