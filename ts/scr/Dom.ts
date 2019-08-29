import * as _ from "lodash";

// Types

type Select = Array<{ text: string }>;

type Table = Array<Array<HTMLTableDataCellElement>>;

type Link = { href: string; content: HTMLLinkElement };

// Errors

const errors = {
  NOT_FOUND: (selector: string) => `Element not found: ${selector}`
};

// Functions

export const parseSelect = (
  parentNode: ParentNode,
  refinement: string = ""
): Select => {
  const selector = `select${refinement}`;
  const selectElement = parentNode.querySelector(selector);
  if (!selectElement) throw new Error(errors.NOT_FOUND(selector));
  const elementsOption = selectElement.querySelectorAll("option");

  return _.map(elementsOption, ({ textContent }) => {
    return { text: textContent || "" };
  });
};

export const parseTable = (
  parentNode: ParentNode,
  refinement: string = ""
): Table => {
  const selector = `table${refinement}`;
  const table = parentNode.querySelector(selector);
  if (!table) throw new Error(errors.NOT_FOUND(selector));
  const rows = _.toArray(table.querySelectorAll("tr"));

  if (rows[0] && rows[0].querySelector("th")) {
    rows.shift();
  }

  return _.map(rows, row => {
    const column = row.querySelectorAll("td");
    return _.toArray(column);
  });
};

export const parseLink = (
  parentNode: ParentNode,
  refinement: string = ""
): Link => {
  const selector = `a${refinement}`;
  const link = parentNode.querySelector(selector) as HTMLLinkElement;
  if (!link) throw new Error(errors.NOT_FOUND(selector));

  return { href: link.href, content: link };
};
