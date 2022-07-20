import React, { useState, useEffect } from "react";
import Tracks from "./Tracks";
import Urbit from "@urbit/http-api";

export default function App() {
  const [tracks, setTracks] = useState([]);

  async function tracksScry() {
    const result = await window.urbit.scry({app: "tracks", path: "/tracks"});
    setTracks(result);
  }

  function changeTracksPoke(newTracks) {
    window.urbit.poke({
      app: "tracks",
      mark: "tracks-change-tracks",
      json: newTracks,
      onSuccess: tracksScry
    });
  }

  function addTrackPoke(newTrack) {
    window.urbit.poke({
      app: "tracks",
      mark: "tracks-add-track",
      json: newTrack,
      onSuccess: tracksScry
    });
  }

  window.urbit = new Urbit("");
  window.urbit.ship = window.ship;

  useEffect(tracksScry, []);

  return <>
    <Tracks tracks={tracks} changeTracksPoke={changeTracksPoke} />
  </>;
}
