#!/usr/bin/env node --harmony

funcs = require './functions'
params = require 'commander'
glob = require 'glob'
suspend = require 'suspend'
go = suspend.resume
assert = require 'assert'

params
	# TODO read version from package.json
	.version('0.2.1')
  .usage('-i <src> [-o <dir>')
	.option('-i, --source <src>', 
		'Input file or directory')
	.option('-o, --output-dir <dir>', 
		'Output directory for the built files (required)')
	.parse(process.argv)

if not params.sourceDir or not params.buildDir 
	return params.help()

if params.yield and params.pack 
	return params.help()

main = suspend ->
	# TODO doesnt glob subdirs?
	files = yield glob '**/*.coffee', {cwd: params.sourceDir}, go()
	assert files.length, "No files to precess found"
	builder = new Builder files, params.sourceDir, params.buildDir, params.pack,
		params.yield
	
	# run
	if params.watch
		yield builder.watch go()
	else 
		yield builder.build go()
		console.log "Compilation completed"
		
main()

###
TODO
  var files input
	watch files
  watch definitions
  flowless restart (clock)
  ...
  typescript service integration? (via memory, not just files)
  merge command line tools directly to this event loop
  watch changes throttling support
###