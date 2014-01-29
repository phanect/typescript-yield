// TODO Module
declare function yield<T>(result: T): T;

declare module suspend {
	export interface IResume {
		(err: any, result: any);
	}
	
	export interface IResumeRaw {
		(result: any);
	}
	
	export function resume(): IResume;
	export function resumeRaw(): IResumeRaw;
	export function async<F>(fn: F): F;
}

declare module 'suspend' {
	export = suspend;
}
