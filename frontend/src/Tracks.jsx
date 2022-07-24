import React from "react";

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

function pathOfTrack(track) {
  return "/" + track.taft.join("/");
}

function modalForTrack(track) {
  return <div className="modal" id={pathOfTrack(track)} role="dialog">
    <div className="modal-dialog" role="document">
      <div className="modal-content">
        <div className="modal-header">
          <h5 className="modal-title" id="exampleModalLabel">Modal title</h5>
          <button type="button" className="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div className="modal-body">
          ...
        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" className="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>
}

function cardForTrack(track) {
  return <>
    {modalForTrack(track)}
    <div className="col-md-4">
      <div className="card mb-4 box-shadow">
        <h5 className="card-title mb-0 text-center text-muted">{track.name}</h5>
        <div className="card-body">
          <h3 className="text-center mb-1">{dataFromCargo(track.results)}</h3>
        </div>
        <div className="row">
          <div className="col-sm text-right">
            <div className="row justify-content-between">
              <div className="col-auto">
                <h6 className="card-subtitle text-muted text-left">
                  {pathOfTrack(track)}
                </h6>
              </div>
              <div className="col-auto mr-3">
                <div className="row">
                  <h6 className="card-subtitle text-muted">
                    <a href="#" className="badge badge-light">
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
                    <a href="#" className="badge badge-light">
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

export default function Tracks(props) {
  return <div className="container">
    <div className="row">
      {props.tracks.map(cardForTrack)}
    </div>
  </div>;
}
