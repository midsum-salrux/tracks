import React, { useState } from "react";
import Frequency from "./Frequency";
import Name from "./Name";
import Params from "./Params";
import pathOfTrack from "./pathOfTrack";
import Taft from "./Taft";
import { CheckIcon, TrashIcon } from "@primer/octicons-react";

export default function TrackModal(props) {
  const track = props.tracks[props.index];

  const [taft, setTaft] = useState(track.taft);
  const [name, setName] = useState(track.name);
  const [frequency, setFrequency] = useState(track.frequency);
  const [params, setParams] = useState(track.params);

  // TODO make save and delete work
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
          <Taft taft={taft} setTaft={setTaft} />
          <Name name={name} setName={setName} />
          <Frequency frequency={frequency} setFrequency={setFrequency} />
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
