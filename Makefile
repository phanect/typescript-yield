build:
	node_modules/.bin/coffee -co build src/*.coffee
	
build-watch:
	node_modules/.bin/coffee  -cwo build src/*.coffee
	
test:
	node_modules/.bin/mocha \
		--compilers coffee:coffee-script \
		--reporter spec \
		test
		
example-compile:
	tsc example/src/example.ts \
		--module CommonJS
		
example-fix-yields:
	cd example/src && ../../bin/ts-yield example.js -o ../build
	
.PHONY: build test example