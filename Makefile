
.PHONY: page git clean

work_dir = .pages

page: $(work_dir)/index.html

git: page
	cd $(work_dir);\
		if [ "$$(git status -s)" ]; then \
			git commit -am "Update to master branch" && git push; \
		fi

clean:
	-rm -r $(work_dir)

SRC_FILES = $(wildcard *.dot)
TGT_FILES = $(patsubst %.dot,$(work_dir)/%.svg,$(SRC_FILES))

$(work_dir)/index.html: index.html $(TGT_FILES) | $(work_dir)
	awk -f template.awk $< $(patsubst $(work_dir)/%,%,$(filter %.svg,$^)) > $@

$(work_dir)/%.svg: %.dot | $(work_dir)
	dot -Tsvg -o $@ $<

$(work_dir):
	git clone -s -b gh-pages . $(work_dir)
