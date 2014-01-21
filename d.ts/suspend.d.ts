declare function yield<T>(result: T, resume: Function): T;
declare function resume(): Function;
declare function async<F>(fn: F): F;
