::  TODO comments, have floor for more than one nft
/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
=/  m  (strand ,vase)
|^  ted
++  mine-json
  %-  ot
  :~  :-  %stats
      %-  ot
      :~  [%'floor_price' ne]
      ==
  ==
++  url
  |=  name=tape
  ;:  weld
      "https://api.opensea.io/api/v1/collection/"
      name
      "/stats?format=json"
  ==
++  ted
  ^-  thread:spider
  |=  arg=vase
  ^-  form:m
  =/  =cart  !<(cart arg)
  =/  name  (find-param params.cart %name)
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json (url name))
  =/  result  (mine-json json)
  =/  =delivery
    [taft.cart [%rd result now]]
  (pure:m !>(delivery))
--
