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
	browserify/build.1.js \
	browserify/build.2.coffee \
	browserify/build.out.js
	# 4: testing...
	@cd browserify && npm install && npm test

browserify/build.1.js: browserify/simple.js

%/build.1.js: %/simple.js
	# 1: bundle... [$<      > $@]
	@$(browserify) -s mod $< | $(uglifyjs) -b > $@

# ----
eventemitter2@test: \
	eventemitter2/build.1.js \
	eventemitter2/build.2.coffee \
	eventemitter2/build.out.js
	# 4: testing...
	@cd eventemitter2 && npm install && npm test

eventemitter2/build.1.js: eventemitter2/index.js
	# 1: bundle... [$<       > $@]
	@$(browserify) -s eventemitter2 $< | $(uglifyjs) -b > $@

# ----
qs@test: \
	qs/build.1.js \
	qs/build.2.coffee \
	qs/build.out.js
	# 4: testing...
	@cd qs && npm install && npm test

qs/build.1.js: qs/index.js
	# 1: bundle... [$<       > $@]
	@$(browserify) -s qs $< | $(uglifyjs) -b > $@

# ----
%.out.js: %.2.coffee
	# 3: coffee... [$< > $@]
	@$(coffee) -p $< > $@

%.2.coffee: %.1.js
	# 2: js2c...   [$<     > $@]
	@$(js2c) $< > $@

.PHONY: dummy
