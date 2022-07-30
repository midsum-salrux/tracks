import React from "react";

export default function Name(props) {
  return <div className="form-group">
    <label className="col-form-label">Name</label>
    <div className="input-group mb-2">
      <input type="text" className="form-control" placeholder="Track Name"
             value={props.name} onChange={(e) => props.setName(e.target.value)} />
    </div>
  </div>
}
