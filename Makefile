.PHONY: thesis.pdf
thesis.pdf:
	latexmk -pdf thesis.tex

.PHONY: deploy
deploy: thesis.pdf index.html
	cp -r $^ out/
