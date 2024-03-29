SRCS := $(wildcard *.c)

ASMS := $(patsubst %.c, stage1/%.s, $(SRCS))

CROSS := /opt/riscv/bin/riscv64-unknown-elf-gcc

OUTDIR := stage1

CLEANEDDIR := stage2

RARS := java -jar $(HOME)/rars/rars.jar

PYTHON := python3

CLEANUP_SCRIPT := cleanup.py

all: $(OUTDIR) $(ASMS) cleanup rars

$(OUTDIR):
	mkdir -p -Os $(OUTDIR)

$(OUTDIR)/%.s : %.c
	$(CROSS) -S -mstrict-align $< -o $@

cleanup:
	mkdir -p $(CLEANEDDIR)
	$(PYTHON) $(CLEANUP_SCRIPT)

rars: $(CLEANEDDIR)/main.s
	$(RARS) nc sm p rv64 $<

clean:
	rm -rf $(OUTDIR)
	rm -rf $(CLEANEDDIR)
