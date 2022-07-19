import React from "react";
import Urbit from "@urbit/http-api";

export default function App() {
  window.urbit = new Urbit("");
  window.urbit.ship = window.ship;

  return <>
    <h1>Tracks</h1>
  </>;
}
