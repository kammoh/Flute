# Makefile to create an elf_to_hex executable.
# The executable creates mem-hex files containing 32-Byte words

# CC = gcc

CFLAGS = $(shell pkg-config --cflags libelf)
LDFLAGS = $(shell pkg-config --libs libelf)

elf_to_hex: elf_to_hex.c
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $<

# ================================================================

.PHONY: clean
clean:
	rm -f *~

.PHONY: full_clean
full_clean:
	rm -f *~ elf_to_hex
