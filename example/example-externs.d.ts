// Real declaration, with a callback.
declare function bar(param: boolean, 
	callback: (err: any, result: string) => void);
// Yieldable overload, hidding the callback.
declare function bar(param: boolean): string;