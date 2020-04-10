#
# pandoc_rules.mk
#

#
# pandoc rule md->html
#

my_dir = $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

%.html: %.md
	pandoc $< -o $@ -t html5 -s --mathjax --css=/shared/style.css -B $(my_dir)/shared/before_body.html

#
# Note: pandoc flag --css should point to absolute path from website root to
# css file, since this will be converted to an html <style> element to read the
# .css file.  
#
# However, -B (--include-before-body) needs the local path to the 'shared' dir.
#

#
# Default top level rule 'html', run on all .md files;
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

# Note: tried to use pandoc default file, but ran into path issues when running
# pandoc from subdir.
#	pandoc $< -o $@ -d html_defaults


