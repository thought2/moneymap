export const allInSeq: <T>(
  promises: Array<Promise<T>>
) => Promise<T> = promises => {
  return promises.reduce((promise1, promise2) => promise1.then(_ => promise2));
};

type T<T1, T2> = (x: T1) => Promise<T2>;

export const wrap: <T1, T2, T3, T4>(
  before: T<T1, T2>,
  after: T<T3, T4>
) => (promise: T<T2, T3>) => T<T1, T4> = (before, after) => middle => x =>
  Promise.resolve(x)
    .then(before)
    .then(middle)
    .then(after);
