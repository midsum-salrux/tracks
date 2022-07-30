import React from "react";

const FIVE_MIN = "~m5"
const HOURLY = "~h1"
const DAILY = "~d1"

export default function Name(props) {
  return <div className="form-group">
    <label className="col-form-label">Frequency</label>
    <select className="form-control" id="frequency"
            value={props.frequency} onChange={(e) =>
              { props.setFrequency(e.target.value); e.preventDefault(); }
            }>
      <option value={FIVE_MIN}>5 minutes</option>
      <option value={HOURLY}>hourly</option>
      <option value={DAILY}>daily</option>
    </select>
  </div>
}
