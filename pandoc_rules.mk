#
# pandoc_rules.mk
#

#
# pandoc md->html
#

%.html: %.md
	pandoc $< -o $@ -t html5 -s --mathjax --css=/shared/style.css

#
# default top level rule 'html', run on all .md files;
# 'clean' removes all .html files
# 

html_targets = $(patsubst %.md,%.html,$(wildcard *.md))

.PHONY: html
html: $(html_targets)

.PHONY: clean
clean:
	rm -f $(html_targets)


#
# implementation notes
#

# $* stem of implicit rule match 
# $@ target 
# $< first prerequisite

# Note: pandoc flag --css should point to absolute path to css file, since we
# may be building from a subdir.  As a result, web server must be run from root,
# i.e. it won't work to serve a subdir independently.

# Note: tried to use pandoc default file, but ran into path issues when running
# pandoc from subdir.
#	pandoc $< -o $@ -d html_defaults


