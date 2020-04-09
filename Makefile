#
# Makefile
#

# $* stem of implicit rule match 
# $@ target 
# $< first prerequisite


subdirs = pyramid
subdirs_clean = $(addsuffix _clean,$(subdirs))

html_targets = $(patsubst %.md,%.html,$(wildcard *.md))

html: $(subdirs) $(html_targets)
	mkdir -p html
	cp -r shared $(subdirs) $(html_targets) html
	
# TODO: combine this rule with pyramid/Makefile (fix path)
%.html: %.md
	pandoc $< -o $@ -t html5 -s --mathjax --css=shared/style.css

$(subdirs):
	$(MAKE) -C $@

$(subdirs_clean):
	$(MAKE) -C $(subst _clean,,$@) clean

clean: $(subdirs_clean)
	rm -rf html
	rm $(html_targets)

.PHONY: html $(subdirs) $(subdirs_clean) clean 


