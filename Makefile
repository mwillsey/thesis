.PHONY: abstract
abstract: macros.tex abstract.tex
	pandoc $^ -t plain --wrap none
