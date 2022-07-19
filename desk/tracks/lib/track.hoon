|%
+$  track
  [desk=@tas ted=@tas frequency=@dr name=tape results=(list cargo)]
+$  cargo
  $%  [%ud data=@ud time=@da]
      [%rs data=@rs time=@da]
      [%bool data=? time=@da]
      [%tape data=tape time=@da]
  ==
+$  delivery  [desk=@tas ted=@tas =cargo]
++  find-track
  |=  [desk=@tas ted=@tas tracks=(list track)]
  ^-  (unit track)
  =/  matching
    %+  skim  tracks
      |=  =track
      &(=(desk desk.track) =(ted ted.track))
  ?~  matching  ~
  `i.matching
++  add-cargo-to-track
  |=  [tracks=(list track) =delivery]
  ^-  (list track)
  =/  old-track  (need (find-track desk.delivery ted.delivery tracks))
  =/  index  (need (find ~[old-track] tracks))
  =/  new-track
    :*  desk.old-track
        ted.old-track
        frequency.old-track
        name.old-track
        (into results.old-track 0 cargo.delivery)
    ==
  (zing ~[(scag index tracks) ~[new-track] (slag +(index) tracks)])
++  default-tracks
  ^-  (list track)
  :~  [%tracks %hello-world ~h1 "Hello World" ~]
  ==
--
