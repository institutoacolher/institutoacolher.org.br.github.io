# Nota 1: A pasta final com os arquivos HTML foi alterada para docs para
# atender os requisitos do github pages.

.PHONY: all deps update css js preview check docs

all: preview update deps css js
	pug --watch *.pug --obj componentes/membros.js --out docs/ --pretty

deps:
	npm install
	mkdir -p docs/img
	cp img/* docs/img/
	mkdir -p docs/css
	cp _variables.scss node_modules/materialize-css/sass/components/_variables.scss

css:
	sass node_modules/materialize-css/sass/materialize.scss docs/css/materialize.css
	sass scss/style.scss docs/css/style.css
	cp node_modules/animate.css/animate.min.css docs/css/

js:
	cp node_modules/wowjs/dist/wow.min.js       docs/js/

preview:
	google-chrome $(PWD)/docs/index.html &
	git gui &

update:
	rm -rf     docs/
	mkdir -p   js css img
	mkdir -p   docs/
	cp -r js   docs/
	cp -r css  docs/
	cp -r img  docs/

check:
	linkchecker docs/

docs:
	tar zcvf docs.tgz -C docs .
