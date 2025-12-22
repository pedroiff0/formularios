# Minimal Makefile: only Cálculo and Física
# Supported:
#   make <subdir> cap<num>     (e.g. make fisicaiii cap30)
#   make <subdir>_<cap>        (e.g. make fisicaiii_cap30)
#   make calculos              (build all calculos)
#   make fisicas               (build all fisicas)
#   make all 

TEX=pdflatex

.SILENT:
MAKEFLAGS += -s

# Includes for calculos and fisicas
CALCULOS_INCLUDES = \
	calculos/calculoi/calculo_basico \
	calculos/calculoiv/calciv \

FISICAS_INCLUDES = \
	fisicas/fisicaiii/cap28 fisicas/fisicaiii/cap30 fisicas/fisicaiii/deducao_biot_savart \

# Basename dispatch
BASENAMES := $(sort $(notdir $(CALCULOS_INCLUDES) $(FISICAS_INCLUDES)))
.PHONY: $(BASENAMES)

# Subdirs
SUBDIRS_FISICAS := fisicaiii
SUBDIRS_CALCULOS := calculoi calculoiv
.PHONY: $(SUBDIRS_FISICAS) $(SUBDIRS_CALCULOS)

# Delegate to helper script
$(SUBDIRS_FISICAS):
	@scripts/build_chapter.sh $@ $(word 2,$(MAKECMDGOALS))

$(SUBDIRS_CALCULOS):
	@scripts/build_chapter.sh $@ $(word 2,$(MAKECMDGOALS))

.PHONY: cap% all
cap%:
	@:

