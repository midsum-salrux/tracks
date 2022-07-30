import React, { useState } from "react";
import Params from "./Params";
import pathOfTrack from "./pathOfTrack";
import { CheckIcon, TrashIcon } from "@primer/octicons-react";

const FIVE_MIN = "~m5"
const HOURLY = "~h1"
const DAILY = "~d1"

export default function TrackModal(props) {
  const track = props.tracks[props.index];
  const [name, setName] = useState(track.name);
  const [frequency, setFrequency] = useState(track.frequency);
  const [params, setParams] = useState(track.params)

  return <div className="modal" id={pathOfTrack(track)} role="dialog">
    <div className="modal-dialog" role="document">
      <div className="modal-content">
        <div className="modal-header">
          <h5 className="modal-title">Edit Track</h5>
          <button type="button" className="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div className="modal-body">
          <div className="form-group">
            <label className="col-form-label">Name</label>
            <div className="input-group mb-2">
              <input type="text" className="form-control" placeholder="Track Name"
                     value={name} onChange={(e) => setName(e.target.value)} />
            </div>
          </div>
          <div className="form-group">
            <label className="col-form-label">Frequency</label>
            <select className="form-control" id="frequency"
                    value={frequency} onChange={(e) =>
                      { setFrequency(e.target.value); e.preventDefault(); }
                    }>
              <option value={FIVE_MIN}>5 minutes</option>
              <option value={HOURLY}>hourly</option>
              <option value={DAILY}>daily</option>
            </select>
          </div>
          <Params params={params} setParams={setParams} />
        </div>
        <div className="modal-footer justify-content-between">
          <button type="button" className="btn btn-danger"><TrashIcon /></button>
          <button type="button" className="btn btn-primary" data-dismiss="modal"><CheckIcon /></button>
        </div>
      </div>
    </div>
  </div>;
}
