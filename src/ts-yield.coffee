###
Transforms `yield(foo(params), resume())` into `yield foo(params, resume())` 
###
unwrapYield = (input) ->
	level_up_chars = ['[', '(']
	level_down_chars = [']', ')']
	output = ''
	pos_end = 0
	
	while ~pos = input.indexOf 'yield(', pos_end
		# copy the previous chunk
		output += input.slice pos_end, pos
		output += 'yield '
		# level is 1, as we're skipping the first parenthesis
		level = 1
		pos_last_comma = null
		# start where the yield ends
		i = pos+6
		while char = input[i++]
			if ~level_up_chars.indexOf char
				level++
			else if ~level_down_chars.indexOf char
				level--
				
			pos_last_comma = i-1 if char is ','
			
			if level is 0
				pos_end = i-1
				break
		# copy the yielded value, without the fake-yield closing parenthesis
		output += input.slice pos + 6, pos_last_comma
		# copy the generator callback
		output += input.slice pos_last_comma, pos_end - 1
		
	# copy rest of the input string
	output += input.slice pos_end
		
	output
		
###
Transforms `function() { yield 1; }` into `function*() { yield 1; }`.
###
markGenerators = (input) ->
	output = ''
	level_up_chars = ['{']
	level_down_chars = ['}']
	# end is lover than pos, as its a reverse search
	pos_end = 0
	pos_previous = 0
	while ~pos = input.indexOf 'yield ', pos_previous + 1
		level = 0
		search_fuction = no
		i = pos
		double_yield = no
		while char = input[i--]
			if not search_fuction
				if ~level_up_chars.indexOf char
					level--
				else if ~level_down_chars.indexOf char
					level++
				
				if level is -1
					search_fuction = yes
					
				# TODO optimize
				double_yield = pos if (input.slice i, i + 6) is 'yield '
				break if double_yield
			else
				# TODO optimize
				# search for a "function" string 
				if (input.slice i + 1, i + 9) is 'function'
					pos_end = i + 1
					break

		# TODO check if the function is already a generator
		if double_yield
			output += input.slice pos_previous, pos
		else 
			output += input.slice pos_previous, pos_end
			output += "function*"
			output += input.slice pos_end + 8, pos
		
		pos_previous = pos
		
	# copy rest of the input string
	output += input.slice pos_previous
		
	output

module.exports = {markGenerators, unwrapYield}
