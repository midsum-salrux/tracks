import React, { useState, useEffect } from "react";
import Urbit from "@urbit/http-api";

export default function App() {
  const [tracks, setTracks] = useState([]);

  async function tracksScry() {
    const result = await window.urbit.scry({app: "tracks", path: "/tracks"});
    setTracks(result);
  }

  window.urbit = new Urbit("");
  window.urbit.ship = window.ship;

  useEffect(tracksScry, []);

  return <>
    <code>{JSON.stringify(tracks)}</code>
  </>;
}
