export const allInSeq: <T>(
  promises: Array<() => Promise<T>>
) => Promise<Array<T>> = promises => {
  return promises.reduce(
    (promise1, func) =>
      promise1.then(accum => func().then(result => accum.concat(result))),
    Promise.resolve([] as any)
  );
};

// Array.prototype.concat.bind(result)

Promise.all;
