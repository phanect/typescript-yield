funcs = require './functions'
path = require 'path'
fs = require 'fs'
params = require 'commander'
writestreamp = require 'writestreamp'

params
	# TODO read version from package.json
	.version('0.2.1')
  .usage('-o <dir> source1 [ source2 ]')
  .option('-w, --watch', 'Watch for file changes')
	.option('-o, --output-dir <dir>', 
		'Output directory for the built files (required)')
	.parse(process.argv)

if not params.outputDir
  params.help()

params.args.forEach (source) ->

	file = path.join process.cwd(), source
	target = path.join params.outputDir or process.cwd(), source
  
	exec = (curr, prev) ->
		if fs.statSync(file).isFile()
			fs.readFile file, encoding: 'utf8', (arr, content) ->
				content = funcs.unwrapYield content
				content = funcs.markGenerators content
				destination = writestreamp target
				destination.write content, destination.end.bind destination

	# TODO locks map
	if params.watch
		# TODO use fs.watch when stable
		fs.watchFile file, persistent: yes, interval: 500, exec
		exec()
	else
		exec()
