#
# pandoc_rules.mk
#

%.html: %.md
	pandoc $< -o $@ -t html5 -s --mathjax --css=/shared/style.css

# note: --css should point to absolute path to css file

# note: tried to use pandoc default file, but ran into path issues when running
# pandoc from subdir.
#	pandoc $< -o $@ -d html_defaults

