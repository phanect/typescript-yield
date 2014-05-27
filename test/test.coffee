{expect} = require 'chai'
{markGenerators, unwrapYield} = require '../src/functions.coffee'

input1 = """
/// <reference path="yield.d.ts"/>
/// <reference path="externs.d.ts"/>

var a = yield(foo(true, resume()));
a = yield(foo('warning', resume()));
var b = yield(bar(true, resume()));
b = yield(bar('warning', resume()));

var foo = async(function (param, next) {
    return true;
});
"""

input2 = """
/// <reference path="yield.d.ts"/>
/// <reference path="externs.d.ts"/>
function foo() {
	alert('foo');
	a = yield bar('warning', resume());
	b = yield foo('warning', resume());
	alert('bar');
}

function bar() {
	alert('foo');
	a = yield foo('warning', resume());
	b = yield bar('warning', resume());
	alert('bar');
}
alert('bar');
"""

describe 'TypeScript yield', ->
	output = ''
	
	describe 'unwrapping yield', ->
		
		before ->
			output = unwrapYield input1
			
		it 'should remove parenthesis', ->
			expect(output).not.to.contain 'yield('
			
		it 'should perserve rest of the yielded function\'s params', ->
			expect(output).to.contain "foo('warning', resume());"
			expect(output).to.contain "foo('warning', resume());"
			expect(output).to.contain 'bar(true, resume());'
			expect(output).to.contain "bar('warning', resume());"
		
		it 'shouldn\'t change rest of the codebase', ->
			expect(output).to.contain "var foo = async(function (param, next) {"
			expect(output).to.contain '/// <reference path="yield.d.ts"/>'
			expect(output).to.contain "var b = yield"
			expect(output).to.contain "var a = yield"
		
	describe 'marking function as generators', ->
		
		before ->
			output = markGenerators input2
			
		it 'should add a * to the function keyword', ->
			expect(output).to.contain 'function* foo() {'
			expect(output).to.contain 'function* bar() {'
			
		it 'should support multiple yields in the same function', ->
			expect(output).to.contain "a = yield foo('warning', resume());"
			expect(output).to.contain "b = yield bar('warning', resume());"
			
		it 'shouldn\'t change rest of the codebase', ->
			expect(output).to.contain "bar() {\n\talert('foo');"
			expect(output).to.match /\nalert\('bar'\);$/
			expect(output).to.match /^\/\/\/ <reference path="yield.d.ts"\/>/

	describe 'compilation', ->
		describe 'of external functions', ->
			describe 'with a callback', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
			describe 'suspended', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
			describe 'with a promise', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
		describe 'of declared functions', ->
			describe 'with a callback', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
			describe 'suspended', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
			describe 'with a promise', ->
				it 'should identify incorrect params'
				it 'should identify incorrect return'
			