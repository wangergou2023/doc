CC = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -I ../lib_static_inc \
		 -I ../lib_shared_inc
LDFLAGS = -L ../lib_static_src -lstatic \
		  -L ../lib_shared_src  -lshared 
TARGET = app
SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c,%.o,$(SRCS))

all: $(TARGET)

$(TARGET): $(OBJS)
	$(info "OBJS_C:"$(OBJS))
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS) $(TARGET)


