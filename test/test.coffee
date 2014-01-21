{markGenerators, unwrapYield} = require '../src/ts-yield.coffee'

input1 = """
/// <reference path="yield.d.ts"/>
/// <reference path="externs.d.ts"/>

var a = yield(foo(true), resume());
a = yield(foo('warning'), resume());
var b = yield(bar(true), resume());
b = yield(bar('warning'), resume());

var foo = async(function (param) {
    return true;
});
"""

input2 = """
/// <reference path="yield.d.ts"/>
/// <reference path="externs.d.ts"/>
function foo() {
	alert('foo');
	a = yield foo('warning', resume());
	b = yield bar('warning', resume());
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
		it 'should remove parenthesis'
		it 'should move the callback to the function if present'
		it 'should identify a promise when there\'s no callback'
		it 'shouldn\'t change rest of the codebase'
		
	describe 'marking function as generators', ->
		before ->
			output = markGenerators input2
		it 'should add a * to the function keyword'
		it 'should support multiple yields in the same function'
		it 'shouldn\'t change rest of the codebase'
