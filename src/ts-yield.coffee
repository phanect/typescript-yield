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
		'Output directory for the built files')
	.parse(process.argv)

compile = (files, cwd, out) ->
	files.forEach (source) ->
		file = path.join cwd, source
		target = path.join out, source
	
		exec = (curr, prev) ->
			stats = fs.statSync file
			if stats.isFile()
				fs.readFile file, encoding: 'utf8', (arr, content) ->
					content = funcs.unwrapYield content
					content = funcs.markGenerators content
					destination = writestreamp target
					destination.write content, destination.end.bind destination
			else if stats.isDirectory()
				files_in_dir = fs.readdirSync(file)
				o = path.join out, source

				compile(files_in_dir, file, o)

		# TODO locks map
		if params.watch
			# TODO use fs.watch when stable
			fs.watchFile file, persistent: yes, interval: 500, exec
			exec()
		else
			exec()

cwd = process.cwd()
out = params.outputDir or cwd
compile params.args, cwd, out
