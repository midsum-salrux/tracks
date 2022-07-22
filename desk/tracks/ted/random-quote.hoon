/-  spider
/+  *strandio
/+  *track
=,  strand=strand:spider
=,  dejs:format
=,  strand-fail=strand-fail:libstrand:spider
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
  =/  m  (strand ,vase)
  ^-  form:m
  ;<  now=@da  bind:m  get-time
  ;<  eny=@uvJ  bind:m  get-entropy
  ;<  =json  bind:m  (fetch-json (url eny))
  =/  result  (mine-json json)
  =/  =delivery
    [[%tracks %random-quote] [%tape result now]]
  (pure:m !>(delivery))
--
