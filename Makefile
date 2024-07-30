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

# ######################################################################
# # FONTS                                                              #
# ######################################################################

# Usage: make font FONT=<font name> OUTPUT=<output prefix>
.PHONY: font
font:
	@magick \
		-size 1280x960 \
		canvas:"#1e1e2e" \
		\( -size 1200x900 \
				-background none \
				-fill "#b4befe" \
				-font "$(FONT)" \
				-pointsize 92 \
				-gravity northwest \
				label:@misc/font_1.txt \) \
		-gravity northwest \
		-geometry +40+30 \
		-composite \
		$(OUTPUT)_1@2x.png
	@magick \
		-size 1280x960 \
		canvas:"#1e1e2e" \
		\( -size 1200x900 \
				-background none \
				-fill "#b4befe" \
				-font "$(FONT)" \
				-pointsize 142 \
				-gravity northwest \
				label:@misc/font_2.txt \) \
		-gravity northwest \
		-geometry +40+30 \
		-composite \
		$(OUTPUT)_2@2x.png
	@magick \
		-size 1280x960 \
		canvas:"#1e1e2e" \
		\( -size 1200x900 \
				-background none \
				-fill "#b4befe" \
				-font "$(FONT)" \
				-pointsize 32 \
				-gravity northwest \
				label:@misc/font_3.txt \) \
		-gravity northwest \
		-geometry +40+30 \
		-composite \
		$(OUTPUT)_3@2x.png
