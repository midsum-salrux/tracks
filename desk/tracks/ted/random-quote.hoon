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
  :~  content+sa
      author+sa
  ==
++  mine-json
  |=  =json
  =/  [content=tape author=tape]  (decoder json)
  ;:  weld
    content  " -- "  author
  ==
++  url-ben  "https://api.quotable.io/random?author=benjamin-franklin"
++  url-bruce  "https://api.quotable.io/random?author=bruce-lee"
++  url
  |=  eny=@uvj
  =/  coinflip  (mod eny 2)
  ?:  =(coinflip 1)
    url-ben
  url-bruce
++  ted
  ^-  thread:spider
  |=  arg=vase
  ^-  form:m
  =/  =cart  !<(cart arg)
  ;<  now=@da  bind:m  get-time
  ;<  eny=@uvJ  bind:m  get-entropy
  ;<  =json  bind:m  (fetch-json (url eny))
  =/  result  (mine-json json)
  =/  =delivery
    [taft.cart [%tape result now]]
  (pure:m !>(delivery))
--
