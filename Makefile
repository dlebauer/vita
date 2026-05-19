.PHONY: all cv resume clean

SOURCE_DATE_EPOCH ?= 0
export SOURCE_DATE_EPOCH

all: cv resume
	cp output/cv.pdf dlebauer-full-vita.pdf
	cp output/resume.pdf dlebauer-resume.pdf

cv:
	quarto render cv.qmd --quiet

resume:
	quarto render resume.qmd

clean:
	rm -rf output .quarto cv.tex cv.pdf.md
