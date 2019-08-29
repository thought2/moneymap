import request, { RequestPromise } from "request-promise-native";
import { JSDOM } from "jsdom";
import * as _ from "lodash";
import * as querystring from "querystring";

export const ERRORS = {
  notFound: `NOT_FOND`,
  isEmpty: "IS_EMPTY",
  noText: "NO_TEXT",
  NaN: "NAN"
};

type Select = Array<{ text: string }>;

type Table = Array<Array<HTMLTableDataCellElement>>;

export const parseSelect = (
  parentNode: ParentNode,
  refinement: string = ""
): Select => {
  const selectElement = parentNode.querySelector(`select${refinement}`);
  if (!selectElement) throw ERRORS.notFound;
  const elementsOption = selectElement.querySelectorAll("option");

  return _.map(elementsOption, ({ textContent }) => {
    if (!textContent) throw ERRORS.noText;

    return { text: textContent };
  });
};

export const parseTable = (
  parentNode: ParentNode,
  refinement: string = ""
): Table => {
  const table = parentNode.querySelector(`table${refinement}`);
  if (!table) throw ERRORS.notFound;
  const rows = table.querySelectorAll("tr");

  return _.map(rows, row => {
    const column = row.querySelectorAll("td");
    return _.toArray(column);
  });
};

export const parseCycles = (document: ParentNode): Array<number> => {
  const formElement = document.querySelector("#rightColumn > form");
  if (!formElement) throw ERRORS.notFound;
  const options = parseSelect(formElement as HTMLSelectElement);

  return options
    .map(({ text }) => parseInt(text, 10))
    .filter(text => !_.isNaN(text));
};
