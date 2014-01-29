build:
	node_modules/.bin/coffee -co build src/*.coffee
	
build-watch:
	node_modules/.bin/coffee  -cwo build src/*.coffee
	
test:
	node_modules/.bin/mocha \
		--compilers coffee:coffee-script \
		--reporter spec \
		test
		
example:
	tsc example/example.ts \
		--module CommonJS
	
.PHONY: build test example