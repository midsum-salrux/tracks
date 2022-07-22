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
  return <div className="col-md-4">
    <div className="card mb-4 box-shadow text-center">
      <h5 className="card-title mb-2">{track.name}</h5>
      <h4 className="mb-3">{dataFromCargo(track.results[0])}</h4>
      <h6 className="card-subtitle mb-2 text-muted">%{track.taft.desk} - /ted/{track.taft.ted} ({track.frequency})</h6>
    </div>
  </div>;
}

export default function Tracks(props) {
  return <div className="container">
    <div className="row">
      {props.tracks.map(cardForTrack)}
    </div>
  </div>;
}
