/// <reference path="../d.ts/node.d.ts"/>
/// <reference path="../d.ts/suspend.d.ts"/>
/// <reference path="example-externs.d.ts"/>

import suspend = require('suspend');

var a = yield(foo(true, suspend.resume()));
a = yield(foo('warning', suspend.resume()));
var b = yield(bar(true, suspend.resume()));
b = yield(bar('warning', suspend.resume()));

var foo = suspend.async(function(param: boolean, next: suspend.IResume): boolean {
	return true;
});
