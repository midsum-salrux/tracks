/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
|^  ted
++  mine-json
  %-  ot
  :~  :-  %stats
      %-  ot
      :~  [%'floor_price' ne]
      ==
  ==
++  url  "https://api.opensea.io/api/v1/collection/urbit-id-star/stats?format=json"
++  ted
  ^-  thread:spider
  |=  arg=vase
  =/  m  (strand ,vase)
  ^-  form:m
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json url)
  =/  result  (mine-json json)
  =/  =delivery
    [%tracks %star-price [%rd result now]]
  (pure:m !>(delivery))
--
