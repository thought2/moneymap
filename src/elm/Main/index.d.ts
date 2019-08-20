// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        setLayout: {
          subscribe(callback: (data: { graph: { rankdir: string }; nodes: { id: number; label: { width: number; height: number } }[]; edges: { from: number; to: number; label: { weight: number } }[] }) => void): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: null;
    }): Elm.Main.App;
  }
}