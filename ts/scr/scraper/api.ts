import request, { RequestPromise } from "request-promise-native";
import { JSDOM } from "jsdom";
import * as _ from "lodash";
import * as parser from "./parser";
import * as querystring from "querystring";

type Node = { tag: "Organisation" } | { tag: "Individual" };

type Edge = { cycle: number; money: number };

type NodeId = string;

type Graph = {
    nodes: Map<NodeId, Node>;
    edges: Array<{ from: NodeId; to: NodeId; label: Edge }>;
};

const parseDocument = (body: string): Document =>
    new JSDOM(body).window.document;

const passOrThrow = (x: any) => {
    if (!x) throw "";
    return x;
};

const api = {
    openSecrets: {
        orgs: {
            list: ({ cycle }: { cycle?: number }) => ({
                method: "get",
                uri: "https://www.opensecrets.org/orgs/list.php"
            })
        }
    }
};


const getCycles = (): Promise<Array<number>> =>
    request(api.openSecrets.orgs.list({})).then(parseDocument).then(parser.parseCycles);



/*
const getOrganisationIds = (cycle: number): Promise<Array<NodeId>> =>
    request({ uri: "https://www.opensecrets.org/orgs/list.php", qs: { cycle } })
        .then(parseDocument)
        .then(document => document.querySelector("table.#contribs"))
        .then(passOrThrow)
        .then(table => parser.parseTable(table))
        .then(rows => rows.map(([_, org]) => parseOrg(org)).filter(x => x !== null))



const parseOrg = (col: HTMLTableDataCellElement): NodeId | null => {
    const link = col.querySelector("a")
    if (!link) return null

    const x = foo(link.href)
    if (!x.id || typeof x.id !== 'string') return null

    return x.id
}

const foo = (url: string): querystring.ParsedUrlQuery => {
    const [_, right] = url.split("?")
    return querystring.parse(right)
}
*/

getCycles().then(x => console.log(x));
