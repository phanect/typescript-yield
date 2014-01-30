declare function yield<T>(result: T): T;

declare module suspend {
	export interface IResume<T> {
		(err: any, result: T);
		(err: any);
		();
	}
	
	export interface IResumeRaw {
		(result: any);
		();
	}
	
	export function resume<T>(): IResume<T>;
	export function fork<T>(): IResume<T>;
	export function run(fn: Function);
	// TODO type this somehow
	export function join(): any[]
	export function resumeRaw(): IResumeRaw;
	export function async<F>(fn: F): F;
	export function fn<F>(fn: F): F;
}

// CommonJS version
declare module 'suspend' {
	export = suspend;
}
