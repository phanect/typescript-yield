/// <reference path="../d.ts/node.d.ts"/>
/// <reference path="../d.ts/suspend.d.ts"/>
/// <reference path="example-externs.d.ts"/>
var suspend = require('suspend');

// Local function examples
function generators1() {
    var a = yield(foo(true, suspend.resume()));
    a = yield(foo('warning', suspend.resume()));
}

// External function examples
function generators2() {
    var b = yield(bar(true, suspend.resume()));
    b = yield(bar('warning', suspend.resume()));
}

var foo = suspend.async(function (param, next) {
    return true;
});

