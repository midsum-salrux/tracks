import React, { useState, useEffect } from "react";
import NavBar from "./NavBar";
import Tracks from "./Tracks";
import Urbit from "@urbit/http-api";

export default function App() {
  const [tracks, setTracks] = useState([]);

  async function tracksScry() {
    const scryResult = await window.urbit.scry({app: "tracks", path: "/tracks"});

    const tracks = scryResult.map(function(track) {
      let newTrack = track;

      // because millisecond timestamps are serialized with scientific notation
      // which the backend can't parse correctly, we need to turn the timestamps
      // into second timestamps
      newTrack.results = track.results.map(function(result) {
        let newResult = result;

        if ("ud" in result) {
          newResult.ud.time = Math.floor(result.ud.time / 1000)
        } else if ("rd" in result) {
          newResult.rd.time = Math.floor(result.rd.time / 1000)
        } else if ("bool" in result) {
          newResult.bool.time = Math.floor(result.bool.time / 1000)
        } else if ("tape" in result) {
          newResult.tape.time = Math.floor(result.tape.time / 1000)
        }

        return newResult;
      });

      return newTrack;
    })

    setTracks(tracks);
  }

  function changeTracksPoke(newTracks) {
    window.urbit.poke({
      app: "tracks",
      mark: "tracks-change-tracks",
      json: newTracks,
      onSuccess: tracksScry
    });
  }

  window.urbit = new Urbit("");
  window.urbit.ship = window.ship;

  useEffect(tracksScry, []);

  return <>
    <NavBar tracks={tracks} changeTracksPoke={changeTracksPoke} />
    <Tracks tracks={tracks} changeTracksPoke={changeTracksPoke} />
  </>;
}
