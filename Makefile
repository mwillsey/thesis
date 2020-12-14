.PHONY: thesis.pdf
thesis.pdf:
	latexmk -pdf thesis.tex

.PHONY: deploy
deploy: thesis.pdf
	cp -r $^ out/
