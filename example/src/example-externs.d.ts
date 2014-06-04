/// <reference path="../../d.ts/suspend.d.ts"/>

// Real declaration, with a callback.
declare function bar(param: boolean, 
	callback: (err: any, result: string) => void);
// Yieldable overload, hidding the callback.
declare function bar(param: boolean, callback: suspend.IResume<string>): string;