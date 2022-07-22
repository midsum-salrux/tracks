/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
|^  ted
++  decoder
  %-  ot
  :~  :-  %hourly
      %-  ot
      :~  [%'temperature_2m' (ar ne)]
      ==
  ==
++  mine-json
  |=  =json
  ^-  @rd
  =/  [hourly=[temps=(list @rd)]]  (decoder json)
  ?~  temps.hourly  .~0
  i.temps.hourly
++  url
  |=  [latitude=tape longitude=tape]
  ;:  weld
    "https://api.open-meteo.com/v1/forecast?latitude="
    latitude
    "&longitude="  longitude
    "&hourly=temperature_2m&temperature_unit=fahrenheit"
  ==
++  ted
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  ^-  form:m
  =/  params  !<((list param) arg)
  =/  latitude  (find-param params %latitude)
  =/  longitude  (find-param params %longitude)
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json (url latitude longitude))
  =/  result  (mine-json json)
  =/  =delivery
    [[%tracks %weather] [%rd result now]]
  (pure:m !>(delivery))
--
