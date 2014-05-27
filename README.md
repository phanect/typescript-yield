Transpiler that helps using the ES6 yield statement in TypeScript today. Works 
well with the [suspend](https://github.com/jmar777/suspend) library.

### Features
- full type awareness (input params, return value)
- needs only small d.ts changes (signature overload)
- simply use yield as a function, with a callback as a last param

### Install

```
npm install typescript-yield
```

### Usage
```
ts-yield -o build src/**.js
```

### Example

```
var async = require('suspend').async;

var foo = async(function(param: boolean): boolean {
	return true;
});

var a: boolean = yield(foo(true), resume());
```

See `make example-fix-yield`.

### Definition file preparation
- find all callback and promise async functions
- refactor callback param value to be function's return value
- refactor promise generic type to be function's return value

### Limitations
- dont use "yield" anywhere else in the codebase! (like strings)

### TODO
- rewrite to jsfmt?
