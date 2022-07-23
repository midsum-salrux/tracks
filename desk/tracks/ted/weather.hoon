::  TODO comments, have more than one city
/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
=/  m  (strand ,vase)
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
  ^-  form:m
  =/  =cart  !<(cart arg)
  =/  latitude  (find-param params.cart %latitude)
  =/  longitude  (find-param params.cart %longitude)
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json (url latitude longitude))
  =/  result  (mine-json json)
  =/  =delivery
    [taft.cart [%rd result now]]
  (pure:m !>(delivery))
--
