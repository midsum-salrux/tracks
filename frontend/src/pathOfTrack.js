// this could be a bigger utils file

export default function pathOfTrack(track) {
  return "/" + track.taft.join("/");
}
