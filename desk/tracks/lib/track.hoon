/-  *tracks
=,  dejs:format
|%
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
  :~  :*  /tracks/crypto-price/bitcoin  ~h1
          "Bitcoin Price (USD)"
          ~[[%token "bitcoin"]]
          ~
      ==
      :*  /tracks/crypto-price/ethereum  ~h1
          "Ethereum Price (USD)"
          ~[[%token "ethereum"]]
          ~
      ==
      :*  /tracks/nft-floor/star  ~d1
          "Star Floor Price (ETH)"
          ~[[%name "urbit-id-star"]]
          ~
      ==
      :*  /tracks/nft-floor/milady  ~d1
          "Milady Floor Price (ETH)"
          ~[[%name "milady"]]
          ~
      ==
      :*  /tracks/weather/nyc  ~h1
          "Current Weather (NYC)"
          ~[[%latitude "40.71"] [%longitude "-74.01"]]
          ~
      ==
      :*  /tracks/weather/miami  ~h1
          "Current Weather (Miami)"
          ~[[%latitude "25.76"] [%longitude "-80.19"]]
          ~
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
  ::  these are staggered in part because of a khan bug
  ::  where simultaneously-started threads don't return results
  %+  turn  tracks
    |=  =track
    =/  index  (need (find ~[track] tracks))
    =/  time  (add (mul ~s1 index) now)
    [taft.track time]
++  update-timer
  |=  [timers=(list taft-timer) new-timer=taft-timer]
  =/  matching
    %+  skim  timers
    |=  =taft-timer
    =(taft.taft-timer taft.new-timer)
  ?~  matching  timers
  =/  old-timer  i.matching
  =/  index  (need (find ~[old-timer] timers))
  (zing ~[(scag index timers) ~[new-timer] (slag +(index) timers)])
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
::  text formatting
++  rd-to-cord
  |=  [n=@rd]
  ^-  cord
  (crip (r-co:co (rlyd n)))
++  ud-to-cord
  |=  [n=@ud]
  ^-  cord
  (crip ((d-co:co 0) n))
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