# Support building per-chapter targets for disciplines
# Usage examples:
#   make disciplinas=calculos
#   make disciplinas=calculos,fisicas
# This will build each chapter individually and silently (producing files like
# <module>_<basename>.pdf saved in their respective folders).
# Pattern rule: target names like module_basename will call build_chapter.sh
# e.g., make fisicaiii_cap30 -> scripts/build_chapter.sh fisicaiii cap30
%_%:
	@name=$@; module=$${name%%_*}; token=$${name#*_}; \
	if [ -n "$(VERBOSE)" ]; then \
		echo "Building $$module $$token"; \
		scripts/build_chapter.sh "$$module" "$$token" || (echo "Failed: $$module $$token" >&2; exit 1); \
	else \
		scripts/build_chapter.sh "$$module" "$$token" >/dev/null 2>&1 || (echo "Failed: $$module $$token" >&2; exit 1); \
	fi

# If 'disciplines' or 'disciplinas' is set on the command line, make it the default goal
ifeq ($(origin disciplines), command line)
.DEFAULT_GOAL := disciplines
endif
ifeq ($(origin disciplinas), command line)
.DEFAULT_GOAL := disciplinas
endif

# Compose lists of per-chapter targets from the include lists (do not modify includes)
CALCULOS_TARGETS := $(subst /,_,$(patsubst calculos/%,%,$(CALCULOS_INCLUDES)))
FISICAS_TARGETS := $(subst /,_,$(patsubst fisicas/%,%,$(FISICAS_INCLUDES)))
.PHONY: $(CALCULOS_TARGETS) $(FISICAS_TARGETS)

# Determine which targets to build based on the 'disciplines' (english) or 'disciplinas' (pt) variable.
CHOICE := $(strip $(if $(strip $(disciplines)),$(disciplines),$(disciplinas)))
ifeq ($(CHOICE),)
DISCIPLINE_TARGETS := $(CALCULOS_TARGETS) $(FISICAS_TARGETS)
else
ifneq (,$(findstring calculos,$(CHOICE)))
DISCIPLINE_TARGETS += $(CALCULOS_TARGETS)
endif
ifneq (,$(findstring fisicas,$(CHOICE)))
DISCIPLINE_TARGETS += $(FISICAS_TARGETS)
endif
endif

.PHONY: disciplinas
disciplinas:
	@C="$(strip $(disciplines) $(disciplinas))"; \
	C="$$(echo $$C | sed 's/,/ /g')"; \
	if [ -z "$$C" ]; then C="calculos fisicas"; fi; \
	for d in $$C; do \
		if [ "$$d" = "calculos" ]; then \
			for inc in $(CALCULOS_INCLUDES); do \
				module=$$(echo $$inc | cut -d'/' -f2); base=$$(echo $$inc | cut -d'/' -f3); \
				if [ -n "$(VERBOSE)" ]; then echo "Building $$module $$base"; scripts/build_chapter.sh "$$module" "$$base" || exit 1; else scripts/build_chapter.sh "$$module" "$$base" >/dev/null 2>&1 || exit 1; fi; \
			done; \
		elif [ "$$d" = "fisicas" ]; then \
			for inc in $(FISICAS_INCLUDES); do \
				module=$$(echo $$inc | cut -d'/' -f2); base=$$(echo $$inc | cut -d'/' -f3); \
				if [ -n "$(VERBOSE)" ]; then echo "Building $$module $$base"; scripts/build_chapter.sh "$$module" "$$base" || exit 1; else scripts/build_chapter.sh "$$module" "$$base" >/dev/null 2>&1 || exit 1; fi; \
			done; \
		else \
			echo "Unknown discipline: $$d" >&2; exit 1; \
		fi; \
	done

.PHONY: disciplines
disciplines: disciplinas

all: main.pdf disciplinas

# Combined builds
.PHONY: calculos
calculos:
	@printf '%s\n' '\documentclass[a4paper]{report}' > build_calculos.tex
	@printf '%s\n' '\usepackage{latexconfig/forms}' >> build_calculos.tex
	@printf '%s\n' '\begin{document}' >> build_calculos.tex
	@for inc in $(CALCULOS_INCLUDES); do echo "\include{$$inc}" >> build_calculos.tex; done
	@echo "\end{document}" >> build_calculos.tex
	@mkdir -p calculos
	@$(TEX) build_calculos.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@$(TEX) build_calculos.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@if [ -f build_calculos.pdf ]; then mv -f build_calculos.pdf calculos/calculos.pdf; echo "Saved calculos/calculos.pdf"; else echo 'Error: build_calculos.pdf not generated' >&2; exit 1; fi
	@rm -f build_calculos.aux build_calculos.log build_calculos.out build_calculos.toc build_calculos.tex build_calculos.synctex.gz || true
	@find calculos -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' \) -delete || true

.PHONY: fisicas
fisicas:
	@printf '%s\n' '\documentclass[a4paper]{report}' > build_fisicas.tex
	@printf '%s\n' '\usepackage{latexconfig/forms}' >> build_fisicas.tex
	@printf '%s\n' '\begin{document}' >> build_fisicas.tex
	@for inc in $(FISICAS_INCLUDES); do echo "\include{$$inc}" >> build_fisicas.tex; done
	@echo "\end{document}" >> build_fisicas.tex
	@mkdir -p fisicas
	@$(TEX) build_fisicas.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@$(TEX) build_fisicas.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@if [ -f build_fisicas.pdf ]; then mv -f build_fisicas.pdf fisicas/fisicas.pdf; echo "Saved fisicas/fisicas.pdf"; else echo 'Error: build_fisicas.pdf not generated' >&2; exit 1; fi
	@rm -f build_fisicas.aux build_fisicas.log build_fisicas.out build_fisicas.toc build_fisicas.tex build_fisicas.synctex.gz || true
	@find fisicas -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' \) -delete || true

.PHONY: combined
# Build a single PDF that contains both calculos and fisicas together (like a full book)
# Usage: make combined
combined:
	@printf '%s\n' '\documentclass[a4paper]{report}' > build_combined.tex
	@printf '%s\n' '\usepackage{latexconfig/forms}' >> build_combined.tex
	@printf '%s\n' '\begin{document}' >> build_combined.tex
	@echo '\chapter{Cálculos}' >> build_combined.tex
	@for inc in $(CALCULOS_INCLUDES); do echo "\\include{$$inc}" >> build_combined.tex; done
	@echo '\chapter{Físicas}' >> build_combined.tex
	@for inc in $(FISICAS_INCLUDES); do echo "\\include{$$inc}" >> build_combined.tex; done
	@echo '\end{document}' >> build_combined.tex
	@$(TEX) build_combined.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@$(TEX) build_combined.tex >/dev/null || (echo 'pdflatex failed' >&2; exit 1)
	@if [ -f build_combined.pdf ]; then mv -f build_combined.pdf combined.pdf; echo "Saved combined.pdf"; else echo 'Error: build_combined.pdf not generated' >&2; exit 1; fi
	@rm -f build_combined.aux build_combined.log build_combined.out build_combined.toc build_combined.tex build_combined.synctex.gz || true
	@find . -maxdepth 3 -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' \) -delete || true
	@echo "Examples:"
	@echo "  make <subdir> cap<num> (e.g. make fisicaiii cap30)"
	@echo "  make <subdir> <chapter_basename> (e.g. make fisicaiii deducao_biot_savart)"
	@echo "  make disciplinas=calculos,fisicas (build combined PDFs for selected disciplines)"
	@echo "  make combined (build a single PDF that includes both calculos and fisicas)"
	@echo "  make all (build main.pdf and combined discipline PDFs)"

.PHONY: clean distclean

clean:
	rm -f build_*.aux build_*.log build_*.out build_*.toc build_*.tex build_*.synctex.gz *.aux *.log || true

distclean: clean
	@echo "Cleaned project files (PDFs in discipline folders preserved)"

.PHONY: help
help:
	@sed -n '1,220p' Makefile
