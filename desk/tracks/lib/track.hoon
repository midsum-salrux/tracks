=,  dejs:format
|%
::  types
+$  track
  [desk=@tas ted=@tas frequency=@dr name=tape results=(list cargo)]
+$  cargo
  $%  [%ud data=@ud time=@da]
      [%rs data=@rs time=@da]
      [%bool data=? time=@da]
      [%tape data=tape time=@da]
  ==
+$  delivery  [desk=@tas ted=@tas =cargo]
::  utility
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
::  json (enjs)
++  enjs-tracks
  |=  tracks=(list track)
  ^-  json
  :-  %a
  (turn tracks enjs-track)
++  enjs-track
  |=  =track
  ^-  json
  %-  pairs:enjs:format
  :~  ['desk' s+`@t`desk.track]
      ['ted' s+`@t`ted.track]
      ['frequency' (enjs-frequency frequency.track)]
      ['name' s+(crip name.track)]
      ['results' (enjs-results results.track)]
  ==
++  enjs-frequency
  |=  frequency=@dr
  ^-  json
  [%s `cord`(scot %dr frequency)]
++  enjs-results
  |=  results=(list cargo)
  ^-  json
  :-  %a
  (turn results enjs-cargo)
++  enjs-cargo
  |=  =cargo
  ::  TODO
  ^-  json
  [%s 'foo']
::  json (dejs)
++  dejs-frequency
  |=  =json
  ^-  @dr
  ?+  json  !!
      [%s p=cord]
    (need (slaw %dr p.json))
  ==
--
