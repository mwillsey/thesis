.PHONY: thesis.pdf
thesis.pdf:
	latexmk -pdf thesis.tex

.PHONY: deploy
deploy: thesis.pdf index.html
	rm -rf out/
	mkdir out/
	cp -r $^ out/
