import * as Graph from "./Graph";
import * as fs from "fs";

type Config = {
  size?: number;
  outPath: string;
};

const config: Config = {
  size: process.env.SIZE ? parseInt(process.env.SIZE, 10) : undefined,
  outPath: process.env.OUT_PATH || "data.json"
};

const main = (): Promise<void> => {
  return Graph.getGraph(config.size).then(graph => {
    const graphData = Graph.toGraphData(graph);

    fs.writeFileSync(JSON.stringify(graphData, null, 2), config.outPath);
  });
};

console.log(config);
