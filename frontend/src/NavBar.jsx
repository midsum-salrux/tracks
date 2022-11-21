import React from "react";
import { PlusIcon } from "@primer/octicons-react";

export default function NavBar(props) {
  return <>
    <div className="modal" tabIndex="-1" role="dialog" id="about">
      <div className="modal-dialog" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title">About</h5>
            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div className="modal-body">
            <!-- TODO update authorship, make a real group and link it here -->>
            <p>Made by <code>~midsum-salrux</code></p>
            <p>Visit <code>~tomdys/tracks</code> for support</p>
          </div>
        </div>
      </div>
    </div>

    <div className="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-4 bg-white border-bottom box-shadow">
      <h5 className="my-0 mr-md-auto font-weight-normal">Tracks</h5>
      <nav className="my-2 my-md-0 mr-md-3">
        <button className="btn btn-light btn-sm mr-3" href="#">
          <!-- TODO create "new track" modal -->>
          <PlusIcon />
        </button>
        <button className="btn btn-light btn-sm" href="#"
           data-toggle="modal" data-target="#about">?</button>
      </nav>
    </div>
  </>
}
