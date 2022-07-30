import React from "react";

function setDesk(taft, setTaft, desk) {
  setTaft([desk, taft[1], taft[2]]);
}

function setTed(taft, setTaft, ted) {
  setTaft([taft[0], ted, taft[2]]);
}

function setSlug(taft, setTaft, slug) {
  setTaft([taft[0], taft[1], slug]);
}

// TODO this could be better as dropdowns where it gets the desks & threads from the ship

export default function Taft(props) {
  return <div className="form-group">
    <label className="col-form-label">Taft</label>
    <div className="form-row justify-content-between mb-2">
      <div className="col-4">
        <input type="text" className="form-control" placeholder="Desk"
               value={props.taft[0]}
               onChange={(e) => setDesk(props.taft, props.setTaft, e.target.value)} />
      </div>
      <div className="col-4">
        <input type="text" className="form-control" placeholder="Thread"
               value={props.taft[1]}
               onChange={(e) => setTed(props.taft, props.setTaft, e.target.value)} />
      </div>
      <div className="col-4">
        <input type="text" className="form-control" placeholder="Slug"
               value={props.taft[2]}
               onChange={(e) => setSlug(props.taft, props.setTaft, e.target.value)} />
      </div>
    </div>
  </div>
}
