build:
	node_modules/.bin/coffee -c -o build src/*.coffee
	
test:
	node_modules/.bin/mocha test
	
.PHONY: build