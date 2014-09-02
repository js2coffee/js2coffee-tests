js2c       = ../js2coffee/node_modules/.bin/js2coffee
js2c       = ../js2coffee-redux/bin/js2c
coffee     = ./node_modules/.bin/coffee
browserify = ./node_modules/.bin/browserify
uglifyjs   = ./node_modules/.bin/uglifyjs

test: \
	browserify@test \
	qs@test

# ----
browserify@test: \
	browserify/build.js \
	browserify/build.out.coffee \
	browserify/build.out.js
	# 4: testing...
	@cd browserify && npm install && npm test

browserify/build.js: browserify/simple.js dummy
	# [browserify] 1: browserify...
	@$(browserify) -s mod $< | $(uglifyjs) -b > $@

# ----
qs@test: \
	qs/build.js \
	qs/build.out.coffee \
	qs/build.out.js
	# 4: testing...
	@cd qs && npm install && npm test

qs/build.js: qs/index.js
	# [qs] 1: browserify...
	@$(browserify) -s qs $< | $(uglifyjs) -b > $@

# ----
%.out.js: %.out.coffee
	# 3: coffee...
	@$(coffee) -p $< > $@

%.out.coffee: %.js
	# 2: js2c...
	@$(js2c) $< > $@

.PHONY: dummy
