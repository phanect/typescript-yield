Transpiler that helps using the ES6 yield statement in TypeScript today. Works 
well with the [suspend](https://github.com/jmar777/suspend) library.

## Features
- full type awareness (input params, return value)
- needs only small d.ts changes (signature overload)
- simply use yield as a function, with a callback as a last param

## Definition file preparation
- find all callback and promise async functions
- refactor callback param value to be function's return value
- refactor promise generic type to be function's return value

## Limitations
- dont use yield anywhere else in the codebase! (like strings)
