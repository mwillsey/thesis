DATA=$(shell find data/ -type f)

UNAME=$(shell uname)
ifeq ($(UNAME),Darwin)
DRAWIO ?= /Applications/draw.io.app/Contents/MacOS/draw.io
endif
DRAWIO ?= drawio

DRAWINGS=$(wildcard figures/*.drawio)
DRAW_PDFS=$(patsubst figures/%.drawio, _build/%.pdf, $(DRAWINGS))

.PHONY: thesis.pdf
thesis.pdf: figures
	latexmk -pdf thesis.tex

SPEEDUP_OUT=_build/speedup.pdf _build/speedup-log.pdf _build/speedup-iter.pdf _build/repairs.pdf
$(SPEEDUP_OUT): scripts/speedup.py $(DATA)
	mkdir -p _build/
	python3 $<

_build/herbie.pdf: scripts/herbie.py
	mkdir -p _build/
	python3 $<

.PHONY: figures
figures: $(DRAW_PDFS) $(SPEEDUP_OUT) _build/herbie.pdf
_build/%.pdf: figures/%.drawio
	mkdir -p _build/
	-rm -f $@
	$(DRAWIO) --export --format=pdf --crop $< -o $@

.PHONY: deploy
deploy: thesis.pdf
	cp -r $^ out/

.PHONY: clean
clean:
	latexmk -C
