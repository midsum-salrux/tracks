=,  dejs:format
|%
::  types
+$  track
  [desk=@tas ted=@tas frequency=@dr name=tape results=(list cargo)]
+$  cargo
  $%  [%ud data=@ud time=@da]
      [%rd data=@rd time=@da]
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
  ?-  cargo
      [%ud @ud @da]
    %+  frond:enjs:format  'ud'
    %-  pairs:enjs:format
    :~  ['data' (numb:enjs:format data.cargo)]
        ['time' (time:enjs:format time.cargo)]
    ==
      [%rd @rd @da]
    %+  frond:enjs:format  'rd'
    %-  pairs:enjs:format
    :~  ['data' n+(rd-to-cord data.cargo)]
        ['time' (time:enjs:format time.cargo)]
    ==
      [%bool ? @da]
    %+  frond:enjs:format  'bool'
    %-  pairs:enjs:format
    :~  ['data' b+data.cargo]
        ['time' (time:enjs:format time.cargo)]
    ==
      [%tape * @da]
    %+  frond:enjs:format  'tape'
    %-  pairs:enjs:format
    :~  ['data' s+(crip data.cargo)]
        ['time' (time:enjs:format time.cargo)]
    ==
  ==
++  rd-to-cord
  |=  [n=@rd]
  ^-  cord
  (crip (r-co:co (rlyd n)))
::  json (dejs)
++  dejs-tracks
  |=  =json
  ^-  (list track)
  %.  json
  (ar dejs-track)
++  dejs-track
  |=  =json
  ^-  track
  %.  json
  %-  ot
  :~  desk+so
      ted+so
      frequency+dejs-frequency
      name+sa
      results+dejs-results
  ==
++  dejs-results
  |=  =json
  ^-  (list cargo)
  %.  json
  (ar dejs-cargo)
++  dejs-cargo
  |=  =json
  ^-  cargo
  %.  json
  %-  of
  :~  [%ud (ot ~[data+ni time+du])]
      [%rd (ot ~[data+ne time+du])]
      [%bool (ot ~[data+bo time+du])]
      [%tape (ot ~[data+sa time+du])]
  ==
++  dejs-frequency
  |=  =json
  ^-  @dr
  ?+  json  !!
      [%s p=cord]
    (need (slaw %dr p.json))
  ==
--
