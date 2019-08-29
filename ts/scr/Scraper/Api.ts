import request from "request-promise-native";
import { JSDOM } from "jsdom";
import * as _ from "lodash";
import * as Parser from "./Parser";
import { Recipient, Organisation } from "./Types";

export const getCycles = (): Promise<Array<number>> =>
  request
    .get({ url: "https://www.opensecrets.org/orgs/list.php" })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseCycles);

export const getOrganisations = ({
  cycle
}: {
  cycle: number;
}): Promise<Array<Organisation>> =>
  request
    .get({ url: "https://www.opensecrets.org/orgs/list.php", qs: { cycle } })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseOrganisations);

export const getRecipients = ({
  id,
  cycle
}: {
  id: string;
  cycle: number;
}): Promise<Array<Recipient>> =>
  request
    .get({
      url: "https://www.opensecrets.org/orgs/summary.php",
      qs: { id, cycle }
    })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseRecipients);
