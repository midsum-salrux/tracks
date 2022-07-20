import React from "react";

function dataFromCargo(cargo) {
  if ("ud" in cargo) {
    return cargo.ud.data
  } else if ("rd" in cargo) {
    return cargo.rd.data
  } else if ("bool" in cargo) {
    return cargo.bool.data
  } else if ("tape" in cargo) {
    return cargo.tape.data
  } else {
    return null
  }
}

function cardForTrack(track) {
  return <div className="card mb-4 box-shadow">
    <h5 className="card-title">{track.name}</h5>
    <h6 className="card-subtitle mb-2 text-muted">%{track.desk} - /ted/{track.ted} ({track.frequency})</h6>
    <h1>{dataFromCargo(track.results[0])}</h1>
  </div>;
}

export default function Tracks(props) {
  return <div className="container">
    <div className="row">
      <div className="col-md-4">
        {props.tracks.map(cardForTrack)}
      </div>
    </div>
  </div>;
}
