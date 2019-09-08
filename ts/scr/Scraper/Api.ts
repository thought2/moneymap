import request from "request-promise-native";
import { JSDOM } from "jsdom";
import * as _ from "lodash";
import * as Parser from "./Parser";
import { Recipient, Organisation } from "./Types";

const errors = {
  HTTP_ERROR: (data: any) => `Resource not available: ${JSON.stringify(data)}`
};

export const getCycles = (): Promise<Array<number>> => {
  const requestOpt = {
    method: "get",
    url: "https://www.opensecrets.org/orgs/list.php"
  };

  return request(requestOpt)
    .catch(e => {
      throw new Error(errors.HTTP_ERROR(requestOpt));
    })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseCycles);
};

export const getOrganisations = ({
  cycle
}: {
  cycle: number;
}): Promise<Array<Organisation>> => {
  const requestOpt = {
    method: "get",
    url: "https://www.opensecrets.org/orgs/list.php",
    qs: { cycle }
  };

  return request(requestOpt)
    .catch(e => {
      throw new Error(errors.HTTP_ERROR(requestOpt));
    })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseOrganisations);
};

export const getRecipients = ({
  id,
  cycle
}: {
  id: string;
  cycle: number;
}): Promise<Array<Recipient>> => {
  const requestOpt = {
    method: "get",
    url: "https://www.opensecrets.org/orgs/toprecips.php",
    qs: { id, cycle }
  };

  return request(requestOpt)
    .catch(e => {
      throw new Error(errors.HTTP_ERROR(requestOpt));
    })
    .then(body => new JSDOM(body).window.document)
    .then(Parser.parseRecipients);
};
