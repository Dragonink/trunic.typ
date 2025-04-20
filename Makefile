MAKEFLAGS += --no-builtin-rules
ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TYPST ?= typst


-include docs/manual.d
%.d %.pdf &: %.typ
	$(TYPST) compile $< --root $(ROOT) --make-deps $*.d $(TYPSTFLAGS)

.PHONY: manual
manual: docs/manual.pdf

-include docs/quick_start.d
-include docs/banner.d
%.d %.svg &: %.typ
	$(TYPST) compile $< --format svg --root $(ROOT) --make-deps $*.d $(TYPSTFLAGS)

docs/banner.png: docs/banner.svg
	$(MAGICK) $< -resize 1280x640 $@

.PHONY: all
all: manual docs/quick_start.svg docs/banner.png

.DEFAULT_GOAL := all
