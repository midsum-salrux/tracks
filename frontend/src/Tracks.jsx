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
    <div className="card mb-4 box-shadow">
      <h5 className="card-title mb-0 text-center text-muted">{track.name}</h5>
      <div className="card-body">
        <h3 className="text-center mb-1">{dataFromCargo(track.results[0])}</h3>
      </div>
      <div className="row">
        <div className="col-lg-auto text-left">
          <h6 className="card-subtitle text-muted">/{track.taft.join("/")}</h6>
        </div>
        <div className="col-sm text-right">
          <h6 className="card-subtitle text-muted">edit</h6>
        </div>
      </div>
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
