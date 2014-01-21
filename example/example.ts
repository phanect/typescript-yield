/// <reference path="../d.ts/suspend.d.ts"/>
/// <reference path="example-externs.d.ts"/>
 
var a = yield(foo(true), resume());
a = yield(foo('warning'), resume());
var b = yield(bar(true), resume());
b = yield(bar('warning'), resume());

var foo = async(function(param: boolean): boolean {
	return true;
});
