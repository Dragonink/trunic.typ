MAKEFLAGS += --no-builtin-rules
ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TYPST ?= typst


-include docs/manual.d
%.d %.pdf &: %.typ
	$(TYPST) compile $< --root $(ROOT) --make-deps $*.d $(TYPSTFLAGS)

.PHONY: manual
manual: docs/manual.pdf

-include docs/quick_start.d
%.d %.svg &: %.typ
	$(TYPST) compile $< --format svg --root $(ROOT) --make-deps $*.d $(TYPSTFLAGS)

.PHONY: all
all: manual docs/quick_start.svg

.DEFAULT_GOAL := all
