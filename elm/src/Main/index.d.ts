// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        setLayout: {
          subscribe(
            callback: (data: {
              label: { rankdir: string };
              nodes: { id: number; label: { width: number; height: number } }[];
              edges: { from: number; to: number; label: { weight: number } }[];
            }) => void
          ): void;
        };
        getLayout: {
          send(data: {
            label: { width: number; height: number };
            nodes: { id: number; label: { x: number; y: number } }[];
            edges: {
              from: number;
              to: number;
              label: { points: { x: number; y: number }[] };
            }[];
          }): void;
        };
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: null;
    }): Elm.Main.App;
  }
}
