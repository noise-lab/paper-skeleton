TARGET=paper

all: pdf

pdf:
	latexmk -latexoption="-file-line-error -8bit" -xelatex $(TARGET).tex

clean:
	latexmk -c

cleanall: clean
	latexmk -C
	rm -f paper.bbl
