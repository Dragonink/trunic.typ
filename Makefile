MAKEFLAGS += --no-builtin-rules
ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TYPST ?= typst


-include docs/manual.d
%.d %.pdf &: %.typ
	$(TYPST) compile $< --root $(ROOT) --make-deps $*.d $(TYPSTFLAGS)

.PHONY: manual
manual: docs/manual.pdf
