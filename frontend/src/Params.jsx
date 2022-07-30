import React from "react";
import { PlusIcon, TrashIcon } from "@primer/octicons-react";

function updateKey(params, setParams, index, newKey) {
  const before = params.slice(0, index);
  const after = params.slice(index + 1);
  setParams(
    before.concat([{key: newKey, value: params[index].value}].concat(after))
  );
}

function updateValue(params, setParams, index, newValue) {
  const before = params.slice(0, index);
  const after = params.slice(index + 1);
  setParams(
    before.concat([{key: params[index].key, value: newValue}].concat(after))
  );
}

function removeParam(params, setParams, index) {
  const before = params.slice(0, index);
  const after = params.slice(index + 1);
  setParams(
    before.concat(after)
  );
}

function addParam(params, setParams) {
  setParams(
    params.concat([{ key: "", value: ""}])
  )
}

function paramInput(params, setParams, index) {
  return <div className="form-row mb-2">
    <div className="col">
      <input type="text" className="form-control" placeholder="Key"
             value={params[index].key}
             onChange={(e) => updateKey(params, setParams, index, e.target.value)} />
    </div>
    <div className="col">
      <input type="text" className="form-control" placeholder="Value"
             value={params[index].value}
             onChange={(e) => updateValue(params, setParams, index, e.target.value)} />
    </div>
    <div className="col-sm-auto">
      <button type="button" className="btn btn-danger"
              onClick={() => removeParam(params, setParams, index)}>
        <TrashIcon />
      </button>
    </div>
  </div>
}

export default function Params(props) {
  return <div className="form-group">
    <div className="form-row justify-content-between mb-2">
      <div className="col">
        <label className="col-form-label">Params</label>
      </div>
      <div className="col-sm-auto">
        <button type="button" className="btn btn-success"
                onClick={(e) =>
                  { addParam(props.params, props.setParams); e.preventDefault(); }
                }>
          <PlusIcon />
        </button>
      </div>
    </div>
    {props.params.map((_, index) => paramInput(props.params, props.setParams, index))}
  </div>
}
