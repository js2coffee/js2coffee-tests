js2c       = ../js2coffee/node_modules/.bin/js2coffee
coffee     = ./node_modules/.bin/coffee
mocha      = ./node_modules/.bin/mocha -R spec
browserify = ./node_modules/.bin/browserify

browserify@test: \
	browserify@build
	$(mocha) browserify/test.js

browserify@build: \
	browserify/build.js \
	browserify/build.out.coffee \
	browserify/build.out.js

browserify/build.js: browserify/simple.js
	$(browserify) $< > $@

%.out.js: %.out.coffee
	$(coffee) -p $< > $@

%.out.coffee: %.js
	$(js2c) $< > $@
