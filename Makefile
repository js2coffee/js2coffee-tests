js2c       = ../js2coffee/node_modules/.bin/js2coffee
js2c       = ../js2coffee-redux/bin/js2c
coffee     = ./node_modules/.bin/coffee
mocha      = ./node_modules/.bin/mocha -R spec
browserify = ./node_modules/.bin/browserify
uglifyjs   = ./node_modules/.bin/uglifyjs

browserify@test: \
	browserify@build
	$(mocha) browserify/test.js

browserify@build: \
	browserify/build.js \
	browserify/build.out.coffee \
	browserify/build.out.js \
	dummy

browserify/build.js: browserify/simple.js
	$(browserify) -s mod $< | $(uglifyjs) -b > $@

%.out.js: %.out.coffee
	$(coffee) -p $< > $@

%.out.coffee: %.js
	$(js2c) $< > $@

dummy:
.PHONY: dummy
