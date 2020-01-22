SRC:=dcutest.c port.c PeripheralAPI.c init.c common.c

TARGET:=dcu_test

DATETIME:=$(shell date)

CFLAGS += '-DBUILDTIME="$(DATETIME)"'

all:	$(SRC)
	$(CC) -o $(TARGET) $(LDFLAGS) $(CFLAGS) $(SRC)

clean:
	rm -f $(TARGET)
