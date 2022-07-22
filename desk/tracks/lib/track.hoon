=,  dejs:format
|%
::  types
+$  taft  [desk=@tas ted=@tas slug=@tas ~]
+$  param  [key=@tas value=tape]
::  params are not a map because they have a user-definable order
+$  track
  [=taft frequency=@dr name=tape params=(list param) results=(list cargo)]
+$  cargo
  $%  [%ud data=@ud time=@da]
      [%rd data=@rd time=@da]
      [%bool data=? time=@da]
      [%tape data=tape time=@da]
  ==
+$  cart  [=taft params=(list param)]
+$  delivery  [=taft =cargo]
+$  taft-timer  [=taft time=@da]
::  utility
++  find-track
  |=  [=taft tracks=(list track)]
  ^-  (unit track)
  =/  matching
    %+  skim  tracks
      |=  =track
      =(taft taft.track)
  ?~  matching  ~
  `i.matching
++  add-cargo-to-track
  |=  [tracks=(list track) =delivery]
  ^-  (list track)
  =/  old-track  (need (find-track taft.delivery tracks))
  =/  index  (need (find ~[old-track] tracks))
  =/  new-track
    :*  taft.old-track
        frequency.old-track
        name.old-track
        params.old-track
        (into results.old-track 0 cargo.delivery)
    ==
  (zing ~[(scag index tracks) ~[new-track] (slag +(index) tracks)])
++  default-tracks
  ^-  (list track)
  :~  [/tracks/star-price/star ~d1 "Star Price (ETH)" ~ ~]
      [/tracks/random-quote/b-or-b ~h1 "Quote (Ben or Bruce)" ~ ~]
      :*  /tracks/weather/nyc  ~h1  "Current Temperature"
          ~[[%latitude "40.71"] [%longitude "-74.01"]]  ~
      ==
  ==
++  find-param
  |=  [params=(list param) key=@tas]
  ^-  tape
  =/  matches
    %+  skim  params
    |=  =param
    =(key key.param)
  ?~  matches  !!
  value.i.matches
++  timers-for-tracks
  |=  [tracks=(list track) now=@da]
  ^-  (list taft-timer)
  %+  turn  tracks
    |=  =track
    =/  index  (need (find ~[track] tracks))
    =/  time  (add (mul ~s1 index) now)
    [taft.track time]
++  update-timer
  |=  [timers=(list taft-timer) taft-timer]
  ::  TODO
  timers
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
  :~  ['taft' (enjs-taft taft.track)]
      ['frequency' (enjs-frequency frequency.track)]
      ['name' s+(crip name.track)]
      ['params' (enjs-params params.track)]
      ['results' (enjs-results results.track)]
  ==
++  enjs-taft
  |=  =taft
  ^-  json
  :-  %a
  :~  s+desk.taft
      s+ted.taft
      s+slug.taft
  ==
++  enjs-params
  |=  params=(list param)
  ^-  json
  :-  %a
  %+  turn  params
    |=  =param
    %-  pairs:enjs:format
    :~  ['key' s+key.param]
        ['value' s+(crip value.param)]
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
  :~  taft+dejs-taft
      frequency+dejs-frequency
      name+sa
      params+dejs-params
      results+dejs-results
  ==
++  dejs-taft
  %+  cu
    |=  [desk=@tas ted=@tas slug=@tas]
    ^-  taft
    [desk ted slug ~]
  (at ~[so so so])
++  dejs-params
  %-  ar
  %-  ot
  :~  key+so
      value+sa
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
