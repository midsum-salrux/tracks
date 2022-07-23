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
+$  state-0  [%0 tracks=(list track) timers=(list taft-timer)]
+$  update-poke
  $%  [%reinit]
  ==
::  cards
++  run-track-card
  |=  =track
  ^-  card
  :*  %pass  /run-track  %arvo  %k  %fard
      desk.taft.track  ted.taft.track  %noun
      !>([taft.track params.track])
  ==
++  timer-card
  |=  [=taft-timer]
  ^-  card
  [%pass :-(%timer taft.taft-timer) %arvo %b [%wait time.taft-timer]]
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
  =/  default-timers  (timers-for-tracks default-tracks now.bowl)
  :-  (turn default-timers timer-card)
  this(tracks default-tracks, timers default-timers)
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
      %tracks-change-tracks
    ::  TODO start timers if tracks are added
    ::  TODO remove timers if tracks are removed
    =/  new-tracks  !<((list track) vase)
    `this(tracks new-tracks)
      %noun
    =/  =update-poke  !<(update-poke vase)
      ?-  update-poke
          [%reinit]
        ::  TODO clear timers
        on-init
      ==
  ==
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek
  |=  [=path]
  ^-  (unit (unit cage))
  ?>  ?=([%x %tracks ~] path)
  :^  ~  ~  %json
  !>  (enjs-tracks tracks)
++  on-agent  on-agent:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  (on-arvo:def wire sign-arvo)
      [%run-track *]
    ?+  sign-arvo  (on-arvo:def wire sign-arvo)
        [%khan %arow %.n %thread-fail *]
      `this
        [%khan %arow %.y %noun *]
      =/  [%khan %arow %.y %noun result=vase]  sign-arvo
      =/  [=taft =cargo]  !<(delivery result)
      =/  track  (need (find-track taft tracks))
      `this(tracks (add-cargo-to-track tracks [taft cargo]))
    ==
      [%timer @tas @tas @tas ~]
    =/  [%timer =taft]  wire
    =/  track  (need (find-track taft tracks))
    =/  new-timer  [taft (add frequency.track now.bowl)]
    :_  this(timers (update-timer timers new-timer))
    :~  (run-track-card track)
        (timer-card new-timer)
    ==
  ==
++  on-fail   on-fail:def
--
