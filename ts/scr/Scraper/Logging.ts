import { wrap } from "../Promise";
import * as _ from "lodash";

export const log: <T>(
  depth: number,
  symbol: string,
  msg: string
) => (x: T) => T = (depth, symbol, msg) =>
  pass(() => console.error(`${_.repeat(symbol, depth)} ${msg}`));

const pass: <T>(f: (x: T) => void) => (x: T) => T = f => x => {
  f(x);
  return x;
};
