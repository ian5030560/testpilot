import { expect } from "chai";
import awaitQueue from "../src/awaitQueue";

function sleep(ms: number){
    return new Promise(resolve => setTimeout(resolve, ms));
}

describe("test awaitQueue", () => {
    it("should execute tasks in order", async () => {
        const queue = awaitQueue();
        const order: number[] = [];

        const task1 = queue.await(async () => {
            await sleep(500);
            order.push(1);
        });
        const task2 = queue.await(async () => {
            await sleep(300);
            order.push(2);
        });
        const task3 = queue.await(async () => {
            await sleep(1000);
            order.push(3);
        });

        await Promise.all([task1, task2, task3]);

        expect(order).to.deep.equal([1, 2, 3]);
    });
});