SHELL := /bin/bash

MAIN := main.tex
BUILD_DIR := build
PDF_BASENAME ?= analysis2_fs2026_hliddal
OUTPUT_PDF := $(PDF_BASENAME).pdf
OUTPUT_SYNC := $(PDF_BASENAME).synctex.gz
BUILD_STAMP ?= $(shell date -u +%Y%m%dT%H%M%SZ)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo nogit)
LATEX_DEFS := \def\ZSFBuildStamp{$(BUILD_STAMP)}\def\ZSFGitCommit{$(GIT_COMMIT)}

.PHONY: build lint format check-main-full check-chapters check-root-clean check-pdf-identity check release-proof all test clean

build:
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -outdir=$(BUILD_DIR) -auxdir=$(BUILD_DIR) \
		-pdflatex="pdflatex %O '$(LATEX_DEFS)\input{%S}'" $(MAIN)
	@cp $(BUILD_DIR)/main.pdf "$(OUTPUT_PDF)"
	@if [ -f "$(BUILD_DIR)/main.synctex.gz" ]; then cp $(BUILD_DIR)/main.synctex.gz "$(OUTPUT_SYNC)"; fi

lint:
	chktex -q -n1 -n3 -n6 -n8 -n9 -n11 -n12 -n13 -n16 -n17 -n18 -n23 -n25 -n26 -n35 -n36 -n37 -n40 -n44 $(MAIN)

format:
	find . -name '*.tex' -print0 | xargs -0 latexindent -w -s -l=.latexindent.yaml

check-main-full:
	./tests/check_main_full.sh

check-chapters:
	./tests/check_chapter_rules.sh

check-root-clean:
	./tests/check_root_clean.sh

check-pdf-identity:
	PDF_FILE="$(OUTPUT_PDF)" ./tests/check_pdf_identity.sh

check: check-main-full check-chapters check-root-clean lint check-pdf-identity

release-proof:
	@mkdir -p $(BUILD_DIR)
	@shasum -a 256 $(BUILD_DIR)/main.pdf | awk '{print $$1}' > $(BUILD_DIR)/main.pdf.sha256
	@echo "Wrote $(BUILD_DIR)/main.pdf.sha256"

test:
	@echo "Usage: ./tests/run_test.sh <test_name>"
	@ls -1 tests/*.tex 2>/dev/null | sed 's|^tests/||' || true

clean:
	rm -rf $(BUILD_DIR) tests/build .*~ tests/.*~
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *.blg *.bcf *.run.xml
	rm -f *.pdf

all: build check
