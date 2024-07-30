# ######################################################################
# # ALL                                                                #
# ######################################################################

# Usage: make all
.PHONY: all
all:
	@rm -rf ../content/notes/*
	@./export.el 'notes/*.org'

# ######################################################################
# # WATCH                                                              #
# ######################################################################

# Usage: make watch
.PHONY: watch
watch:
	@while sleep 0.1; do git ls-files -cdmo --exclude-standard | entr -cdp ./export.el /_; done
