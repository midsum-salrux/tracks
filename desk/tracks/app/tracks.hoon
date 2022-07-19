/+  default-agent, dbug
/+  *track
|%
::  aliases
+$  card  card:agent:gall
+$  sign  sign:agent:gall
::  state
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 tracks=(list track)]
::  cards
++  run-track-card
  |=  =track
  ^-  card
  :*  %pass  /run-track  %arvo  %k  %fard
      desk.track  ted.track  %noun  !>(~)
  ==
++  timer-card
  |=  [desk=@tas ted=@tas delay=@dr now=@da]
  ^-  card
  [%pass `path`~[%timer desk ted] %arvo %b [%wait (add delay now)]]
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  :_  this(tracks default-tracks)
      (turn default-tracks run-track-card)
++  on-save
  ^-  vase
  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  !!
      %tracks-add-track
    =/  new-track  !<(track vase)
    :_  this(tracks (into tracks 0 new-track))
        ~[(run-track-card new-track)]
  ==
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  (on-arvo:def wire sign-arvo)
      [%run-track *]
    ?+  sign-arvo  (on-arvo:def wire sign-arvo)
        [%khan %arow %.y %noun *]
      =/  [%khan %arow %.y %noun result=vase]  sign-arvo
      =/  [desk=@tas ted=@tas =cargo]  !<(delivery result)
      =/  track  (need (find-track desk ted tracks))
      :_  this(tracks (add-cargo-to-track tracks [desk ted cargo]))
          ~[(timer-card desk ted frequency.track now.bowl)]
    ==
      [%timer @tas @tas *]
    =/  [%timer desk=@tas ted=@tas *]  wire
    =/  maybe-track  (find-track desk ted tracks)
    :_  this
        ~[(run-track-card (need maybe-track))]
  ==
++  on-fail   on-fail:def
--
