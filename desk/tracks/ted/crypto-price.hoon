::
::  CRYPTO PRICE
::  Returns the price of a crypto token in USD
::
::  PARAMETERS
::  %token: the full name of the token, like "bitcoin"
::
::  DATA SOURCE
::  https://www.coingecko.com/
::
/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
=/  m  (strand ,vase)
|^  ted
++  decoder
  |=  token=cord
  %-  ot
  :~  [token (ot ~[[%usd ne]])]
  ==
++  mine-json
  |=  [=json token=cord]
  ^-  @rd
  ((decoder token) json)
++  url
  |=  [token=tape]
  ;:  weld
    "https://api.coingecko.com/api/v3/simple/price?ids="
    token
    "&vs_currencies=usd"
  ==
++  ted
  ^-  thread:spider
  |=  arg=vase
  ^-  form:m
  =/  =cart  !<(cart arg)
  =/  token  (find-param params.cart %token)
  ;<  now=@da  bind:m  get-time
  ;<  =json  bind:m  (fetch-json (url token))
  =/  result  (mine-json json (crip token))
  =/  =delivery
    [taft.cart [%rd result now]]
  (pure:m !>(delivery))
--
