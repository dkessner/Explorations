#
# Makefile
#

subdirs = pyramid
subdirs_clean = $(addsuffix .clean,$(subdirs))

#
# default build: 
# 	- make local html files
# 	- run make recursively in each subdir
# 	- stage everything in 'html' directory
#

all: html $(subdirs)
	mkdir -p html
	cp -r shared $(subdirs) $(html_targets) html

#
# define $(html_targets), html/clean rules for .md files in root dir
#

include pandoc_rules.mk 	


#
# recursive make rules
#
	
$(subdirs):
	$(MAKE) -C $@

$(subdirs_clean):
	$(MAKE) -C $(subst .clean,,$@) clean

clean: $(subdirs_clean) clean_html	# note: adds prereqs, but doesn't override rule

clean_html:
	rm -rf html

.PHONY: all $(subdirs) $(subdirs_clean) clean_html


# $* stem of implicit rule match 
# $@ target 
# $< first prerequisite


