#-------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES BELOW
#-------------------------------------------------------------------------------
PANDOC ?= pandoc
PROJECT ?= texte_devoir_fin_session.md
BIBLIOGRAPHY ?= bibliography.bib
BIB_STYLE ?= universita-pontificia-salesiana-fr
TEMPLATE ?= template/custom-reference.docx
#------------  -------------------------------------------------------------------
# ENVIRONMENT   VARIABLES ABOVE
#------------  -------------------------------------------------------------------

# only docx output
OUTPUT=$(addprefix output/,$(PROJECT:.md=.docx))

# Filters Used by pandoc
DIAGRAM_FILTER_LINK=https://raw.githubusercontent.com/pandoc/lua-filters/master/diagram-generator/diagram-generator.lua
DIAGRAM_FILTER=filters/diagram-generator.lua
FILTERS=$(DIAGRAM_FILTER)

# Bibliography
BIB_CSL_LINK=https://www.zotero.org/styles
BIB_STYLE_FILE=$(addprefix styles/,$(addsuffix .csl,$(BIB_STYLE)))

.PHONY: all
all: $(OUTPUT)

.PHONY: clean
clean:
	@rm -rf filters || true
	@rm -rf output || true
	@rm -rf styles || true


.PHONY: filters
filters: $(FILTERS)

$(BIB_STYLE_FILE):
	@mkdir -p $(dir $(BIB_STYLE_FILE))
	@wget $(addprefix $(BIB_CSL_LINK)/,$(BIB_STYLE)) --output-document=$@

$(DIAGRAM_FILTER):
	@echo Getting diagram filter
	@mkdir -p $(dir $(DIAGRAM_FILTER))
	@wget $(DIAGRAM_FILTER_LINK) --output-document=$(DIAGRAM_FILTER)

$(OUTPUT): $(PROJECT) $(DIAGRAM_FILTER) $(BIB_STYLE_FILE)	$(BIBLIOGRAPHY)
	@mkdir -p $(dir $@)
	@$(PANDOC) \
		--csl=$(BIB_STYLE_FILE) \
		--bibliography=$(BIBLIOGRAPHY) \
	    --lua-filter=$(DIAGRAM_FILTER) \
		--reference-doc=$(TEMPLATE) \
	    --output=$@ $<
