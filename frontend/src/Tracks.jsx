import React from "react";
import TrackCard from "./TrackCard";

export default function Tracks(props) {
  return <div className="container">
    <div className="row">
      {props.tracks.map(
        function(track, index) {
          return <TrackCard key={index}
                            index={index}
                            tracks={props.tracks}
                            changeTracksPoke={props.changeTracksPoke} />;
        }
      )}
    </div>
  </div>;
}
