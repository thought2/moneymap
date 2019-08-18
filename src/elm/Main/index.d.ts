// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        setLayout: {
          subscribe(callback: (data: { nodes: { id: number; label: { width: number; height: number; x: number; y: number } }[]; edges: { from: number; to: number; label: { points: { x: number; y: number }[] } }[] }) => void): void
        }
        getLayout: {
          send(data: { nodes: { id: number; label: { width: number; height: number; x: number; y: number } }[]; edges: { from: number; to: number; label: { points: { x: number; y: number }[] } }[] }): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: null;
    }): Elm.Main.App;
  }
}