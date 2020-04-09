#
# Makefile (pyramid)
#


html_targets = $(patsubst %.md,%.html,$(wildcard *.md))

all: $(html_targets)

#html: $(html_targets)
#	@echo Targets: $(targets)
#	mkdir -p html
#	cp *.html *.pde html
#	cp ../share/processing.min.js html

%.html: %.md
	pandoc $< -o $@ -t html5 -s --mathjax --css=../shared/style.css

clean:
	rm -f $(html_targets)
	rm -rf html

.PHONY: all html clean

