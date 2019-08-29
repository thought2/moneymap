import * as _ from "lodash";
import * as querystring from "querystring";
import * as Dom from "../Dom";
import * as url from "url";
import { Recipient, Individual, Organisation } from "./Types";

// Errors

const errors = {
  NOT_FOUND: (selector: string) => `Element not found: ${selector}`,
  NO_REGEX_MATCH: (subject: string) => `Regex does not match: ${subject}`,
  ID_NOT_FOUND: (query: string) => `Cannot find Id: ${query}`
};

// Functions

export const parseCycles = (document: ParentNode): Array<number> => {
  const selector = "#rightColumn > form";
  const formElement = document.querySelector(selector);
  if (!formElement) throw new Error(errors.NOT_FOUND(selector));
  const options = Dom.parseSelect(formElement as HTMLSelectElement);

  return options
    .map(({ text }) => parseInt(text, 10))
    .filter(text => !_.isNaN(text));
};

export const parseOrganisations = (node: ParentNode): Array<Organisation> => {
  const table = Dom.parseTable(node, "#contribs");
  return table.map(([_, org]) => {
    const link = Dom.parseLink(org);
    const url_ = url.parse(link.href, true);
    const name = link.content.textContent || "";

    return { id: parseIdLink(url_), name: name.trim() };
  });
};

export const parseIndividual = (
  row: Array<HTMLTableDataCellElement>
): Individual => {
  const regexMember = /([^,]+), ([^(]+)\(([RD])-([A-Z]+)\)/;
  const [chamber, member] = row;
  const subject = member.textContent || "";
  const result = subject.match(regexMember);
  if (!result) throw new Error(errors.NO_REGEX_MATCH(subject));
  const [_, surname, prename, party, state] = result;

  const link = Dom.parseLink(member);
  const url_ = url.parse(link.href, true);

  return {
    prename: prename.trim(),
    surname: surname.trim(),
    chamber: chamber.textContent || "",
    state,
    party,
    id: parseIdLink(url_)
  };
};

export const parseRecipients = (node: ParentNode): Array<Recipient> => {
  const selector = "#profileLeftColumn";
  const elem = node.querySelector(selector);
  if (!elem) throw new Error(errors.NOT_FOUND(selector));
  const table = Dom.parseTable(elem, ".datadisplay");

  return table.map(row => {
    return {
      individual: parseIndividual(row),
      money: parseMoney(row[2].textContent || "")
    };
  });
};

export const parseMoney = (value: string): number => {
  const regex = /\$([0-9,]+)/;
  const result = value.match(regex);
  if (!result) throw new Error(errors.NO_REGEX_MATCH(value));
  const [_, digit] = result;

  return parseInt(digit.replace(/,/g, ""), 10);
};

export const parseIdLink = ({ query }: url.UrlWithParsedQuery): string => {
  if (!query.id || typeof query.id !== "string")
    throw new Error(errors.ID_NOT_FOUND(JSON.stringify(query)));

  return query.id;
};
