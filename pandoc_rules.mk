#
# pandoc_rules.mk
#

#
# pandoc rule md->html
#

my_dir = $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

%.html: %.md
	pandoc $< -o $@ --resource-path=$(my_dir)/shared --template=$(my_dir)/shared/default.html --defaults=$(my_dir)/shared/pandoc_html_defaults.yaml

#
# Notes: 
#
# pandoc flag --css should point to absolute path from website root to
# css file, since this will be converted to an html <style> element to read the
# .css file.  
#
# -B (--include-before-body) needs the local path to the 'shared' dir.
# When using this in defaults file, pandoc searches "resource path" for the file to include.
#
# Command line without defaults file:
#   pandoc $< -o $@ -t html5 -s --mathjax --css=/shared/style.css -B $(my_dir)/shared/before_body.html
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


