export type Organisation = { name: string; id: string };

export type Individual = {
  prename: string;
  surname: string;
  chamber: string;
  state: string;
  party: string;
  id: string;
};

export type Recipient = { individual: Individual; money: number };
