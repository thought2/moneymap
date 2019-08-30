import * as parser from "../../scr/Scraper/Parser";

import * as assert from "assert";
import { JSDOM } from "jsdom";
import * as url from "url";

describe("Scraper.Parser", () => {
  describe("parseCycles", () => {
    it("succeeds", () => {
      const html = `
        <div id="rightColumn">
          <form>
            <select>
              <option>1999</option>
              <option>2000</option>
              <option>2001</option>
            </select>
          </form>
        </div>
      `;
      const document = new JSDOM(html).window.document;
      const actual = parser.parseCycles(document);
      const expected = [1999, 2000, 2001];

      assert.deepEqual(actual, expected);
    });
  });

  describe("parseOrganisations", () => {
    it("succeeds", () => {
      const html = `
        <table id="contribs">
          <tr>
            <td></td>
            <td>
              <a
                href="/orgs/summary.php?id=D000031992&amp;cycle=2018"
                >Bloomberg LP        </a
              >
            </td>
          </tr>
          <tr>
            <td></td>
            <td>
              <a
                href="/org/summary.php?id=D000067344&amp;cycle=2018"
                >Fahr LLC           </a
              >
            </td>
          </tr>
        </table>
      `;
      const document = new JSDOM(html).window.document;
      const actual = parser.parseOrganisations(document);
      const expected = [
        { id: "D000031992", name: "Bloomberg LP" },
        { id: "D000067344", name: "Fahr LLC" }
      ];

      assert.deepEqual(actual, expected);
    });
  });

  describe("parseRecipients", () => {
    it("succeeds", () => {
      // TODO: Add president case
      const html = `
        <div id="profileLeftColumn">
          <h2></h2>
          <table class="datadisplay">
            <tr>
              <th></th>
              <th></th>
              <th></th>
            </tr>
            <tr>
              <td>Senate</td>
              <td>
                <a
                  href="/members-of-congress/summary?cid=N00027694&amp;cycle=2018"
                  >McCaskill, Claire				 (D-MO)</a
                >
              </td>
              <td class="number">$30,783</td>
            </tr>
            <tr>
              <td>House</td>
              <td>
                <a
                  href="/members-of-congress/summary?cid=N00036928&amp;cycle=2018"
                  >Donovan, Dan				 (R-NY)</a
                >
              </td>
              <td class="number">$21,600</td>
            </tr>
            <tr>
              <td colspan="3">
                See all recipients
              </td>
            </tr>
          </table>
        </div>
      `;
      const document = new JSDOM(html).window.document;
      const actual = parser.parseRecipients(document);
      const expected = [
        {
          individual: {
            prename: "Claire",
            surname: "McCaskill",
            chamber: "Senate",
            party: "D",
            state: "MO",
            id: "N00027694"
          },
          money: 30783
        },
        {
          individual: {
            prename: "Dan",
            surname: "Donovan",
            chamber: "House",
            party: "R",
            state: "NY",
            id: "N00036928"
          },
          money: 21600
        }
      ];

      assert.deepEqual(actual, expected);
    });
  });

  describe("parseIdLink", () => {
    it("succeeds", () => {
      // TODO: Add cid case
      const url_ = url.parse("summary.php?id=D000031992&amp;cycle=2018", true);
      const actual = parser.parseIdLink(url_);
      const expected = "D000031992";

      assert.deepEqual(actual, expected);
    });
  });

  describe("parseMoney", () => {
    it("succeeds with one comma", () => {
      const actual = parser.parseMoney("$32,333");
      const expected = 32333;
      assert.deepEqual(actual, expected);
    });

    it("succeeds with two commas", () => {
      const actual = parser.parseMoney("$32,333,123");
      const expected = 32333123;
      assert.deepEqual(actual, expected);
    });
  });
});
