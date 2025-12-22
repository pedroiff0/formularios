# Minimal Makefile: only Cálculo and Física
# Supported:
#   make <subdir> cap<num>     (e.g. make fisicaiii cap30)
#   make <subdir>_<cap>        (e.g. make fisicaiii_cap30)
#   make calculos              (build all calculos)
#   make fisicas               (build all fisicas)

TEX=pdflatex

.SILENT:
MAKEFLAGS += -s

# Includes for calculos and fisicas
CALCULOS_INCLUDES = \
	calculos/calculoi/calculo_basico \
	calculos/calculoii/calculoii \
	calculos/calculoiii/calculoiii \
	calculos/calculoiv/calciv \
	calculos/calculoiv/matematica_basica \
	calculos/calculoiv/calculo_basico \
	calculos/calculoiv/deduction_example

FISICAS_INCLUDES = \
	fisicas/fisicai/cap01 fisicas/fisicai/cap02 fisicas/fisicai/cap03 fisicas/fisicai/cap04 fisicas/fisicai/cap05 fisicas/fisicai/cap06 fisicas/fisicai/cap07 fisicas/fisicai/cap08 fisicas/fisicai/cap09 fisicas/fisicai/cap10 fisicas/fisicai/cap11 \
	fisicas/fisicaii/cap12 fisicas/fisicaii/cap13 fisicas/fisicaii/cap14 fisicas/fisicaii/cap15 fisicas/fisicaii/cap16 fisicas/fisicaii/cap17 fisicas/fisicaii/cap18 fisicas/fisicaii/cap19 \
	fisicas/fisicaiii/cap21 fisicas/fisicaiii/cap22 fisicas/fisicaiii/cap23 fisicas/fisicaiii/cap24 fisicas/fisicaiii/cap25 fisicas/fisicaiii/cap26 fisicas/fisicaiii/cap27 fisicas/fisicaiii/cap28 fisicas/fisicaiii/cap29 fisicas/fisicaiii/cap30 fisicas/fisicaiii/cap31 fisicas/fisicaiii/deducao_biot_savart \
	fisicas/fisicaiv/cap33 fisicas/fisicaiv/cap34 fisicas/fisicaiv/cap35 fisicas/fisicaiv/cap36 fisicas/fisicaiv/cap37 fisicas/fisicaiv/cap38 fisicas/fisicaiv/cap39 fisicas/fisicaiv/cap40 fisicas/fisicaiv/cap41 fisicas/fisicaiv/cap42 fisicas/fisicaiv/cap43 fisicas/fisicaiv/cap44

# Basename dispatch
BASENAMES := $(sort $(notdir $(CALCULOS_INCLUDES) $(FISICAS_INCLUDES)))
.PHONY: $(BASENAMES)

# Subdirs
SUBDIRS_FISICAS := fisicai fisicaii fisicaiii fisicaiv
SUBDIRS_CALCULOS := calculoi calculoii calculoiii calculoiv
.PHONY: $(SUBDIRS_FISICAS) $(SUBDIRS_CALCULOS)

# Delegate to helper script
$(SUBDIRS_FISICAS):
	@scripts/build_chapter.sh $@ $(word 2,$(MAKECMDGOALS))

$(SUBDIRS_CALCULOS):
	@scripts/build_chapter.sh $@ $(word 2,$(MAKECMDGOALS))

.PHONY: cap% all
cap%:
	@:

all: main.pdf

# Combined builds
.PHONY: calculos
calculos:
	@printf '%s\n' '\\documentclass[a4paper]{report}' > build_calculos.tex; \
	printf '%s\n' '\\usepackage{latexconfig/forms}' >> build_calculos.tex; \
	printf '%s\n' '\\begin{document}' >> build_calculos.tex; \
	for inc in $(CALCULOS_INCLUDES); do echo "\\include{$$inc}" >> build_calculos.tex; done; \
	echo "\\end{document}" >> build_calculos.tex; \
	mkdir -p calculos; \
	$(TEX) build_calculos.tex >/dev/null; $(TEX) build_calculos.tex >/dev/null; \
	mv -f build_calculos.pdf calculos/calculos.pdf; \
	@echo "Saved calculos/calculos.pdf"; \
	rm -f build_calculos.aux build_calculos.log build_calculos.out build_calculos.toc build_calculos.tex build_calculos.synctex.gz || true

.PHONY: fisicas
fisicas:
	@printf '%s\n' '\\documentclass[a4paper]{report}' > build_fisicas.tex; \
	printf '%s\n' '\\usepackage{latexconfig/forms}' >> build_fisicas.tex; \
	printf '%s\n' '\\begin{document}' >> build_fisicas.tex; \
	for inc in $(FISICAS_INCLUDES); do echo "\\include{$$inc}" >> build_fisicas.tex; done; \
	echo "\\end{document}" >> build_fisicas.tex; \
	mkdir -p fisicas; \
	$(TEX) build_fisicas.tex >/dev/null; $(TEX) build_fisicas.tex >/dev/null; \
	mv -f build_fisicas.pdf fisicas/fisicas.pdf; \
	@echo "Saved fisicas/fisicas.pdf"; \
	rm -f build_fisicas.aux build_fisicas.log build_fisicas.out build_fisicas.toc build_fisicas.tex build_fisicas.synctex.gz || true

.PHONY: list
list:
	@echo "Available parts: calculos, fisicas"
	@echo "Example: make <subdir> cap<num>  (e.g. make fisicaiii cap30)"

.PHONY: clean distclean

clean:
	rm -f build_*.aux build_*.log build_*.out build_*.toc build_*.tex build_*.synctex.gz *.aux *.log || true

distclean: clean
	@echo "Cleaned project files (PDFs in discipline folders preserved)"

.PHONY: help
help:
	@sed -n '1,220p' Makefile
