import * as Cli from "../../scr/Scraper/Cli";

import * as assert from "assert";
import { JSDOM } from "jsdom";
import * as _ from "lodash";

describe("Scraper.Cli", () => {
  it("succeeds to compile entry point", () => {
    const _ = Cli.main;
    assert.deepEqual(true, true);
  });
});
