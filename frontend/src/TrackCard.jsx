import React from "react";
import pathOfTrack from "./pathOfTrack";
import TrackModal from "./TrackModal";

function dataFromCargo(results) {
  if (results.length == 0) {
    return "~";
  }

  let cargo = results[0];

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

export default function TrackCard(props) {
  function moveTrackLeft(track) {
    let newTracks = props.tracks;
    const index = newTracks.findIndex((e) => e.taft == track.taft);

    if (index == 0) {
      return null;
    }

    newTracks.splice(index, 1);
    newTracks.splice(index - 1, 0, track);

    props.changeTracksPoke(newTracks);
  }

  function moveTrackRight(track) {
    let newTracks = props.tracks;
    const index = newTracks.findIndex((e) => e.taft == track.taft);

    if (index == props.tracks.length - 1) {
      return null;
    }

    newTracks.splice(index, 1);
    newTracks.splice(index + 1, 0, track);

    props.changeTracksPoke(newTracks);
  }

  const track = props.tracks[props.index];

  return <>
    <TrackModal index={props.index} tracks={props.tracks} changeTracksPoke={props.changeTracksPoke} />
    <div className="col-md-4">
      <div className="card mb-4 box-shadow">
        <h5 className="card-title mb-0 text-center text-muted">{track.name}</h5>
        <div className="card-body">
          <h3 className="text-center mb-1">{dataFromCargo(track.results)}</h3>
        </div>
        <div className="row">
          <div className="col">
            <div className="row justify-content-between">
              <div className="col-9">
                <h6 className="card-subtitle text-muted text-left">
                  {pathOfTrack(track)}
                </h6>
              </div>
              <div className="col-auto mr-3">
                <div className="row">
                  <h6 className="card-subtitle text-muted">
                    <a href="#" className="badge badge-light"
                       onClick={() => moveTrackLeft(track, props.changeTracksPoke)}>
                      {"<"}
                    </a>
                  </h6>
                  <h6 className="card-subtitle text-muted">
                    <a href="#" className="badge badge-light"
                       data-toggle="modal" data-target={"#" + pathOfTrack(track)}>
                      edit
                    </a>
                  </h6>
                  <h6 className="card-subtitle text-muted">
                    <a href="#" className="badge badge-light"
                       onClick={() => moveTrackRight(track, props.changeTracksPoke)}>
                      {">"}
                    </a>
                  </h6>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </>;
}
