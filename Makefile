CC = /usr/bin/gcc
CFLAGS = -Wall -g -O3 

all: test/test_chacha \
test/test_wots \
test/test_xmss

test/test_chacha: chacha.c prg.c randombytes.c test/test_chacha.c chacha.h prg.h randombytes.h
	$(CC) $(CFLAGS) chacha.c prg.c randombytes.c test/test_chacha.c -o $@ #-lcrypto -lm

test/test_wots: chacha.c hash.c prg.c randombytes.c wots.c xmss_commons.c test/test_wots.c chacha.h hash.h prg.h randombytes.h wots.h xmss_commons.h 
	$(CC) $(CFLAGS) chacha.c hash.c prg.c randombytes.c wots.c xmss_commons.c test/test_wots.c -o $@ -lcrypto -lm
	
test/test_xmss: chacha.c hash.c prg.c randombytes.c wots.c xmss.c xmss_commons.c test/test_xmss.c chacha.h hash.h prg.h randombytes.h wots.h xmss.h xmss_commons.h 
	$(CC) $(CFLAGS) chacha.c hash.c prg.c randombytes.c wots.c xmss.c xmss_commons.c test/test_xmss.c -o $@ -lcrypto -lm

debug:clean
	$(CC) $(CFLAGS) -g -o xmss_ref main.c
stable:clean
	$(CC) $(CFLAGS) -o xmss_ref main.c
clean:
	rm -vfr *~ xmss_ref