type Task<T> = () => Promise<T>;

export interface AwaitQueue {
    await<T>(task: Task<T>): Promise<T>;
}
export default function awaitQueue(): AwaitQueue{
    let promiseChain: Promise<unknown> = Promise.resolve();

    return {
        async await<T>(task: Task<T>): Promise<T> {
            promiseChain = promiseChain.then(task);
            return promiseChain as Promise<T>;
        }
    }
}