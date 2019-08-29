export const allInSeq: <T>(
  promises: Array<Promise<T>>
) => Promise<T> = promises => {
  return promises.reduce((promise1, promise2) => promise1.then(_ => promise2));
};
