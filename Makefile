#
# Makefile
#

# $* stem of implicit rule match 
# $@ target 
# $< first prerequisite


subdirs = pyramid
subdirs_clean = $(addsuffix _clean,$(subdirs))

html: website $(subdirs)
	@echo Targets: $(targets)
	
website:
	mkdir -p html
	$(MAKE) -C website html
	cp website/html/* html
	
$(subdirs):
	mkdir -p html
	$(MAKE) -C $@ html
	cp -r $@/html html/$@

website_clean $(subdirs_clean):
	$(MAKE) -C $(subst _clean,,$@) clean

clean: website_clean $(subdirs_clean)
	rm -f $(targets)
	rm -rf html

.PHONY: html website $(subdirs) website_clean $(subdirs_clean) clean 


