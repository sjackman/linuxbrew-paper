pandoc_opt=-Fpandoc-citeproc

.DELETE_ON_ERROR:
.SECONDARY:

all: linuxbrew.html

clean:
	rm -f linuxbrew.html linuxbrew.pdf linuxbrew-supp.html linuxbrew-supp.pdf

# Download the citation style language (CSL).
linuxbrew.csl:
	curl -o $@ https://www.zotero.org/styles/bioinformatics

# Render Markdown to HTML using Pandoc.
%.html: %.md
	pandoc $(pandoc_opt) -s -o $@ $<

# Render Markdown to PDF using Pandoc.
%.pdf: %.md
	pandoc $(pandoc_opt) -o $@ $<

# Generate Table of Contents for supplemental material only
linuxbrew-supp.pdf: linuxbrew-supp.md
	pandoc $(pandoc_opt) --toc -o $@ $<

# Render Markdown to DOCX using Pandoc.
%.docx: %.md
	pandoc $(pandoc_opt) -o $@ $<

# Render RMarkdown to HTML using R.
%.html: %.rmd
	RScript -e 'rmarkdown::render("$<")'

linuxbrew.docx: linuxbrew.bib linuxbrew.csl
linuxbrew.html: linuxbrew.bib linuxbrew.csl
linuxbrew.pdf: linuxbrew.bib linuxbrew.csl

linuxbrew-supp.docx: linuxbrew.bib linuxbrew.csl
linuxbrew-supp.html: linuxbrew.bib linuxbrew.csl
linuxbrew-supp.pdf: linuxbrew.bib linuxbrew.csl
